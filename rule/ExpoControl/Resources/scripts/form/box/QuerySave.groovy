package form.box

import kz.flabs.users.User
import kz.nextbase.script.*
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {
    @Override
    void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {
        doc.setForm('box')

        if (!webFormData.containsField("reg")) {
            String encoding

            if (webFormData.containsField("char_enc")) {
                encoding = webFormData.getValueSilently("char_enc")
            } else {
                encoding = "UTF-8"
            }
            doc.setValueString('name', new String(webFormData.getValueSilently('name').getBytes(encoding), "UTF-8"))
            doc.setValueString('rfid', webFormData.getValueSilently('rfid'))
            doc.setValueString('category', webFormData.getValueSilently('category'))
            doc.setValueString('description', webFormData.getValueSilently('description'))
            //doc.setValueString("onwarehouse", "false")

            doc.setViewDate(new Date())
      /*      doc.setViewText(doc.getValueString("name"))
            doc.addViewText(doc.getValueString("category"))
            doc.addViewText(doc.getValueString("rfid"))
            doc.addViewText(doc.getValueString("description"))*/

            doc.addEditor("[administrator]")
            doc.addReader("[administrator]")
            doc.addReader("[reception]")
            doc.addEditor("[registrator]")
            doc.addReader("[registrator]")
            def returnURL = ses.getURLOfLastPage()
            setRedirectURL(returnURL)

        } else {
            doc.setValueString("register", "true")
            doc.setValueString("onwarehouse", "true")
            String rfid = webFormData.getValueSilently("rfid")
            doc.setValueString("rfid", rfid)
            def ua = new _UserActivity(ses.getCurrentDatabase().baseObject, new User())
            ua.postStartActivity("Warehouse rfid: ${rfid} access: granted", rfid, "pavilion_access", _Helper.getRandomValue(), "warehouse", "", "register_box", new Date())
        }
        doc.setViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("category"))
        doc.addViewText(doc.getValueString("rfid"))
        doc.addViewText(doc.getValueString("description"))

    }
}
