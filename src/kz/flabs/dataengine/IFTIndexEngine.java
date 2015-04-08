package kz.flabs.dataengine;

import kz.flabs.exception.ComplexObjectException;
import kz.flabs.exception.DocumentException;
import kz.flabs.users.User;
import kz.nextbase.script._ViewEntryCollection;

import java.util.Set;

public interface IFTIndexEngine {
	@Deprecated
	int ftSearchCount(Set<String> complexUserID, String absoluteUserID, String keyWord) throws DocumentException, ComplexObjectException;
	@Deprecated
	StringBuffer ftSearch(Set<String> complexUserID, String absoluteUserID,  String keyWord, int offset, int pageSize) throws DocumentException, FTIndexEngineException, ComplexObjectException;

	int updateFTIndex() throws FTIndexEngineException;
	
	_ViewEntryCollection search(String keyWord,User user,int pageNum,int pageSize, String[] sorting, String[] filters) throws FTIndexEngineException;
}
