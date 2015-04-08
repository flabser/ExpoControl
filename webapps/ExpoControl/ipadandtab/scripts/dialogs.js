var tableField;
var hiddenField;
var formName;
var entryCollections = new Array();

var queryOpt = {
	queryname:'',
	formname:'',
	fieldname:'',
	isMultiValue:'',
	tablename:'',
	pagenum:'1',
	keyword:'*',
	dialogview:'1'
}

/* ��������� ������� ������ esc � enter */
function keyDown(el){
	if(event.keyCode==27){
		$("#"+el).css("display","none");
		$("#"+el).empty();
		$("#"+el).remove();
		$("#blockWindow").remove();
	}
	if(event.keyCode==13){
		if (el !='coordParam'){
			pickListBtnOk()
		}else{
			coordOk()
		}
	}
}

/* ����� ������ �������������� �� ��������� */
function pickListSingleOk(docid){ 
	text=$("#"+docid).attr("value");
	$("input[name="+ queryOpt.fieldname +"]").remove();
	/* ������� ������� ���� ��� �������� ���� *�������������* */
	if (queryOpt.fieldname == "signer"){
		$("#coordBlockSign").remove();
		$("#frm").append("<input type='hidden' name='coordBlock'  id='coordBlockSign' value='new`tosign`0`"+docid+"'>")
	}
	if (queryOpt.fieldname == 'executor'){
		$("#intexectable tr:gt(0)").remove();
		$("input [name=executor]").remove();
		num=$("#intexectable tr").length;
		addExecutorField(num,docid);
		$('#intexectable').append("<tr>" +
				"<td style='text-align:center'>"+num+"</td>" +
				"<td>"+text+"<input  type='hidden' id='idContrExec"+num+"' value='"+docid+"'/></td>" +
				"<td id='controlOffDate"+num+"'></td>" +
				"<td id='idCorrControlOff"+num+"'></td>" +
				"<td id='switchControl"+num+"'><a href='javascript:controlOff("+num+")'><img  title='����� � ��������' src='/SharedResources/img/classic/exec_control.gif'/><a/></td>" +
		"</tr>");
	}else{
		$("#frm").append("<input type='hidden' name='"+ queryOpt.fieldname +"'  id='"+queryOpt.fieldname+"' value='"+docid+"'>")
	}
	newTable="<table id="+ queryOpt.tablename +" width='600px' style='border:1px solid #ccc; '><tr><td>"+ text +"</td></tr></table>"
	$("#"+ queryOpt.tablename).replaceWith(newTable)
	pickListClose(); 
}

/* ������� ������ "��" � ����� ������ ������������� �� ���������*/
function pickListBtnOk(){
	var k=0;
	var chBoxes = $('input[name=chbox]'); 
	var hidfields = $("#executorsColl").children("input[type=hidden]"); 
	if (queryOpt.fieldname == "executor"){
		for( var i = 0; i < $("#executorsColl").children("input[type=hidden]").length; i ++ ){
			if (k==0){
				$("#intexectable tr:gt(0)").remove();
				newTable="<table id='"+ queryOpt.tablename +"' width='600px' ></table>"
				$("#"+ queryOpt.tablename ).replaceWith(newTable)
				$("input[name="+queryOpt.fieldname +"]").remove();
			}
			k=k+1;
			$("#"+ queryOpt.tablename ).append("<tr><td style='border:1px solid #ccc'>"+hidfields[i].value +"</td><td></td></tr>");
			 if(k==1 && $("#executorsColl").children("input[type=hidden]").length > 1 ){
				 $("#"+queryOpt.tablename + " tr:first td:last").append("&#xA0;<img src='/SharedResources/img/iconset/bullet_yellow.png' style='height:16px' title='�������������'/>")
			 }
			num=$("#intexectable tr").length;
			addExecutorField(num,hidfields[i].id);
			$('#intexectable').append("<tr>" +
				"<td style='text-align:center'>"+num+"</td>" +
				"<td>"+hidfields[i].value+"<input  type='hidden' id='idContrExec"+num+"' value='"+hidfields[i].id+"'/></td>" +
				"<td id='controlOffDate"+num+"'></td>" +
				"<td id='idCorrControlOff"+num+"'></td>" +
				"<td id='switchControl"+num+"'><a href='javascript:controlOff("+num+")'><img  title='����� � ��������' src='/SharedResources/img/classic/exec_control.gif'/><a/></td>" +
			"</tr>");
		}
	}else{
		for( var i = 0; i < chBoxes.length; i ++ ){
			if (chBoxes[i].checked){ 
				if (k==0){
					newTable="<table id="+ queryOpt.tablename +" width='600px' ></table>"
					$("#"+ queryOpt.tablename).replaceWith(newTable)
					$("input[name="+queryOpt.fieldname+"]").remove();
				}
				k=k+1;
				$("#"+ queryOpt.tablename).append("<tr><td style='border:1px solid #ccc'>"+chBoxes[i].value+"</td></tr>");
				if (queryOpt.fieldname == "signer"){
					$("#coordBlockSign").remove();
					$("#frm").append("<input type='hidden' name='coordBlock'  id='coordBlockSign' value='new`tosign`0`"+chBoxes[i].id+"`367"+"'>")
				}else{
					$("#"+ queryOpt.formname).append("<input type='hidden' name='"+queryOpt.fieldname+"' id='"+queryOpt.fieldname+"' value='"+chBoxes[i].id+"'>")
				}
			}
		}
		
	}
	if (k>0){
		pickListClose();  
	}else{
		alert('�������� ��������');
	}
}

/*�������� ����� ������ ��������������� �� ��������� */
function pickListClose(){ 
	$("#picklist").empty();
	$('#picklist').remove();
	$('#blockWindow').remove();
	// ��������� ��������� ������ �� �����
	$('#picklist').enableSelection();
	if (queryOpt.fieldname == 'executor'){
		$("#content").focus();
		$("#content").blur()
		$("#content").focus();
	}
}

/* ����� ������ ��������������*/
function pickListSingleCoordOk(docid){ 
	text=$("#"+docid).attr("value");
	$("input[name=coorder]").remove();
	$("#frm").append("<input type='hidden' name='coorder'  id='coorder' value='"+docid+"'>")
	newTable="<table id='coordertbl' width='100%'><tr><td>"+ text +"</td></tr></table>"
	$("#coordertbl").replaceWith(newTable);
	closePicklistCoord();  
}

/* �������� ����������� ����*/
function closePicklistCoord(){
	$("#picklist").remove();
	$("#blockWindow").css('z-index','2');
}

/* ����� ���� ���������� ������  */
function centring(id,wh,ww){
	var w=document.body.clientWidth; 
	var h=document.body.clientHeight;
	var winH=wh; 
	var winW=ww;
	var scrollA=$("body").scrollTop(); 
	var scrollB=$("body").scrollLeft();
	htop=scrollA+((h/2)-(winH/2))
	hleft=scrollB+((w/2)-(winW/2))
	$('#'+id).css('top',htop) ;
	$('#'+id).css('left',hleft) ;
}

/*������� ��� ����������� rollover*/
function entryOver(cell){
	cell.style.backgroundColor='#FFF1AF';
}

/*������� ��� ����������� rollover*/
function entryOut(cell){
	cell.style.backgroundColor='#FFFFFF';
}

function entrySelect(el){
	if($(el).attr("checked")== "checked"){
		if($(el).attr("type")=="radio"){
			$("div [name=itemStruct]").css("backgroundColor","#FFFFFF");
			$(el).parent("div").css("backgroundColor","#FFF1AF");
		}else{
			$(el).parent("div").css("backgroundColor","#FFF1AF");
		}
	}else{
		$(el).parent("div").css("backgroundColor","#FFFFFF");
	}
}

function entrySelectForTable(el){
	if($(el).attr("checked")== "checked"){
		if($(el).attr("type")=="radio"){
			$(".entry_tr").css("backgroundColor","#FFFFFF");
			$(el).parent("td").parent("tr").css("backgroundColor","#FFF1AF");
		}else{
			$(el).parent("td").parent("tr").css("backgroundColor","#FFF1AF");
		}
	}else{
		$(el).parent("td").parent("tr").css("backgroundColor","#FFFFFF");
	}
}

/* ������� ��� �������� ��������������� � ����� �������� ������ ������������ */
function picklistCoordinators(){
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id=bossandemp',
		success:function (data){
			if(data.match("html")){
				window.location="Provider?type=static&id=start&autologin=0"
			}
			$("#contentpane").html('');
			$("#contentdiv").append(data);
			$('#searchCor').focus();
		}
	});
}

var elementCoord;
/* ���������� ��������������� � ������� ������� ������� ����*/

function addCoordinator(docid,el){
	//docid - userID  ���������� ��������������
	// el - ������ ������� � ��������� ���������������
	cwb=$(".coordinatorsWithBlock")
	signer=$("#signer").val(); 
	recipient=$("#recipient").val()
	if (signer == docid){
		text="��������� ���� ��������� �������� ������������� ��������� �������"
			infoDialog(text)
	}else{
		if (recipient == docid){
			text="��������� ���� ��������� �������� ����������� ��������� �������"
				infoDialog(text)
		}else{
			if ($("."+docid).val()!= null){
				text="������ ������������� ��� ������ ��� ������������"
					infoDialog(text)
			}else{
				text=$("#"+docid).val();
				$(el).replaceWith("");
				tr="<div style='display:block; width:100%; text-align:left; cursor:pointer' name='itemStruct' onClick='selectItem(this)' ondblclick='removeCoordinator(&quot;"+docid+"&quot;,this)' style='cursor:pointer'><input class='chbox' type='hidden' name='chbox'   id='"+ docid+"' value='"+ text +"'></input><font style='font-size:12px'>"+text+"</font></div>";
				$("#coorderToBlock").append(tr);
			}
		}
	}
}

/*�������� �� ������� ��������������� ������� ������� ���� */
function removeCoordinator(docid,el){
	text=$("#"+docid).attr("value");
	$(el).remove();
	tr="<div style='display:block; width:100%; text-align:left; cursor:pointer' name='itemStruct' onClick='selectItem(this)' ondblclick='addCoordinator(&quot;"+docid+"&quot;,this)' ><input class='chbox' type='hidden' name='chbox'   id='"+ docid+"' value='"+ text +"'></input><font style='font-size:12px'>"+ text+"</font></div>";
	$("#picklistCoorder").append(tr);
}

/*��������� � ������ ��������� �������������� � ������� ��������� ������� ���� */
var prevSelectItem=null

function selectItem (el){
	elementCoord=el;
	if (prevSelectItem != null){
		$(prevSelectItem).attr("class","")
	}
	$(el).attr("class","selectedItem");
	prevSelectItem=el
}

function plusCoordinator(){
	isWithBlock="false";
	userID=$(".selectedItem  input").attr("id");
	if(!userID){
		infoDialog("Вы не выбрали участника согласования для добавления");
	}
	if($("."+userID).val() != null){
		infoDialog(alreadychosen)
		isWithBlock="true"
	}
	if (isWithBlock=="false"){
		signer=$("#signer").val(); 
		recipient=$("#recipient").val()
		if (userID == signer){
			infoDialog(issignerofsz);
		}else{
			if (userID == recipient){
				infoDialog(isrecieverofsz);
			}else{
				$("#coorderToBlock").append(elementCoord);
				$(elementCoord).removeClass();
				$("#picklistCoorder .selectedItem").replaceWith("");
				elementCoord=null;
			} 
		}
	}
}

/* удаление корреспондента из таблицы нажатием кнопки "<--" */
function minusCoordinator(){
	if($("#coorderToBlock").children(".selectedItem").length !=0){
		$("#coorderToBlock").children(".selectedItem").remove();
		$("#picklistCoorder").append(elementCoord);
		$(elementCoord).removeClass();
		elementCoord=null
	}else{
		infoDialog("Вы не выбрали участника согласования для удаления");
	}
}

function closeDialog(el){
	$("#"+el).empty().remove();
	$("#blockWindow").remove();
}

function fastCloseDialog(){
	$("#picklist").css("display","none");
}

function dialogBoxStructure(query,isMultiValue, field, form, table) {
	queryOpt.fieldname = field;
	queryOpt.formname = form;
	queryOpt.isMultiValue = isMultiValue;
	queryOpt.queryname = query;
	queryOpt.tablename = table;
	el='picklist'
	divhtml ="<div class='picklist' id='picklist' onkeyUp='keyDown(el);'>";
	divhtml +="<div  class='header'><font id='headertext' style='font-size:0.9em'></font>";
	divhtml +="<div class='closeButton'><img src='/SharedResources/img/iconset/window_close.png' onclick='pickListClose(); ' style='border:0;margin-left:3px; width:40px; height:40px'/>";
	divhtml +="</div></div><div id='divChangeView' style='margin-top:7%; margin-left:81%'>" 
	divhtml +="<a id='btnChangeView' href='javascript:changeViewStructure(1)' style='font-size:11px'>�������� ���</a></div>";
	divhtml +="<div id='divSearch' class='divSearch' display='inline-block'></div><div id='contentpane' class='contentpane'>�������� ������...</div>";  
	divhtml += "<div  id = 'btnpane' style='margin:30px 30px 20px 0px; text-align:right;'>";
	divhtml += "<a class='gray button' href='javascript:pickListBtnOk()'>" 
	divhtml +="<font>��</font></a>&#xA0;&#xA0;";    
	divhtml += "<a class='gray button' href='javascript:pickListClose()'><font>������</font></a>";    
	divhtml += "</div><div id='executorsColl' display='none'></div></div>";
	$("body").append(divhtml);
	$("#picklist").draggable({handle:"div.header"});
	blockWindow = "<div  class = 'ui-widget-overlay' id = 'blockWindow'></div>"; 
	$("body").append(blockWindow);
	$("#picklist").focus()
	$('#picklist').css('width',$(document).width()); 
	$('#picklist').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$('#picklist').css('display', "none");
	$("#headertext").text("����� ��������������");
	$("body").css("cursor","wait")
	
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+query+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (isMultiValue=="false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").text('');
			$("#contentpane").append(data);
			$("#searchTable").remove();
			if (isMultiValue=="false"){
				$("#contentpane").append("<input type='hidden' id='radio' value='true'/>");
			}else{
				$("#contentpane").append("<input type='hidden' id='radio' value='false'/>");
				$("div[name=itemStruct] input[type=checkbox]").click(function(){
					addToCollectExecutor(this)
				});
			}
			// ��������� ��������� ������
			$(document).ready(function(){
				$('#picklist').disableSelection();
			});
			if ($("#coordTableView tr").length > 1 &&  field == 'signer'){
				textConfirm="��� ��������� ���� '��� ����� ��������' ������������ ����� ������������ ����� �������"
					dialogConfirm (textConfirm, "picklist","trblockCoord")
			}else{
				$('#blockWindow').css('display',"block")
				$('#picklist').css('display', "inline-block");
			}
			$('#picklist').focus()
		},
		error:function (xhr, ajaxOptions, thrownError){
            if (xhr.status == 400){
         	  $("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
         	  $("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
         	  $("li[type='square'] > a").attr("href","javascript:backtocontent()")
            }
         }  
	});
	$("body").css("cursor","default")
}

function addToCollectExecutor(el){
	if($(el).attr("checked")== "checked"){
		$("#executorsColl").append("<input type='hidden' id='"+$(el).attr("id")+"' value='"+$(el).val() +"'/>")
	}else{
		$("#executorsColl").children("#"+$(el).attr("id")).remove();
	}
	$("#executorsColl input[type=hidden]:first").attr("class","otv")
}


/* �������  ������� � ���������� ��������� ������   */
jQuery.fn.extend({
    disableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function() { return false; };
    		this.unselectable = "on";
    		jQuery(this).css('-moz-user-select', 'none');
    	});
    },
    enableSelection : function() {
    	this.each(function() {
    		this.onselectstart = function() {};
    		this.unselectable = "off";
    		jQuery(this).css('-moz-user-select', 'auto');
    	});
    }
});

/* ������� ������ ��������������� � ����� '����� ������������'*/
function findCorCoord(){
	var value=$('#searchCor').val();
	var len=value.length
	if (len > 0){
		$("#picklistCoorder div[name=itemStruct]").css("display","none");
		$("#contentdiv").find("div[name=itemStruct]").each(function(){
			if ($(this).text().substring(0,len).toLowerCase()== value.toLowerCase()){
				$(this).css("display","block")
			}
		});
	}else{
		$("div[name=itemStruct]").css("display","block");
	}
}

/* ������� ������ � ���������*/
function findCorStructure(){
	var value=$('#searchCor').val();
	var len=value.length
	if (len > 0){
		$("div[name=itemStruct]").css("display","none");
		$("#contentpane").find("div[name=itemStruct]").each(function(){
			if ($(this).text().substring(0,len).toLowerCase()== value.toLowerCase()){
				$(this).css("display","block")
			}
		});
	}else{
		$("div[name=itemStruct]").css("display","block");
	}
}
/* ������� ������ �������� � ��������*/
function selectPage(page){
	queryOpt.pagenum = page;
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+ queryOpt.queryname +'&page='+ queryOpt.pagenum +"&keyword="+queryOpt.keyword,
		success:function (data){
			if (queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").html('');
			$("#contentpane").append(data);
			$('#btnChangeView').attr("href","javascript:changeViewStructure("+queryOpt.dialogview+")");
			$('#searchCor').focus()
		}
	});
}

/* ������� ��������� ���� ������� (������ ��� ���������)*/
function changeViewStructure (viewType){
	if (viewType==1){
		switch (queryOpt.queryname){
			case "corresp":
				queryOpt.queryname="corr";
				break;
			case "signers":
				queryOpt.queryname="signers";
				break;
			case "n":
				queryOpt.queryname="n";
				break;
			default:
				queryOpt.queryname="structure";
				break;
		}
		queryOpt.dialogview = 2;
	}else{
		switch (queryOpt.queryname){
			case "corr":
				queryOpt.queryname="corresp";
				break;
			case "corresp":
				queryOpt.queryname="corr";
				break;
			case "signers":
				queryOpt.queryname="signers";
				break;
			case "n":
				queryOpt.queryname="n";
				break;
			default:
				queryOpt.queryname="bossandemppicklist";
				break;
		}
		queryOpt.dialogview = 1;
	}
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+queryOpt.queryname+'&keyword='+queryOpt.keyword+'&page='+queryOpt.pagenum,
		success:function (data){
			if (queryOpt.isMultiValue =="false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").text('');
			$("#contentpane").append(data);
			if(viewType == 1){
				searchTbl ="<font style='vertical-align:3px; float:left; margin-left:4%'><b>�����:</b></font>";
				if (queryOpt.queryname == 'n'){
					searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='ajaxFind()'/>"; 
				}else{
					searchTbl +=" <input type='text' id='searchCor' style='float:left; margin-left:3px;' size='34' onKeyUp='findCorStructure()'/>"; 
				}
				$("#divSearch").append(searchTbl);
				$('#searchCor').focus()
			}else{
				$("#divSearch").empty()
			}
			$('#btnChangeView').attr("href","javascript:changeViewStructure("+queryOpt.dialogview+")");
		},
		error:function (xhr, ajaxOptions, thrownError){
			if (xhr.status == 400){
				$("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
				$("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
				$("li[type='square'] > a").attr("href","javascript:backtocontent()")
			}
		}  
	});
}

function ajaxFind(){
	queryOpt.keyword=$("#searchCor").val()+"*";
	$.ajax({
		type: "get",
		url: 'Provider?type=view&id='+queryOpt.queryname+'&keyword='+queryOpt.keyword+"&page=1",
		success:function (data){
			if (isMultiValue=="false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$("#contentpane").html('');
			$("#contentpane").append(data);
			$('#btnChangeView').attr("href","javascript:changeViewStructure(2)");
			$('#searchCor').focus()
		},
		error:function (xhr, ajaxOptions, thrownError){
            if (xhr.status == 400){
         	  $("body").children().wrapAll("<div id='doerrorcontent' style='display:none'></div>")
         	  $("body").append("<div id='errordata'>"+xhr.responseText+"</div>")
         	  $("li[type='square'] > a").attr("href","javascript:backtocontent()")
            }
         }    
	});
}

/* ������� �������� ��������� � ���������*/
function expandChapter(query,id,doctype) {
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=expand`'+id+'`'+doctype,
		success: function(data) {
			if(queryOpt.isMultiValue == "false"){
				while(data.match("checkbox")){
					data=data.replace("checkbox", "radio");
				}
			}
			$(".tbl"+id+doctype).append(data);	
			if (doctype == "891"){
				$("input[name=chbox]").removeAttr("style");	
			}
		}
	});	
	$("#a"+id+doctype).attr("href","javascript:collapseChapter('"+query+"','"+id+"','"+ doctype+"')");
	$("#img"+id+doctype).attr("src","ipadandtab/img/toggle_minus_small.png");
}

/* ������� �������� ��������� � ���������*/
function collapseChapter(query,id,doctype){
	$.ajax({
		url: 'Provider?type=view&id='+query+'&parentdocid='+id+'&parentdoctype='+doctype+'&command=collaps`'+id+'`'+doctype,
		success: function(data) {
			$(".tbl"+id+doctype+" tr:[name=child]").remove()
		}
	});
	$("#img"+id+doctype).attr("src","ipadandtab/img/toggle_plus_small.png");
	$("#a"+id+doctype).attr("href","javascript:expandChapter('"+query+"','"+id+"','"+ doctype+"')");
}

/* ������� �������� ��������� ���������������*/

function expandChapterCorr(viewtext,num,url,doctype, page) {
	el = $(".tblCorr:eq("+num+")");
	$("#contentpane").html("<center>�����... ���� ��������...</center><img style='margin-top:10%' src='/SharedResources/img/classic/loading.gif'/>");
	if($.browser.msie){
		encd= UrlDecoder.decode(viewtext)
		encd= UrlDecoder.encode(encd)
	}else{
		encd= UrlDecoder.encode(viewtext)
	}
	
	$.ajax({
		url:'Provider?type=view&id=corresp&page='+ queryOpt.pagenum +'&command=expand`'+encd,
		dataType:'HTML',
		success: function(data) {
			$("#contentpane").empty();
			$("#contentpane").append(data);	
		}
	});	
}

/* ������� �������� ��������� ���������������*/

function collapsChapterCorr(viewtext,num,url,doctype) {
	el = $(".tblCorr:eq("+num+")");
	$("#contentpane").html("<center>�����... ���� ��������...</center><img style='margin-top:10%' src='/SharedResources/img/classic/loading.gif'/>");
	if($.browser.msie){
		encd= UrlDecoder.decode(viewtext)
		encd= UrlDecoder.encode(encd)
	}else{
		encd= UrlDecoder.encode(viewtext)
	}
	$.ajax({
		url:'Provider?type=view&id=corresp&page='+queryOpt.pagenum+'&command=collaps`'+encd,
		dataType:'HTML',
		success: function(data) {
			$("#contentpane").empty();
			$("#contentpane").html(data);	
		}
	});	
}