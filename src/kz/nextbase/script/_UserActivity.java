package kz.nextbase.script;

import kz.flabs.dataengine.ActivityStatusType;
import kz.flabs.dataengine.IActivity;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.IUsersActivity;
import kz.flabs.runtimeobj.viewentry.ViewEntryCollection;
import kz.flabs.users.User;

import java.util.Date;

public class _UserActivity {
	private IUsersActivity act;
    private IActivity service_activity;
	private User user;
	
	public _UserActivity(IDatabase db, User currentUser) {
		act = db.getUserActivity();
        service_activity = db.getActivity();
		this.user = currentUser;
	}
	
	public void postActivity(String agent, String text){	
		act.postSomeActivity("[" + agent + "] " + text, user.getUserID());
	}
	
	public void postActivity(String agent, Exception e){	
		act.postSomeActivity("[" + agent + "] " + e.toString(), user.getUserID());
	}
	
	public void postActivity(String text){	
		act.postSomeActivity(text, user.getUserID());
	} 

    public void postStartActivity(String viewtext, String userid, String service, String method, String parameters, String springServer, String transaction, Date request_time) {
        service_activity.postStartOfActivity(viewtext, userid, service, method, parameters, springServer, transaction, request_time);
    }

    public void postStartActivity(String viewtext, String userid, String service, String method, String parameters, String springServer, String transaction, Date request_time, Integer minutes) {
        service_activity.postStartOfActivity(viewtext, userid, service, method, parameters, springServer, transaction, request_time, minutes);
    }

    public void postEndOfActivity(ActivityStatusType type, Date returnTime, String comment, int processedRec, int processedSize, String transaction) {
        service_activity.postEndOfActivity(type, returnTime, comment, processedRec, processedSize, transaction);
    }

	public void postEndOfActivity(Integer activityID) {
		service_activity.postEndOfActivity(activityID);
	}

    public void postEndOfFailureActivity(ActivityStatusType type, Date returnTime, String comment, String transaction) {
        service_activity.postEndOfFailureActivity(type, returnTime, comment, transaction);
    }

	public _ViewEntryCollection getActivity (String userID, String objectid, String transaction, String service, int pageSize, int pageNum, _Session session) {
		ViewEntryCollection col =  service_activity.getActivities(userID, objectid, transaction, service, pageSize);
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(session, col);
		return _col;
	}

	public _ViewEntryCollection getActivity (String userID, int pageNum, int pageSize, int... typeCodes) {		
		ViewEntryCollection col =  act.getActivities(act.getParentDatabase().calcStartEntry(pageNum, pageSize), pageSize, userID, typeCodes);
	//	if (pageNum = 0)pageNum = 
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(user, col);
		return _col;
	}

	public _ViewEntryCollection getAllActivities(int pageNum, int pageSize, _Session session) {
		ViewEntryCollection col = act.getAllActivities(pageNum, pageSize);
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(session, col);
		return _col;
	}

	public _ViewEntryCollection getAllActivitiesByUser(int pageNum, int pageSize, _Session session) {
		ViewEntryCollection col = act.getAllActivitiesByUser(pageNum, pageSize);
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(session, col);
		return _col;
	}

	public _ViewEntryCollection getUnprocessedActivities(int pageNum, int pageSize, _Session session) {
		ViewEntryCollection col = act.getUnprocessedActivities(pageNum, pageSize);
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(session, col);
		return _col;
	}

	public _ViewEntryCollection getCurrentActivitiesByID(int pageNum, int pageSize, _Session session, String pav_id) {
		ViewEntryCollection col = act.getCurrentActivitiesByID(pageNum, pageSize, pav_id);
		col.setCurrentPage(pageNum);
		_ViewEntryCollection _col = new _ViewEntryCollection(session, col);
		return _col;
	}

}
