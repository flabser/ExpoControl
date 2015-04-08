package page.global_access

import kz.flabs.users.User
import kz.nextbase.script.*
import kz.nextbase.script.events._DoScript
import org.joda.time.DateTime
import org.joda.time.Minutes

import java.text.SimpleDateFormat

class DoScript extends _DoScript {
    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {
        String rfid = formData.getValue("rfid")
        def db = session.getCurrentDatabase()
        def params = new _ViewEntryCollectionParam(session)
        params.query = "rfid = '${rfid}'"
        params.checkResponse = false
        params.expandAllResponses = false
        params.pageNum = 0
        params.pageSize = 0
        def rfids = db.getCollectionOfDocuments(params)
        def rootTag = new _Tag("message");

        def ua = new _UserActivity(db.baseObject, new User())

        def visitor_params = new _ViewEntryCollectionParam(session)
        visitor_params.query = "rfid = '${rfid}' and form = 'visitor'"
        visitor_params.checkResponse = false
        visitor_params.expandAllResponses = false
        visitor_params.pageNum = 0
        visitor_params.pageSize = 0
        def staff = db.getCollectionOfDocuments(visitor_params)

        def vis_emp = null

        if (staff && staff.count > 0) {
            staff.entries.each {
                vis_emp = (_Document) it.document
            }
        }

        def nameTag = new _Tag("name")
        def surnameTag = new _Tag("surname")
        def birthdateTage = new _Tag("birthdate")
        def sexTag = new _Tag("sex")
        def citizenshipTag = new _Tag("citizenship")
        def passportTag = new _Tag("passport")
        def passportexpTag = new _Tag("passportexp")

        if (vis_emp) {
            nameTag.setTagValue(((_Document) vis_emp).getValueString("name"))
            surnameTag.setTagValue(((_Document) vis_emp).getValueString("surname"))
            birthdateTage.setTagValue(((_Document) vis_emp).getValueString("birthdate"))
            sexTag.setTagValue(((_Document) vis_emp).getValueString("sex"))
            citizenshipTag.setTagValue(((_Document) vis_emp).getValueString("citizenship"))
            passportTag.setTagValue(((_Document) vis_emp).getValueString("passport"))
            passportexpTag.setTagValue(((_Document) vis_emp).getValueString("passportexp"))
        }
        if (rfids && rfids.count > 0) {

            def act_in = ua.getActivity(rfid, "global", "in", "global_access", 0, 0, session)
            def act_out = ua.getActivity(rfid, "global", "out", "global_access", 0, 0, session)

            int div = (act_in.count + act_out.count) % 2

            if (div == 0) {
                ua.postStartActivity("Global access rfid: ${rfid} in", rfid, "global_access", _Helper.getRandomValue(), "global", "", "in", new Date())
                rootTag.setAttr("id", "1")
                //rootTag.setTagValue("1")

                def resTag = new _Tag("result")
                resTag.setTagValue("1")
                rootTag.addTag(resTag)

            } else {
                def sort_act_in = act_in.entries.sort {
                    it.getViewText(15)
                }
                def last_int_act = sort_act_in.last()
                String id = last_int_act.getViewText(13)
                Date event_time = new SimpleDateFormat("dd.MM.yyyy hh:mm:ss").parse(last_int_act.getViewText(15))

                DateTime now = DateTime.now();
                DateTime dateTime = new DateTime(event_time);
                Minutes minutes = Minutes.minutesBetween(dateTime, now)
                //фиксируем время нахождения посетителя на выставке и время выхода

                ua.postStartActivity("Global access rfid: ${rfid} out", rfid, "global_access", id, "global", "", "out", new Date(), minutes.minutes)
                rootTag.setAttr("id", "1")

                def resTag = new _Tag("result")
                resTag.setTagValue("2")
                rootTag.addTag(resTag)

                //rootTag.setTagValue("2")
            }


        } else {
            ua.postStartActivity("Global access rfid: ${rfid} access: denied", rfid, "global_access", "", "global", "", "denied", new Date())
            rootTag.setAttr("id", "1")
            //rootTag.setTagValue("0")

            def resTag = new _Tag("result")
            resTag.setTagValue("0")
            rootTag.addTag(resTag)
        }

        rootTag.addTag(nameTag)
        rootTag.addTag(surnameTag)
        rootTag.addTag(birthdateTage)
        rootTag.addTag(sexTag)
        rootTag.addTag(citizenshipTag)
        rootTag.addTag(passportTag)
        rootTag.addTag(passportexpTag)

        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
