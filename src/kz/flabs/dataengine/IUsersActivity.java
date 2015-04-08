package kz.flabs.dataengine;

import kz.flabs.appenv.AppEnv;
import kz.flabs.runtimeobj.document.BaseDocument;
import kz.flabs.runtimeobj.document.Document;
import kz.flabs.runtimeobj.viewentry.ViewEntryCollection;
import kz.flabs.servlets.BrowserType;

import java.sql.Connection;
import java.util.HashSet;
import java.util.Set;

public interface IUsersActivity {
	IDatabase getParentDatabase();
	
	int postSomeActivity(String event, String userID);
	int isRead(int docID, int docType, String userName);
	int isRead(Connection conn, int docID, int docType, String userName);

    int postRemoveFromFavorites(int docID, int docType, String userID, HashSet<String> groups);

    int postMarkRead(int docID, int docType, String userID);
	int postMarkUnread(int docID, int docType, String userID);

    int postAddToFavorites(int docID, int docType, String userID, HashSet<String> groups);

	int postCompose(Document doc, String userID);
	int postModify(Document oldDoc, Document modifiedDoc, String userID);
	int postDelete(BaseDocument doc, String userID);
	int postUndelete(BaseDocument doc, String userID);	
	int postLogin(BrowserType agent, String ipAddr, String userID);
	int postLogout(String userID);

	StringBuffer getUsersWhichRead(int docID, int docType);
	StringBuffer getUsersWhichRead(int docID, int docType, AppEnv env);
	int getAllActivityCount();
	StringBuffer getAllActivity(int offset, int pageSize);

	ViewEntryCollection getCurrentActivitiesByID(int offset, int pageSize, String pav_id);

	ViewEntryCollection getUnprocessedActivities(int offset, int pageSize);

	ViewEntryCollection getAllActivitiesByUser(int offset, int pageSize);

	ViewEntryCollection getAllActivities(int offset, int pageSize);
	StringBuffer getActivity(int docID, int docType);

	StringBuffer getActivity(String userID);
	int getActivityCount(int activityType, String userID);
	int postCompletelyDelete(BaseDocument doc, String userID);
	Document getRecycleBinEntry(int docID, Set<String> complexUserID, String absoluteUserID);
	StringBuffer getActivity(String userID, int offset, int pageSize, int... typeCodes);
    StringBuffer getActivityByService(String serviceName, int offset, int pageSize, int... typeCodes);
	
	int getActivitiesCount(String userID, int...typeCodes);
	ViewEntryCollection getActivities(int offset, int pageSize, String userID, int[] typeCodes);
}
