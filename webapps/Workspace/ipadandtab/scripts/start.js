$(document).ready(function() {
	$("#frm").submit(function(e) {
		if (e.target.login.value.length == 0) {
			e.preventDefault();
			infoDialog("Введите имя пользователя");
		} else if (e.target.pwd.value.length == 0) {
			e.preventDefault();
			infoDialog("Заполните пароль");
		}
	});
});

function infoDialog(text) {
	var myDiv = $("<div id='dialog-message' title='Предупреждение'><span style='height:40px; width:100%; text-align:center;font-size:85%;'>"
			+ text + "</span></div>");
	$('body').append(myDiv);

	$("#dialog-message").dialog({
		modal : true,
		buttons : {
			"Ок" : function() {
				$(this).dialog("close");
			}
		},
		close : function() {
			$(this).remove();
			$(myDiv).dialog("destroy");
		}
	});
	$(".ui-dialog button").focus();
}
