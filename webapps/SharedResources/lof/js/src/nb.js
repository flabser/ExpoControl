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
