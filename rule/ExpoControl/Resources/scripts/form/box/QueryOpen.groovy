package form.box

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

		
		publishValue("title",getLocalizedWord("Товар", lang))
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
		
		publishValue("title",getLocalizedWord("Товар", lang) + " " + doc.getValueString("name"))
		publishEmployer("author",doc.getAuthorID())
		publishValue("name",doc.getValueString("name"))
		publishValue("rfid",doc.getValueString("rfid"))
		publishValue("description",doc.getValueString("description"))
		publishValue("category",doc.getValueString("category"))
        try {
            publishAttachment("rtfcontent", "rtfcontent")
        } catch(_Exception e) {

        }
	}
}
