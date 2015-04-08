package kz.flabs.runtimeobj.page;

import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.Const;
import kz.flabs.users.UserSession;
import kz.flabs.webrule.page.PageRule;

public class IncludedPage extends Page implements Const {
	
	/*IncludedPage(AppEnv env, UserSession userSession, PageRule rule, HttpServletRequest request,  HttpServletResponse response){
		super(env,userSession,rule, request ,response);
	}*/
	
	public IncludedPage(AppEnv env, UserSession userSession, PageRule rule){
		super(env,userSession,rule);
	}
	
	public String getID(){
		return "INCLUDED_PAGE_" + rule.id + "_" + userSession.lang;
		
	}
	
	
}
