package page.actionbar

import java.util.ArrayList;
import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.actions.*
import kz.nextbase.script.events._DoScript

class division extends _DoScript { 

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def actionBar = new _ActionBar(session);
		def user = session.getCurrentAppUser();
		if (user.hasRole(["supervisor","administrator","registrator","reception"])){
			def newDocAction = new _Action(getLocalizedWord("Добавить подразделение персонала", lang),getLocalizedWord("Добавить подразделение персонала",lang), "new_glossary")
			newDocAction.setURL("Provider?type=edit&id=division&key=")
			actionBar.addAction(newDocAction);
		}
		if (user.hasRole(["supervisor","administrator","registrator","reception"])){
			actionBar.addAction(new _Action(getLocalizedWord("Удалить объект",lang), getLocalizedWord("Удалить объект", lang),_ActionType.DELETE_DOCUMENT));
		}
		setContent(actionBar);
	}
}

