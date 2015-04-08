package kz.flabs.runtimeobj.document.task;

import java.io.Serializable;
import java.util.Date;

public class Executor implements Serializable {
	public int num;
	public String ID;
    public String name;
    public ExecutorType type;
	public String resetAuthorID = "";
	public String comment = "";
	public boolean isReset;
	public int responsible;
	
	private static final long serialVersionUID = 1033256535647706979L;	
	private Date resetDate;
	private int execper;
	
    public static enum ExecutorType {
        INTERNAL, EXTERNAL
    }

    public Executor(String id, ExecutorType type){
		this.ID = id;
        this.type = type;
	}

    public Executor internalExecutor(String id) {
        return new Executor(id, ExecutorType.INTERNAL);
    }

    public Executor externalExecutor(String id) {
        return new Executor(id, ExecutorType.EXTERNAL);
    }

	public Executor() {
		
	}

	public void setResetDate(Date d){
		resetDate = d;		
	}
	
	public String getID() {
		return ID;
	}
	
	public int getPercentOfExecution(){
		return this.execper;
	}
	
	public void setPercentOfExecution(int percent){
		this.execper = percent;
	}
		
	public void setID(String userID) {
		this.ID = userID;
	}
	
	public Date getResetDate(){
		return (resetDate != null ? resetDate : null);
	}
	
	
	public void setResponsible(int resp) {
		responsible = resp;
	}
	
	public int getResponsible() {
		return responsible;
	}
	
	public String toString(){
		return "executor:" + ID + ",num:" + num + ",isReset:" + isReset;
	}

	public String getResetDateAsDbFormat() {
		return null;
	}


}
