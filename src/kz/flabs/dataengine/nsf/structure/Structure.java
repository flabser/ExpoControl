package kz.flabs.dataengine.nsf.structure;

import kz.flabs.dataengine.*;
import kz.flabs.exception.LicenseException;
import kz.flabs.parser.FormulaBlocks;
import kz.flabs.runtimeobj.Filter;
import kz.flabs.runtimeobj.document.BaseDocument;
import kz.flabs.runtimeobj.document.DocID;
import kz.flabs.runtimeobj.document.glossary.Glossary;
import kz.flabs.runtimeobj.document.structure.*;
import kz.flabs.users.RunTimeParameters;
import kz.flabs.users.User;
import kz.nextbase.script._ViewEntryCollection;
import lotus.domino.Database;
import lotus.domino.Document;
import lotus.domino.NotesException;
import lotus.domino.NotesFactory;
import lotus.domino.NotesThread;
import lotus.domino.Session;
import lotus.domino.View;

import java.sql.*;
import java.util.*;


public class Structure implements IStructure, Const{
	public int numberOfLicense = 200;

	protected IDatabase db;	

	
	public Structure(IDatabase db) {	
		this.db = db;
	}

	@Override
	public IDatabase getParent() {		
		return db;
	}

	@Override
	public void setConnectionPool(IDBConnectionPool pool) {
		
	}

	@Override
	public StringBuffer getExpandedStructure() {
		return null;
	}

	@Override
	public StringBuffer getStructure(Set<DocID> toExpand) {
		return null;
	}

	@Override
	public Employer getAppUser(String user) {
		Session session;
		Employer emp = null;
		try {
			NotesThread.sinitThread();
			session = NotesFactory.createSession();
			Database db = session.getDatabase(null, "C:/Lotus/Domino/data/sd/struct.nsf");
			View view = db.getView("(NotesAddress)");
			Document doc = view.getDocumentByKey("CN=k k k/O=lof");
			emp = new Employer(this);
			emp.setFullName(doc.getItemValueString("FullName"));
		} catch (NotesException e) {
		
			e.printStackTrace();
		}
		

		return emp;
	}

	@Override
	public Employer getAppUserByCondition(String condition) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public ArrayList<Employer> getAppUsersByRoles(String rolename) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int getStructObjByConditionCount(IQueryFormula nf) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public StringBuffer getStructObjByCondition(IQueryFormula queryCondition,
			int offset, int pageSize) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public StringBuffer getResponses(int parentDocID, int parentDocType) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertOrganization(Organization doc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateOrganization(Organization doc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int deleteOrganization(int id) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public Organization getOrganization(int id, User user) {
		// TODO Auto-generated method stub
		return null;
	}

    @Override
    public _ViewEntryCollection getOrganization(ISelectFormula sf, User user, int pageNum, int pageSize, RunTimeParameters parameters) {
        return null;
    }

	@Override
	public int insertDepartment(Department doc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateDepartment(Department doc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public StringBuffer getDepartments(int parentDocID, int parentDocType,
			Set<DocID> toExpand) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public Department getDepartment(int id, User user) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public int insertEmployer(Employer doc) throws LicenseException {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public int updateEmployer(Employer doc) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public StringBuffer getEmployers(int parentDocID, int parentDocType,
			Set<DocID> toExpand) {
		return null;
	}

	@Override
	public Employer getEmployer(int id, User user) {
		return null;
	}

	@Override
	public ArrayList<Employer> getAllEmployers() {
		return null;
	}

	@Override
	public StringBuffer getEmployersByRoles(String rolename) {
		return null;
	}

	@Override
	public int insertGroup(UserGroup doc) {
		return 0;
	}

	@Override
	public UserGroup getGroup(int id, Set<String> complexUserID,
			String absoluteUserID) {
		return null;
	}

	@Override
	public UserGroup getGroup(String groupName, Set<String> complexUserID,
			String absoluteUserID) {
		return null;
	}

	@Override
	public int updateGroup(UserGroup doc) {
		return 0;
	}

	@Override
	public StringBuffer getGroupsByCondition(IQueryFormula queryCondition,
			int offset, int pageSize, String fieldsCond, Set<String> toExpand) {
		return null;
	}

	@Override
	public StringBuffer getGroupsByCondition(IQueryFormula queryCondition) {
		return null;
	}

	@Override
	public int getGroupsCountByCondition(IQueryFormula nf, String userID) {
		return 0;
	}

	@Override
	public UserGroup getGroupByParent(int parentDocID, int parentDocType) {
		return null;
	}

	@Override
	public ArrayList<BaseDocument> getAllGroups() {
		return null;
	}

	@Override
	public int getGroupsCount() {
			return 0;
	}

	@Override
	public Filter getFilter(int filterID, HashSet<String> allUserGroups,
			String userID) {
		return null;
	}

	@Override
	public Filter fillFilterDoc(Connection conn, ResultSet rs) {
		return null;
	}

	@Override
	public StringBuffer getEmployersByFrequencyExecution() {
		return null;
	}

	@Override
	public int deleteEmployer(int id) {
		return 0;
	}

	@Override
	public boolean hasGroup(String name, Set<String> complexUserID,
			String absoluteUserID) {
		return false;
	}

	@Override
	public Glossary getGlossaryDocumentByID(int docID) {
		return null;
	}

    @Override
    public ISelectFormula getSelectFormula(FormulaBlocks fb) {
        return null;

    }

    @Override
    public DatabaseType getRDBMSType() {
        return DatabaseType.NSF;
    }


}
