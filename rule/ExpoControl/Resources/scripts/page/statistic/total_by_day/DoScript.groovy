package page.statistic.total_by_day

import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {

        def db = session.getCurrentDatabase();
        def params = new _ViewEntryCollectionParam(session)
        params.query = "form = 'visitor'"

        def total = db.getCollectionOfDocuments("form = 'visitor'", false)
        def total_group = total.entries.groupBy {it ->
            it.getDocument().getValueString("regdate")
        }
        println total_group.size()


        /      pavillions.entries.each {
            def entryTag = new _Tag("entry")
            entryTag.setAttr("id", it.document.getDocID())
            entryTag.setAttr("viewtext", it.document.getViewText())
            pavTag.addTag(entryTag)
        }/



        def rootTag = new _Tag("statistic")
        def totalTag = new _Tag("total")

        total_group.each {
            def entryTag = new _Tag("entry")
            entryTag.setAttr("date", it.key)
            entryTag.setAttr("count", it.value.size())
            totalTag.addTag(entryTag)
        }

       // totalTag.setTagValue(total_amount.count)
        rootTag.addTag(totalTag)
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
