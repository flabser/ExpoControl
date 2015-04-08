package kz.nextbase.script.outline;

import java.util.ArrayList;
import kz.flabs.webrule.constants.RunMode;
import kz.nextbase.script._IXMLContent;


public class _Outline  implements _IXMLContent {
	public RunMode isOn = RunMode.ON;
	public String caption = "";
	public String hint = "";
	public String customID;
		
	private ArrayList<_Outline> outlines = new ArrayList<_Outline>();
	private ArrayList<_OutlineEntry> entries = new ArrayList<_OutlineEntry>();
	
	_Outline(String caption, String hint, String customID){
		this.caption = caption;
		this.hint = hint;		
		this.customID = customID;
	}
	
	void addOutline(_Outline outl){
		outlines.add(outl);
	}
	
	void addEntry(_OutlineEntry entry){
		entries.add(entry);
	}
	
	public String toXML(){
		String a = "";
		
		for(_Outline o: outlines){
			a += o.toXML();
		}
		
		for(_OutlineEntry e: entries){
			a += e.toXML();
		}
		
		return "<outline mode=\"" + isOn +"\" id=\"" + customID + "\" caption=\"" + caption + "\" hint=\"" +  hint + "\">" + a + "</outline>";
	}
	
}
