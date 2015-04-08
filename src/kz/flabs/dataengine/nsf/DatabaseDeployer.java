package kz.flabs.dataengine.nsf;

import kz.flabs.appenv.AppEnv;
import kz.flabs.dataengine.DatabasePoolException;
import kz.flabs.dataengine.IDatabaseDeployer;

public class DatabaseDeployer implements IDatabaseDeployer {

	
	 
	 public DatabaseDeployer(AppEnv env) throws DatabasePoolException, InstantiationException, IllegalAccessException, ClassNotFoundException {
	       
	  }
	 
	@Override
	public boolean deploy() {
		return true;
	}

	@Override
	public boolean patch() {
		return true;
	}

}
