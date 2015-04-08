package page.events

import kz.flabs.users.User
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript
{
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        def db = session.getCurrentDatabase()
        def ua = new _UserActivity(db.baseObject, new User())
        def events = ua.getUnprocessedActivities(0, 0, session)

        def rootTag = new _Tag("events");


        events.entries.each {

            def entryTag = new _Tag("entry")

            //id события для последующей отметки об обработке
            def idTag = new _Tag("id")
            def id = it.viewNumberValue.intValue()
            idTag.setTagValue(id)
            entryTag.addTag(idTag)

            //отметка времени события
            def timeTag = new _Tag("event_time")
            def time = it.getViewText(15)
            timeTag.setTagValue(time)
            entryTag.addTag(timeTag)

            //6 фио
            def fioTag = new _Tag("fio")
            def fio = it.getViewText(8)
            fioTag.setTagValue(fio)
            entryTag.addTag(fioTag)

            def actTag = new _Tag("action")
            def action = it.getViewText(11)
            def act = it.getViewText(11)
            switch (action) {
                case 'in':
                    action = 'Вход'
                    break;
                case 'out':
                    action = 'Выход'
                    break;
                case 'denied':
                    action = 'Доступ запрещен'
                    break;
                case 'register_personal':
                    action = 'Регистрация сотрудника'
                    break;
                case 'register_visitor':
                    action = 'Регистрация посетителя'
                    break;
                default:
                    action = 'Действие не определено'
                    break;
            }
            actTag.setTagValue(action)
            entryTag.addTag(actTag)

            //Название помещения
            def roomTag = new _Tag("pav_text");
            def room_text = it.getViewText(5);
            roomTag.setTagValue(room_text);
            entryTag.addTag(roomTag);

            //тип события
            if (act == 'in' || act == 'out' || act == 'register_personal' || act == 'register_visitor' || act == 'denied') {
                def photo_url = new _Tag("photo")
                def userid = it.getViewText(4)

                def visitors = db.getCollectionOfDocuments("rfid = '${userid}'" , false).entries
                visitors.each {
                    def visitor_doc = it.getDocument()
                    if (it.document.hasAttachment()) {
                        def field = (_BlobField) visitor_doc.getField("rtfcontent")
                        def files = field.getFiles()
                        files.each {
                            photo_url.setTagValue("Provider?type=getattach&formsesid=546465&doctype=896&key=${it.id}&field=rtfcontent&id=rtfcontent&file=${it.originalName}")
                            entryTag.addTag(photo_url)
                        }
                    }
                }
            }
            rootTag.addTag(entryTag)
        }
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
