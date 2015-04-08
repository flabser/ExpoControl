package kz.flabs.dataengine.postgresql.useractivity;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.runtimeobj.document.Document;

public class PostModify extends kz.flabs.dataengine.h2.usersactivity.PostModify {
	
	PostModify(IDatabase db, Document oldDoc, Document modifiedDoc, String userID){
		super(db, oldDoc, modifiedDoc, userID);
	}


	
}
