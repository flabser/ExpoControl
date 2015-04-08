package kz.flabs.runtimeobj.viewentry;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.runtimeobj.document.structure.Employer;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;

/**
 * Created with IntelliJ IDEA.
 * User: dzhillian
 * Date: 23.03.13
 * Time: 9:51
 * To change this template use File | Settings | File Templates.
 */
public class ActivityEntry extends ViewEntry {

    public ActivityEntry(ResultSet rs, ViewEntryType type, IDatabase db) throws SQLException {
        super("", 0, db);
        this.type = type;
        switch (type) {
            case ACTIVITY:
                viewNumberValue = BigDecimal.valueOf(rs.getInt("id"));
                Employer emp = db.getStructure().getAppUser(rs.getString("userid"));
                /*0*/viewTexts.add(new ViewText(rs.getString("viewtext"), "viewtext"));
                /*1*/viewTexts.add(new ViewText((emp != null ? emp.getFullName() : ""), "fio"));
                /*2*/viewTexts.add(new ViewText(rs.getString("userid"), "userid"));
                /*3*/viewTexts.add(new ViewText(rs.getString("parameters"), "parameters"));
                /*4*/viewTexts.add(new ViewText((rs.getBoolean("ACTIVITY_TYPE") ? 1 : 0), "type"));
                /*5*/viewTexts.add(new ViewText(rs.getTimestamp("RETURN_TIME"), "returntime"));
                /*6*/viewTexts.add(new ViewText(rs.getString("COMMENT"), "comment"));
                /*7*/viewTexts.add(new ViewText(rs.getInt("PROCESSED_REC"), "processed_rec"));
                /*8*/viewTexts.add(new ViewText(rs.getInt("PROCESSED_SIZE"), "processed_size"));
                /*9*/viewTexts.add(new ViewText(rs.getString("TRANSACTION"), "transaction"));
                /*10*/viewTexts.add(new ViewText(rs.getString("SERVICE_NAME"), "service_name"));
                /*11*/viewTexts.add(new ViewText(rs.getString("METHOD_NAME"), "method_name"));
                /*12*/viewTexts.add(new ViewText(rs.getString("SPRING_SERVER"), "spring_server"));
                /*13*/viewTexts.add(new ViewText(rs.getTimestamp("EVENT_TIME"), "eventtime"));
                /*14*/viewTexts.add(new ViewText(rs.getTimestamp("REQUEST_TIME"), "requesttime"));
                break;
            case ACCESS_ACTIVITY:
                viewTexts.add(new ViewText(rs.getString("event_time"), "event_time"));
                viewTexts.add(new ViewText(rs.getString("userid"), "rfid"));
                viewTexts.add(new ViewText(rs.getString("pav_text"), "object"));
                viewTexts.add(new ViewText(rs.getString("act_text"), "action"));
                viewTexts.add(new ViewText(rs.getString("fio_text"), "fio"));
                break;
            case USER_ACTIVITY:
                viewTexts.add(new ViewText(rs.getString("parameters"), "parameters"));
                viewTexts.add(new ViewText(rs.getString("count"), "count"));
                viewTexts.add(new ViewText(rs.getString("time"), "time"));
                break;
            case COUNT_ACTIVITY:
                viewTexts.add(new ViewText(rs.getString("userid"), "userid"));
                viewTexts.add(new ViewText(rs.getString("pav_text"), "pav_text"));
                viewTexts.add(new ViewText(rs.getString("value"), "value"));
                break;
        }
    }

}
