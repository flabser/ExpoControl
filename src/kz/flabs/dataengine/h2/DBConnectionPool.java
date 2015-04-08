package kz.flabs.dataengine.h2;

import java.sql.*;
import java.util.NoSuchElementException;
import java.util.Properties;

import kz.flabs.dataengine.*;
import org.apache.commons.dbcp.ConnectionFactory;
import org.apache.commons.dbcp.DriverManagerConnectionFactory;
import org.apache.commons.dbcp.PoolableConnectionFactory;
import org.apache.commons.dbcp.PoolingDataSource;
import org.apache.commons.pool.impl.GenericObjectPool;

public class DBConnectionPool  implements IDBConnectionPool {
    protected GenericObjectPool connectionPool;
    protected static int timeBetweenEvictionRunsMillis = 1000 * 60 * 15;

    private boolean isValid;
    private DatabaseType dt = DatabaseType.DEFAULT;
    public void initConnectionPool(String driver, String dbURL, String userName, String password) throws DatabasePoolException, InstantiationException, IllegalAccessException, ClassNotFoundException {
        Properties props = null;
        Class.forName(driver).newInstance();
        connectionPool = new GenericObjectPool(null);
        connectionPool.setTestOnBorrow(true);
        connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_BLOCK);
        connectionPool.setMaxWait(15000);
        connectionPool.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);

        props = new Properties();
        props.setProperty("user", userName);
        props.setProperty("password", password);
        props.setProperty("accessToUnderlyingConnectionAllowed", "true");

        ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(dbURL, props);
        new PoolableConnectionFactory(connectionFactory, connectionPool, null, "SELECT 1", false, true);
        new PoolingDataSource(connectionPool);
        connectionPool.setMaxIdle(200);
        connectionPool.setMaxActive(2000);

        dt = DatabaseUtil.getDatabaseType(dbURL);

        checkConnection();
        isValid = true;
    }

    public void initConnectionPool(String driver, String dbURL) throws DatabasePoolException, InstantiationException, IllegalAccessException, ClassNotFoundException {
        Class.forName(driver).newInstance();
        connectionPool = new GenericObjectPool(null);
        connectionPool.setTestOnBorrow(true);
        connectionPool.setWhenExhaustedAction(GenericObjectPool.WHEN_EXHAUSTED_BLOCK);
        connectionPool.setMaxWait(15000);
        connectionPool.setTimeBetweenEvictionRunsMillis(timeBetweenEvictionRunsMillis);

        ConnectionFactory connectionFactory = new DriverManagerConnectionFactory(dbURL, null,null);
        new PoolableConnectionFactory(connectionFactory, connectionPool, null, "SELECT 1", false, true);
        new PoolingDataSource(connectionPool);
        connectionPool.setMaxIdle(200);
        connectionPool.setMaxActive(2000);

        dt = DatabaseUtil.getDatabaseType(dbURL);

        checkConnection();
        isValid = true;
    }

    public Connection getConnection(){
        Connection con = null;
        try{
            con = (Connection) connectionPool.borrowObject();
            con.setAutoCommit(false);
        }catch(NoSuchElementException nsee){
            Database.logger.errorLogEntry(nsee);
        } catch (SQLException e) {
            DatabaseUtil.debugErrorPrint(e);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return con;
    }

    public void returnConnection(Connection con) {
        if (con == null) {
            //System.err.println("Returning NULL to pool!!!");
            return;
        }

        try {
            connectionPool.returnObject(con);
        } catch (Exception ex) {
            ex.fillInStackTrace();
        }
    }

    public void close(Connection conn) {
		/*	if (null != conn) {
			try {
		//		conn.close();
	//		} catch (SQLException e) {
				//e.printStackTrace();
			}	

		}*/
    }

    @Override
    public DatabaseType getDatabaseType() {
        return dt;
    }

    public void closeAll() {
        connectionPool.clear();
        try {
            connectionPool.close();
        } catch (Exception e) {
            Database.logger.errorLogEntry(e);
        }
    }

    public int getNumActive() {
        return connectionPool.getNumActive();
    }

    public String toXML() {
        return "<active>" + connectionPool.getNumActive() + "</active>" +
                "<idle>" +  connectionPool.getNumIdle() + "</idle>" +
                "<maxactive>" +  connectionPool.getMaxActive() + "</maxactive>" +
                "<maxidle>" +  connectionPool.getMaxIdle() + "</maxidle>";
    }

    private void checkConnection() throws DatabasePoolException{
        Connection con = null;
        try{
            con = (Connection) connectionPool.borrowObject();
            con.setAutoCommit(false);
        } catch (SQLException e) {
            DatabaseUtil.errorPrint(e);
            if (e.getMessage().contains("Connection refused")){
                throw new DatabasePoolException(DatabasePoolExceptionType.DATABASE_CONNECTION_REFUSED);
            }else if(e.getMessage().contains("password authentication failed")){
                throw new DatabasePoolException(DatabasePoolExceptionType.DATABASE_AUTHETICATION_FAILED);
            }else{
                throw new DatabasePoolException(DatabasePoolExceptionType.DATABASE_SQL_ERROR);
            }
        } catch (Exception e) {
            Database.logger.errorLogEntry(e);
        }finally{
            returnConnection(con);
        }
    }

}
