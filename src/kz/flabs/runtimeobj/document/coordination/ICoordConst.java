package kz.flabs.runtimeobj.document.coordination;

public interface ICoordConst {
	
	int TO_SIGN = 327;
	int PARALLEL_COORDINATION = 328;
	int SERIAL_COORDINATION = 329;
	int UNKNOWN_COORDINATION = 330;
	
	int DECISION_UNKNOWN = 340;
	int DECISION_YES = 341;
	int DECISION_NO = 342;
	
	int STATUS_UNDEFINED = 350;
	int STATUS_DRAFT = 351;
	int STATUS_COORDINTING = 352;
	int STATUS_COORDINTED = 353;
	int STATUS_REJECTED = 354;
	int STATUS_SIGNING = 355;
	int STATUS_SIGNED = 356;	
	int STATUS_NOCOORDINATION = 358;
	int STATUS_EXPIRED = 359;
	int STATUS_NEWVERSION = 360;
	int STATUS_EXECUTING = 361;
	int STATUS_EXECUTED = 362;
	
	int BLOCK_STATUS_COORDINATING = 365;
	int BLOCK_STATUS_COORDINATED = 366;
	int BLOCK_STATUS_AWAITING = 367;
	int BLOCK_STATUS_UNDEFINED = 368;
	int BLOCK_STATUS_EXPIRED = 373;
	
	int COORDINATOR_TYPE_UNDEFINED = 370;
	int COORDINATOR_TYPE_REVIEWER = 371;
	int COORDINATOR_TYPE_SIGNER = 372;
		
}