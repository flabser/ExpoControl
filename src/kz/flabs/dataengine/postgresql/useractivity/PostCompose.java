package kz.flabs.dataengine.postgresql.useractivity;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.runtimeobj.document.Document;


public class PostCompose extends kz.flabs.dataengine.h2.usersactivity.PostCompose{
	
	PostCompose(IDatabase db, Document doc, String userID){
		super(db, doc, userID);	
	}
	
}
