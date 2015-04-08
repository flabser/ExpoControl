package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class visitors extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if (user.hasRole(["supervisor","administrator","registrator","reception"])){
			def newDocAction = new _Action(getLocalizedWord("Новый посетитель", lang),getLocalizedWord("Новый посетитель",lang), "new_document")
			newDocAction.setURL("Provider?type=edit&id=visitor&key=")
			actionBar.addAction(newDocAction);
		}
		if (user.hasRole(["supervisor","administrator","registrator","reception"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить посетителя",lang), getLocalizedWord("Удалить посетителя", lang),_ActionType.DELETE_DOCUMENT));
		}
		setContent(actionBar);
	}
}

