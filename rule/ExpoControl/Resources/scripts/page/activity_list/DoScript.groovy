package page.activity_list
import kz.flabs.users.User
import kz.nextbase.script._Session
import kz.nextbase.script._UserActivity
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {

    public void doProcess(_Session session, _WebFormData formData, String lang) {
       def page = 1;
		if (formData.containsField("page") && formData.getValue("page")){
			page = Integer.parseInt(formData.getValue("page"))
		}
		def db = session.getCurrentDatabase()
		def ua = new _UserActivity(db.baseObject, new User())
		def act = ua.getAllActivities(page, 0, session)
		println act.count
		setContent(act)
    }

}