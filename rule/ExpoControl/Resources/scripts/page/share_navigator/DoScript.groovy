package page.share_navigator

import java.util.Map;
import kz.nextbase.script.*;
import kz.nextbase.script.events._DoScript
import kz.nextbase.script.outline.*;

class DoScript extends _DoScript {

	@Override
	public void doProcess(_Session session, _WebFormData formData, String lang) {
		def list = []
		def user = session. getCurrentAppUser()
		def outline = new _Outline("", "", "outline")

		def all_outline = new _Outline(getLocalizedWord("Документы организации",lang), getLocalizedWord("Документы организации",lang), "orgdocs")
		def objects = new _OutlineEntry(getLocalizedWord("Объекты выставки",lang), getLocalizedWord("Объекты выставки",lang), "objects", "Provider?type=page&id=objects&page=0")
        all_outline.addEntry(addEntryByFinalDocType(session, objects, "objects"));
		def personal = new _OutlineEntry(getLocalizedWord("Персонал",lang), getLocalizedWord("Персонал",lang), "personal", "Provider?type=page&id=personal&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, personal, "personal"));
		def visitors = new _OutlineEntry(getLocalizedWord("Посетители",lang), getLocalizedWord("Посетители",lang), "visitors", "Provider?type=page&id=visitors&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, visitors, "visitors"));
		def box = new _OutlineEntry(getLocalizedWord("Товары",lang), getLocalizedWord("Товары ",lang), "box", "Provider?type=page&id=boxes&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, box, "box"));
		def inventory = new _OutlineEntry(getLocalizedWord("Инвентаризация",lang), getLocalizedWord("Инвентаризация ",lang), "inventory", "Provider?type=page&id=inventory&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, inventory, "boinventoryx"));
		
		def activity = new _OutlineEntry(getLocalizedWord("История активности",lang), getLocalizedWord("История активности",lang), "activity", "Provider?type=page&id=activity&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, activity, "activity"));
		def visitors_stat = new _OutlineEntry(getLocalizedWord("Количество посетителей",lang), getLocalizedWord("Количество посетителей",lang), "visitors_stat", "Provider?type=page&id=visitors_stat&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, visitors_stat, "visitors_stat"));
		def averagetime_stat = new _OutlineEntry(getLocalizedWord("Среднее время посещения",lang), getLocalizedWord("Среднее вермя посещения",lang), "averagetime_stat", "Provider?type=page&id=averagetime_stat&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, averagetime_stat, "averagetime_stat"));
		def map_stat = new _OutlineEntry(getLocalizedWord("Карта активности",lang), getLocalizedWord("Карта активности",lang), "map_stat", "Provider?type=page&id=map_stat&page=0")
		all_outline.addEntry(addEntryByFinalDocType(session, map_stat, "map_stat"));
		if (user.hasRole("administrator_software")){
			def personal_category = new _OutlineEntry(getLocalizedWord("Категория персонала",lang), getLocalizedWord("Категория персонала",lang), "personal_category", "Provider?type=page&id=personal_category&page=0")
			all_outline.addEntry(addEntryByFinalDocType(session, personal_category, "personal_category"));
			def boxes_category = new _OutlineEntry(getLocalizedWord("Категория товаров",lang), getLocalizedWord("Категория товаров",lang), "boxes_category", "Provider?type=page&id=boxes_category&page=0")
			all_outline.addEntry(addEntryByFinalDocType(session, boxes_category, "boxes_category"));
			def division = new _OutlineEntry(getLocalizedWord("Подразделение персонала",lang), getLocalizedWord("Подразделение персонала",lang), "division", "Provider?type=page&id=division&page=0")
			all_outline.addEntry(addEntryByFinalDocType(session, division, "division"));
			def citizenship = new _OutlineEntry(getLocalizedWord("Гражданство",lang), getLocalizedWord("Гражданство",lang), "citizenship", "Provider?type=page&id=citizenship&page=0")
			all_outline.addEntry(addEntryByFinalDocType(session, citizenship, "citizenship"));
			/*def recyclebin = new _OutlineEntry(getLocalizedWord("Корзина",lang), getLocalizedWord("Корзина",lang), "recyclebin", "Provider?type=page&id=recyclebin&page=0")
			all_outline.addEntry(addEntryByFinalDocType(session, recyclebin, "recyclebin"));*/
		}
        
		outline.addOutline(all_outline)
		list.add(all_outline)
		setContent(list)
	}

    def addEntryByFinalDocType(_Session session, def entry, formid){

        def projects = session.getCurrentDatabase().getGroupedEntries("finaldoctype#number", 1, 20);
        def cdb = session.getCurrentDatabase();
        def pageid = "prjbyfinaldoctype";
        if(formid == "workdoc")
            pageid = "docsbyfinaldoctype";
        for(it in projects){
            try{
                int docid = it.getViewText().toDouble().toInteger()
                def name = cdb.getGlossaryDocument(docid)?.getName();
                if(name != null && name != ""){
                    entry.addEntry(new _OutlineEntry(name, name, formid + it.getViewText(), "Provider?type=page&id=$pageid&finaldoctype=$docid&formid=$formid&page=0"));
                }
            }catch(Exception e){}
        }

        return entry;
    }
}
