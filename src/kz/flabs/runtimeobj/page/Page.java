package kz.flabs.runtimeobj.page;

import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.Const;
import kz.flabs.exception.DocumentAccessException;
import kz.flabs.exception.DocumentException;
import kz.flabs.exception.QueryException;
import kz.flabs.exception.RuleException;
import kz.flabs.localization.LocalizatorException;
import kz.flabs.parser.QueryFormulaParserException;
import kz.flabs.runtimeobj.document.DocID;
import kz.flabs.runtimeobj.queries.Query;
import kz.flabs.runtimeobj.queries.QueryFactory;
import kz.flabs.scriptprocessor.form.querysave.IQuerySaveTransaction;
import kz.flabs.scriptprocessor.page.doscript.DoProcessor;
import kz.flabs.sourcesupplier.SourceSupplier;
import kz.flabs.users.User;
import kz.flabs.users.UserSession;
import kz.flabs.util.ResponseType;
import kz.flabs.util.Util;
import kz.flabs.util.XMLResponse;
import kz.flabs.webrule.Caption;
import kz.flabs.webrule.constants.ValueSourceType;
import kz.flabs.webrule.form.GlossaryRule;
import kz.flabs.webrule.page.ElementRule;
import kz.flabs.webrule.page.PageRule;
import kz.pchelka.env.Environment;
import kz.pchelka.scheduler.IProcessInitiator;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;
import java.util.StringTokenizer;

public class Page implements IProcessInitiator, Const {
    public boolean fileGenerated;
    public String generatedFilePath;
    public String generatedFileOriginalName;

    protected AppEnv env;
    protected PageRule rule;
    protected Map<String, String[]> fields = new HashMap<String, String[]>();
    protected UserSession userSession;

//	private HttpServletRequest request;
//	private HttpServletResponse response;

/*	public Page(AppEnv env, UserSession userSession, PageRule rule, HttpServletRequest request, HttpServletResponse response){
		this.request = request;
		this.response = response;
		this.userSession = userSession;
		this.env = env;
		this.rule = rule;
	}*/

    public Page(AppEnv env, UserSession userSession, PageRule rule) {
        this.userSession = userSession;
        this.env = env;
        this.rule = rule;
    }

    public String getSpravFieldSet(User user, String lang) throws RuleException, DocumentException, DocumentAccessException, QueryFormulaParserException, QueryException, LocalizatorException {
        StringBuffer glossariesAsText = new StringBuffer("<glossaries>");
        SourceSupplier ss = new SourceSupplier(user, env, lang);
        for (GlossaryRule glos : rule.getGlossary()) {
            glossariesAsText.append("<" + glos.name + ">" + ss.getDataAsXML(glos.valueSource, glos.value, glos.macro, lang) + "</" + glos.name + ">");
        }
        return glossariesAsText.append("</glossaries>").toString();
    }

    public String getCaptions(SourceSupplier captionTextSupplier, ArrayList<Caption> captions) throws DocumentException {
        StringBuffer captionsText = new StringBuffer("<captions>");
        for (Caption cap : captions) {
            captionsText.append("<" + cap.captionID + captionTextSupplier.getValueAsCaption(cap.source, cap.value).toAttrValue() + "></" + cap.captionID + ">");
        }
        return captionsText.append("</captions>").toString();
    }


    public String getAsXML(User user, String lang) throws RuleException, DocumentException, DocumentAccessException, QueryFormulaParserException, QueryException, LocalizatorException {
        SourceSupplier captionTextSupplier = new SourceSupplier(env, lang);
        String captions = getCaptions(captionTextSupplier, rule.captions);
        String glossarySet = getSpravFieldSet(user, lang);
        return "<content>" + rule.getAsXML() + glossarySet + captions + "</content>";
    }


    public StringBuffer process(Map<String, String[]> formData) throws ClassNotFoundException, RuleException, QueryFormulaParserException, DocumentException, DocumentAccessException, QueryException {
        StringBuffer resultOut = null;
        long start_time = System.currentTimeMillis();
        switch (rule.caching) {
            case NO_CACHING:
                resultOut = getContent(formData);
                break;
            case CACHING_IN_USER_SESSION_SCOPE:
                resultOut = userSession.getPage(this, formData);
                break;
            case CACHING_IN_APPLICATION_SCOPE:
                resultOut = env.getPage(this, formData);
                break;
            case CACHING_IN_SERVER_SCOPE:
                resultOut = new Environment().getPage(this, formData);
                break;
            default:
                resultOut = getContent(formData);
        }
        DocID toFlash = userSession.getFlashDoc();
        String flashAttr = "";
        if (toFlash != null) {
            flashAttr = "flashdocid=\"" + toFlash.id + "\" flashdoctype=\"" + toFlash.type + "\"";
        }
        StringBuffer output = new StringBuffer(5000);

        output.append("<page id=\"" + rule.id + "\" cache=\"" + rule.caching + "\" elapsed_time = \"" + Util.getTimeDiffInSec(start_time) + "\" " + flashAttr + ">");
        output.append(resultOut);
        return output.append("</page>");
    }

    public String getID() {
        return "PAGE_" + rule.id + "_" + userSession.lang;

    }


    public StringBuffer getContent(Map<String, String[]> formData) throws ClassNotFoundException, RuleException, QueryFormulaParserException, DocumentException, DocumentAccessException, QueryException {
        fields = formData;
        StringBuffer output = new StringBuffer(1000);
        User user = userSession.currentUser;
        if (rule.runUnderUser.getSourceType() == ValueSourceType.STATIC) {
            user = new User(rule.runUnderUser.value, env);
            user.setSession(userSession);
        }
        if (rule.elements.size() > 0) {
            loop:
            for (ElementRule elementRule : rule.elements) {
                if (elementRule.hasElementName) output.append("<" + elementRule.name + ">");
                switch (elementRule.type) {
                    case STATIC_TAG:
                        output.append(elementRule.value);
                        break;
                    case SCRIPT:
                        DoProcessor sProcessor = new DoProcessor(env, user, userSession.lang, fields, this);
                        XMLResponse xmlResp = sProcessor.processScript(elementRule.doClassName);

                        for (IQuerySaveTransaction toPostObects : sProcessor.transactionToPost) {
                            toPostObects.post();
                        }

                        if (xmlResp.type == ResponseType.SHOW_FILE_AFTER_HANDLER_FINISHED) {
                            fileGenerated = true;
                            generatedFilePath = xmlResp.getMessage("filepath").text;
                            generatedFileOriginalName = xmlResp.getMessage("originalname").text;
                            break loop;
                        } else {
                            output.append(xmlResp.toXML());
                        }

                        break;
                    case QUERY:
                        StringBuffer xmlContent = new StringBuffer(5000);
                        int pageNum = 0;
                        try {
                            pageNum = Integer.parseInt(formData.get("page")[0]);
                        } catch (Exception nfe) {
                            pageNum = 1;
                        }
                        int pageSize = userSession.pageSize;
                        if (formData.containsKey("pagesize")) {
                            try {
                                pageSize = Integer.valueOf(formData.get("pagesize")[0]);
                            } catch (Exception nfe) {
                                pageSize = userSession.pageSize;
                            }
                        }
                        int parentDocProp[] = getParentDocProp(formData);
                        if (formData.containsKey("command")) {
                            String commandURL = formData.get("command")[0];
                            if (commandURL != null && (!commandURL.equals("null"))) {
                                StringTokenizer t = new StringTokenizer(commandURL, ":");
                                ArrayList<String> commands = new ArrayList<String>();
                                while (t.hasMoreTokens()) {
                                    commands.add(t.nextToken());
                                }

                                for (String command : commands) {
                                    try {
                                        StringTokenizer commandDetails = new StringTokenizer(command, "`");
                                        String commandType = commandDetails.nextToken();

                                        if (commandType.equals("expand")) {
                                            String docIDOrCat = commandDetails.nextToken();
                                            try {
                                                String docType = commandDetails.nextToken();
                                                DocID commandDocID = new DocID(docIDOrCat, docType);
                                                userSession.addExpandedThread(commandDocID);
                                            } catch (Exception e) {
                                                docIDOrCat = new String(((String) docIDOrCat).getBytes("ISO-8859-1"), "UTF-8");
                                                userSession.addExpandedCategory(docIDOrCat);
                                            }
                                        } else if (commandType.equals("collaps")) {
                                            String docIDOrCat = commandDetails.nextToken();
                                            try {
                                                String docType = commandDetails.nextToken();
                                                DocID commandDocID = new DocID(docIDOrCat, docType);
                                                userSession.resetExpandedThread(commandDocID);
                                            } catch (Exception e) {
                                                docIDOrCat = new String(((String) docIDOrCat).getBytes("ISO-8859-1"), "UTF-8");
                                                userSession.resetExpandedCategory(docIDOrCat);
                                            }

                                        }
                                    } catch (Exception e) {
                                        AppEnv.logger.errorLogEntry(e);
                                    }
                                }
                            }
                        }
                        Query query = QueryFactory.getQuery(env, elementRule, userSession.currentUser);
                        //Query query =  new Query(env, (IQueryRule)elementRule, userSession.currentUser);
                        query.setQiuckFilter(fields, env);
                        int result = query.fetch(pageNum, pageSize, parentDocProp[0], parentDocProp[1], userSession.expandedThread, userSession.expandedCategory, userSession.getFlashDoc(), fields);
                        if (result > -1) {
                            xmlContent.append(query.toXML());
                        }
                        output.append(xmlContent);
                        break;
                    case INCLUDED_PAGE:
                        PageRule rule = (PageRule) env.ruleProvider.getRule(PAGE_RULE, elementRule.value);
                        //	IncludedPage page = new IncludedPage(env, userSession, rule, request, response);
                        IncludedPage page = new IncludedPage(env, userSession, rule);
                        output.append(page.process(fields));
                        break;
                }
                if (elementRule.hasElementName) output.append("</" + elementRule.name + ">");
            }
        }
        SourceSupplier captionTextSupplier = new SourceSupplier(env, userSession.lang);
        return output.append(getCaptions(captionTextSupplier, rule.captions));

    }

    protected int[] getParentDocProp(Map<String, String[]> formData) {
        int[] prop = new int[2];
        try {
            prop[0] = Integer.parseInt(formData.get("parentdocid")[0]);
        } catch (Exception nfe) {
            prop[0] = 0;
        }
        try {
            prop[1] = Integer.parseInt(formData.get("parentdoctype")[0]);
        } catch (Exception nfe) {
            prop[1] = DOCTYPE_UNKNOWN;
        }
        return prop;
    }

    @Override
    public String getOwnerID() {
        return rule.getRuleID();
    }

}
