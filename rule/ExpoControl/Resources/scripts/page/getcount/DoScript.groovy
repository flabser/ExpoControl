package page.getcount

import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

import java.text.SimpleDateFormat

class DoScript extends _DoScript {

    public void doProcess(_Session session, _WebFormData formData, String lang) {
       def page = 1;
		if (formData.containsField("page") && formData.getValue("page")){
			page = Integer.parseInt(formData.getValue("page"))
		}
		def formula = "form='box'";
		def db = session.getCurrentDatabase()
		def col = db.getCollectionOfDocuments(formula, page, true, true, new SimpleDateFormat("dd.MM.yyyy"))
		setContent(col)
    //select * from activity where method_name in (select method_name from activity where transaction = 'in' except (select method_name from activity where transaction = 'out'))
	}

}