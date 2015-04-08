package kz.nextbase.script.outline;

import java.util.ArrayList;

import kz.flabs.util.XMLUtil;
import kz.flabs.webrule.constants.RunMode;

public class _OutlineEntry {
	public RunMode isOn = RunMode.ON;
	public String caption;
	public String hint;
	public String url;
	public String customID;
	
	private String value = "";
	private ArrayList<_OutlineEntry> entries = new ArrayList<_OutlineEntry>();
	
	_OutlineEntry(String caption, String hint, String customID, String url){
		this.caption = caption;
		this.hint = hint;
		this.url = url + "&entryid=" + caption.hashCode() + customID.hashCode() + "&title=" + caption;
		this.customID = customID;
	}
		
	public void setValue(String v){
		value = v;
	}
	
	public void setValue(int v){
		value = Integer.toString(v);
	}
	
	void addEntry(_OutlineEntry entry){
		entries.add(entry);
	}
	
	public String toXML() {
		String a = "";
		
		for(_OutlineEntry e: entries){
			a += e.toXML();
		}
		
		return "<entry mode=\"" + isOn +"\"" +  XMLUtil.getAsAttribute("url", url) + XMLUtil.getAsAttribute("id", customID) + XMLUtil.getAsAttribute("caption", caption) + XMLUtil.getAsAttribute("hint", hint) + ">" + XMLUtil.getAsTagValue(value) + a + "</entry>";
	}

}
