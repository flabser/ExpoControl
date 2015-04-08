package kz.flabs.dataengine.postgresql.useractivity;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.runtimeobj.document.BaseDocument;

public class PostDelete extends kz.flabs.dataengine.h2.usersactivity.PostDelete {

	PostDelete(IDatabase db, BaseDocument deletedDoc, String userID){
		super(db,deletedDoc, userID);	
	}
	
}
