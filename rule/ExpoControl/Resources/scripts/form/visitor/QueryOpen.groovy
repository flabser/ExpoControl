package form.visitor

import kz.nextbase.script.*
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.actions.*;
import kz.nextbase.script.events.*;
import kz.nextbase.script.constants.*;

class QueryOpen extends _FormQueryOpen{
    @Override
	public void doQueryOpen(_Session session, _WebFormData webFormData, String lang) {
		
		def user = session.getCurrentAppUser()
		
		def nav = session.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = session.createActionBar();
		actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)

		
		publishValue("title",getLocalizedWord("Посетитель", lang))
		publishEmployer("author", session.getCurrentAppUser().getUserID())
	}


	@Override
	public void doQueryOpen(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
		def user = ses.getCurrentAppUser()
		
		def nav = ses.getPage("outline", webFormData)
		publishElement(nav)
		
		def actionBar = new _ActionBar(ses)
		
		if(doc.getEditMode() == _DocumentModeType.EDIT){
			actionBar.addAction(new _Action(getLocalizedWord("Сохранить и закрыть",lang),getLocalizedWord("Сохранить и закрыть",lang),_ActionType.SAVE_AND_CLOSE))
		}
		if(user.hasRole("supervisor")){
			actionBar.addAction(new _Action(_ActionType.GET_DOCUMENT_ACCESSLIST))
		}
		actionBar.addAction(new _Action(getLocalizedWord("Закрыть",lang),getLocalizedWord("Закрыть без сохранения",lang),_ActionType.CLOSE))
		publishElement(actionBar)
		
		publishValue("title",getLocalizedWord("Посетитель", lang) + " " + doc.getValueString("surname")+" "+ doc.getValueString("name")+ " "+ doc.getValueString("patronymic"))
		publishEmployer("author",doc.getAuthorID())
		publishValue("surname",doc.getValueString("surname"))
		publishValue("name",doc.getValueString("name"))
		publishValue("patronymic",doc.getValueString("patronymic"))
		publishValue("rfid",doc.getValueString("rfid"))
		publishValue("personalid",doc.getValueString("personalid"))
		publishValue("birthdate",doc.getValueString("birthdate"))
		publishValue("regdate",doc.getValueString("regdate"))
		publishValue("sex",doc.getValueString("sex"))
		publishValue("citizenship",doc.getValueString("citizenship"))
        try {
            publishAttachment("rtfcontent", "rtfcontent")
        } catch(_Exception e) {

        }
        publishDocumentValue("objects", doc.getValueList("objects").collect{it as int})
	}
}
