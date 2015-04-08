package page.check_staff_access

import kz.flabs.users.User
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript
import org.joda.time.DateTime
import org.joda.time.Minutes

import java.text.SimpleDateFormat

class DoScript extends _DoScript {
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        String rfid = formData.getValue("rfid")
        def db = session.getCurrentDatabase()
        def params = new _ViewEntryCollectionParam(session)
        params.query = "rfid = '${rfid}'"
        params.checkResponse = false
        params.expandAllResponses = false
        params.pageNum = 0
        params.pageSize = 0
        def records = db.getCollectionOfDocuments(params)
        def rootTag = new _Tag("message");
        def ua = new _UserActivity(db.baseObject, new User())
        String form = ""
        if (records && records.count > 0) {
            //собираем записи из базы с таким rfid, чтобы определить форму документа - персонал или товар
            records.entries.each {
                form = it.document.getDocumentForm()
            }
            //если это сотрудник
            if (form && "personal".equalsIgnoreCase(form)) {
                def act_in = ua.getActivity(rfid, "personal", "in", "pavilion_access", 0, 0, session)
                def act_out = ua.getActivity(rfid, "personal", "out", "pavilion_access", 0, 0, session)

                int div = (act_in.count + act_out.count) % 2

                if (div == 0) {
                    //если количество записей четное, то фиксируем вход
                    ua.postStartActivity("Staffroom rfid: ${rfid} access: granted", rfid, "pavilion_access", _Helper.getRandomValue(), "personal", "", "in", new Date())
                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("1")
                } else {
                    //если количество нечетное, фиксируем выход
                    //предварительно находим соответствующее действие на вход и берем его айдишку для завершения транзакции
                    //и считаем время, проведенное в павильоне

                    //вычисляем последнюю запись на вход
                    def sort_act_in = act_in.entries.sort {
                        it.getViewText(15)
                    }
                    def last_int_act = sort_act_in.last()
                    //айди транзакции
                    String id = last_int_act.getViewText(13)
                    //время события
                    Date event_time = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss").parse(last_int_act.getViewText(15))

                    //вычисляем время, проведенное в помещение
                    DateTime now = DateTime.now();
                    DateTime dateTime = new DateTime(event_time);
                    Minutes minutes = Minutes.minutesBetween(dateTime, now)

                    ua.postStartActivity("Staffroom rfid: ${rfid} access: granted", rfid, "pavilion_access", id, "personal", "", "out", new Date(), minutes.minutes)
                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("2")
                }
            } else if ("box".equalsIgnoreCase(form)) {
                //собираем записи о регистрации товара
                def act_in = ua.getActivity(rfid, "warehouse", "in", "pavilion_access", 0, 0, session)
                //сортируем по дате
                def sort_act_in = act_in.entries.sort {
                    it.getViewText(15)
                }
                if (!sort_act_in.isEmpty()) {
                    def last_int_act = sort_act_in.last()
                    String id = last_int_act.getViewText(13)
                    Date event_time = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss").parse(last_int_act.getViewText(15))

                    DateTime now = DateTime.now();
                    DateTime dateTime = new DateTime(event_time);
                    Minutes minutes = Minutes.minutesBetween(dateTime, now)
                    //фиксируем время нахождения товара на складе и время выноса товара
                    ua.postStartActivity("Warehouse rfid: ${rfid} access: granted", rfid, "pavilion_access", id, "warehouse", "", "out", new Date(), minutes.minutes)

                    def box_col = db.getCollectionOfDocuments("rfid = '${rfid}'", false)
                    box_col.entries.each {
                        def box_doc = it.document
                        box_doc.setValueString("onwarehouse", "false")
                        box_doc.save("[supervisor]")
                    }

                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("3")

                } else {
                    ua.postStartActivity("Rfid: ${rfid} access: denied", rfid, "pavilion_access", "", "personal", "", "denied", new Date())
                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("0")
                }
            } else {
                ua.postStartActivity("Rfid: ${rfid} access: denied", rfid, "pavilion_access", "", "personal", "", "denied", new Date())
                rootTag.setAttr("id", "1")
                rootTag.setTagValue("0")
            }
        } else {
            ua.postStartActivity("Rfid: ${rfid} access: denied", rfid, "pavilion_access", "", "personal", "", "denied", new Date())
            rootTag.setAttr("id", "1")
            rootTag.setTagValue("0")
        }
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
