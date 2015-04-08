<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/view.xsl"/>
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:variable name="actionbar" select="//actionbar"/>
	<xsl:variable name="query" select="//query"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="no"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="//query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr title="{@viewtext}" class="{@docid}" id="{@docid}{@doctype}" style="height:40px">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="position() mod 2 = 0">
				<xsl:attribute name="bgcolor">#F5F5F5</xsl:attribute>
			</xsl:if>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="font-weight">bold</xsl:attribute>
			</xsl:if>
			<xsl:call-template name="viewtable_dblclick_open"/>
			<td style="text-align:center;border:1px solid #ccc; width:30px;">
				<input type="checkbox" name="chbox" id="{@id}" autocomplete="off" value="{@doctype}"/>
			</td>
			
			<!-- Number -->
			<xsl:if test="/request/@id !='task' and /request/@id != 'waitforcoord' and /request/@id != 'waitforsign'   and /request/@id != 'outdocreg' and //current_outline_entry/response/content/entry/@formid != 'task'">
				<td  style="border:1px solid #ccc;width:190px;">
					<div style="overflow:hidden; width:99%;">
						<xsl:if test="@hasresponse='1'">
				        	<xsl:choose>
				        		<xsl:when test=".[responses]">
									<img style="vertical-align:top; margin-left:2px; border:0px; cursor:pointer" src="/SharedResources/img/classic/1/minus1.png" docid="{@docid}" doctype="{@doctype}">
										<xsl:attribute name='onclick'>javascript:closeResponses(this)</xsl:attribute>
									</img>
								</xsl:when>
								<xsl:otherwise>
									<img style="vertical-align:top; margin-left:2px; border:0px; cursor:pointer" src="/SharedResources/img/classic/1/plus1.png" docid="{@docid}" doctype="{@doctype}">
										<xsl:attribute name='onclick'>javascript:openParentDocView(this)</xsl:attribute>
									</img>
								</xsl:otherwise>
							</xsl:choose>
						</xsl:if>
						<xsl:if test="not(hasresponse) and @hasresponse='0'">
							<span style="width:11px; display:inline-block"></span>
						</xsl:if>
						<a class="doclink" style="padding-left:5px;" href="{@url}" title="{@viewtext}">
							<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
							<xsl:if test="@isread = '0'">
								<xsl:attribute name="style">font-weight:bold;padding-left:5px</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="viewcontent/viewtext1"/>
						</a>
					</div>
				</td>
			</xsl:if>
			<!-- Название  -->
			<td  style="border:1px solid #ccc; width:450px;">
				<div style="overflow:hidden; width:100%; padding-left:5px">
					<a href="{@url}" class="doclink" style="width:100%; margin-left:5px">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold; margin-left:5px</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext2"/>
					</a>
				</div>
			</td>
			<!-- Местоположение -->
			<td  style="border:1px solid #ccc;min-width:280px; word-wrap:break-word; padding-left: 5px">
				<div style="display:block; width:99%; " title="{viewcontent/viewtext}">
					<a href="{@url}" class="doclink" style="width:90%">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext3"/>
					</a>
				</div>
			</td>
		</tr>
		<xsl:apply-templates select="responses"/>
	</xsl:template>

	<xsl:template match="responses">
		<tr class="{concat('response',../@docid,../@doctype)}">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<td style="width:3%"/>
			<td style="width:5%"/>
			<td colspan="4" nowrap="true">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="viewtext" mode="line"/>
	<xsl:template match="viewcontent" mode="line"/>
	
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden;" id="{@docid}{@doctype}">
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a  href="{@url}" title="{@viewtext}" class="doclink" style="font-style:arial; width:100%; font-size:99%">
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:variable name='simbol'>'</xsl:variable>
			<xsl:variable name='ecr1' select="replace(viewcontent/viewtext,$simbol ,'&quot;')"/>
			<xsl:variable name='ecr2' select="replace($ecr1, '&#34;' ,'&quot;')"/>
			<font id="font{@docid}{@doctype}">
				<script>
					text='<xsl:value-of select="$ecr2"/>';
					symcount= <xsl:value-of select="string-length(viewcontent/viewtext)"/>;
					ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
					replaceVal="<img/>";
					text=text.replace("-->",replaceVal);
					$("#"+ids).html(text);
					$("#"+ids+" > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
					$("#"+ids+" > img").attr("style","vertical-align:middle");
				</script>
			</font>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_corner.gif">
			<xsl:if test="following-sibling::entry">
				<xsl:attribute name="src" select="'/SharedResources/img/classic/tree_tee.gif'"/>
			</xsl:if>
		</img>
	</xsl:template>
	
	<xsl:template match="responses" mode="tree"/>

	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::entry and entry[@url]">
				<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="parent::responses or parent::entry">
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('EXPO Контроль доступа - ', page/captions/viewnamecaption/@caption)"/>
				</title>
				<link type="text/css" rel="stylesheet" href="classic/css/outline.css"/>
				<link type="text/css" rel="stylesheet" href="classic/css/main.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/smoothness/jquery-ui-1.8.20.custom.css"/>
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/js/hotnav/jquery.hotnav.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.widget.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.core.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.effects.core.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.mouse.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.draggable.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.position.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.button.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/minified/jquery.ui.dialog.min.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotkeys.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/hotnav/jquery.hotnav.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/scrollTo/scrollTo.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/tiptip/jquery.tipTip.js"/>
				<script type="text/javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="classic/scripts/view.js"/>
				<script type="text/javascript" src="classic/scripts/form.js"/>
				<script type="text/javascript" src="classic/scripts/page.js"/>
				<script type="text/javascript">
					$(document).ready(function(){
						shedule_find_events()
						hotkeysnav()
						outline.type = '<xsl:value-of select="@type"/>'; 
						outline.viewid = '<xsl:value-of select="@id"/>';
						outline.element = 'project';
						outline.command='<xsl:value-of select="current/@command"/>';
						outline.curPage = '<xsl:value-of select="current/@page"/>'; 
						outline.category = '';
						outline.filterid = '<xsl:value-of select="@id"/>';
						refresher();  
					});
					function hotkeysnav(){
						$(document).bind('keydown', function(e){
 							if (e.ctrlKey) {
 								switch (e.keyCode) {
								   case 78:
										<!-- клавиша n -->
								     	e.preventDefault();
								     	$("#btnNewdoc").click();
								     	break;
								   case 68:
								   		<!-- клавиша d -->
								     	e.preventDefault();
								     	$("#btnDeldoc").click();
								      	break;
								   case 70:
								   		<!-- клавиша f -->
								     	e.preventDefault();
								     	$("#btnQFilter").click();
								      	break;
								   case 85:
								   		<!-- клавиша u -->
								     	e.preventDefault();
								     	window.location.href=$("#currentuser").attr("href")
								      	break;
								   case 81:
								   		<!-- клавиша q -->
								     	e.preventDefault();
								     	window.location.href=$("#logout").attr("href")
								      	break;
								   case 72:
								   		<!-- клавиша h -->
								     	e.preventDefault();
								     	window.location.href=$("#helpbtn").attr("href")
								      	break;
								   default:
								      	break;
								}
	    					}
    					});
    					$("#btnNewdoc .ui-button-text").hotnav({keysource:function(e){ return "n"; }});
						$("#btnDeldoc .ui-button-text").hotnav({keysource:function(e){ return "d"; }});
						$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
						$("#btnQFilter .ui-button-text").hotnav({keysource:function(e){ return "f"; }});
						$("#logout").hotnav({keysource:function(e){ return "q"; }});
						$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
					}
				</script>
			</head>			
			<body>
				<xsl:call-template name="flashentry"/>
				<div id="blockWindow" style="display:none"/>
					<div id="wrapper">
						<xsl:call-template name="loadingpage"/>
						<xsl:call-template name="header-page"/>
						<xsl:call-template name="outline-menu-page"/>
						<span id="view" class="viewframe">
							<div id="viewcontent" style="margin-left:12px;">
								<div id="viewcontent-header" style="height:130px;">
									<xsl:call-template name="pageinfo"/>
									<div class="button_panel" style="margin-top:1px">
										<div style="float:left; margin-left:3px; margin-top:2px; margin-bottom:3px">
											<xsl:if test="$actionbar/action[@id='new_document']/@mode = 'ON'">
												<button class="blue-button" style="margin-right:5px" title="{$actionbar/action[@id='new_document']/@hint}" id="btnNewdoc">
													<xsl:attribute name="onclick">javascript:window.location.href="<xsl:value-of select="$actionbar/action[@id='new_document']/@url"/>"; beforeOpenDocument()</xsl:attribute>
													<font class="button_text"><xsl:value-of select="$actionbar/action[@id='new_document']/@caption"/></font>
												</button>
											</xsl:if>
											<xsl:if test="$actionbar/action[@id='delete_document']/@mode = 'ON'">
												<button class="blue-button" style="margin-right:5px" title="{//action[@id='delete_document']/@hint}" id="btnDeldoc">
													<xsl:attribute name="onclick">javascript:delDocument();</xsl:attribute>
													<font class="button_text"><xsl:value-of select="$actionbar/action[@id='delete_document']/@caption"/></font>
												</button>
											</xsl:if>
										</div>
										<span style="float:right; padding-right:10px;">
										</span>
									</div>
									<div style="clear:both"/>
									<div id="tableheader">
										<table class="viewtable" id="viewtable" width="100%" style="">
											<tr class="th">
												<xsl:choose>
													<xsl:when test="@id='report_tasks'">
														<td style="text-align:center;height:30px;width:20px;" class="thcell">
															<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this)"/>					
														</td>
														<td style="text-align:center;height:30px" class="thcell">
															<xsl:value-of select="page/captions/name/@caption"/>
														</td>
													</xsl:when>
												<xsl:otherwise>
												<td style="text-align:center;height:30px;width:32px;" class="thcell">
													<input type="checkbox" id="allchbox" autocomplete="off" onClick="checkAll(this)"/>					
												</td>
												<td style="width:190px;" class="thcell">
													<xsl:call-template name="sortingcellpage">
														<xsl:with-param name="namefield" select="'VIEWTEXT2'"/>
														<xsl:with-param name="sortorder" select="//query/columns/viewtext1/sorting/@order"/>
														<xsl:with-param name="sortmode" select="//query/columns/viewtext1/sorting/@mode"/>
													</xsl:call-template>
												</td>
												<td style="width:450px;" class="thcell">
													<xsl:call-template name="sortingcellpage">
														<xsl:with-param name="namefield" select="'VIEWTEXT1'"/>
														<xsl:with-param name="sortorder" select="//query/columns/viewtext2/sorting/@order"/>
														<xsl:with-param name="sortmode" select="//query/columns/viewtext2/sorting/@mode"/>
													</xsl:call-template>
						 						</td>
													<!-- <td style="width:250px;" class="thcell">
													<xsl:value-of select ="page/captions/viewtext/@caption"/>
														<xsl:call-template name="sortingcellpage">
															<xsl:with-param name="namefield">VIEWTEXT1</xsl:with-param>
															<xsl:with-param name="sortfield" select="page/view_content/query/sorting/field"/>
															<xsl:with-param name="sortorder" select="page/view_content/query/sorting/order"/>
														</xsl:call-template>
													</td> -->
													<td style="min-width:280px;" class="thcell">
														<xsl:call-template name="sortingcellpage">
															<xsl:with-param name="namefield" select="'VIEWTEXT3'"/>
															<xsl:with-param name="sortorder" select="//query/columns/viewtext3/sorting/@order"/>
															<xsl:with-param name="sortmode" select="//query/columns/viewtext3/sorting/@mode"/>
														</xsl:call-template>
													</td>
												</xsl:otherwise>
											</xsl:choose>
										</tr>
									</table>
								</div>
							</div>
							<div id="viewtablediv">
								<div id="tablecontent" style="top:135px">
									<xsl:if test="query/filtered/condition[fieldname != ''][value != '0']">
										<xsl:attribute name="style">top:132px;</xsl:attribute>
									</xsl:if>
									<table class="viewtable" id="viewtable" width="100%">
										<xsl:apply-templates select="//query/entry"/>
									</table>
									<div style="clear:both; width:100%">&#xA0;</div>
								</div>
							</div>
			 			</div>
					</span>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>