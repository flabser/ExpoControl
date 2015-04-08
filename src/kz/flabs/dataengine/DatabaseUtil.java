package kz.flabs.dataengine;

import kz.flabs.dataengine.h2.Database;
import kz.flabs.runtimeobj.document.BaseDocument;
import kz.flabs.webrule.constants.QueryType;

import java.sql.*;
import java.util.Collection;
import java.util.Set;

public class DatabaseUtil implements Const {

    public static void errorPrint(Throwable e) {
        if (e instanceof SQLException) {
            SQLException sqle = (SQLException) e;
            SQLExceptionPrint(sqle);
        } else {
            Database.logger.errorLogEntry(e.toString());
            e.printStackTrace();
        }
    }

    public static void debugErrorPrint(Throwable e) {
        if (e instanceof SQLException) {
            SQLException sqle = (SQLException) e;
            SQLExceptionPrintDebug(sqle);
        } else {
            Database.logger.errorLogEntry(e.toString());
            e.printStackTrace();
        }
    }

    public static String getViewTextValues(BaseDocument doc) {
        String viewTextList = "";
        for (int i = 1; i <= DatabaseConst.VIEWTEXT_COUNT; i++) {
            viewTextList += "'" + doc.getViewTextList().get(i).replaceAll("'", "''") + "',";
        }
        if (viewTextList.endsWith(",")) {
            viewTextList = viewTextList.substring(0, viewTextList.length() - 1);
        }
        return viewTextList;
    }

    public static void errorPrint(String DbID, Throwable e) {
        Database.logger.errorLogEntry(DbID);
        if (e instanceof SQLException) {
            SQLException sqle = (SQLException) e;
            SQLExceptionPrintDebug(sqle);
        } else {
            Database.logger.errorLogEntry(e.toString());
            e.printStackTrace();
        }
    }

    public static void errorPrint(Throwable e, String sql) {
        Database.logger.errorLogEntry(sql);
        if (e instanceof SQLException) {
            SQLException sqle = (SQLException) e;
            SQLExceptionPrintDebug(sqle);
        } else {
            Database.logger.errorLogEntry(e.toString());
            e.printStackTrace();
        }
    }

    public static void SQLExceptionPrint(SQLException sqle) {
        while (sqle != null) {
            Database.logger.errorLogEntry("SQLState:   " + sqle.getSQLState());
            Database.logger.errorLogEntry("Severity: " + sqle.getErrorCode());
            Database.logger.errorLogEntry("Message:  " + sqle.getMessage());
            //Database.logger.errorLogEntry(sqle);
            sqle = sqle.getNextException();
        }
    }

    public static void SQLExceptionPrintDebug(SQLException sqle) {
        while (sqle != null) {
            Database.logger.errorLogEntry("SQLState:   " + sqle.getSQLState());
            Database.logger.errorLogEntry("Severity: " + sqle.getErrorCode());
            Database.logger.errorLogEntry("Message:  " + sqle.getMessage());
            Database.logger.errorLogEntry(sqle);
            sqle.printStackTrace();
            sqle = sqle.getNextException();
        }
    }

    public static boolean hasTable(String tableName, Connection conn) throws SQLException {
        try {
            DatabaseMetaData metaData = null;
            metaData = conn.getMetaData();
            String[] tables = {"TABLE"};
            ResultSet rs = metaData.getTables(null, null, null, tables);
            while (rs.next()) {
                String table = rs.getString("TABLE_NAME");
                if (tableName.equalsIgnoreCase(table)) {
                    return true;
                }
            }
            return false;
        } catch (Throwable e) {
            return false;
        }
    }

    public static boolean hasView(String viewName, Connection conn) throws SQLException {
        try {
            Statement s = conn.createStatement();
            ResultSet rs = s.executeQuery("SELECT * FROM INFORMATION_SCHEMA.VIEWS where upper(table_name) = '" + viewName.toUpperCase() + "'");
            if (rs.next()) {
                return true;
            }
            return false;
        } catch (Throwable e) {
            e.printStackTrace();
            return false;

        }
    }

    public static boolean hasProcedureAndTriger(String name, Connection conn) throws SQLException {
        try {
            DatabaseMetaData metaData = null;
            metaData = conn.getMetaData();
            ResultSet rs = metaData.getProcedures(null, null, null);
            while (rs.next()) {
                String procedure = rs.getString("PROCEDURE_NAME");
                if (name.equalsIgnoreCase(procedure)) {
                    return true;
                }
            }
            return false;
        } catch (Throwable e) {
            return false;
        }
    }

    public static boolean hasTrigger(String name, Connection conn) throws SQLException {
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery("select * from sys.triggers where name = '" + name + "'");
            if (rs.next()) {
                return true;
            }
            return false;
        } catch (Throwable e) {
            return false;
        }
    }

    public static DatabaseType getDatabaseType(String dbURL) {
        if ( dbURL.contains("postgresql") ) {
            return DatabaseType.POSTGRESQL;
        } else if (dbURL.contains("sqlserver")) {
            return DatabaseType.MSSQL;
        }else if (dbURL.contains("nsf")) {
            return DatabaseType.NSF;
        } else {
            return DatabaseType.H2;
        }
    }

    public static String prepareListToQuery(Collection<String> elements) {
        StringBuffer result = new StringBuffer(1000);
        if (elements != null) {
            for (String element : elements) {
                result.append("'" + element + "',");
            }
            if (result.length() != 0) {
                result = result.deleteCharAt(result.length() - 1);
            }
        }
        return result.toString();
    }

    public static String getPrimaryKeyColumnName(int docType) {
        String columnName;
        switch (docType) {
            case DOCTYPE_ORGANIZATION:
                columnName = "ORGID";
                break;
            case DOCTYPE_DEPARTMENT:
                columnName = "DEPID";
                break;
            case DOCTYPE_EMPLOYER:
                columnName = "EMPID";
                break;
            case DOCTYPE_GROUP:
                columnName = "GROUPID";
                break;
            case DOCTYPE_ACTIVITY_ENTRY:
            case DOCTYPE_RECYCLE_BIN_ENTRY:
                columnName = "ID";
                break;
            default:
                columnName = "DOCID";
        }
        return columnName;
    }

    public static String getViewTextList(String prefix) {
        String list = "";
        for (int i = 1; i <= DatabaseConst.VIEWTEXT_COUNT; i++) {
            list += (prefix.length() > 0 ? prefix + "." : "") + "VIEWTEXT" + i + ",";
        }
        if (list.endsWith(",")) {
            list = list.substring(0, list.length() - 1);
        }
        return list;
    }

/*    public static String get() {
        String viewTextList = "";
        for (int i = 1; i <= DatabaseConst.VIEWTEXT_COUNT; i++) {
            viewTextList += "'" + doc.getViewTextList().get(i).replaceAll("'", "''") + "',";
        }
        if (viewTextList.endsWith(",")) {
            viewTextList = viewTextList.substring(0, viewTextList.length()-1);
        }
        return viewTextList;
    }*/

    public static String getCustomBlobsTableName(int docType) {
        String tableName;
        switch (docType) {
            case DOCTYPE_MAIN:
            case DOCTYPE_TASK:
            case DOCTYPE_EXECUTION:
            case DOCTYPE_PROJECT:
            case DOCTYPE_EMPLOYER:
                tableName = "CUSTOM_BLOBS_" + getMainTableName(docType);
                break;
            default:
                throw new IllegalArgumentException("Document type is unknown");
        }

        return tableName;
    }

    @Deprecated
    public static String getReadersTableName(int docType) {
        return "READERS_" + getMainTableName(docType);
    }

    @Deprecated
    public static String getMainTableName(int docType) {
        String tableName = "";
        switch (docType) {
            case DOCTYPE_MAIN:
                tableName = "MAINDOCS";
                break;
            case DOCTYPE_TASK:
                tableName = "TASKS";
                break;
            case DOCTYPE_EXECUTION:
                tableName = "EXECUTIONS";
                break;
            case DOCTYPE_PROJECT:
                tableName = "PROJECTS";
                break;
            case DOCTYPE_GLOSSARY:
                tableName = "GLOSSARY";
                break;
            case DOCTYPE_ORGANIZATION:
                tableName = "ORGANIZATIONS";
                break;
            case DOCTYPE_DEPARTMENT:
                tableName = "DEPARTMENTS";
                break;
            case DOCTYPE_EMPLOYER:
                tableName = "EMPLOYERS";
                break;
            case DOCTYPE_GROUP:
                tableName = "GROUPS";
                break;
            case DOCTYPE_ACTIVITY_ENTRY:
                tableName = "USERS_ACTIVITY";
                break;
            case DOCTYPE_RECYCLE_BIN_ENTRY:
                tableName = "RECYCLE_BIN";
                break;
            case DOCTYPE_TOPIC:
                tableName = "TOPICS";
                break;
            case DOCTYPE_POST:
                tableName = "POSTS";
                break;
            default:
                throw new IllegalArgumentException("Document type is unknown");
        }
        return tableName;
    }

    public static boolean hasAbsoluteReadAccess(Set<String> complexUserID) {
        return (complexUserID.contains(Const.observerGroup[0]) && complexUserID.contains(Const.supervisorGroup[0]));
    }

    public static boolean hasFTIndex(Connection conn, String tableName) {
        String sql = "SELECT COUNT(*) FROM sys.fulltext_indexes where object_id = object_id('" + tableName + "')";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    return true;
                } else {
                    return false;
                }
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            DatabaseUtil.errorPrint(e, sql);
        }
        return false;
    }

    public static boolean hasFTCatalog(Connection conn, String catalogName) {
        String sql = "SELECT COUNT(*) FROM sys.fulltext_catalogs where name = '" + catalogName + "'";
        try {
            Statement st = conn.createStatement();
            ResultSet rs = st.executeQuery(sql);
            if (rs.next()) {
                int count = rs.getInt(1);
                if (count > 0) {
                    return true;
                } else {
                    return false;
                }
            }
            rs.close();
            st.close();
        } catch (SQLException e) {
            DatabaseUtil.errorPrint(e, sql);
        }
        return false;
    }

    public static String getCustomTableName(QueryType docType) {
        if (docType == QueryType.GLOSSARY) {
            return "CUSTOM_FIELDS_GLOSSARY";
        } else {
            return "CUSTOM_FIELDS";
        }
    }

    @Deprecated
    public static String resolveElement(int docType) {
        switch (docType) {
            case Const.DOCTYPE_TASK:
                return "task";
            case Const.DOCTYPE_EXECUTION:
                return "execution";
            case Const.DOCTYPE_PROJECT:
                return "project";
            default:
                return "document";
        }
    }
}
