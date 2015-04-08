package kz.flabs.appenv;

import kz.flabs.dataengine.Const;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.IGlossariesTuner;
import kz.flabs.exception.DocumentAccessException;
import kz.flabs.exception.DocumentException;
import kz.flabs.exception.QueryException;
import kz.flabs.exception.RuleException;
import kz.flabs.localization.Localizator;
import kz.flabs.localization.LocalizatorException;
import kz.flabs.localization.Vocabulary;
import kz.flabs.parser.QueryFormulaParserException;
import kz.flabs.runtimeobj.Application;
import kz.flabs.runtimeobj.caching.ICache;
import kz.flabs.runtimeobj.page.Page;
import kz.flabs.webrule.GlobalSetting;
import kz.flabs.webrule.Lang;
import kz.flabs.webrule.Role;
import kz.flabs.webrule.WebRuleProvider;
import kz.flabs.webrule.constants.RunMode;
import kz.flabs.webrule.module.ExternalModule;
import kz.flabs.webrule.module.ExternalModuleType;
import kz.pchelka.env.AuthTypes;
import kz.pchelka.env.Environment;
import kz.pchelka.env.Site;
import kz.pchelka.scheduler.IProcessInitiator;
import kz.pchelka.scheduler.Scheduler;
import kz.pchelka.server.Server;

import java.io.File;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

public class AppEnv implements Const, ICache, IProcessInitiator { 
	public boolean isValid;
	public String appType = "undefined";	
	public WebRuleProvider ruleProvider;
	public HashMap<String, File> xsltFileMap = new HashMap<String, File>();
//	public String rulePath;
	public String adminXSLTPath;	
	public static kz.pchelka.log.ILogger logger;	
	public GlobalSetting globalSetting;
	public boolean isSystem;
	public boolean isWorkspace;
	public AuthTypes authType = AuthTypes.WORKSPACE;
	public Vocabulary vocabulary;
	public Scheduler scheduler;
	public Application application;
	
	
	private IDatabase dataBase;
	private HashMap<String, StringBuffer> cache = new HashMap<String, StringBuffer>();

	public AppEnv(String at){
		isSystem = true;
		isValid = true;
		appType = "administrator";
	}


	public AppEnv(String appType, String globalFileName){
		this.appType = appType;
		try{			
			AppEnv.logger.normalLogEntry("# Start application \"" + appType + "\"");
			Site appSite = Environment.webAppToStart.get(appType);
			if (appSite != null) authType = appSite.authType;
	//		rulePath = "rule" + File.separator + appType;	
			ruleProvider = new WebRuleProvider(this);		
			ruleProvider.initApp(globalFileName);
			globalSetting = ruleProvider.global;			
			isWorkspace = globalSetting.isWorkspace;
			if (globalSetting.isOn == RunMode.ON){				
				if (globalSetting.langsList.size() > 0){
					AppEnv.logger.normalLogEntry("Dictionary is loading...");

					try{
						Localizator l = new Localizator(globalSetting);
						vocabulary = l.populate("vocabulary");
						if (vocabulary != null){
							AppEnv.logger.normalLogEntry("Dictionary has loaded");
						}							
					}catch(LocalizatorException le){
						AppEnv.logger.verboseLogEntry(le.getMessage());
					}

				}
				isValid = true;
			}else{
				AppEnv.logger.warningLogEntry("Application: \"" + appType + "\" is off");
				Environment.reduceApplication();
			}

		}catch(Exception e) {
			AppEnv.logger.errorLogEntry(e);	
			//e.printStackTrace();
		}
	}

	public void setDataBase(IDatabase db) {
		if(!db.getDbID().equalsIgnoreCase("NoDatabase")){
			int cv = db.getVersion();
			if(cv != Server.necessaryDbVersion){
				AppEnv.logger.warningLogEntry("Database version do not accord to compatible version with core of the server (necessary:" + Server.necessaryDbVersion + ", current=" + cv + ")");	
			}
			this.dataBase = db;
			//	checkLangsSupport();
		}else{
			this.dataBase = db;
		}
	}
	
	public ArrayList<Role> getRolesList(){
		ArrayList <Role> rolesList = (ArrayList<Role>) globalSetting.roleCollection.getRolesList().clone();
		for(AppEnv extApp: Environment.getApplications()){
			for(ExternalModule module:extApp.globalSetting.extModuleMap.values()){
				if (module.getType() == ExternalModuleType.STRUCTURE && module.getName().equalsIgnoreCase(appType)){
					rolesList.addAll(extApp.getRolesList());
				}
			}
		}		
		return rolesList;
	}
	

	
	public HashMap<String, Role> getRolesMap(){
		HashMap<String, Role> rolesMap = (HashMap<String, Role>) globalSetting.roleCollection.getRolesMap().clone();
		for(AppEnv extApp: Environment.getApplications()){
			for(ExternalModule module:extApp.globalSetting.extModuleMap.values()){
				if (module.getType() == ExternalModuleType.STRUCTURE && module.getName().equalsIgnoreCase(appType)){
					rolesMap.putAll(extApp.getRolesMap());
				}
			}
		}	
		return rolesMap;
	}
	
	public IDatabase getDataBase() {
		return dataBase;
	}

	public String toString(){
		return Server.serverTitle + "-" + appType;
	}


	private boolean checkLangsSupport(){
		ArrayList<Lang> unsupportedlangs = new ArrayList<Lang>();
		IGlossariesTuner glosTuner = dataBase.getGlossaries().getGlossariesTuner();
		ArrayList<String> langs = glosTuner.getSupportedLangs();
		for(Lang lang: globalSetting.langsList){
			if ((!langs.contains(lang.id)) && (!lang.isPrimary)){
				unsupportedlangs.add(lang);
			}
		}

		for(Lang lang: unsupportedlangs){
			AppEnv.logger.warningLogEntry("Tune database to support lang (" + lang + ")");
			glosTuner.addLang(lang);
		}

		return true;

	}


	@Override
	public StringBuffer getPage(Page page, Map<String, String[]> formData) throws ClassNotFoundException, RuleException, QueryFormulaParserException, DocumentException, DocumentAccessException, QueryException {
		boolean reload = false;
		Object obj = cache.get(page.getID());	
		String p[] = formData.get("cache");
		if (p != null){
			String cacheParam = formData.get("cache")[0];	
			if (cacheParam.equalsIgnoreCase("reload")){
				reload = true;
			}
		}		
		if (obj == null || reload){
			StringBuffer buffer = page.getContent(formData);
			cache.put(page.getID(),buffer);
			return buffer;
		}else{
			return (StringBuffer)obj;	
		}

	}


	@Override
	public void flush() {
		cache.clear();
	}

	
	@Override
	public String getOwnerID() {
		return appType;
	}


	public static String getName() {

		return "appType";
	}


	

}
