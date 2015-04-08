/** author Kairat* */
var fieldIsValid = true;
var alertmessage = '';

/* открытие и закрытие форм */
function showHideForm(idDiv, idImg) {
	if ($('#'+idDiv).is(':hidden') ) {
		$('#'+idDiv).show()
		$('#'+idImg).attr('src', "/SharedResources/img/classic/open.gif");
	} else {
		$('#'+idDiv).hide();
		$('#'+idImg).attr('src',"/SharedResources/img/classic/close.gif");	
	}
}

/* ограничение количества ввода символов в поле*/
function maxCountSymbols (el, count, e){
	if ($(el).val().length > count){
		if ((e.keyCode == 46) || (e.keyCode == 8) ||  (e.keyCode > 36 && e.keyCode < 41) ) {
		}else{
			 e.returnValue = false;
		}
	} 
}

/*  загрузка хода исполнения  КР*/ 
function showExecution(parentid,parentdoctype,id){
	$.ajax({
		  url: 'Provider?type=view&id=docthread&parentdocid='+parentid+'&parentdoctype='+parentdoctype,
		  success: function(data) {
			$("#executionTbl").html("<tr"+data.split('<tr')[1]);
			currentDocLink=$("#"+id+" a");
			currentDocLinkTitle = currentDocLink.attr("title");
			currentDocLink.replaceWith("<font class='font'>"+ currentDocLinkTitle.replace("-->", "<img src='/SharedResources/img/classic/arrow_blue.gif'/>") +"</font>");
			$("a").find('.font').each(function(){
				html=$(this).attr("innerHTML").replace("--&gt;", "<img src='/SharedResources/img/classic/arrow_blue.gif'/>");
				$(this).attr("innerHTML","");
				$(this).append(html);
				});
			}
		});	
}

/*  загрузка хода исполнения  СЗ*/ 
function showExecutionSZ(parentid,parentdoctype){
	$.ajax({
		url: 'Provider?type=view&id=docthread&parentdocid='+parentid+'&parentdoctype='+parentdoctype,
		success: function(data) {
			$("#executionTbl").html("<tr"+data.split('<tr')[1]);
			$("a").find('.font').each(function(){
				html=$(this).attr("innerHTML").replace("--&gt;", "<img src='/SharedResources/img/classic/arrow_blue.gif'/>");
				$(this).attr("innerHTML","");
				$(this).append(html);
				$("#executionTbl").css("width","95%")
			});
		}
	});	
}

/* кнопка "назад"*/
function CancelForm() {
	window.history.back();
}

function fieldOnFocus(field) {
	field.style.backgroundColor = '#FFFFE4';
}

function fieldOnBlur(field) {
	field.style.backgroundColor = '#FFFFFF';
}

function Numeric(el) {
	$(el).keypress(function (e) {
		if ((e.which < 48) || (e.which > 57) ) {
			return false
		}
	});
}

/*проверка выбранного формата файла отчета*/
function reportsTypeCheck (el){
	if($(el).val() == 2){
		$("input[type=radio][name=disposition][value=inline]").attr("disabled","disabled")
		$("input[type=radio][name=disposition][value=attachment]").attr("checked","checked")
	} else{
		$("input[type=radio][name=disposition][value=inline]").removeAttr("disabled")
	}
}



function fillingReport(){
	var fields = $('form').serializeArray();
	var formData = $("form").serialize();
	var recursiveEncoded = $.param(fields);
	 window.location.href = 'Provider?type=handler&id=filling_report&'+recursiveEncoded
	/*alert(recursiveEncoded);
	$.ajax({
		type: "get",
		url: 'Provider?type=handler&id=filling_report&'+recursiveEncoded,
		data: $("form").serialize(),
		success:function (data, status, xhr){
			//alert(data)
			
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}    
	});*/
}

/* функция снятия с контроля*/
function controlOff(pos){
	$("#idCorrControlOff"+pos).html($("#localusername").val());
	var time=new Date();
	month=time.getMonth()+1;
	day=time.getDate();
	hours=time.getHours();
	minute=time.getMinutes();
	if (month< 10){
		month="0"+month;
	}
	if (day<10){
		day="0"+ time.getDate();
	}
	if (hours<10){
		hours="0"+time.getHours();
	}
	if (minute<10){
		minute="0"+time.getMinutes();
	}
	timeOff=day +"."+ month + "." + time.getFullYear()+ " " + hours + ":" + minute +":00";
	$("#controlOffDate"+pos).text(timeOff);
	$("#switchControl"+pos).html("<a title='Поставить на контроль' href='javascript:controlOn("+pos+")'><img src='/SharedResources/img/classic/tick.gif'/></a>");
	execid=$("#idContrExec"+pos).val();
	idCorrControlOff=$("#currentuser").val();
	$("#controlres"+pos).val( execid +"`"+ timeOff +"`"+idCorrControlOff);
}

function addExecutorField(pos,execid){
	if (pos==1){
		$("#frm").append("<input type='hidden' id='controlres"+pos+"' name='executor' value='"+ execid +"`1`0`` '/>");
	}else{
		$("#frm").append("<input type='hidden' id='controlres"+pos+"' name='executor' value='"+ execid +"`0`0`` '/>");
	}
}

/* функция на контроль*/
function controlOn(pos){
	$("#idCorrControlOff"+pos).text(""); 
	$("#controlOffDate"+pos).text("");
	$("#switchControl"+pos).html("<a title='Снять с контроля' href='javascript:controlOff("+pos+")'><img  src='/SharedResources/img/classic/exec_control.gif'/></a>");
	$("#controlres"+pos).val($("#idContrExec"+pos).text()+"` ` ");
}

function infoDialog(text){
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:40px; width:100%; text-align:center;'>"+
	   			"<font style='font-size:13px;'>"+text+"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	   $( "#dialog-message" ).dialog({
		modal: true,
		buttons: {
			"Ок": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
			}
		}
	});
	$( ".ui-dialog button" ).focus();
}

function dialogAndRedirectFunction (text,func){
	// func - функция которая будет использоваться при нажатии на кнопку "продолжить" 
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	   			"<font style='font-size:13px; '>"+text+"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	$( "#dialog-message" ).dialog({
		height:140,
		modal: true,
		buttons: {
			"Ок": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
				//jQuery.globalEval(func)
			}
		}
	});
}

function dialogConfirm (text,el,actionEl){
	 var myDiv = document.createElement("DIV");
	   divhtml ="<div id='dialog-message' title='Предупреждение'  >";
	   divhtml+="<span style='height:50px; margin-top:4%; width:100%; text-align:center'>"+
	   			"<font style='font-size:13px; '>"+text+"</font>"+"</span>";
	   divhtml += "</div>";
	   myDiv.innerHTML = divhtml;
	   document.body.appendChild(myDiv);
	   $("#dialog").dialog("destroy");
	   $( "#dialog-message" ).dialog({
		   height:140,
		   modal: true,
		   buttons: {
			   "Ок": function() {
				   $( this ).dialog( "close" );
				   $( this ).remove();
				   if (el == 'picklist'){
					   $('#blockWindow').css('display',"block")
				   }
				   $('#'+el).css('display', "inline-block");
				   $("."+actionEl).remove();
			},
			"Отмена": function() {
				$( this ).dialog( "close" );
				$( this ).remove();
				if (el == 'picklist'){
					$('#blockWindow').remove()
				}
				$('#'+el).empty();
				$('#'+el).remove();
			}
		}
	});
}

/* сохранение формы */
function SaveFormJquery(typeForm, formName, redirecturl, docType) {
	alertmessage='';
	fieldIsValid=true;
	if (fieldIsValid == true){
		var myDiv = document.createElement("DIV");
		divhtml ="<div id='dialog-message' title='Сохранение'  >";
		divhtml+="<br/>" +"<table style='width:100%; margin-top:23px; font-family:arial'>" +
									"<tr>" +
										"<td><font style='font-size:15px;'>Пожалуйста ждите...</font></td>" +
									"</tr>" +
									"<tr>" +
										"<td><font style='font-size:13px;'>идет сохранение документа</font></td>" +
									"</tr>" +
									"<tr>" +
										"<td align='center'>" +
											"<img style='margin-top:23px' src='/SharedResources/img/classic/loading.gif'/>" +
										"</td>" +
									"</tr>" +
							"</span>";
		 divhtml += "</div>";
		 myDiv.innerHTML = divhtml;
		 document.body.appendChild(myDiv);
		 $("#dialog").dialog("destroy");
		 $("#dialog-message").dialog({
			   modal: true,
			   height:271
		 });
		var formData = $("form").serialize();
		$.ajax({
			type: "POST",
			url: 'Provider',
			data: $("form").serialize(),
			success:function (xml){
				$(xml).find('response').each(function(){
					var st=$(this).attr('status');
					if (st =="error" || st =="undefined"){
						$( "#dialog-message" ).dialog({ height: 210 });
						$( "#dialog-message" ).dialog({ buttons: { 
							Ok: function() {
								$(this).dialog('close');
								$( "#dialog-message" ).remove()
							}
						} 
						});
						msgtext=$(xml).find('message').text();
						$( "#dialog-message" ).dialog({ title: 'Уведомление' });
						if (msgtext.length==0){
							$("#dialog-message" ).html("<br/><span style='height:33px; margin-top:8px;'>"+"<font style='font-size:13px; margin-left:16%; font-family:arial'>Ошибка сохранения</font>"+"</span>");
						}else{
							$("#dialog-message" ).html("<br/><span style='height:33px'><font style='font-size:14px; font-family:arial'>"+msgtext+"</font></span>");
						}
					}
					if (st == "ok"){
						$( "#dialog-message" ).dialog({ height: 210 });
						$( "#dialog-message" ).dialog({ buttons: { 
							Ok: function() {
								$(this).dialog('close');
								$( "#dialog-message" ).remove()
								if (redirect==''){
									window.history.back();
								}else{
									window.location = redirect;
								}
								
							}
						} 
						});
						msgtext=$(xml).find('message').text();
						redirect=redirecturl;
						$( "#dialog-message" ).dialog({ title: 'Уведомление' });
						if (msgtext.length==0){
							$("#dialog-message" ).html("<br/><span style='height:33px; margin-top:8px; font-family:arial'>"+"<font style='font-size:13px; margin-left:16%;'>Документ успешно сохранен</font></span>");
						}else{
							$("#dialog-message" ).html("<br/><span style='height:33px'><font style='font-size:14px; font-family:arial'>"+msgtext+"</font></span>");
						}
					}
					$( ".ui-dialog button" ).focus();
				});
			}});
		}else{
			dialogMsg(alertmessage);
		}
}

/* вывод диалога сообщений (ошибка, уведомление) */
function dialogMsg(idfield) {
	divhtml ="<div class='messageBox' id='messageBox'   onkeyUp='keyDown();'>";
	divhtml +="<div  class='headerMessageBox'><font id='headertext' style='font-size:0.9em'></font>";
	divhtml +="<div class='closeButton'  onclick='javascript:closeDialog(&quot;messageBox&quot;)' ><img src='/SharedResources/img/classic/smallcancel.gif' style='border:0;'/>";
	divhtml +="</div></div><br/>";
	divhtml +="<div id='contentpane'   style=' margin-top:30px; border-bottom:2px solid  #a6c9e2; padding-top:10px; height:80px; word-wrap: break-word;  ' ></table></div>";  
	divhtml += "<div  id = 'btnpane' style='margin-top:3%; text-align:right;'>";
	divhtml += "<a href='javascript:closeDialog(&quot;messageBox&quot;)'><font class='button'>ОК</font></a>&#xA0;&#xA0;";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#messageBox").draggable({handle:"div.headerMessageBox"});
	centring('messageBox',150,400);
	$("#contentpane").append($('#'+idfield).val());
	blockWindow = "<div  class = 'blockWindow' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$('#messageBox').css('display', "inline-block");
	$("#headertext").attr('innerText',"Комментарий ответа");
}

/* добавление вложений в форму */
function submitFile(form, tableID, fieldName) {
	if ($('#'+fieldName).attr('value') == '') {
		alert('Укажите имя файла для вложения');
	} else {
		form = $('#'+form);
		var frame = createIFrame();
		frame.onSendComplete = function() {
			uploadComplete(tableID, getIFrameXML(frame));
		};
		form.attr('target', frame.id);
		form.submit();
		$("#upload")[0].reset();
		//form.reset();
	}
}

var cnt = 0;

function uploadComplete(tableID, doc) {
	if (!doc)
		return;
	var xmldoc = doc.documentElement;
	var st = xmldoc.getAttribute('status');
	var msg = xmldoc.getElementsByTagName('BODY');
	d=$("BODY", doc).text();
	var Url = {
			encode : function (string) {
				return escape(this._utf8_encode(string));
			},
			decode : function (string) {
				return this._utf8_decode(unescape(string));
			},
			_utf8_encode : function (string) {
				string = string.replace(/\r\n/g,"\n");
				var utftext = "";
				for (var n = 0; n < string.length; n++) {
					var c = string.charCodeAt(n);
					if (c < 128) {
						utftext += String.fromCharCode(c);
					}
					else if((c > 127) && (c < 2048)) {
						utftext += String.fromCharCode((c >> 6) | 192);
						utftext += String.fromCharCode((c & 63) | 128);
					}else {
						utftext += String.fromCharCode((c >> 12) | 224);
						utftext += String.fromCharCode(((c >> 6) & 63) | 128);
						utftext += String.fromCharCode((c & 63) | 128);
					}
				}
				return utftext;
			},
			_utf8_decode : function (utftext) {
				var string = "";
				var i = 0;
				var c = c1 = c2 = 0;
				while ( i < utftext.length ) {
					c = utftext.charCodeAt(i);
					if (c < 128) {
						string += String.fromCharCode(c);
						i++;
					}
					else if((c > 191) && (c < 224)) {
						c2 = utftext.charCodeAt(i+1);
						string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
						i += 2;
					}else {
						c2 = utftext.charCodeAt(i+1);
						c3 = utftext.charCodeAt(i+2);
						string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
						i += 3;
					}
				}
				string=string.substring(0, string.length - 3)
				return string;
			}
	}
	encd= Url.encode(d)
	encd=encd.substring(0, encd.length - 3)
      
	if (st = 'ok') {
		tableid='#'+tableID;
		var table = $(tableid);
		sesid=$(doc).find("message").attr('formsesid');
		var range = 200 - 1 + 1;
		fieldid=Math.floor(Math.random()*range) + 1;;
		$(table).append("<tr id='"+ fieldid + "'>" +
				"<td></td>" +
				"<td >" +
					"<div style='display:inline; border:1px solid #CCC; width:47.7%'>"+ d +"</div>&#xA0;&#xA0;" +
		 				"<a href='Provider?type=getattach&formsesid="+ sesid+"&field=rtfcontent&file="+encd+"'>Открыть</a>&#xA0;&#xA0;&#xA0;" +
		 				"<a href='javascript:deleterow("+sesid +",&quot;"+ d +"&quot;,"+ fieldid +")'>Удалить</a>" +
		 		"</td><td></td</tr>");
	} else {
		alert('Произошла ошибка на сервере при выгрузке файла');
	}
}

/* подмена стандартного контекстного меню  */
function mainContextMenu(el,docid,doctype,page){
	$(el).bind("contextmenu",function(e){
		$("#contextMenu").removeShadow();
		$("#contextMenu").remove();
		x=e.pageX + 15;
		y=e.pageY;
		redirectKR="Provider?type=document&id=kr&key=&parentdocid="+ docid+"&parentdoctype="+doctype+"&page="+page;
		redirectKI="Provider?type=document&id=ki&key=&parentdocid="+ docid+"&parentdoctype="+doctype+"&page="+page;
		contextmenu="<div class='contextMenu' id='contextMenu' style='display:inline;padding:2px; border:1.5px solid #a5a5a5; background:#f4f4f4'>" +
						"<table width='160px'>" +
							"<tr style='cursor:pointer;' onMouseOver='javascript:contextEntryOver(this)' onMouseOut='javascript:contextEntryOut(this)' onclick='javascript:redir(&quot;"+redirectKR+"&quot;)' >" +
								"<td>" +
									"<font style='font-size:0.8em; margin-left:5px; font-family:tahoma'>Резолюция</font>" +
								"</td>" +
							"</tr>" +
							"<tr  style='cursor:pointer;' onMouseOver='javascript:contextEntryOver(this)' onMouseOut='javascript:contextEntryOut(this)' onclick='javascript:redir(&quot;"+redirectKI+"&quot;)'>" +
								"<td>" +
									"<font style='font-size:0.8em; margin-left:5px; font-family:tahoma'>Карточка исполнения</font>" +
								"</td>" +
							"</tr>" +
						"</table>" +
					"</div>";
		$("body").append(contextmenu);
		$("#contextMenu").css({position:'absolute',left: x, top:y});
		$("#contextMenu").dropShadow();
		return false;
	});
	$(document).bind("click",function(e){
		$("#contextMenu").removeShadow();
		$("#contextMenu").remove();
	});
	
	$(document).bind("contextmenu",function(e){
		$("#contextMenu").removeShadow();
		$("#contextMenu").remove();
	});
}

function contextEntryOver(cell){
	cell.style.backgroundColor='#3c78b4';
}

function contextEntryOut(cell){
	cell.style.backgroundColor='#f4f4f4';
}

/* создание  cookie для сохранения настроек пользователя*/
function saveUserProfile(){
		var formData = $("form").serialize();
		$.ajax({
			type: "POST",
			url: "Provider?type=save&element=user_profile",
			data: formData,
			success: function(data){
				alert(data)
				refreshval=$("select[name='refresh']").val();
				$.cookie("refresh", refreshval,{
					path:"/",
					expires:30
				});		
				countdocinview=$("select[name='countdocinview']").val();
				$.cookie("pagesize", countdocinview,{
					path:"/",
					expires:30
				});		
				window.history.back()
			}
		});
	/*$.ajax({
		   type: "POST",
		   url: "Provider",
		   data: $("form").serialize(),
		   success:function (xml){
			   window.history.back();
		   }
	});*/
}
function SaveUserprofileOutline(){
	var formData = $("form").serialize();
	$.ajax({
		type: "POST",
		url: "Provider?type=save&element=user_profile",
		data: formData,
		success: function(data){
			refreshval=$("select[name='refresh']").val();
			$.cookie("refresh", refreshval,{
				path:"/",
				expires:30
			});		
			countdocinview=$("select[name='countdocinview']").val();
			$.cookie("pagesize", countdocinview,{
				path:"/",
				expires:30
			});		
		}
	});
	/*$.ajax({
		   type: "POST",
		   url: "Provider",
		   data: $("form").serialize(),
		   success:function (xml){
			   window.history.back();
		   }
	});*/
}

function markRead(doctype, docid){
	$.ajax({
		type: "GET",
		url: "Provider?type=service&operation=mark_as_read&doctype="+doctype+"&key="+docid+"&nocache="+Math.random(),
		success:function (xml){
			$("#markDocRead").animate({backgroundColor: '#ffff99'}, 500);
			$("#markDocRead").html("&#xA0; Прочтен");
			$("#markDocRead").animate({backgroundColor: 'white'}, 1000);
		}
	});
}

function redir(redirect){
	window.location=redirect;
}

function deleterow(sesid,filename, fieldid){
	$("#"+fieldid).remove()
	$("#frm").append("<input type='hidden' name='deletertfcontentsesid' value='"+ sesid +"'></input>")
	$("#frm").append("<input type='hidden' name='deletertfcontentname' value='"+ filename +"'></input>")
	$("#frm").append("<input type='hidden' name='deletertfcontentfield' value='rtfcontent'></input>")
}

function createIFrame() {
	var id = 'f' + Math.floor(Math.random() * 99999);
	var div = document.createElement('div');
	var divHTML = '<iframe style="display:none" src="about:blank" id="' + id
			+ '" name="' + id + '" onload="sendComplete(\'' + id
			+ '\')"></iframe>';
	div.innerHTML = divHTML;
	document.body.appendChild(div);
	return document.getElementById(id);
}

function sendComplete(id) {
	var iframe = document.getElementById(id);
	if (iframe.onSendComplete && typeof (iframe.onSendComplete) == 'function')
		iframe.onSendComplete();
}

function getIFrameXML(iframe) {
	var doc = iframe.contentDocument;
	if (!doc && iframe.contentWindow)
		doc = iframe.contentWindow.document;
	if (!doc)
		doc = window.frames[iframe.id].document;
	if (!doc)
		return null;
	if (doc.location == "about:blank")
		return null;
	if (doc.XMLDocument)
		doc = doc.XMLDocument;
	return doc;
}

var el;
var UrlDecoder = {
		encode : function (string) {
			return escape(this._utf8_encode(string));
		},
		decode : function (string) {
			return this._utf8_decode(unescape(string));
		},
		_utf8_encode : function (string) {
			string = string.replace(/\r\n/g,"\n");
				var utftext = "";
				for (var n = 0; n < string.length; n++) {
					var c = string.charCodeAt(n);
					if (c < 128) {
						utftext += String.fromCharCode(c);
					}
					else if((c > 127) && (c < 2048)) {
					 utftext += String.fromCharCode((c >> 6) | 192);
					 utftext += String.fromCharCode((c & 63) | 128);
					}
					else {
						utftext += String.fromCharCode((c >> 12) | 224);
						utftext += String.fromCharCode(((c >> 6) & 63) | 128);
						utftext += String.fromCharCode((c & 63) | 128);
					}
				}
				return utftext;
			},
			_utf8_decode : function (utftext) {
				var string = "";
				var i = 0;
				var c = c1 = c2 = 0;
				while ( i < utftext.length ) {
					c = utftext.charCodeAt(i);
					if (c < 128) {
						string += String.fromCharCode(c);
						i++;
					}
					else if((c > 191) && (c < 224)) {
						c2 = utftext.charCodeAt(i+1);
						string += String.fromCharCode(((c & 31) << 6) | (c2 & 63));
						i += 2;
					}
					else {
						c2 = utftext.charCodeAt(i+1);
						c3 = utftext.charCodeAt(i+2);
						string += String.fromCharCode(((c & 15) << 12) | ((c2 & 63) << 6) | (c3 & 63));
						i += 3;
					}
				}
				string=string.substring(0, string.length )
				return string;
			}
}

function expandChapterCorr(viewtext,num,url,doctype, page) {
	el = $(".tblCorr:eq("+num+")");
	$("#contentpane").html("<center>Ждите... идет загрузка...</center><img style='margin-top:10%' src='/SharedResources/img/classic/loading.gif'/>");
	encd= UrlDecoder.decode(viewtext)
	encd= UrlDecoder.encode(encd)
	$.ajax({
		url:'Provider?type=view&id=corresp&page='+page+'&command=expand`'+encd,
		success: function(data) {
			$("#contentpane").html(data);	
		}
	});	
}

function collapsChapterCorr(viewtext,num,url,doctype) {
	el = $(".tblCorr:eq("+num+")");
	$("#contentpane").html("<center>Ждите... идет загрузка...</center><img style='margin-top:10%' src='/SharedResources/img/classic/loading.gif'/>");
	encd= UrlDecoder.decode(viewtext)
	encd= UrlDecoder.encode(encd)
	$.ajax({
		url:'Provider?type=view&id=corresp&command=collaps`'+encd,
		success: function(data) {
			$("#contentpane").html(data);	
		}
	});	
}

/* функция напомнить*/
function remind(key,doctype){
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' style='font-size:0.9em'></font>";
	divhtml +="<div class='closeButton'><img src='/SharedResources/img/classic/smallcancel.gif' onclick='pickListClose(); ' style='border:0;margin-left:3px'/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:7%; margin-left:81%'></div>";
	divhtml +="<div id='divSearch' display='block'><div style='font-size:13px; text-align:left; margin-left:1%'>Список получателей напоминания:</div></div>" ;
	if($.browser.msie){
		divhtml +="<div id='contentpane'   style='overflow:auto; margin-top:10px; border:1px solid  #a6c9e2; padding-top:10px; width:97%; height:250px;' >Загрузка данных...</div>";  
	}else{
		divhtml +="<div id='contentpane'   style='overflow:auto; margin-top:10px; border:1px solid  #a6c9e2; padding-top:10px; width:96%; margin:1%; height:250px;' >Загрузка данных...</div>"; 
	}
	divhtml +="<div id='divComment' style='text-align:left; margin-top:8px; font-size:13px; width:98%'><table width='100%'><tr><td>Комментарий : </td></tr><tr><td><textarea id='comment'  rows='6' style='border:1px solid #a6c9e2;width:100%; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div  id = 'btnpane' style='margin:2%; text-align:right;'>";
	divhtml += "<a href='javascript:remindOk("+key+","+doctype+")'><font class='button'>ОК</font></a>&#xA0;&#xA0;";    
	divhtml += "<a href='javascript:pickListClose()'><font class='button'>Отмена</font></a>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	centring('picklist',500,500);
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$("body").css("cursor","wait");
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$('#picklist').css('display', "none");
	$("#headertext").text("Выбор корреспондента");
	$("#contentpane").text('');
	$("#contentpane").html($("#executers").html());
	$('#picklist').css('display', "inline-block");
	$("body").css("cursor","default")
	$('#picklist').focus();
}

/* обработчик нажатия кнопки "ок" a окне "напомнить"*/	
function remindOk(key,doctype){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		alert ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
						$("body").append(form);
				}
				new FormData('notifyrecipients', chBoxes[i].id); 
				k++		 	
			}
		}
		if (k>0){
			new FormData('type', 'handler'); 
			new FormData('id', "notify_executors"); 
			new FormData('key', key);
			new FormData('doctype', doctype);
			new FormData('comment', $("#comment").val());
			submitFormDecision ()
			pickListClose(); 
		}else{
			alert('Выберите значение');
		}
	}
}

/* функция ознакомить*/
function acquaint(key,doctype){
	el='picklist'
	divhtml ="<div class='picklist' id='picklist'  onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' style='font-size:0.9em'></font>";
	divhtml +="<div class='closeButton'><img src='/SharedResources/img/iconset/window_close.png' onclick='pickListClose(); ' style='border:0;margin-left:3px; width:40px; height:40px'/>";
	divhtml +="</div></div>";
	divhtml +="<div id='divSearch' class='divSearch' display='inline-block'></div>" ;
	divhtml +="<div style='font-size:13px; text-align:left; margin-top:10px'>&#xA0;Список корреспондентов для ознакомления:</div>" ;
	
	divhtml +="<div id='contentpane'  class='contentpane' >Загрузка данных...</div>";   
	
	divhtml +="<div id='divComment' style='text-align:left; font-size:13px; width:99.5%; margin-left:1%; background:#ffffff'>" ;
	divhtml +="<table width='98%'><tr><td>Комментарий : </td></tr><tr><td><textarea id='comment'  rows='6' style='width:100%; border:1px solid #a6c9e2; margin-top:8px'></textarea></td></tr></table></div>"
	divhtml += "<div  id = 'btnpane' style='margin-top:1%; text-align:right; margin:2%; padding-bottom:10px'>";
	divhtml += "<a href='javascript:acquaintOk("+key+","+doctype+")' class='gray button'><font>ОК</font></a>&#xA0;&#xA0;";    
	divhtml += "<a href='javascript:pickListClose()' class='gray button'><font>Отмена</font></a>";    
	divhtml += "</div></div>";
	$("body").append(divhtml);
	$("#headertext").text("Выбор корреспондента");
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemppicklist',
		success:function (data){
			$("#contentpane").text('');
			$("#contentpane").append(data);
			searchTbl =
				"<font style='vertical-align:3px; float:left; margin-left:4%'><b>Поиск:</b></font> <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>" 
				$("#contentpane div").removeAttr("ondblclick")		
				$("#contentpane div").removeAttr("onmouseover")		
				$("#contentpane div").removeAttr("onmouseout")		
				$("#divSearch").append(searchTbl);
			$('#btnChangeView').attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
			$("body").css("cursor","default")
			$('#picklist').disableSelection();	
			$('#searchCor').focus()
		}
	});
}

/* обработчик нажатия кнопки "ок" a окне "ознакомить"*/	
function acquaintOk(key,doctype){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	if ($("#comment").val().length == 0){
		alert ("Поле 'Комментарий' не заполнено")
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
						$("body").append(form);
				}
				new FormData('grantusers', chBoxes[i].id); 
				k++		 	
			}
		}
		if (k>0){
			new FormData('type', 'handler'); 
			new FormData('id', "grant_access"); 
			new FormData('key', key);
			new FormData('doctype', doctype);
			new FormData('comment', $("#comment").val());
			submitFormDecision ()
			pickListClose(); 
		}else{
			alert('Выберите значение');
		}
	}
}

/* смена вида в окне "ознакомить"*/
function changeViewAcquaint(viewType,key,doctype){
	if (viewType==1){
		$.ajax({
			type: "get",
			url: 'Provider?type=view&id=bossandemppicklist',
			success:function (data){
				$("#contentpane").text('');
				$("#contentpane").append(data);
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>Поиск:</b></font>";
				searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				$("#divSearch").append(searchTbl);
				$('#btnChangeView').attr("href","javascript:changeViewAcquaint(2,"+key+","+doctype+")");
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
				$('#searchCor').focus()
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane div").removeAttr("ondblclick")
					$("#contentpane div").removeAttr("onmouseover")		
					$("#contentpane div").removeAttr("onmouseout");
				});
			}
		});
	}else{
		$('#btnChangeView').attr("href","javascript:changeViewAcquaint(1,"+key+","+doctype+")");
		$.ajax({
			type: "get",
			url: 'Provider?type=view&id=structure',
			success:function (data){
				if(data.match("html")){
					window.location="Provider?type=static&id=start"
				}
				$("#contentpane").text('');
				$("#contentpane").append(data);
				$("#divSearch").empty();
				// запрещаем выделение текста
				$(document).ready(function(){
					$('#picklist').disableSelection();
				});
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
				$("#contentpane").ajaxSuccess(function(evt, request, settings){
					$("#contentpane td").removeAttr("ondblclick")
					$("#contentpane tr").removeAttr("onmouseover")		
					$("#contentpane tr").removeAttr("onmouseout")
					$("#contentpane tr").removeAttr("onmouseout")
				});
			}
		});
	}
}