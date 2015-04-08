package page.boxes_list

import java.text.SimpleDateFormat
import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript


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
    }

}