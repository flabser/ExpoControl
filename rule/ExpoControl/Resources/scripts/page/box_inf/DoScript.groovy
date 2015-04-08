package page.box_inf

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript


class DoScript extends _DoScript {

    public void doProcess(_Session session, _WebFormData formData, String lang) {
        def db = session.getCurrentDatabase()
        String box_id = formData.getValueSilently("box_id")
        def pavillions = db.getCollectionOfDocuments("form = 'box' and docid = " + box_id, 0, false)

        def rootTag = new _Tag("glossaries");
        def catTag = new _Tag("category")
        def descTag =  new _Tag("description")

        pavillions.entries.each {
            def box = it.document
            def cat = db.getGlossaryDocument(box.getValueString("category")as int)
            def entryTag = new _Tag("entry")
            entryTag.setAttr("id", cat.getDocID())
            entryTag.setAttr("viewtext", cat.getViewText())
            catTag.addTag(entryTag)
            entryTag = new _Tag("entry")
            entryTag.setAttr("viewtext", box.getValueString("description"))
            descTag.addTag(entryTag)
            rootTag.addTag(catTag)
            rootTag.addTag(descTag)
        }
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }

}