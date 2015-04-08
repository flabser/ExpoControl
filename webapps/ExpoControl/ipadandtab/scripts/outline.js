var type;
var viewid;
var direction;
var curPage;
var n;
var cfg;
var command;
var sumReloadView;
var curlangOutline;

function slideMenu(e){
	if (event.targetTouches.length == 1) {
		 var touch = event.targetTouches[0];
		$("#view").css("left",touch.pageX + 'px')
		
		}
}

function flipLeft(){
	$(".next").click()
}

function flipRight(){
	$(".prev").click()
}

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
			return string;
		}
}

function openOutlineNavigation(){
	$(".outline_navigation").animate({height: "100%"}, 600);
	$("#arrow").addClass("rotate");
	$(".outline_navigation_footer").attr("onclick","javascript:closeOutlineNavigation(this)");
}

function closeOutlineNavigation(el){
	$(".outline_navigation").animate({height: "40px"}, 600);
	$("#arrow").removeClass("rotate");
	$(".outline_navigation_footer").attr("onclick","javascript:openOutlineNavigation()");
}


function openXMLdoc(){
	window.location.href=window.location +"&onlyxml"
}

function openXMLdocView(curviewid){
	window.location.href="Provider?type=view&id="+curviewid+"&onlyxml"
}

function colapseOutlineCategory(num){
	$(".outlineEntry"+num).css("display","none");
	$("#acategory"+num).attr("href","javascript:expandOutlineCategory("+num+")");
	$("#imgcategory"+num).attr("src","/SharedResources/img/classic/plus.gif");
}

function expandOutlineCategory(num){
	$(".outlineEntry"+num).css("display","block");
	$("#acategory"+num).attr("href","javascript:colapseOutlineCategory("+num+")");
	$("#imgcategory"+num).attr("src","/SharedResources/img/classic/minus.gif");
}

function openCloseAdvSearchDiv(){
	$("#advancedSearchDiv").css("display") == "none" ? $("#advancedSearchDiv").css("display","block") : $("#advancedSearchDiv").css("display","none");
}

function search(){
	$(".searchpan").html("");
	value=$("#searchInput").val();
	if(value.length==0){
		message("Заполните строку поиска","searchInput");
	}else{
		value = Url.encode(value)
		window.location="Provider?type=outline&subtype=search&keyword="+value;
	}
}

function closeSearch(){
	$(".searchpan").css("display","none");
	$("#searchInput").attr("value","");
}

function openSearch(){
	$(".searchpan").css("display","block")
}

function collapsSearch(){
	$("#content").attr("style","display:none");
	$(".searchpan").css("style","height:20px");
	$("#colsearch").attr("src","/SharedResources/img/classic/open_gray.gif");
	$("#excol").attr("href","javascript:expandSearch()");
}

function expandSearch(){
	$("#content").attr("style","display:block");
	$("#colsearch").attr("src","/SharedResources/img/classic/close_gray.gif");
	$("#excol").attr("href","javascript:collapsSearch()");
	
}

function openParentDocView(id,cdoctype,pos,s) {
	$.ajax({
		  url: 'Provider?type=view&id=docthread&parentdocid='+id+'&parentdoctype='+cdoctype+'&command=expand`'+id+'`'+cdoctype,
		  datatype:'html',
		  success: function(data) {
			 $(data).insertAfter("."+ id );	
			  if($("."+id).attr("bgcolor")!= undefined){
				  $("."+id+ " tr").attr("style","background:"+$("."+id).attr("bgcolor"));
			  }
			  $("."+id).next("tr").css("background",$("."+id).attr("bgcolor"))
		  }
	});	
	$("#a"+id).attr("href","javascript:closeResponses('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
	$("#img"+id).attr("src","ipadandtab/img/toggle_minus.png");
}

function closeResponses(id,cdoctype,pos,s){
	$.get('Provider?type=view&id=docthread&command=collaps`'+id+'`'+cdoctype, {})
	$("."+id).next("tr").replaceWith("");
	$("#img"+id).attr("src","ipadandtab/img/toggle_plus.png");
	$("#a"+id).attr("href","javascript:openParentDocView('"+id+"','"+ cdoctype+"','"+pos+"',"+s+")");
}

function deleteDoc() {
	var i; var result = false;
	var chBoxes = document.getElementsByName('chbox');
	for (i = 0; i < chBoxes.length; i++) {	
		if (chBoxes[i].checked){			
			docid=chBoxes[i].id;
			$.get('Provider?type=delmaindoc&key='+docid, {},function (){});
		}
	}
	window.location.reload()
}	 

function checkAll(allChbox) {
	allChbox.checked ? $("input[name=chbox]").attr("checked","true") : $("input[name=chbox]").removeAttr("checked");
}

function refresher() {
	sumReloadView = 0
	if ($.cookie("refresh") !=null){
		timeval= $.cookie("refresh") * 60000;
	}else{
		timeval=60000
	}
	setInterval("refreshAction()", timeval);
}

function refreshAction() {
	sumReloadView = sumReloadView + 1
	updateView(type, viewid, curPage, command);
}

function doSearch(keyWord ,num){
	if (num != null){
		curPage = num
	}
	keyWord = Url.encode(keyWord)
	$.ajax({
		url: 'Provider?type=search&keyword=' + keyWord + '&page=' + curPage,
		datatype:"html",
		beforeSend: function(){
			loadingViewInOutline()
		},
		success: function(data) {
			$('#view').html(data.split("<body>")[1].split("</body>")[0]);
			endLoadingViewInOutline()
		},
		error: function(data) {
			$("#noserver").css("display","block");
			$("#finddoc").css("display","none");
		}
	});
}

function flashentry(id) {
	$("#"+id).animate({backgroundColor: '#ffff99'}, 500);
	$("#"+id).animate({backgroundColor: 'white'}, 1000);
}

function updateAllCount(){
	updateCount("tasksforme_count", "countSpanTaskforme")
	updateCount("mytasks_count", "countSpanMytasks")
	updateCount("completetask_count", "countSpanCompletetask")
	updateCount("waitforcoord_count", "countSpanWaitforcoord")
	updateCount("waitforsign_count", "countSpanWaitforsign")
}

function updateCount(query, idcount) {
	$.ajax({
		url: 'Provider?type=query&id='+query+'&rndm='+Math.random(),
		dataType:'xml',
		async:'true',
		success: function(data) {
			count = $(data).find('query').text() || 0;
			$("#"+ idcount).html("<font style='font-size:12px'>["+count+"]</font>")
		}
	});
}

function updateView(type, viewid, page, command, docid, doctype){
	commandPart = '';
	if (command != null){
		commandPart = '&command=' + command;
	}
	curPage=page;
	$.ajax({
		url: 'Provider?type=' + type + '&id=' + viewid + '&page=' + curPage + commandPart,
		dataType:'HTML',
		async:'true',
		beforeSend: function(){
			loadingViewInOutline()
		},
		success: function(data) {
			$('#view').html(data.split("<body>")[1].split("</body>")[0]);
			if (data.match("viewtable")){
				endLoadingViewInOutline()
				$("#block_user_info").html($("#userprofile").children().clone())
			}
		},
		error: function(data) {
			$("#noserver").css("display","block");
			$("#finddoc").css("display","none");
		}
	});
}

function loadingViewInOutline(){
	loading="<div id='loadingpage' style='display:block ; position:absolute; top:47%; width:100%; z-index:999;'>"
	loading+="<center><img src='/SharedResources/img/classic/ajax-loader.gif'/></center>"
	loading+="</div>"
	$("#view").append(loading);
	blockWindow = "<div class='blockWindow' id='blockWindow'/>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$("body").css("cursor","wait")
}

function endLoadingViewInOutline(){
	$('#loadingpage').empty();
	$('#blockWindow').remove();
	$("body").css("cursor","default")
}

function toglleSection(tableid, imgid) {
	if ($(tableid).style.display == "block") {
		$(tableid).style.display = "none";
		$(imgid).src = "sdimg/plus.gif";
	}else{
		$(tableid).style.display = "block";
		$(imgid).src = "sdimg/minus.gif";
	}
}

function subentry(id) {
	if ($("subentry" + id).style.display == "none") {
		$('subentry' + id).style.display = "block"
	} else {
		$('subentry' + id).style.display = "block"
	}
}

function beforeOpenDocument(){
	loading="<div id='loadingpage' style='display:block ; position:absolute; top:47%; width:100%; z-index:999;'>"
	loading+="<center><img  src='/SharedResources/img/classic/ajax-loader.gif'/></center>"
	loading+="</div>"
	$("#view").append(loading);
	blockWindow = "<div class='blockWindow' id='blockWindow'/>"; 
	$("body").append(blockWindow);
	$('#blockWindow').css('width',$(document).width()); 
	$('#blockWindow').css('height',$(document).height());
	$('#blockWindow').css('display',"block")
	$("body").css("cursor","wait")
	$(window).unload(function(){ 
			$("#loadingpage").remove()
		});
	
}