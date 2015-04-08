package kz.flabs.dataengine.h2.forum;

import java.util.Set;

import kz.flabs.dataengine.DatabaseUtil;
import kz.flabs.dataengine.ISelectFormula;
import kz.flabs.parser.FormulaBlocks;
import kz.flabs.users.RunTimeParameters.Filter;
import kz.flabs.users.RunTimeParameters.Sorting;

public class ForumQueryFormula implements ISelectFormula {

	public ForumQueryFormula(FormulaBlocks queryFormulaBlocks) {	
		
	}

	@Override
	public String getCondition(Set<String> complexUserID, int pageSize,	int offset, String[] filters, String[] sorting,	boolean checkResponse) {
		return null;
	}

	@Override
	public String getCountCondition(Set<String> complexUserID, String[] filters) {
		return null;
	}

	@Override
	public String getCondition(Set<String> complexUserID, int pageSize,	int offset, Set<Filter> filters, Set<Sorting> sorting,	boolean checkResponse) {
		 String sql = "select tc.count,   case when exists(select 1 from posts where posts.parentdocid = t.docid) then 1 else 0 end as parent_exist, docid, doctype, author, theme,content,regdate," +
				 		"sign,signedfields, citationindex, ispublic, status,parentdocid,parentdoctype,viewtext1,viewtext2,viewtext3,viewnumber,viewdate,defaultruleid," +
				 		"lastupdate,viewtext,topicdate,form,viewtext4,viewtext5,viewtext6,viewtext7,ddbid from (select count(*) from topics) as tc, topics t " +
				 		"where exists(select 1  from readers_topics rt where rt.USERNAME IN (" + DatabaseUtil.prepareListToQuery(complexUserID) + "))";
		return sql;
	}

	@Override
	public String getCountCondition(Set<String> complexUserID,	Set<Filter> filters) {
		return null;
	}

	@Override
	public String getCondition(Set<String> users, int pageSize, int offset,	Set<Filter> filters, Set<Sorting> sorting, boolean checkResponse, String responseQueryCondition) {
		return null;
	}

}
