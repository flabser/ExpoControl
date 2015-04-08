package kz.flabs.dataengine;

import kz.flabs.exception.DocumentAccessException;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.Set;
import kz.flabs.exception.DocumentException;
import kz.flabs.parser.QueryFormulaParserException;
import kz.flabs.runtimeobj.document.BaseDocument;
import kz.flabs.runtimeobj.document.DocID;
import kz.flabs.runtimeobj.document.project.Project;
import kz.flabs.webrule.query.QueryFieldRule;

public interface IProjects {
	int getProjectsByConditionCount(IQueryFormula condition, Set<String> complexUserID, String absoluteUserID);
	StringBuffer getProjectsByCondition(IQueryFormula condition, Set<String> complexUserID, String absoluteUserID, QueryFieldRule[] fields, int offset, int pageSize, Set<DocID> toExpandResp) throws DocumentException;
	Project getProjectByID(int docID, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException;
	int insertProject(Project doc, Set<String> complexUserID, String absoluteUserID) throws DocumentException;
	int updateProject(Project doc, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException, DocumentException ;
	ArrayList<BaseDocument> getDocumentsByCondition(String condition, HashSet<String> userGroups,
			String userID) throws QueryFormulaParserException, DocumentException, DocumentAccessException;	
	int recalculate();
	int recalculate(int docID);
    StringBuffer getStatisticsByAllObjects();
    StringBuffer getStatisticsByObject(int objectID);
    StringBuffer getStatisticByContragent(int objectID);
    StringBuffer getStatisticByContragentByProject(int contragentID, int projectID);
	ArrayList<BaseDocument> getProjectsByCondition(String condition,
			Set<String> complexUserID, String absoluteUserID)
			throws DocumentException, DocumentAccessException;
}
