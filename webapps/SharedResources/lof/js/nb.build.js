/* склеено с Grunt */

/**
 * @author Medet
 */

'use strict';

var nextbase = {
	APP_NAME : location.hostname,
	LANG_ID : "RUS",
	debug : true,
	strings : {
		"yes" : "Да",
		"no" : "Нет",
		ok : "Ok",
		cancel : "Отмена",
		select : "Выбрать",
		dialog_select_value : "Вы не сделали выбор"
	},
	form : {},
	dialog : {},
	utils : {},
	xhr : {}
};

var nb = nextbase; // short name
var nbApp = {}; // local application namespace

/**
 * ajax
 */
nextbase.ajax = function(options) {

	var deferred = $.ajax(options);

	// error
	deferred.error(function(xhr) {
		console.error("nextbase.ajax : error", xhr);

		if (xhr.status == 400) {
			nextbase.dialog.error({
				title : nextbase.getText("error_xhr", "Ошибка запроса"),
				message : xhr.responseText
			});
		}

		return xhr;
	});

	return deferred;
};

/**
 * getText
 */
nextbase.getText = function(stringKey, defaultText, langId) {
	if (nbStrings[langId || this.LANG_ID][stringKey]) {
		return nbStrings[langId || this.LANG_ID][stringKey];
	} else {
		return (defaultText !== undefined) ? defaultText : stringKey;
	}
};

/**
 * openXML
 */
nextbase.openXML = function() {
	window.location.href = window.location + "&onlyxml";
};

/**
 * setValues
 */
nextbase.form.setValues = function(currentNode) {

	var _dlgWrapper = nextbase.utils.findAncestorNodes(currentNode, "[role=dialog]");
	var dlgWidget = $("[data-role='nextbase-dialog']", _dlgWrapper);

	var _form = nextbase.utils.getForm(dlgWidget[0].dialogOptions.targetForm);
	var fieldName = dlgWidget[0].dialogOptions.fieldName;

	var nodeList; // коллекция выбранных
	var isMulti = false;
	var itemSeparate = "";
	var displaySeparate = "<br/>"; // отобразить мульти значения разделителем

	if (!_form) {
		nextbase.dialog.warn({
			title : "Error",
			message : "Error nextbase.form.setValues > form is not found: " + form
		});
		return false;
	}

	nodeList = $("[data-type='select']:checked", dlgWidget[0]);
	if (nodeList.length > 0) {
		isMulti = nodeList.length > 1;
		if (!isMulti) {
			itemSeparate = "";
		}

		return _writeValues(nodeList);
	} else {
		if (dlgWidget[0].dialogOptions.effect) {
			_dlgWrapper.stop();
			_dlgWrapper.effect(dlgWidget[0].dialogOptions.effect, {
				times : 2
			}, 300);
		}

		if ($(".js-no-selected-value", _dlgWrapper[0]).length === 0) {
			(function() {
				var _html = $("<div class='alert alert-danger js-no-selected-value'"
						+ "style='border-radius:2px;top:55%;left:4%;right:4%;position:absolute;'>"
						+ dlgWidget[0].dialogOptions.errorMessage + "</div>");
				dlgWidget.after(_html);
				setTimeout(function() {
					_html.fadeOut({
						always : function() {
							_html.remove();
						}
					});
				}, 800);
			})();
		}

		return false;
	}

	// write values to form
	function _writeValues() {
		if (isMulti) {
			$("[name='" + fieldName + "']", _form).remove();
			var htm = [];
			nodeList.each(function(index, node) {
				$("<input type='hidden' name='" + fieldName + "' value='" + node.value + "' />").appendTo(_form);
				htm.push("<li>" + $(node).data("text") + "</li>");
			});
			$("#" + fieldName + "tbl").html(htm.join(""));
		} else {
			var fieldNode = $("[name='" + fieldName + "']", _form);
			if (fieldNode.length === 0) {
				fieldNode = $("<input type='hidden' name='" + fieldName + "' />");
				$(_form).append(fieldNode[0]);
			}

			fieldNode.val(nodeList[0].value);
			// $("[data-refers-to-field='" + fieldName +
			// "']").html($(nodeList[0]).text());
			$("#" + fieldName + "tbl").html("<li>" + nodeList.attr("data-text") + "</li>");
		}

		return true;
	}
};

/**
 * clearField
 */
nextbase.utils.clearField = function(fieldName, context) {
	$("[name='" + fieldName + "']").val("");
	$("#" + fieldName + "tbl").html("");
};

/**
 * getContextForm
 */
nextbase.utils.getForm = function(_target) {
	if (_target === null || _target === undefined) {
		return _target;
	}

	if (typeof (_target) === "string" && (document[_target] && document[_target].nodeName === "FORM")) {
		return document[_target];
	}

	return _target.form || _target;
};

/**
 * findAncestorNodes
 */
nextbase.utils.findAncestorNodes = function(node, query) {
	return $(node).parents(query);
};

/**
 * blockUI
 */
nextbase.utils.blockUI = function() {
	var blockEl = $("#nb-block-ui");
	if (blockEl.length === 0) {
		var tpl = "<div id='nb-block-ui' style='background:rgba(0,0,0,0.1);position:absolute;top:0;left:0;height:100%;width:100%;'></div>";
		$(tpl).appendTo("body");
	}

	blockEl.css("display", "block");
};

nextbase.utils.unblockUI = function() {
	$("#nb-block-ui").css("display", "none");
};
//

nextbase.utils.notify = function(options) {

	var _notify = {
		_el : $("<div class='nb-notify-entry-" + (options.type || "info") + "'>" + options.message + "</div>")
				.appendTo("body"),
		show : function() {
			this._el.css("display", "block");
			return this;
		},
		hide : function() {
			this._el.css("display", "none");
			return this;
		},
		set : function(opt) {
			for ( var key in opt) {
				if (key === "text") {
					this._el.text(opt[key]);
				} else if (key === "type") {
					this._el.attr("class", "nb-notify-entry-" + opt[key]);
				}
			}
			return this;
		},
		remove : function(timeout, callbackAfter) {
			if (this._el === null) {
				return;
			}

			if (timeout && timeout > 0) {
				var _this = this;
				setTimeout(function() {
					_this._el.remove();
					_this._el = null;
					callbackAfter && callbackAfter();
				}, timeout);
			} else {
				this._el.remove();
				this._el = null;
				callbackAfter && callbackAfter();
			}
		}
	};

	return _notify;
};

//
$(document).ready(function() {
	//
	nextbase.LANG_ID = $.cookie("lang") || "RUS";

	//
	$(':checkbox').bind("click", function() {
		var checkbox = $(this);
		var toggle;

		if (checkbox.data('toggle')) {
			toggle = checkbox;
		} else {
			return true;
		}

		var _name = checkbox.attr('name') || checkbox.data('toggle');

		if (toggle !== undefined) {
			var el = $("[name='" + _name + "']:checkbox:visible");
			if (toggle.is(':checked')) {
				el.each(function() {
					this.checked = true;
				});
			} else {
				el.each(function() {
					this.checked = false;
				});
			}
		}
	});
});

/**
 * dialog
 */
nextbase.dialog = {
	_props : {
		title : nextbase.APP_NAME
	},
	info : function(options) {
		options.className = "dialog-info";
		options.width = options.width || "360";
		options.height = options.height || "210";
		options.buttons = options.buttons || {
			"Ok" : function() {
				$(this).dialog("close");
			}
		};

		return this.show(options);
	},
	warn : function(options) {
		options.className = "dialog-warn";
		options.width = options.width || "360";
		options.height = options.height || "210";
		options.buttons = options.buttons || {
			"Ok" : function() {
				$(this).dialog("close");
			}
		};

		return this.show(options);
	},
	error : function(options) {
		options.className = "dialog-error";
		options.width = options.width || "360";
		options.height = options.height || "210";
		options.buttons = options.buttons || {
			"Ok" : function() {
				$(this).dialog("close");
			}
		};

		return this.show(options);
	},
	execute : function(currentNode) {
		var _dlgWrapper = nextbase.utils.findAncestorNodes(currentNode, "[role=dialog]");
		var dlgWidget = $("[data-role='nextbase-dialog']", _dlgWrapper);

		dlgWidget[0].dialogOptions.onExecute(arguments);
	},
	show : function(options) {
		var $dialog;

		options.id = options.id || null;
		options.title = options.title || this._props.title;
		options.href = options.href || null;
		options.className = options.className || "";
		options.message = options.message || null;
		options.filter = options.filter;
		options.dialogFilterListItem = options.dialogFilterListItem || "li";
		options.buttons = options.buttons || null;
		options.dialogClass = (options.dialogClass ? ("nextbase-dialog " + options.dialogClass) : false)
				|| "nextbase-dialog";
		options.errorMessage = options.errorMessage || nextbase.strings.dialog_select_value;

		options.onLoad = options.onLoad || null;

		options.onExecute = options.onExecute || function() {
			if (nextbase.form.setValues($dialog, null)) {
				$dialog.dialog("close");
			}
		};

		options.autoOpen = true;
		if (options.modal === false) {
			options.modal = false;
		} else {
			options.modal = true;
		}
		options.width = options.width || "360";
		// options.height = options.height || "420";
		options.position = options.position || "center";

		if (options.id === null && options.href) {
			options.id = "dlg_" + options.href.replace(/[^a-z0-9]/gi, "");

			$dialog = $("#" + options.id);
			if ($dialog[0]) {
				if ($dialog.dialog("isOpen") === true) {
					return;
				} else {
					$dialog.dialog("open");
					return;
				}
			}
		} else if (options.id !== null) {
			$dialog = $("#" + options.id);
			if ($dialog[0]) {
				if ($dialog.dialog("isOpen") === true) {
					return;
				} else {
					$dialog.dialog("open");
					return;
				}
			}
		}

		if (options.id === null) {
			options.close = options.close || function() {
				$dialog.dialog("destroy");
				$dialog.remove();
			};
		}

		var dialogContainerNode;

		if (options.href) {
			dialogContainerNode = $("<div data-role='nextbase-dialog' id='" + options.id
					+ "' class='nextbase-dialog-container " + options.className
					+ "'><div class='loading-state'></div></div>");
		} else {
			if (options.id) {
				dialogContainerNode = $("<div data-role='nextbase-dialog' id='" + options.id
						+ "' class='nextbase-dialog-container " + options.className + "'>" + options.message + "</div>");
			} else {
				dialogContainerNode = $("<div data-role='nextbase-dialog' class='nextbase-dialog-container "
						+ options.className + "'>" + options.message + "</div>");
			}
		}

		if (options.href) {
			$dialog = $(dialogContainerNode).load(options.href, "", function(response, status, xhr) {
				if (status === "error") {
					dialogContainerNode.html("<div class='alert alert-danger'>" + status + "</div>");

					console.log("nextbase.dialog : load callback", xhr);
				} else {
					try {
						if (options.onLoad != null) {
							options.onLoad(response, status, xhr);
						}
					} catch (e) {
						console.log("nextbase.dialog", e);
					}

					try {
						if (options.filter !== false) {
							new nextbase.dialog.Filter(dialogContainerNode, options.dialogFilterListItem, 13);
						}
					} catch (e) {
						console.log("nextbase.dialog", e);
					}
				}
			}).dialog(options);

			$dialog.on("click", "a", function(e) {
				e.preventDefault();
				dialogContainerNode.load(this.href);
			});

			$dialog.on("change", "select", function(e) {
				e.preventDefault();
				dialogContainerNode.load(this.href);
			});
		} else {
			$dialog = $(dialogContainerNode).dialog(options);
		}

		$dialog[0].dialogOptions = options;

		if (nextbase.debug === true) {
			console.log("nextbase.dialog: ", options);
		}

		return $dialog;
	}
};

/**
 * nextbase.dialog.Filter
 */
nextbase.dialog.Filter = function(_containerNode, _filterNode, _initCount, _triggerLen) {

	var collection = {};
	var inputEl = null;
	var initCount = _initCount || 13;
	var triggerLen = _triggerLen || 2;
	var timeout = 300;
	var to = null;
	var filterNode = _filterNode || ".item";
	var containerNode = $(_containerNode)[0];
	var dlgWrapper = nextbase.utils.findAncestorNodes(containerNode, "[role=dialog]");
	var enabledViewSearch = false;

	init();

	function init() {
		collection = $(filterNode, containerNode);

		var isHierarchical = $(".toggle-response", containerNode).length > 0;
		if (collection.length < initCount) {
			if (!isHierarchical) {
				return;
			}
		}

		if ($(".dialog-filter", dlgWrapper).length === 0) {
			$(containerNode).before("<div class='dialog-filter'></div>");
		}

		$(".dialog-filter", dlgWrapper).append(
				"<label>Фильтр: <label><input type='text' name='keyword' data-role='search' />");

		inputEl = $(".dialog-filter input[data-role='search']", dlgWrapper);
		inputEl.on("keyup", function(e) {
			try {
				clearTimeout(to);
				if (e.keyCode === 13) {
					return;
				}
			} catch (ex) {
				console.log(ex);
			}

			to = setTimeout(function() {
				collection = $(filterNode, containerNode);
				filter(e.target.value);
			}, timeout);
		});
	}

	function filter(value) {
		try {
			if (value.length >= triggerLen) {
				var hiddenCount = 0;
				collection.attr("style", "");

				var re = new RegExp(value, "gim");

				collection.each(function(index, node) {
					if (!re.test(node.textContent)) {
						if ($(":checked", node).length === 0) {
							$(node).attr("style", "display:none;");
							hiddenCount++;
						}
					}
				});

				if (collection.length > hiddenCount) {
					inputEl.attr("title", "By keyword [" + value + "] filtered " + (collection.length - hiddenCount));
				} else {
					inputEl.attr("title", "filter_no_results");
				}
			} else {
				collection.attr("style", "");
				inputEl.attr("title", "");
			}
		} catch (e) {
			console.log(e);
		}
	}
};

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

var nbStrings = {
	"RUS" : {},
	"KAZ" : {},
	"ENG" : {},
	"CHN" : {}
};

nbStrings.RUS = {
	"yes" : "Да",
	"no" : "Нет",
	ok : "Ok",
	cancel : "Отмена",
	select : "Выбрать",
	dialog_select_value : "Вы не сделали выбор"
};

/**
 * sendSortRequest
 */
nextbase.xhr.sendSortRequest = function(pageId, column, direction) {

	if (nextbase.debug === true) {
		console.log("nextbase.xhr.sendSortRequest: ", pageId, column, direction);
	}

	return nextbase.ajax({
		type : "POST",
		datatype : "XML",
		url : "Provider?param=sorting_mode~on&param=sorting_column~" + column.toLowerCase()
				+ "&param=sorting_direction~" + direction.toLowerCase(),
		data : {
			"type" : "service",
			"operation" : "tune_session",
			"element" : "page",
			"id" : pageId
		}
	});
};
