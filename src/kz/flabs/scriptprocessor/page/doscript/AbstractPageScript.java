package kz.flabs.scriptprocessor.page.doscript;

import kz.flabs.localization.Vocabulary;
import kz.flabs.scriptprocessor.Msg;
import kz.flabs.scriptprocessor.ScriptEvent;
import kz.flabs.scriptprocessor.ScriptProcessorUtil;
import kz.flabs.servlets.SignalType;
import kz.flabs.util.ResponseType;
import kz.flabs.util.Util;
import kz.flabs.util.XMLResponse;
import kz.nextbase.script.*;
import kz.nextbase.script.reports._ExportManager;

import java.util.ArrayList;
import java.util.Collection;

public abstract class AbstractPageScript extends ScriptEvent implements IPageScript {	
	public ArrayList<Msg> messages = new ArrayList<Msg>();
	

	private String lang;
	private _WebFormData formData;
	private XMLResponse xmlResp = new XMLResponse(ResponseType.RESULT_OF_PAGE_SCRIPT);
	private SignalType signal;
	private ArrayList<_IXMLContent> xml = new ArrayList<_IXMLContent>(); 

	public void setSession(_Session ses){			
		this.ses = ses;
	}

	public void setFormData(_WebFormData formData){
		this.formData = formData;
	}

	public void setCurrentLang(Vocabulary vocabulary, String lang){
		this.lang = lang;
		this.vocabulary = vocabulary;
	}	

	public void setContent(_IXMLContent document) {
		xml.add(document);
	}

	public void setContent(Collection<_IXMLContent> documents) {
		xml.addAll(documents);
	}

	public void println(Exception e){
		String errText = e.toString();
		System.out.println(errText);
		_Tag tag = new _Tag("error",errText);
		tag.addTag(ScriptProcessorUtil.getScriptError(e.getStackTrace()));
		_XMLDocument xml = new _XMLDocument(tag);
		setContent(xml);
	}

	public void println(String text){		
		System.out.println(text);
	}

    public void showFile(String filePath, String fileName) {
        xmlResp.type = ResponseType.SHOW_FILE_AFTER_HANDLER_FINISHED;
        xmlResp.addMessage(filePath, "filepath");
        xmlResp.addMessage(fileName, "originalname");
    }

	public void showFile(_ExportManager attachment){
		xmlResp.type = ResponseType.SHOW_FILE_AFTER_HANDLER_FINISHED;
		xmlResp.addMessage(attachment.getFilePath(), "filepath");	
		xmlResp.addMessage(attachment.getOriginalFileName(), "originalname");	
	}

	public XMLResponse process(){

		long start_time = System.currentTimeMillis();
		try{					
			doProcess(ses, formData, lang);
			xmlResp.setPublishResult(toPublishElement);
			xmlResp.setResponseStatus(true);
			for(Msg message:messages){
				xmlResp.addMessage(message.text, message.id);	
			}
			if (signal != null)	xmlResp.addSignal(signal);
			if (xml != null)xmlResp.addXMLDocumentElements(xml);
			xmlResp.setRedirect(redirectURL);

		}catch(Exception e){
			xmlResp.setResponseStatus(false);
			xmlResp.addMessage(e.getMessage());
			println(e);
			e.printStackTrace();
		}

		xmlResp.setElapsedTime(Util.getTimeDiffInSec(start_time));
		return xmlResp;
	}

	public abstract void doProcess(_Session session, _WebFormData formData, String lang);
}
