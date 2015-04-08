package kz.flabs.servlets;

import kz.flabs.appdaemon.AppDaemonRule;
import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.DatabasePoolException;
import kz.flabs.dataengine.DatabaseType;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.IDatabaseDeployer;
import kz.flabs.runtimeobj.Application;
import kz.flabs.webrule.scheduler.IScheduledProcessRule;
import kz.flabs.webrule.scheduler.ScheduleType;
import kz.pchelka.env.Environment;
import kz.pchelka.log.Log4jLogger;
import kz.pchelka.scheduler.IDaemon;

import javax.servlet.ServletConfig;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;

public class PortalInit extends HttpServlet{ 

	private static final long serialVersionUID = -8913620140247217298L;
	private boolean isValid;

	public void init (ServletConfig config)throws ServletException{
		ServletContext context = config.getServletContext();
		String app = context.getServletContextName();
		AppEnv.logger = new Log4jLogger(app);
		AppEnv env = null;


		if (app.equalsIgnoreCase("Administrator")){
			try{
				env = new AppEnv(app);
				Environment.systemBase = new kz.flabs.dataengine.h2.SystemDatabase();	
				isValid = true;
			}catch(DatabasePoolException e){
				AppEnv.logger.fatalLogEntry("Server has not connected to system database");
			}catch(Exception e){
				AppEnv.logger.errorLogEntry(e);
			}
		}else{
			String global = Environment.webAppToStart.get(app).global;
			env = new AppEnv(app, global);
			if (env.globalSetting.databaseEnable){
				IDatabaseDeployer dd = null;
				try{
					if (env.globalSetting.databaseType == DatabaseType.POSTGRESQL){
						dd = new kz.flabs.dataengine.postgresql.DatabaseDeployer(env);
						if (env.globalSetting.autoDeployEnable){
							AppEnv.logger.normalLogEntry("Checking database structure ...");
							dd.deploy();		

						}
						env.setDataBase(new kz.flabs.dataengine.postgresql.Database(env));	
					    env.globalSetting.serializeKey();
					} else if (env.globalSetting.databaseType == DatabaseType.MSSQL) {
						dd = new kz.flabs.dataengine.mssql.DatabaseDeployer(env);
						if (env.globalSetting.autoDeployEnable){
							AppEnv.logger.normalLogEntry("Checking database structure ...");
							dd.deploy();		

						}
						env.setDataBase(new kz.flabs.dataengine.mssql.Database(env));
					    env.globalSetting.serializeKey();
					}else if (env.globalSetting.databaseType == DatabaseType.NSF) {
						dd = new kz.flabs.dataengine.nsf.DatabaseDeployer(env);
						IDatabase db = new kz.flabs.dataengine.nsf.Database(env);
						env.setDataBase(db);
						env.globalSetting.serializeKey();
					} else {
						dd = new kz.flabs.dataengine.h2.DatabaseDeployer(env);
						if (env.globalSetting.autoDeployEnable){
							AppEnv.logger.normalLogEntry("Checking database structure ...");
							dd.deploy();	
						}
						env.setDataBase(new kz.flabs.dataengine.h2.Database(env));
					}
					Environment.addDatabases(env.getDataBase());
					env.ruleProvider.loadRules();
					dd.patch();
					isValid = true;
                
				}catch(DatabasePoolException e){
					AppEnv.logger.fatalLogEntry("Application \"" + env.appType + "\" has not connected to database " + env.globalSetting.databaseType + "(" + env.globalSetting.dbURL + ")");
					Environment.reduceApplication();
				}catch(Exception e){
					AppEnv.logger.errorLogEntry(e);
					Environment.reduceApplication();
				}

			}else{
				env.setDataBase(new kz.flabs.dataengine.nodatabase.Database(env));					
				isValid = true;
			}

			
			
			if(isValid){				

                Environment.addApplication(env);

				if (env.globalSetting.databaseEnable){		
					for(AppDaemonRule rule:env.globalSetting.schedSettings){
						try{
							Class c = Class.forName(rule.getClassName());					
							IDaemon daemon =  (IDaemon)c.newInstance();
							daemon.init(rule);
				//			Environment.scheduler.addProcess(rule, daemon);		instead You should use handler written in Groovy 
						}catch (InstantiationException e) {
							AppEnv.logger.errorLogEntry(e);
						} catch (IllegalAccessException e) {
							AppEnv.logger.errorLogEntry(e);
						} catch (ClassNotFoundException e) {
							AppEnv.logger.errorLogEntry(e);
						}
					}

					for(IScheduledProcessRule rule:env.ruleProvider.getScheduledRules()){
						if (rule.getScheduleType() != ScheduleType.UNDEFINED){
							try{
								if(rule.scriptIsValid()){
									Class c = Class.forName(rule.getClassName());
									IDaemon daemon =  (IDaemon)c.newInstance();
									daemon.init(rule);								
									Environment.scheduler.addProcess(rule, daemon);
								}
							}catch (InstantiationException e) {
								AppEnv.logger.errorLogEntry(e);
							} catch (IllegalAccessException e) {
								AppEnv.logger.errorLogEntry(e);
							} catch (ClassNotFoundException e) {
								AppEnv.logger.errorLogEntry("Class not found class=" + rule.getClassName());
							} catch(ClassCastException e){
								AppEnv.logger.errorLogEntry(e);
							}catch(Exception e){
								AppEnv.logger.errorLogEntry(e);
							}
						}
					}
				}
				env.application = new Application(env);
			}

		}

		if(isValid)	context.setAttribute("portalenv", env);

	}
}
