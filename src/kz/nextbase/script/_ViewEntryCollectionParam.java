package kz.nextbase.script;

import java.text.SimpleDateFormat;


public class _ViewEntryCollectionParam {

	public static final SimpleDateFormat DATE_FORMAT_FULL = new SimpleDateFormat("dd.MM.yyyy kk:mm:ss");
	public static final SimpleDateFormat DATE_FORMAT_SHORT = new SimpleDateFormat("dd.MM.yyyy");

	private String query;
	private int pageNum = 0;
	private int pageSize = 0;
	private boolean checkResponse;
	private boolean useFilter;
	private boolean expandAllResponses;
	private SimpleDateFormat dateFormat = DATE_FORMAT_FULL;

	public _ViewEntryCollectionParam(_Session ses) {
		this.pageSize = ses.getUser().getSession().pageSize;
	}

	public String getQuery() {
		return query;
	}

	public _ViewEntryCollectionParam setQuery(String query) {
		this.query = query;
		return this;
	}

	public int getPageNum() {
		return pageNum;
	}

	public _ViewEntryCollectionParam setPageNum(int pageNum) {
		if (pageNum < 0) {
			throw new IllegalArgumentException("incorrect page number: pageNum = " + pageNum
					+ ", pageNum may be >= 0, ([pageNum=0] = last page)");
		}

		this.pageNum = pageNum;
		return this;
	}

	public int getPageSize() {
		return pageSize;
	}

	public _ViewEntryCollectionParam setPageSize(int pageSize) {
		if (pageSize < 0) {
			throw new IllegalArgumentException("incorrect page size: pageSize = " + pageSize
					+ ", pageSize may be >= 0, ([pageSize=0] = no limit)");
		}

		this.pageSize = pageSize;
		return this;
	}

	public boolean isCheckResponse() {
		return checkResponse;
	}

	public _ViewEntryCollectionParam setCheckResponse(boolean checkResponse) {
		this.checkResponse = checkResponse;
		return this;
	}

	public boolean isUseFilter() {
		return useFilter;
	}

	public _ViewEntryCollectionParam setUseFilter(boolean useFilter) {
		this.useFilter = useFilter;
		return this;
	}

	public boolean isExpandAllResponses() {
		return expandAllResponses;
	}

	public _ViewEntryCollectionParam setExpandAllResponses(boolean expandAllResponses) {
		this.expandAllResponses = expandAllResponses;
		return this;
	}

	public SimpleDateFormat getDateFormat() {
		return dateFormat;
	}

	public _ViewEntryCollectionParam setDateFormat(SimpleDateFormat dateFormat) {
		this.dateFormat = dateFormat;
		return this;
	}

	@Override
	public String toString() {
		return "queryCondition: " + query + ",\npageNum: " + pageNum + ",\npageSize: " + pageSize
				+ ",\ncheckResponse: " + checkResponse + ",\nuseFilter: " + useFilter + ",\nexpandAllResponses: "
				+ expandAllResponses + ",\nSimpleDateFormat: " + dateFormat.toPattern();
	}
}
