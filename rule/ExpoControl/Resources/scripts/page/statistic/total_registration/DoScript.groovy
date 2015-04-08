package page.statistic.total_registration

import kz.nextbase.script._Session
import kz.nextbase.script._Tag
import kz.nextbase.script._WebFormData
import kz.nextbase.script._XMLDocument
import kz.nextbase.script.events._DoScript


class DoScript extends _DoScript {


    @Override
    void doProcess(_Session session, _WebFormData formData, String lang) {

        def db = session.getCurrentDatabase();
        def total_amount = db.getCollectionOfDocuments("form = 'visitor'", false)

        def rootTag = new _Tag("statistic")
        def totalTag = new _Tag("total")
        totalTag.setTagValue(total_amount.count)
        rootTag.addTag(totalTag)
        def xml = new _XMLDocument(rootTag)
        setContent(xml)
    }
}
