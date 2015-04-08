package kz.flabs.runtimeobj.document.coordination;

import kz.flabs.dataengine.IDatabase;
import kz.flabs.runtimeobj.document.structure.Employer;

import java.io.Serializable;
import java.util.Date;

public class Coordinator implements Serializable{
	int type;
	private Employer user;
	private boolean isCurrent;
	private Decision decision = new Decision();
	public int num;
	//public int decision;
	//public String comment;
    public Date coordDate;
    //public Date decisionDate;
    private transient IDatabase db;
    private static final long serialVersionUID = 1L;
    
	public Coordinator(IDatabase db) {
		this.db = db;
	}

	public Coordinator(IDatabase db, String userID) {
		this.db = db;
		user = db.getStructure().getAppUser(userID);
	}

	public void setType(int coordinatorTypeSigner) {
		type = 	coordinatorTypeSigner;	
	}

	public String getUserID() {
		return user.getUserID();
	}

	public void setUserID(String userID) {
		user = db.getStructure().getAppUser(userID);
	}

	public boolean isCurrent() {
		return isCurrent;
	}

	public void setCurrent(boolean isCurrent) {
		this.isCurrent = isCurrent;
	}

	public void isCurrent(int parseInt) {
       this.isCurrent = parseInt == 1;
	}

	public void setCoorDate(Date date) {
        this.coordDate = date;
	}

	public void setComment(String textContent) {
		decision.comment = textContent;
	}   

	public void setDecision(Decision d) {
		decision = d;	
		
		isCurrent = false;
	}
	
	public void setDecisionDate(Date date) {
		decision.decisionDate = date;
	}

	public int getCoordType() {
		return this.type;
	}

	public String getCoordNumber() {
		return String.valueOf(num);
	}

	public Object getDecisionDate() {
		return decision.decisionDate;
	}

	public Date getCoorDate() {
		return this.coordDate;
	}

	public Employer getEmployer() {
		return user;
	}

	public void setNumber(int num) {
		this.num = num;
		
	}

	public Decision getDecision() {
		return decision;
	}

	
	
}
