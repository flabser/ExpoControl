package form.visitor

import kz.flabs.users.User
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._UserActivity
import kz.nextbase.script.events._FormPostSave

class PostSave extends _FormPostSave{
    @Override
    void doPostSave(_Session ses, _Document doc) {
        def db = ses.getCurrentDatabase()
        def ua = new _UserActivity(db.baseObject, new User())
        ua.postStartActivity("Registration visitor rfid: ${doc.getValueString("rfid")}", doc.getValueString("rfid"), "postsave", "", "registration", "", "register_visitor", new Date())
    }
}
