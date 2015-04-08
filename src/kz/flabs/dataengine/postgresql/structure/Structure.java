package kz.flabs.dataengine.postgresql.structure;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import kz.flabs.dataengine.*;


public class Structure extends kz.flabs.dataengine.h2.structure.Structure implements IStructure, Const{	

	public Structure(IDatabase db, IDBConnectionPool structDbPool) {	
		super(db, structDbPool);
	}
	
	public StringBuffer getEmployersByFrequencyExecution() {
		StringBuffer xmlContent = new StringBuffer(10000);
		Connection conn = dbPool.getConnection();
		try {
			conn.setAutoCommit(false);
			Statement s = conn.createStatement(ResultSet.TYPE_FORWARD_ONLY,	ResultSet.CONCUR_READ_ONLY);
			String sql = "select e.userid, e.viewtext, " + DatabaseUtil.getViewTextList("e") + ", e.viewnumber, e.viewdate, e.post, e.empid, e.fullname, count(cf.value) as numEntries " +
					" from employers as e " +
					" left join custom_fields as cf on cf.name = 'executer' and cf.value = e.userid " +
					" group by e.userid, e.viewtext, " + DatabaseUtil.getViewTextList("e") + ", e.viewnumber, e.viewdate, e.post, e.empid, e.fullname " +
					" order by count(cf.value) desc";
			ResultSet rs = s.executeQuery(sql);		
			while (rs.next()) {
				xmlContent.append(getEmployerEntry(rs));		
			}
			s.close();
			conn.commit();
		} catch (SQLException e) {
			DatabaseUtil.errorPrint(db.getDbID(), e);
		} finally {
			dbPool.returnConnection(conn);
		}
		return xmlContent;
	}

}

