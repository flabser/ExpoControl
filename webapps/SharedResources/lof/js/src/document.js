/**
 * deleteDocument
 */
nextbase.xhr.deleteDocument = function(ck, typeDel) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.deleteDocument: ", ck, typeDel);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "delete",
			"ck" : ck,
			"typedel" : typeDel
		}
	});
};

/**
 * restoreDeletedDocument
 */
nextbase.xhr.restoreDeletedDocument = function(ck) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.restoreDeletedDocument: ", ck);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "undelete",
			"ck" : ck
		}
	});
};

/**
 * addDocumentToFavorite
 */
nextbase.xhr.addDocumentToFavorite = function(docId, docType) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.addDocumentToFavorite: ", docId, docType);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "service",
			"operation" : "add_to_favourites",
			"doctype" : docType,
			"key" : docId
		}
	})
};

/**
 * removeDocumentFromFavorite
 */
nextbase.xhr.removeDocumentFromFavorite = function(docId, docType) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.removeDocumentFromFavorite: ", docId, docType);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "service",
			"operation" : "remove_from_favourites",
			"doctype" : docType,
			"key" : docId
		}
	});
};

/**
 * markDocumentAsRead
 */
nextbase.xhr.markDocumentAsRead = function(docId, docType) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.markDocumentAsRead: ", docId, docType);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "service",
			"operation" : "mark_as_read",
			"id" : "mark_as_read",
			"doctype" : docType,
			"key" : docId
		}
	});
};

/**
 * getUsersWichRead
 */
nextbase.xhr.getUsersWichRead = function(docId, docType) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.getUsersWichRead: ", docId, docType);
	}

	return nextbase.ajax({
		type : "GET",
		datatype : "XML",
		url : "Provider",
		data : {
			"type" : "service",
			"operation" : "users_which_read",
			"id" : "users_which_read",
			"doctype" : docType,
			"key" : docId
		}
	});
};

/**
 * saveDocument
 */
nextbase.xhr.saveDocument = function(options) {

	options = options || {};
	var notify = nextbase.utils.notify({
		message : nextbase.getText("wait_while_document_save", "Пожалуйста ждите... идет сохранение документа"),
		type : "info"
	}).show();

	var xhrArgs = {
		cache : false,
		type : "POST",
		datatype : "XML",
		url : "Provider",
		data : options.data || $("form").serialize(),
		beforeSend : function() {
			nextbase.utils.blockUI();
		},
		success : function(xml) {
			var jmsg = nextbase.utils.parseMessageToJson(xml);
			var msgText = jmsg.message[0];
			if (jmsg.status === "ok") {
				notify.set({
					"text" : nextbase.getText("document_saved", "Документ сохранен"),
					"type" : "success"
				});
				//
				if (msgText.length > 0) {
					nextbase.dialog.info({
						message : msgText,
						close : function() {
							if (jmsg.redirect || options.redirect) {
								window.location.href = jmsg.redirect || options.redirect;
							}
						}
					});
				} else {
					if (jmsg.redirect || options.redirect) {
						setTimeout(function() {
							window.location.href = jmsg.redirect || options.redirect;
						}, 300);
					}
				}
			} else {
				notify.set({
					"text" : msgText,
					"type" : "error"
				});
			}
		},
		error : function() {
			notify.set({
				"text" : nextbase.getText("error_xhr", "Ошибка при выполнении запроса"),
				"type" : "error"
			});
		}
	};

	var def = nextbase.ajax(xhrArgs);
	def.always(function() {
		nextbase.utils.unblockUI();
		notify.remove(2000);
	});

	return def;
};

/**
 * parseMessageToJson
 */
nextbase.utils.parseMessageToJson = function(xml) {

	var msg = {};
	$(xml).find('response').each(function(it) {
		msg.status = $(this).attr("status");
		msg.redirect = $("redirect", this).text();
		msg.message = [];
		$(this).find('message').each(function(it) {
			msg.message.push($(this).text());
		});
	});
	return msg;
};
