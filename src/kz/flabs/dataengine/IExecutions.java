package kz.flabs.dataengine;

import kz.flabs.exception.DocumentAccessException;
import kz.flabs.exception.DocumentException;
import kz.flabs.runtimeobj.document.Execution;
import java.util.Set;

public interface IExecutions {
	Execution getExecutionByID(int docID, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException;
	int insertExecution(Execution doc, Set<String> complexUserID, String absoluteUserID) throws DocumentException;
	int updateExecution(Execution doc, Set<String> complexUserID, String absoluteUserID) throws DocumentAccessException, DocumentException;	
	
}
