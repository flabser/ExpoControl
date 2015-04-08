package kz.flabs.runtimeobj.document.coordination;

import java.io.Serializable;
import java.util.Date;


public class Decision implements ICoordConst, Serializable{
	public int decision = DECISION_UNKNOWN;
	public String comment = "";
	public Date decisionDate;

    private static final long serialVersionUID = 1L;

	public Decision(int d, String c){
		decision = d;
		comment = c;
		decisionDate = new Date();
	}

	public Decision(int d, String c, Date dd) {
		decision = d;
		comment = c;
		decisionDate = dd;
	}

	public Decision() {
		
	}

	public String getComment() {
		if(comment != null){
			return comment;
		}else{
			return "";
		}
	}

	public Date getDecisionDate() {
		return decisionDate;
	}

    public void setDecisionDate(Date date) {
        decisionDate = date;
    }

}
