package kz.flabs.dataengine.h2.usersactivity;

import kz.flabs.dataengine.DatabaseUtil;
import kz.flabs.dataengine.IDBConnectionPool;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.UsersActivityType;
import kz.flabs.dataengine.h2.Database;
import kz.flabs.runtimeobj.document.BaseDocument;
import kz.flabs.util.Util;

import java.sql.Connection;
import java.sql.SQLException;
import java.sql.Statement;

public class PostUndelete extends Thread {
	private IDBConnectionPool dbPool;		
	private BaseDocument recoverDoc;
	private String userID;
	private String dbID;

	protected PostUndelete(IDatabase db, BaseDocument recoverDoc, String userID){
		dbPool = db.getConnectionPool();
		dbID = db.getDbID();
		this.recoverDoc = recoverDoc;
		this.userID = userID;
	}


	public void run() {
		Connection conn = dbPool.getConnection();
		try {			
			conn.setAutoCommit(false);
			Statement s = conn.createStatement();
			String sql = "insert into USERS_ACTIVITY(TYPE, DBID, USERID, EVENTTIME, DOCID, DOCTYPE, VIEWTEXT, DDBID) values ("
				+ UsersActivityType.UNDELETED.getCode() + ",'" + dbID + "', '" + userID + "','" + Database.sqlDateTimeFormat.format(new java.util.Date()) +
				"', " + recoverDoc.getDocID() + ", " + recoverDoc.docType + ", '" + Util.removeHTMLTags(recoverDoc.getViewText().replace("'", "''")) + "', '" + recoverDoc.getDdbID() + "')";

			s.executeUpdate(sql, Statement.RETURN_GENERATED_KEYS);	
			sql = "DELETE FROM RECYCLE_BIN WHERE AID = " + recoverDoc.getValueAsInteger("recID");
			s.execute(sql);
			conn.commit();	
			s.close();
		} catch (SQLException e) {
			DatabaseUtil.errorPrint(dbID,e);		
		} catch (Exception e) {
			DatabaseUtil.errorPrint(dbID,e);			
		} finally {			
			dbPool.returnConnection(conn);
		}
		//return key;
	}
}
