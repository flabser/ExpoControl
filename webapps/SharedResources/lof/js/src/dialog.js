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
