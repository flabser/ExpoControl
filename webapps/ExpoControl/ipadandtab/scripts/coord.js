/** author Kairat* */
var idtr="";
var count=0; //���������� ��� �������� ���������� ������ ������������

 /* ������� �������� ����� ��� ������ ������������ */
function hideDialog(){
	$("#coordParam").css("display","none");
	$("#coordParam").empty();
	setTimeout("coordParamClose()", 100);
}

function addCoord(){
	if (1 == 0){ //if ($("#signer").val()==0 || $("#signer").val()== null){
		text="���������� ��������� ���� '��� ����� ��������'"
		func="dialogBoxStructure('structure','false','signer','frm', 'signertbl')"
		dialogAndRedirectFunction (text,func)
	}else{
		if (1 == 0){ // if ($("#recipient").val()==0 || $("#recipient").val()== null){
			text="���������� ��������� ���� '����������'" 
			func="dialogBoxStructure('structure','true','recipient','frm', 'recipienttbl')"
			dialogAndRedirectFunction ("���������� ��������� ���� '����������'",func)
		}else{
			el="coordParam"
				divhtml="<div class='picklistCoord' id='coordParam' onkeyUp='keyDown(el);'>" +
				"<div class='headerBoxCoord' style='width:100%'>" +
					"<font style='font-family:arial;'>��������� ������������</font>" +
					"<div class='closeButton'  onclick='hideDialog(); '>" +
						"<img src='/SharedResources/img/iconset/window_close.png' style='border:0;'/>" +
					"</div>" +
				"</div>" +
				"<div class='contentCoord' >" +
					"<div style='width:98%; display:inline-block'>" +
						"<table width='99%' style='align:left; font-size:16px; margin-top:10px'>" +
							"<tr>" +
								"<td><b>���:</b></td>" +
								"<td><input type='radio' name='typeCoord' value='par'checked='true'>������������</input></td>" +
								"<td><b>����� ��������:</b>" +
									"<select name='waitTime'>" 
									+"<option value='0'>0</option>" 
									+"<option value='3'>3</option>" 
									+"<option value='7'>7</option>" 
									+"<option value='24'>24</option>" 
									+"<option value='48'>48</option>" 
									+"<option value='72'>72</option>" 
									+"<option value='96'>96</option>" 
									+"<option value='120'>120</option>" 
									+"<option value='144'>144</option>"
									+"<option value='168'>168</option>"
									+"</select><font style='margin-left:5px'>�����<font></div>" +
							  "</td>" +
						"</tr>" +
						"<tr>" +
							"<td></td>" +
							"<td><input type='radio' name='typeCoord' value='ser' >����������������</input></td>" +
							"<td></td>"+
						"</tr>" +
					"</table>" +
				"</div>" +
				
				"<table style='margin-top:3%; width:100%; font-size:16px; '>" +
					"<tr>" +
						"<td style='text-align:left'><b>��������� ������������:</b></td>" +
						"<td></td>" +
					"</tr>" +
				"</table>" +
				"<table style='margin-top:5px; width:100%'>" +
					"<tr>" +
						"<td><font style='vertical-align:5px;'><b>�����:</b></font> <input type='text' id='searchCor' size='34' onKeyUp='findCorCoord()'/></td>" +
						"<td></td>" +
					"</tr>" +
				"</table>" +
				"<table width='98%' height='65%' style='margin-top:1% '><tr><td width='45%'>" +
				"<div id='contentdiv' style='border:1px solid #ccc; width:100%; display:inline-block; height:100%;'>" +
					
				"</div></td>" +
				"<td width='4%'><div style='display:inline-block;  vertical-align:middle;'>" +
					"<table style='font-size:2em; margin-left:10px'>" +
						"<tr><td><a style='text-decoration:none' href='javascript:plusCoordinator()'><img src='/SharedResources/img/classic/arrow_right.gif'/></a><td></tr>" +
						"<tr><td><a style='text-decoration:none' href='javascript:minusCoordinator()'><img src='/SharedResources/img/classic/arrow_left.gif'/></a><td></tr>" +
					"</table>" +
				"</div></td>"+
				"<td width='45%'><div id='coorderToBlock' style='border:1px solid #ccc; width:100%; height:100%; display:inline-block;'>" +
					"<table width='100%'  id='coordertbl'>" +
					"</table>" +
				"</div></td></tr></table>" +
			"</div>" +
			"<div class='buttonPane' style='text-align:right; width:98%;  margin-top:2%'>" +
				"<a href='javascript:coordOk()'>" +
					"<font class='gray button'>��</font>" +
				"</a>&#xA0;&#xA0;" +
				"<a href='javascript:hideDialog()'>" +
					"<font class='gray button'>������</font>" +
				"</a>" +
			"</div>"+
		"</div>";
	
			$("body").append(divhtml);
			$("body").scrollTop(0)
	
			/* ������� �������� ��������� ��� ������ ��������������� */
			picklistCoordinators()
	
	
			/* ����� ����� �������� ������ ������������ ���������� ����*/
	
			$('#coordParam').css('width',$(document).width()); 
			$('#coordParam').css('height',$(document).height());
	
			/* �������� div ��� ���������� ������� ��� ����� �������� ������ ������������*/
			blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
			$("body").append(blockWindow);
			$('#blockWindow').css('width',$(document).width()); 
			$('#blockWindow').css('height',$(document).height());
		}
	}
}

function coordOk(){
	var coorderID="",
		brConstr="",
		nameCoorder = $("#coorderToBlock .chbox").map(function(el){ return this.id; }).get().join("^"),
		waitTimeVal=$("select[name=waitTime]").val(), // время ожидания согласования
		typeCoordVal=$("input[name=typeCoord]:checked").val(); // тип согласования
	/* получение списка id согласователей*/ 
	if ($("#coorderToBlock").text().length == 0){
		infoDialog(choosemember);
	}else{
		$("#coorderToBlock .chbox").each(function(){
			brConstr += "<br/>";
			coorderID+="<input type='hidden' class='"+this.id+"' value='"+this.id+"'/>"
		})
		/* нумерация блоков согласования */	
		countTR=$("#coordTableView tr").length;
		/* построение строки для отображения блоков согласования в форме */
		tdCheckbox="<td style='border-bottom: 1px solid lightgray'><input type='checkbox' name='chbox' id='"+countTR+"'>"+brConstr+"</td>";
		tdNum="<td style='text-align:center; border-bottom: 1px solid lightgray'>"+countTR+""+brConstr+"</td>";
		tdTypeCoord="<td style='text-align:center; border-bottom:1px solid lightgray'>"
		typeCoordVal == "ser" ? tdTypeCoord += sercoord : tdTypeCoord += parcoord+brConstr;
		tdTypeCoord += brConstr+"</td>"
		tdCoorderName="<td style='border-bottom: 1px solid lightgray'>";
		$("#coorderToBlock div").each(function(){
			tdCoorderName+="<font style='margin-top:10%'>"+$(this).text()+"</font><br/>"
		})
		tdCoorderName+="</td>";
		tdWaitTime="<td style='text-align:center; border-bottom:1px solid lightgray'>";
		waitTimeVal==0 ? tdWaitTime += unlimited : tdWaitTime += waitTimeVal+" "+hours;
		tdWaitTime += brConstr+"</td>";
		hiddenField="<input type='hidden' name='coordblock' value='new`"+ typeCoordVal+"`"+ waitTimeVal +"`"+nameCoorder +"'/>"; // построение скрытого поля для отправки параметров блока согласования на сервер
		tdStatus="<td style='text-align:center; border-bottom:1px solid lightgray'>"+newcoord+hiddenField+coorderID+""+brConstr+"</td>";
		trTableViewCoord="<tr id='"+countTR+"' class='trblockCoord'>"+tdCheckbox+tdNum+tdTypeCoord+tdCoorderName+tdWaitTime+tdStatus+"</tr>";
		$("#coordTableView").append(trTableViewCoord);
		hideDialog();
	}
}

/* �������� ������ ������������*/
function delCoord(){
	count=count-1;
	var chBoxes = $("input[name='chbox']");
	for (i = 0; i < chBoxes.length; i++) {	
		if (chBoxes[i].checked){	
		 $(chBoxes[i]).parent().parent().remove();
		
		}
	}
}

 /* ������� �������� ����� �������� ������ ������������ */
 function coordParamClose(){
		$('#coordParam').remove();
		$('#blockWindow').remove();
}

 /* ������ "��������� ��� ��������" */
function savePrjAsDraft(redirecturl){
	$('#coordstatus').val('draft');
	$('#action').val('draft');
    SaveFormJquery('frm', 'frm', redirecturl)		
}

/* ������ "���������" */
function saveAndSend(redirecturl){
		if($("#coordBlockSign").val()==null || $("#coordBlockSign").val()==0 ){
			alert("������� ��� ����� ����������� ������ ��������� �������")
		}else{
			if ($("#recipient").val()==null ||  $("#recipient").val()==0){ 
				alert("������� ����������")
			}else{
				$('#coordstatus').val('signing');
				$('#action').val('send');
				SaveFormJquery('frm', 'frm', redirecturl);	
			}
		}
}

/* ������ "�����������"*/
function saveAndCoord(redirecturl){
	if($("[name=coordBlock]").length==0){ 
		alert("�� �� ������� �� ������ ����� ������������ ")
	}else{
		$("#action").val('startcoord') ;
		$("#coordstatus").val('coordinated') ;
		SaveFormJquery('frm', 'frm', redirecturl);
	}
}

var dataArray=new Array;

/* �������� �������� ���� � ������������ ����� */
function FormData(field, value){
	$("#dynamicform").append("<input type='hidden' name='"+field +"' id='"+field +"' value='"+value +"'>")
}

/* �������� ����� ��� ����� ������������ �������� ������������ "��������" ��� "�� ��������" */
function addComment(){
	divhtml="<div class='comment' id='commentBox'>" +
	"<div class='headerComment'><font style='font-family: arial; font-size:15px'>�����������</font>" +
		"<div class='closeButton'  onclick='commentCancel(); '>" +
			"<img src='/SharedResources/img/classic/smallcancel.gif' style='border:0;'/>" +
		"</div></div>" +
	"<div class='contentComment'>" +
		"<br/><table style=' margin-top:2%; width:100%'>" +
			"<tr>" +
				"<td style='text-align:center'><textarea  name='commentText' id='commentText' rows='10'  tabindex='1' style='width:97%' />" +
				"</td>" +
			"</tr>" +
		"</table><br/>" +
	"</div>"+
	"<div class='buttonPaneComment' style='margin-top:2%; text-align:right; width:98%'>" +
	"<a href='javascript:commentOk()'><font style='font-size:15px' >��</font></a>&#xA0;&#xA0;" +
	"<a href='javascript:commentCancel()'><font style='font-size:15px' >������</font></a>" +
	"</div>" +
	"</div>";
	$("body").append(divhtml);
	$("#commentBox").draggable({handle:"div.headerComment"});
	centring('commentBox',490,460);
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$("#commentBox textarea").focus()
}

/* �������� ����� ��� ����� ����������� ��� �������� ����� �� ������ */
function commentClose(){
	$('#commentBox').remove();
	$('#blockWindow').remove();
}

/* �������� ����� ��� ����� ����������� � �������� ������������ ����� */
function commentCancel(){
	$('#commentBox').remove();
	$('#blockWindow').remove();
	$('#dynamicform').remove();
}

/* ������ ����������� ������������ � ������������ ����� ��� �������� �� ������ */
function commentOk(){
	if ($("#commentText").val().length ==0){
		alert("������� �����������");
	}else{
		new FormData('comment', $("#commentText").val());
		commentClose();
		submitFormDecision();
	}
}

/* ������ "���������� ��������" */
function stopDocument(key){
	form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'></form>"
		$("body").append(form);
	new FormData('type', 'handler'); 
    new FormData('id', 'stopcoord'); 
    new FormData('key', key);
    submitFormDecision();
}

/* обработка действий пользователя при согласовании и подписании. Кнопки "Согласен" и "Не согласен" */
function decision(yesno, key, action){
	form="<form action='Provider' name='dynamicform' method='post' id='dynamicform' enctype='application/x-www-form-urlencoded'/>"
	$("body").append(form);
	actionTime= moment().format('DD.MM.YYYY HH:mm:ss');
	new FormData('actionDate',actionTime);
	new FormData('type', 'page'); 
    new FormData('id', action); 
    new FormData('key', key);
    if (yesno == "no"){
    	addComment(action)
    }else{
    	var dialog_title = "Оставить комментарий ответа?";
    	if ($.cookie("lang")=="KAZ")
    		dialog_title = "Жауаптың түсiнiктемесін қалдырасыз ма?";
        else if ($.cookie("lang")=="ENG")
        	dialog_title = "To leave the answer comment?";
        	
       dialogConfirmComment(dialog_title,action)
    }
}

/* �������� ������������ ����� �� ������*/
function submitFormDecision (){
	 data = $("#dynamicform").serialize();
	 $.ajax({
		 type: "POST",
		 url: "Provider",
		 data: data,
		 success: function() {
			 window.history.back();
		 }
	 });
}

function Block(blockNum){  
    this.revTableName = 'blockrevtable'+blockNum;  
    this.revTypeRadioName = 'block_revtype_'+blockNum;
    this.hiddenFieldName = 'block_reviewers_'+blockNum;
}