package kz.flabs.dataengine.mssql.useractivity;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kz.flabs.dataengine.DatabaseUtil;
import kz.flabs.dataengine.IDBConnectionPool;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.UsersActivityType;
import kz.flabs.dataengine.mssql.Database;
import kz.flabs.runtimeobj.document.Document;
import kz.flabs.runtimeobj.document.Field;
import kz.flabs.util.Util;

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
			String sql = "insert into USERS_ACTIVITY(TYPE, DBID, USERID, EVENTTIME, DOCID, DOCTYPE, VIEWTEXT) values ("
				+ UsersActivityType.COMPOSED.getCode() + ",'" + dbID + "', '" + userID + "','" + Database.sqlDateTimeFormat(new java.util.Date()) +
				"', " + doc.getDocID() + ", " + doc.docType + ", '" + Util.removeHTMLTags(doc.getViewText().replace("'", "''")) + "')";

			s.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);
			ResultSet rs = s.getGeneratedKeys();
			if (rs.next()) {
				key = rs.getInt(1);	
				for(Field field:doc.fields()){
					String sqlStatement = "INSERT INTO USERS_ACTIVITY_CHANGES(AID, FIELDNAME, OLDVALUE, NEWVALUE, FIELDTYPE)"
						+ "VALUES (" + key + ", '" + field.name	+ "', '','" + Util.removeHTMLTags(field.valueAsText.replace("'", "''")) + "', " + field.getTypeAsDatabaseType() + ")";
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
