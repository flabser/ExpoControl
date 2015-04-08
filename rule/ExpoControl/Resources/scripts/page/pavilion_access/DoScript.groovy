package page.pavilion_access
import kz.flabs.users.User
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript
import org.joda.time.DateTime
import org.joda.time.Minutes

import java.text.SimpleDateFormat

class DoScript extends _DoScript{
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        String rfid = formData.getValue("rfid")
        String antid = formData.getValue("antid")
        def db = session.getCurrentDatabase()
        def rootTag = new _Tag("message");
        def ua = new _UserActivity(db.baseObject, new User())

        def staff_params = new _ViewEntryCollectionParam(session)
        staff_params.query = "form = 'personal' and rfid = '${rfid}'"
        def staff_col = db.getCollectionOfDocuments(staff_params)
        if (staff_col.count) {
            def  act_in = ua.getActivity(rfid, antid, "in", "pavilion_access", 0, 0, session)
            def act_out = ua.getActivity(rfid, antid, "out", "pavilion_access", 0, 0, session)

            int div = (act_in.count + act_out.count)%2

            if (div == 0) {
                ua.postStartActivity("Object: ${antid} rfid: ${rfid} access: granted", rfid, "pavilion_access", _Helper.getRandomValue(), "${antid}", "", "in", new Date())
                rootTag.setAttr("id", "1")
                rootTag.setTagValue("1")
            } else {

                def sort_act_in = act_in.entries.sort{
                    it.getViewText(15)
                }
                def last_int_act = sort_act_in.last()
                String id = last_int_act.getViewText(13)
                Date event_time = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss").parse(last_int_act.getViewText(15))

                DateTime now = DateTime.now();
                DateTime dateTime = new DateTime(event_time);
                Minutes minutes = Minutes.minutesBetween(dateTime, now)
                //фиксируем время нахождения посетителя на выставке и время выхода

                ua.postStartActivity("Object: ${antid} rfid: ${rfid} access: granted", rfid, "pavilion_access", id, "${antid}", "", "out", new Date(), minutes.minutes)
                rootTag.setAttr("id", "1")
                rootTag.setTagValue("2")
            }


        } else {
            def  params = new _ViewEntryCollectionParam(session)
            params.query = "rfid = '${rfid}' and antid ~ '${antid}' and form = 'visitor'"
            params.checkResponse = false
            params.expandAllResponses = false
            params.pageNum = 0
            params.pageSize = 0
            def staff = db.getCollectionOfDocuments(params)


            if (staff  && staff.count > 0) {

                def  act_in = ua.getActivity(rfid, antid, "in", "pavilion_access", 0, 0, session)
                def act_out = ua.getActivity(rfid, antid, "out", "pavilion_access", 0, 0, session)

                int div = (act_in.count + act_out.count)%2

                if (div == 0) {
                    ua.postStartActivity("Object: ${antid} rfid: ${rfid} access: granted", rfid, "pavilion_access", _Helper.getRandomValue(), "${antid}", "", "in", new Date())
                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("1")
                } else {

                    def sort_act_in = act_in.entries.sort{
                        it.getViewText(15)
                    }
                    def last_int_act = sort_act_in.last()
                    String id = last_int_act.getViewText(13)
                    Date event_time = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss").parse(last_int_act.getViewText(15))

                    DateTime now = DateTime.now();
                    DateTime dateTime = new DateTime(event_time);
                    Minutes minutes = Minutes.minutesBetween(dateTime, now)
                    //фиксируем время нахождения посетителя на выставке и время выхода

                    ua.postStartActivity("Object: ${antid} rfid: ${rfid} access: granted", rfid, "pavilion_access", id, "${antid}", "", "out", new Date(), minutes.minutes)
                    rootTag.setAttr("id", "1")
                    rootTag.setTagValue("2")
                }
            } else {
                ua.postStartActivity("Object: ${antid} rfid: ${rfid} access: denied", rfid, "pavilion_access", "", "${antid}", "", "denied", new Date())
                rootTag.setAttr("id", "1")
                rootTag.setTagValue("0")
            }
        }
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
