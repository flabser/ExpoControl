package kz.flabs.runtimeobj.document;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.exception.ComplexObjectException;

public abstract class AbstractComplexObject  implements IComplexObject {

	@Override
	public abstract void init(IDatabase db, String initString) throws ComplexObjectException;

	@Override
	public abstract String getContent(); 
	
	public String getPersistentValue(){
		return this.getClass().getName() + "~" + getContent();
	}
	
	
}
