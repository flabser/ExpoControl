package page.category_list

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript


class DoScript extends _DoScript {

    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def db = session.getCurrentDatabase()
        def pavillions = db.getCollectionOfGlossaries("form = 'personal_category'", 0, 0)

        def rootTag = new _Tag("glossaries");
        def pavTag = new _Tag("category");

        pavillions.entries.each {
            def entryTag = new _Tag("entry")
            entryTag.setAttr("id", it.document.getDocID())
            entryTag.setAttr("viewtext", it.document.getViewText())
            pavTag.addTag(entryTag)
        }
        rootTag.addTag(pavTag)
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }

}