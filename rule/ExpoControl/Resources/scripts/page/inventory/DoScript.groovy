package page.inventory

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._ViewEntry
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._DoScript

/**
 * Created by dzhillian on 03.12.2014.
 */
class DoScript extends _DoScript {
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        def db = session.getCurrentDatabase()
        def first_col = db.getCollectionOfDocuments("form = 'box' and register = 'true'", false)
        def second_col = db.getCollectionOfDocuments("form = 'box' and onwarehouse = 'true'", false)

        def first_group = first_col.entries.groupBy {
            it.document.getViewText()
        }

        def second_group = second_col.entries.groupBy {
            it.document.getViewText()
        }

        def total = []
        total.addAll(first_col.entries)
        total.addAll(second_col.entries)

        def group_total = total.groupBy {
            ((_ViewEntry)it).document.getViewText()
        }
        group_total.each {
            it.value.unique()
        }

        def rootTag = new _Tag("invent")

        group_total.each {
            println it.key + " " + it.value
            def entryTag = new _Tag("entry")
            entryTag.setAttr("viewtext", it.key)
            int diff = 0
            if (first_group.containsKey(it.key)) {
                diff = first_group.get(it.key).size()
                entryTag.setAttr("count", diff)
            }
            if (second_group.containsKey(it.key)) {
                diff = diff - second_group.get(it.key).size()
                entryTag.setAttr("byrev", second_group.get(it.key).size())
            }
            entryTag.setAttr("diff", diff)
            rootTag.addTag(entryTag)
        }
        setContent(rootTag)
    }
}
