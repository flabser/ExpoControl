package form.object
import kz.nextbase.script._Document
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {

	@Override
	public void doQuerySave(_Session session, _Document doc, _WebFormData webFormData, String lang) {
		
		println(webFormData)
		
		boolean v = validate(webFormData);
		if(!v){
			stopSave()
			return;
		}

		doc.setForm("object");
		
		doc.addStringField("name", webFormData.getValue("name"));
		doc.addStringField("location", webFormData.getValue("location"));
		doc.addStringField("objectid", webFormData.getValue("objectid"));
		doc.addStringField("firm", webFormData.getValue("firm"));
		doc.addStringField("contactperson", webFormData.getValue("contactperson"));
		doc.addStringField("contacts", webFormData.getValue("contacts"));
		doc.addStringField("characteristic", webFormData.getValue("characteristic"));
		doc.addStringField("author", webFormData.getValue("author"));
		doc.addStringField("antid", webFormData.getValue("antid"));

		doc.addEditor("[administrator]")
		doc.addReader("[administrator]")
		doc.addReader("[reception]")
		doc.addEditor("[registrator]")
		doc.addReader("[registrator]")


		doc.addFile("rtfcontent", webFormData)
		if (doc.isNewDoc ){
			localizedMsgBox(getLocalizedWord("Объект сохранен",lang))
		}
		def nowdate = new Date()
		doc.setViewText(doc.getValueString("name"))
		doc.addViewText(doc.getValueString("objectid"))
		doc.addViewText(doc.getValueString("name"))
		doc.addViewText(doc.getValueString("location"))
		doc.addViewText(doc.getValueString("firm"))
		
		def redirectURL = session.getLastPageURL()
		setRedirectURL(redirectURL)

	}


	def validate(_WebFormData webFormData){
		if (webFormData.getValueSilently("objectid") == ""){
			localizedMsgBox("Поле \"№ ID\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("name") == ""){
			localizedMsgBox("Поле \"Название\" не заполнено.")
			return false
		}else if (webFormData.getValueSilently("location") == ""){
			localizedMsgBox("Поле \"Месторасположение в EXPO\" не заполнено.");
			return false
		}
		return true;
	}
}
