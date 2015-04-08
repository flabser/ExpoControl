package page.process_event

import kz.flabs.users.User
import kz.nextbase.script._Session
import kz.nextbase.script._UserActivity
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {

    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def db = session.getCurrentDatabase()
        def event_id = formData.getValueSilently("event_id")
        def ua = new _UserActivity(db.baseObject, new User())
        ua.postEndOfActivity(event_id as int)
    }

}