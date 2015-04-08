package page.inv

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript

class DoScript extends _DoScript {
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        formData.formData.each {
            println it.key + " : " + it.value
            //println it.key + " : " + it.value[0].split("rfid:")
        }


        def db = session.getCurrentDatabase()
        String json = formData.getValueSilently("json")
        String[] rfid = json.split("rfid:")
        rfid.each {
            if (it) {
                def box_col = db.getCollectionOfDocuments("rfid = ${it}", false)
                box_col.entries.each {
                    def box_doc = it.document
                    box_doc.setValueString("onwarehouse", "true")
                    box_doc.save("[supervisor]")
                }
            }
        }

        def rootTag = new _Tag("root")

        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
