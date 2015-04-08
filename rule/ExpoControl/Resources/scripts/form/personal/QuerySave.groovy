package form.personal

import com.sun.xml.internal.messaging.saaj.util.Base64
import kz.nextbase.script._Document
import kz.nextbase.script._Exception
import kz.nextbase.script._Session
import kz.nextbase.script._WebFormData
import kz.nextbase.script.events._FormQuerySave

class QuerySave extends _FormQuerySave {
    @Override
    void doQuerySave(_Session ses, _Document doc, _WebFormData webFormData, String lang) {

        String encoding

        if (webFormData.containsField("char_enc")) {
            encoding = webFormData.getValueSilently("char_enc")
        } else {
            encoding = "UTF-8"
        }

		doc.setForm('personal')
        doc.setValueString('surname', new String(webFormData.getValueSilently('surname').getBytes(encoding), "UTF-8"))
        doc.setValueString('name', new String(webFormData.getValueSilently('name').getBytes(encoding), "UTF-8"))
        doc.setValueString('patronymic', new String(webFormData.getValueSilently('patronymic').getBytes(encoding), "UTF-8"))
        doc.setValueString('rfid', webFormData.getValueSilently('rfid'))
        doc.setValueString('personal_category', webFormData.getValueSilently('personal_category'))
        doc.setValueString('division', webFormData.getValueSilently('division'))
        doc.setValueString('personalid', webFormData.getValueSilently('personalid'))

        String fio = doc.getValueString("surname") + " " + doc.getValueString("name") + " " + doc.getValueString("patronymic");
        doc.setValueString('fio', fio)

        try {
            String pathToFile = Base64.base64Decode(webFormData.getValueSilently("photo"))
            if (pathToFile) {
                File img = new File(pathToFile);
                if (img?.canRead()) {
                    doc.addAttachment("rtfcontent", img)
                }
            } else {
                doc.clearAttachments()
                doc.addFile("rtfcontent", webFormData)
            }
        } catch(_Exception e) {
        }

/*        if (webFormData.containsField("regdate")) {
            doc.setValueString('regdate', webFormData.getValueSilently('regdate'))
        } else {
            doc.setValueString('regdate', _Helper.getDateAsString())
        }*/

        //doc.replaceListField('objects', webFormData.getListOfValuesSilently('object') as List)

        doc.setViewDate(new Date())
        doc.setViewText(fio + ":" + doc.getValueString("rfid"))
        doc.addViewText(doc.getValueString("surname"))
        doc.addViewText(doc.getValueString("name"))
        doc.addViewText(doc.getValueString("patronymic"))
        doc.addViewText(doc.getValueString("rfid"))


        doc.addEditor("[administrator]")
        doc.addReader("[administrator]")
        doc.addReader("[reception]")
        doc.addEditor("[registrator]")
        doc.addReader("[registrator]")

        def returnURL = ses.getURLOfLastPage()
        returnURL.changeParameter("page", "0");
        setRedirectURL(returnURL)





    }
}
