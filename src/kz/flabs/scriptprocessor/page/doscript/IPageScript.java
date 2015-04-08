package kz.flabs.scriptprocessor.page.doscript;

import kz.flabs.localization.Vocabulary;
import kz.flabs.util.XMLResponse;
import kz.nextbase.script.*;

public interface IPageScript {	
	void setSession(_Session ses);	
	void setFormData(_WebFormData formData);
	void setCurrentLang(Vocabulary vocabulary, String lang);
	XMLResponse process();

	
}
