package kz.pchelka.env;

import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.Const;
import kz.flabs.dataengine.IDatabase;
import kz.flabs.dataengine.ISystemDatabase;
import kz.flabs.exception.DocumentAccessException;
import kz.flabs.exception.DocumentException;
import kz.flabs.exception.QueryException;
import kz.flabs.exception.RuleException;
import kz.flabs.parser.QueryFormulaParserException;
import kz.flabs.runtimeobj.caching.ICache;
import kz.flabs.runtimeobj.page.Page;
import kz.flabs.util.XMLUtil;
import kz.flabs.webrule.constants.RunMode;
import kz.flabs.webrule.module.ExternalModuleType;
import kz.pchelka.daemon.system.BackupServiceRule;
import kz.pchelka.daemon.system.LogsZipRule;
import kz.pchelka.daemon.system.TempFileCleanerRule;
import kz.pchelka.log.ILogger;
import kz.pchelka.messenger.ConnectManager;
import kz.pchelka.messenger.InstMessageListener;
import kz.pchelka.scheduler.IDaemon;
import kz.pchelka.scheduler.IProcessInitiator;
import kz.pchelka.scheduler.Scheduler;
import kz.pchelka.server.Server;
import org.jivesoftware.smack.ChatManager;
import org.jivesoftware.smack.ConnectionConfiguration;
import org.jivesoftware.smack.SASLAuthentication;
import org.jivesoftware.smack.XMPPConnection;
import org.w3c.dom.Document;
import org.w3c.dom.Node;
import org.w3c.dom.NodeList;
import org.xml.sax.SAXException;

import javax.xml.parsers.*;
import java.io.File;
import java.io.IOException;
import java.net.InetAddress;
import java.net.UnknownHostException;
import java.util.ArrayList;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;

public class Environment implements Const, ICache, IProcessInitiator {
	public static boolean verboseLogging;
	public static int serverVersion;
	public static Boolean webServicesEnable = false;
	public static String serverName;
	public static String hostName;
	public static int httpPort = 38779;
	public static boolean noWSAuth = false;
	public static String httpSchema = "http";

	public static ISystemDatabase systemBase;
	public static String defaultSender = "";
	public static HashMap<String, String> mimeHash = new HashMap<String, String>();
	public static boolean adminConsoleEnable;	
	public static HashMap<String,Site> webAppToStart = new HashMap<String,Site>();
	public static String tmpDir;
	public static ArrayList<String> fileToDelete = new ArrayList<String>();
	public static ILogger logger;
	public static int delaySchedulerStart;
	public static Scheduler scheduler = new Scheduler();

	public static Boolean isSSLEnable = false;
	public static int secureHttpPort;
	public static String keyPwd = "";
	public static String keyStore = "";
	public static String trustStore;
	public static String trustStorePwd;
	public static boolean isClientSSLAuthEnable;

	public static Boolean remoteConsole = false;
	public static String remoteConsoleServer = "";
	public static int remoteConsolePort = 0;

	public static boolean XMPPServerEnable;	
	public static String XMPPServer;
	public static int XMPPServerPort;

	public static String XMPPLogin;
	public static String XMPPPwd;
	public static XMPPConnection connection;
	public static ChatManager chatmanager;

	public static String smtpPort;
	public static boolean smtpAuth;
    public static String SMTPHost;
    public static String smtpUser;
    public static String smtpPassword;
    public static Boolean mailEnable = false;

    public static boolean workspaceAuth;

    public static RunMode debugMode = RunMode.OFF;

	private static boolean schedulerStarted;
	private static HashMap<String, ExternalHost> externalHost = new HashMap<String, ExternalHost>();
	private static HashMap<String, AppEnv> applications = new HashMap<String, AppEnv>();
	private static HashMap<String, IDatabase> dataBases = new HashMap<String, IDatabase>();
	private static boolean xmppEnable;

	private static HashMap<String, Object> cache = new HashMap<String, Object>();
	private static int countOfApp;
	private static ArrayList<IDatabase> delayedStart = new ArrayList<IDatabase>();
	public static String backupDir;

	public static void init(){
		logger = Server.logger;	
		initProcess();
	}

	private static void initProcess(){
		try{			
			SAXParserFactory factory = SAXParserFactory.newInstance();
			factory.setValidating(true);
			SAXParser saxParser = factory.newSAXParser();		
			SAXHandler cfgXMLhandler = new SAXHandler();	
			File file = new File("cfg.xml");				
			saxParser.parse(file,cfgXMLhandler);	
			Document xmlDocument = getDocument();

			logger.normalLogEntry("Initialize runtime environment");
			initMimeTypes();

			try{
				int v = Integer.parseInt(XMLUtil.getTextContent(xmlDocument, "/nextbase/webserver/version"));
				if (v == 6 ){
					serverVersion = 6;
				}else{
					serverVersion = 7;
				}
			}catch(NumberFormatException e){
				serverVersion = 7;
			}

			webServicesEnable = XMLUtil.getTextContent(xmlDocument, "/nextbase/webserver/webservices/@mode").equalsIgnoreCase("on");



			hostName = XMLUtil.getTextContent(xmlDocument, "/nextbase/hostname");
			if (hostName.trim().equals("")){
				hostName = getHostName();
			}			

			serverName = XMLUtil.getTextContent(xmlDocument, "/nextbase/name");
			String portAsText = XMLUtil.getTextContent(xmlDocument, "/nextbase/port");
			try{
				httpPort = Integer.parseInt(portAsText);
				logger.normalLogEntry("WebServer is going to use port: " + httpPort);
			}catch (NumberFormatException nfe){
				logger.normalLogEntry("WebServer is going to use standart port");
			}

			try {
				String auth = XMLUtil.getTextContent(xmlDocument, "/nextbase/no-ws-auth");
				if ("true".equalsIgnoreCase(auth)) {
					noWSAuth = true;
				}
			} catch (Exception e) {
				noWSAuth = false;
			}

			try{
				if (XMLUtil.getTextContent(xmlDocument, "/nextbase/adminapp/@mode").equalsIgnoreCase("on")){;
				adminConsoleEnable = true;
				}
			}catch (Exception nfe){
				adminConsoleEnable = false;
			}

			try{
				delaySchedulerStart = Integer.parseInt(XMLUtil.getTextContent(xmlDocument, "/nextbase/scheduler/startdelaymin"));				
			}catch (Exception nfe){
				delaySchedulerStart = 1;
			}

			NodeList nodeList = XMLUtil.getNodeList(xmlDocument, "/nextbase/applications");
			if (nodeList.getLength() > 0) {
				org.w3c.dom.Element root = xmlDocument.getDocumentElement();
				NodeList nodes = root.getElementsByTagName("app");
				for (int i = 0; i < nodes.getLength(); i++) {
					Node appNode = nodes.item(i);
					if (XMLUtil.getTextContent(appNode,"name/@mode", false).equals("on")){                    
						String appName = XMLUtil.getTextContent(appNode, "name", false);						
						Site site = new Site();
						site.appBase = appName;
						site.authType = AuthTypes.valueOf(XMLUtil.getTextContent(appNode, "authtype", false, "WORKSPACE", false));
						site.name = XMLUtil.getTextContent(appNode, "name/@sitename", false);
						String globalAttrValue = XMLUtil.getTextContent(appNode, "name/@global", false);
						if (!globalAttrValue.equals("")){
							site.global = globalAttrValue;
						}
						webAppToStart.put(appName, site);					
					}					
				}
			}

			countOfApp = webAppToStart.size();

			try {
				isSSLEnable = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/@mode").equalsIgnoreCase("on");
				if (isSSLEnable) {
					String sslPort = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/port");
					try{
						secureHttpPort = Integer.parseInt(sslPort);
					}catch (NumberFormatException nfe){
						secureHttpPort = 38789;
					}				
					keyPwd = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/keypass");
					keyStore = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/keystore");
					isClientSSLAuthEnable = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/clientauth/@mode").equalsIgnoreCase("on");
					if (isClientSSLAuthEnable) {
						trustStore = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/clientauth/truststorefile");
						trustStorePwd = XMLUtil.getTextContent(xmlDocument, "/nextbase/ssl/clientauth/truststorepass");
					}
					//logger.normalLogEntry("SSL is enabled. keyPass: " + keyPwd +", keyStore:" + keyStore);
					logger.normalLogEntry("TLS is enabled");
					httpSchema = "https";
				}
			} catch (Exception ex) {
				logger.normalLogEntry("TLS configiration error");
				isSSLEnable = false;
				keyPwd = "";
				keyStore = "";
			}

			try{
				mailEnable = (XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/@mode").equalsIgnoreCase("on")) ? true : false;
				if(mailEnable){
					SMTPHost = XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/smtphost");
					defaultSender = XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/defaultsender");
                    smtpAuth = Boolean.valueOf(XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/auth"));
                    smtpUser = XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/smtpuser");
                    smtpPassword = XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/smtppassword");
                    smtpPort = XMLUtil.getTextContent(xmlDocument, "/nextbase/mailagent/smtpport");
					logger.normalLogEntry("MailAgent is going to redirect some messages to host: " + SMTPHost);
				}else{
					logger.normalLogEntry("MailAgent is switch off");
				}
			}catch (NumberFormatException nfe){
				logger.normalLogEntry("MailAgent is not set");
				SMTPHost = "";
				defaultSender = "";
			}

			try{
				if(adminConsoleEnable){
					remoteConsole = (XMLUtil.getTextContent(xmlDocument, "/nextbase/adminapp/remoteconsole/@mode").equalsIgnoreCase("on")) ? true : false;
					if (remoteConsole){
						remoteConsoleServer = XMLUtil.getTextContent(xmlDocument, "/nextbase/adminapp/remoteconsole/server");
						remoteConsolePort = Integer.parseInt(XMLUtil.getTextContent(xmlDocument, "/nextbase/adminapp/remoteconsole/port"));
						logger.normalLogEntry("RemoteConsole server: " + remoteConsoleServer+" port: " + remoteConsolePort);
					} else {
						logger.normalLogEntry("RemoteConsole disabled");
					}
				}
			}catch (NumberFormatException nfe){
				logger.normalLogEntry("RemoteConsole is not set");
				remoteConsole = false;
				remoteConsoleServer = "";
				remoteConsolePort = 0;
			}

			try{
				xmppEnable = (XMLUtil.getTextContent(xmlDocument, "/nextbase/instmsgagent/@mode").equalsIgnoreCase("on")) ? true : false;
				if(xmppEnable){
					XMPPServer = XMLUtil.getTextContent(xmlDocument, "/nextbase/instmsgagent/xmppserver");
					try{
						String sp = XMLUtil.getTextContent(xmlDocument, "/nextbase/instmsgagent/xmppserverport");
						XMPPServerPort = Integer.parseInt(sp);
					}catch (NumberFormatException nfe){
						XMPPServerPort = 5222;
					}
					XMPPLogin = XMLUtil.getTextContent(xmlDocument, "/nextbase/instmsgagent/xmpplogin");
					XMPPPwd = XMLUtil.getTextContent(xmlDocument, "/nextbase/instmsgagent/xmpppwd");
					logger.normalLogEntry("InstantMessengerAgent is going to connect to server: " + XMPPServer);

					if ((!XMPPServer.equalsIgnoreCase("")) && (!XMPPLogin.equalsIgnoreCase(""))){
						ConnectManager chMan = new ConnectManager();
						chMan.start();
					}
				}

				XMPPServerEnable = true;


				ConnectionConfiguration config = new ConnectionConfiguration(XMPPServer, XMPPServerPort);
				SASLAuthentication.supportSASLMechanism("PLAIN");

				config.setCompressionEnabled(true);
				config.setSASLAuthenticationEnabled(true);

				connection = new XMPPConnection(config);			
				connection.connect();			
				connection.login(XMPPLogin, XMPPPwd, XMPPLogin);
				XMPPServerEnable = true;
				InstMessageListener listener = new InstMessageListener();
				chatmanager = connection.getChatManager();
				chatmanager.addChatListener(listener);
				/*
				try{
					RobotBorner l = new RobotBorner();
					if (l.populate()){
						vocabulary = l.getVocabulary();
					}							
				}catch(LocalizatorException le){
					AppEnv.logger.verboseLogEntry(le.getMessage());
				}*/

			}catch (NumberFormatException nfe){
				logger.normalLogEntry("InstantMessengerAgent is not enabled");			
			}catch (Exception e){
				verboseLogging = false;
			}

			try{							
				String res = XMLUtil.getTextContent(xmlDocument, "/nextbase/logging/verbose");
				if (res.equalsIgnoreCase("true")){
					verboseLogging = true;
					logger.warningLogEntry("Verbose logging is turned on");
				}
			}catch (Exception e){
				verboseLogging = false;
			}


			File tmp = new File("tmp");
			if (!tmp.exists()){
				tmp.mkdir();				
			}

			tmpDir = tmp.getAbsolutePath();			
			
			
			File backup = new File("backup");
			if (!backup.exists()){
				backup.mkdir();				
			}

			backupDir = backup.getAbsolutePath();
			

			NodeList hosts =  XMLUtil.getNodeList(xmlDocument,"/nextbase/externalhost/host");   
			for(int i = 0; i < hosts.getLength(); i++){
				ExternalHost host = new ExternalHost(hosts.item(i));						
				if (host.isOn != RunMode.OFF && host.isValid){					
					externalHost.put(host.id.toLowerCase(), host);
				}
			}

			if (XMLUtil.getTextContent(xmlDocument, "/nextbase/debug/@mode").equalsIgnoreCase("on")){
				debugMode = RunMode.ON;
			}
			

			{
				TempFileCleanerRule tfcr = new TempFileCleanerRule();
				tfcr.init(new Environment());	
				try{
					Class c = Class.forName(tfcr.getClassName());
					IDaemon daemon = (IDaemon)c.newInstance();
					daemon.init(tfcr);
					scheduler.addProcess(tfcr, daemon);		
				}catch (InstantiationException e) {
					logger.errorLogEntry(e);
				} catch (IllegalAccessException e) {
					logger.errorLogEntry(e);
				} catch (ClassNotFoundException e) {
					logger.errorLogEntry(e);
				}
			}

			{
				LogsZipRule lzr = new LogsZipRule();
				lzr.init(new Environment());
				try{
					Class c = Class.forName(lzr.getClassName());
					IDaemon daemon = (IDaemon)c.newInstance();
					daemon.init(lzr);
					scheduler.addProcess(lzr, daemon);					
				}catch (InstantiationException e) {
					logger.errorLogEntry(e);
				} catch (IllegalAccessException e) {
					logger.errorLogEntry(e);
				} catch (ClassNotFoundException e) {
					logger.errorLogEntry(e);
				}
			}

			{
//				BackupServiceRule bsr = new BackupServiceRule();
//				bsr.init(new Environment());
//				try{
//					Class c = Class.forName(bsr.getClassName());
//					IDaemon daemon = (IDaemon)c.newInstance();
//					daemon.init(bsr);
//					scheduler.addProcess(bsr, daemon);
//				}catch (InstantiationException e) {
//					logger.errorLogEntry(e);
//				} catch (IllegalAccessException e) {
//					logger.errorLogEntry(e);
//				} catch (ClassNotFoundException e) {
//					logger.errorLogEntry(e);
//				}
			}
		}catch(SAXException se){
			logger.errorLogEntry(se);
		}catch(ParserConfigurationException pce){
			logger.errorLogEntry(pce);
		}catch(IOException ioe){
			logger.errorLogEntry(ioe);
		}
	}
	public static void reduceApplication(){
		countOfApp -- ;
	}
	
	
	public static void addApplication(AppEnv env){
		applications.put(env.appType, env);	
		if (env.isWorkspace){
			workspaceAuth = true;
		}
		

		if(applications.size() >= countOfApp){
			if (delayedStart.size() > 0){ 
				for(IDatabase db:delayedStart){
					logger.normalLogEntry("Connecting to external module " + db.initExternalPool(ExternalModuleType.STRUCTURE));
					if (!schedulerStarted){
						Thread schedulerThread = new Thread(scheduler);
						schedulerThread.start();
						schedulerStarted = true;
					}
				}			
			}else{
				Thread schedulerThread = new Thread(scheduler);
				schedulerThread.start();
				schedulerStarted = true;
			}
			delayedStart = new ArrayList<>();
		}
	}

	public static void addDelayedInit(IDatabase db){
		delayedStart.add(db);
	}



	public static void addDatabases(IDatabase dataBase){
		dataBases.put(dataBase.getDbID(), dataBase);	
	}

	public static AppEnv getApplication(String appID){
		return applications.get(appID);		
	}

	public static IDatabase getDatabase(String dbID){
		return dataBases.get(dbID);		
	}

	public static HashMap<String, IDatabase> getDatabases(){
		return dataBases;		
	}

	public static Collection<AppEnv> getApplications(){
		return applications.values();		
	}



	public static String getFullHostName(){
		return httpSchema + "://" + Environment.hostName + ":" + Environment.httpPort;
	}

	public static String getWorkspaceURL(){
		return getFullHostName() + "/Workspace/Provider?type=page&id=workspace";
	}

	public static String getExtHost(String id){
		String h = externalHost.get(id.toLowerCase()).host;
		return h;
	}

    public static ExternalHost getExternalHost(String id){
        return externalHost.get(id.toLowerCase());
	}

	public static void addExtHost(String id, String host, String name) {
		externalHost.put(id.toLowerCase(), new ExternalHost(id.toLowerCase(), host, name));
		return;
	}

	private static void initMimeTypes(){
		mimeHash.put("pdf", "application/pdf");
		mimeHash.put("doc", "application/msword");
		mimeHash.put("xls", "application/vnd.ms-excel");
		mimeHash.put("tif", "image/tiff");
		mimeHash.put("rtf", "application/msword");
		mimeHash.put("gif", "image/gif");
		mimeHash.put("jpg", "image/jpeg");
		mimeHash.put("html", "text/html");
		mimeHash.put("zip", "application/zip");
		mimeHash.put("rar", "application/x-rar-compressed");
	}

	private static Document getDocument(){
		try {
			DocumentBuilderFactory domFactory = DocumentBuilderFactory.newInstance();			
			DocumentBuilder builder;

			builder = domFactory.newDocumentBuilder();					
			return builder.parse("cfg.xml");	
		} catch (SAXException e) {
			logger.errorLogEntry(e);
		} catch (IOException e) {
			logger.errorLogEntry(e);
		}catch (ParserConfigurationException e) {
			logger.errorLogEntry(e);				
		}
		return null;
	}


	private static String getHostName(){
		InetAddress addr = null;
		try {
			addr = InetAddress.getLocalHost();
		} catch (UnknownHostException e) {
			e.printStackTrace();
		}	   
		return addr.getHostName();
	}

	@Override
	public  StringBuffer getPage(Page page, Map<String, String[]> formData) throws ClassNotFoundException, RuleException, QueryFormulaParserException, DocumentException, DocumentAccessException, QueryException {
		Object obj = cache.get(page.getID());
		String cacheParam = formData.get("cache")[0];
		if (obj == null || cacheParam.equalsIgnoreCase("reload")){
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


	public static void shutdown(){
		if (XMPPServerEnable)Environment.connection.disconnect();
	}

	@Override
	public String getOwnerID() {
		return "";
	}




}
