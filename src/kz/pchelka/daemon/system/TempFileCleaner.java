package kz.pchelka.daemon.system;

import kz.flabs.webrule.scheduler.DaysOfWeek;
import kz.pchelka.env.Environment;
import kz.pchelka.scheduler.AbstractDaemon;
import kz.pchelka.scheduler.IProcessInitiator;
import kz.pchelka.scheduler.Scheduler;

import java.io.File;
import java.util.ArrayList;

public class TempFileCleaner extends AbstractDaemon {		
	private int ac;	

	@Override
	public int process(IProcessInitiator processOwner) {		
		ac = 0;
		if (isFirstStart){
			File folder = new File(Environment.tmpDir);
			if (folder.exists()){
				File[] list = folder.listFiles();
				for(int i = list.length; --i>=0;){
					File file = list[i];
					delete(file);
				}
			}
			isFirstStart = false;
		}else{
			for(String filePath: Environment.fileToDelete){
				File file = new File(filePath);
				while(file.getParentFile() != null && !file.getParentFile().getName().equals("tmp")){
                    System.out.println(file.getParentFile().getName());
                    file = file.getParentFile();
                }
                if(file.getParentFile() == null)
                    file = null;
                delete(file); 				
			}
		}
		if (ac > 0){
			Scheduler.logger.verboseLogEntry(getID() + ac + " temporary files deleted");
		}
		return 0;
	}

	public void delete(File file) {
		if(file == null || !file.exists())
			return;
		if(file.isDirectory()){
			for(File f : file.listFiles())
				delete(f);
			if (file.delete()) ac ++ ;
		}else{
			if (file.delete()) ac ++ ;
		}
	}

	@Override
	public ArrayList<DaysOfWeek> getDaysOfWeek() {

		ArrayList<DaysOfWeek> daysOfWeek = new ArrayList<DaysOfWeek>();
		daysOfWeek.add(DaysOfWeek.ALL_WEEK);
		return daysOfWeek;
	}
	
}
