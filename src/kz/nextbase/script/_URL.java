package kz.nextbase.script;

import java.util.regex.Pattern;

public class _URL {
	
	private String urlAsString;
	
	_URL(String urlAsString){
		this.urlAsString = urlAsString;
	}
	
	public void changeParameter(String parName, String value){
        int ind = urlAsString.indexOf(parName + "=");
        if(ind > 0){
            Pattern pattern = Pattern.compile("[a-z0-9]");
            int endInd = ind;
            for(int i = ind + parName.length()+1; i < urlAsString.length()-1; i++){
                endInd = i;
                if(!pattern.matcher(urlAsString.substring(i, i + 1)).matches()){
                    break;
                }
            }
            if(endInd != ind){
                urlAsString = urlAsString.substring(0, ind) + parName + "=" + value + urlAsString.substring(endInd, urlAsString.length());
            }
        }else{
        	urlAsString = urlAsString + "&" + parName + "=" + value;
        }
    }
	
	public String toString(){
		return urlAsString;
	}
}
