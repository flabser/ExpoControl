package kz.nextbase.script;

import kz.flabs.runtimeobj.document.BlobField;
import kz.flabs.runtimeobj.document.BlobFile;

import java.util.Collection;

public class _BlobField extends _Field {		
	private BlobField blobField;
	
	protected _BlobField(_Document doc, String name) {
		super(doc, name);	
		blobField = doc.getBaseObject().blobFieldsMap.get(name);	
	}
	
	protected _BlobField (_Document doc, String name, BlobField blobField) {
		super(doc, name);	
		this.blobField = blobField;
	}

	protected Collection<BlobFile> getFiles() {
		return blobField.getFiles();
	}

	@Override
	public String toXML() throws _Exception {
		StringBuffer xmlContent = new StringBuffer(10000);
		Collection<BlobFile> files = blobField.getFiles();					
		for (BlobFile file: files){	
			xmlContent.append("<entry filename=\"" + file.originalName.replaceAll("&", "&amp;") + "\" hash=\"" + file.checkHash + "\" id=\"" + file.id + "\"><comment>" + file.comment + "</comment></entry>");
		}
		return xmlContent.toString();
	}
}