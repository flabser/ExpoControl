package kz.flabs.dataengine;

import kz.flabs.users.RunTimeParameters.Filter;
import kz.flabs.users.RunTimeParameters.Sorting;

import java.util.Set;

public interface ISelectFormula {
	@Deprecated
	String getCondition(Set<String> complexUserID, int pageSize, int offset, String[] filters, String[] sorting, boolean checkResponse);
	@Deprecated
	String getCountCondition(Set<String> complexUserID,String[] filters);	
	
	String getCondition(Set<String> complexUserID, int pageSize, int offset, Set<Filter> filters, Set<Sorting> sorting, boolean checkResponse);
	String getCountCondition(Set<String> complexUserID, Set<Filter> filters);

    String getCondition(Set<String> users, int pageSize, int offset, Set<Filter> filters, Set<Sorting> sorting, boolean checkResponse, String responseQueryCondition);
}
