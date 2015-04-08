package kz.flabs.dataengine;

import java.util.ArrayList;
import java.util.Set;
import kz.flabs.exception.DocumentAccessException;
import kz.flabs.runtimeobj.document.DocID;
import kz.flabs.runtimeobj.document.task.Task;
import kz.flabs.webrule.query.QueryFieldRule;

public interface ITasks {
	
	ArrayList<Task> getTasksByCondition(String condition, Set<String> complexUserID, String absoluteUserID);
	int getTasksCountByCondition(String condition, Set<String> complexUserID, String absoluteUserID);
	StringBuffer getTasksByCondition(String condition, Set<String> complexUserID, String absoluteUserID, QueryFieldRule[] fields, Set<DocID> toExpandResponses, int offset, int pageSize);
	StringBuffer getTasksByCondition(IQueryFormula condition, Set<String> complexUserID, String absoluteUserID, QueryFieldRule[] fields, Set<DocID> toExpandResponses, int offset, int pageSize);
	Task getTaskByID(int docID, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException;	
	int insertTask(Task doc, Set<String> complexUserID, String absoluteUserID);
	int updateTask(Task doc, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException;
	int executorReset(Task doc, Set<String> complexUserID, String absoluteUserID, String executor, String resetAuthor) throws DocumentAccessException;
	Object getTasksForReport(String string, Set<String> userGroups,	String userID, QueryFieldRule[] fields, Set<DocID> toExpandResp,int calcStartEntry, int pageSize);
	int getTasksCountByCondition(IQueryFormula nf, Set<String> userGroups,	String userID);
	int recalculate();
	int recalculate(int docID);	
	//int recalculate(Calendar data);
}
