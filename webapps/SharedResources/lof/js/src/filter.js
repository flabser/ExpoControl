/**
 * chooseFilter
 */
nextbase.xhr.chooseFilter = function(pageId, column, keyword) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.chooseFilter: ", pageId, column, keyword);
	}

	return nextbase.ajax({
		type : "GET",
		datatype : "XML",
		url : "Provider?param=filter_mode~on&param=filtered_column~" + column + "&param=key_word~" + keyword,
		cache : false,
		data : {
			"type" : "service",
			"operation" : "tune_session",
			"element" : "page",
			"id" : pageId
		}
	});
};

/**
 * resetFilter
 */
nextbase.xhr.resetFilter = function(pageId) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.resetFilter: ", pageId);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		cache : false,
		data : {
			"type" : "service",
			"operation" : "tune_session",
			"element" : "page",
			"id" : pageId,
			"param" : "filter_mode~reset_all"
		}
	});
};

/**
 * resetCurrentFilter
 */
nextbase.xhr.resetCurrentFilter = function(pageId, column) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.resetCurrentFilter: ", pageId, column);
	}

	return nextbase.ajax({
		type : "GET",
		datatype : "XML",
		url : "Provider?param=filter_mode~on&param=filtered_column~" + column,
		cache : false,
		data : {
			"type" : "service",
			"operation" : "tune_session",
			"element" : "page",
			"id" : pageId
		}
	});
};
