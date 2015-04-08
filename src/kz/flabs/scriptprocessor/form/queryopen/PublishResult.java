package kz.flabs.scriptprocessor.form.queryopen;

import java.util.ArrayList;

import kz.nextbase.script._IXMLContent;

public class PublishResult {
	public boolean continueOpen;
	public ArrayList<_IXMLContent> toPublishElement = new ArrayList<_IXMLContent>();
	public ArrayList<_IXMLContent> toPublish = new ArrayList<_IXMLContent>();
	
	PublishResult(boolean cs, ArrayList<_IXMLContent> toPublish, ArrayList<_IXMLContent> toPublishElement){
		continueOpen = cs;
		this.toPublish = toPublish;
		this.toPublishElement = toPublishElement;
	}
}
