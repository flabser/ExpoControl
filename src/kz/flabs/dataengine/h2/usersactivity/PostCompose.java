package kz.flabs.dataengine.h2.usersactivity;

import kz.flabs.dataengine.DatabaseUtil;
import kz.flabs.dataengine.IDBConnectionPool;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.UsersActivityType;
import kz.flabs.dataengine.h2.Database;
import kz.flabs.runtimeobj.RuntimeObjUtil;
import kz.flabs.runtimeobj.document.Document;
import kz.flabs.runtimeobj.document.Field;

import java.sql.*;


public class PostCompose extends Thread {
	private IDBConnectionPool dbPool;	
	private Document doc;
	private String dbID;
	private String userID;
	
	protected PostCompose(IDatabase db, Document doc, String userID){
		dbPool = db.getConnectionPool();
		dbID = db.getDbID();
		this.doc = doc;
		this.userID = userID;
	}


	public void run() {
		int key = 0;
		Connection conn = dbPool.getConnection();
		try {			
			conn.setAutoCommit(false);
			Statement s = conn.createStatement();
			String sql = "insert into USERS_ACTIVITY(TYPE, DBID, USERID, EVENTTIME, DOCID, DOCTYPE, VIEWTEXT, DDBID) values ("
				+ UsersActivityType.COMPOSED.getCode() + ",'" + dbID + "', '" + userID + "','" + Database.sqlDateTimeFormat.format(new java.util.Date()) +
				"', " + doc.getDocID() + ", " + doc.docType + ", '" + RuntimeObjUtil.cutHTMLText(doc.getViewText().replace("'", "''"),2048) + "', '" + doc.getDdbID() + "')";

			s.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = s.getGeneratedKeys();
			if (rs.next()) {
				key = rs.getInt(1);	
				for(Field field:doc.fields()){
					String val = field.valueAsText;
					if (val == null) val = "";
					String sqlStatement = "INSERT INTO USERS_ACTIVITY_CHANGES(AID, FIELDNAME, OLDVALUE, NEWVALUE, FIELDTYPE)"
						+ "VALUES (" + key + ", '" + field.name	+ "', '','" + RuntimeObjUtil.cutHTMLText(val.replace("'", "''"), 512) + "', " + field.getTypeAsDatabaseType() + ")";
					PreparedStatement pst = conn.prepareStatement(sqlStatement);
					pst.executeUpdate();
					pst.close();
				}
			}		
			conn.commit();	
			s.close();
		} catch (SQLException e) {
			DatabaseUtil.errorPrint(dbID,e);		
		} catch (Exception e) {
			DatabaseUtil.errorPrint(dbID, e);			
		} finally {			
			dbPool.returnConnection(conn);
		}
		//return key;
	}
}
