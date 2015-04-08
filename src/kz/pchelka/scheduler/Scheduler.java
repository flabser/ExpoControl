package kz.pchelka.scheduler;

import kz.flabs.webrule.constants.RunMode;
import kz.flabs.webrule.scheduler.IScheduledProcessRule;
import kz.pchelka.env.Environment;
import kz.pchelka.log.*;

public class Scheduler implements Runnable {
    public static ILogger logger = new Log4jLogger("Scheduler");
    public PeriodicalServices periodicalServices;
    public static final int minuteInterval = 60 * 1000;

    private BackgroundProcCollection processes = new BackgroundProcCollection();


    private void initServerScheduler(){
        try{
            periodicalServices = new PeriodicalServices(processes.getActivProcList());
            periodicalServices.start();
        }catch(Exception e) {
            logger.errorLogEntry(e);
        }
    }

    public void addProcess(IScheduledProcessRule rule, IDaemon daemon){
        if (rule.getScheduleMode() == RunMode.ON){
            try {
                processes.addActivProcess(daemon);
            } catch (Exception e) {
                logger.errorLogEntry(e);
                daemon = null;
            }
        }else{
            logger.warningLogEntry("Schedule for disabled (process=\"" + daemon.getID() + "\")");
            processes.addProcess(daemon);
        }
    }

    public BackgroundProcCollection getProcesses() {
        return processes;
    }

    @Override
    public void run() {
        Thread.currentThread().setName(" Scheduler main process");
        try {
            Thread.sleep(minuteInterval * Environment.delaySchedulerStart);
            logger.normalLogEntry("Initialize scheduled services");
            initServerScheduler();
        } catch (InterruptedException e) {
            logger.errorLogEntry(e);
        }

    }
}
