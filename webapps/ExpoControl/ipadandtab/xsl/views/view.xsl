<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Проекты - Служебные записки</xsl:variable>
	<xsl:output method="html" />
	
	<xsl:template match="query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="class" select="@docid"/>
			<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
			<xsl:if test="$num mod 2 = 0">
				<xsl:attribute name="bgcolor">#efefef</xsl:attribute>
			</xsl:if>
			<xsl:if test="$num mod 2 != 0">
				<xsl:attribute name="bgcolor">#ffffff</xsl:attribute>
			</xsl:if>
			<td style="text-align:left;" class="thcell">
				<input type="checkbox" name="chbox">	
					<xsl:attribute name="id" select="@docid"/>
				</input>&#xA0;&#xA0;
			</td>
			<td>
				<span style="float:right">
					<xsl:if test="allcontrol = '0'">
						&#xA0;<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0"/>
					</xsl:if>
					<xsl:if test="@hasattach != '0'">
						&#xA0;<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0">
								<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/></xsl:attribute>
							</img> 
					</xsl:if>
				</span>
			</td>
			<td class="thcell" style="text-align:left" nowrap="true">
          		<xsl:if test="hasresponse='true' and //request/@id!='toconsider'">
          			<xsl:choose>
          				<xsl:when test=".[responses]">
							<a href="" style="float:left; margin-top:-5px; margin-left:-8px">
								<xsl:attribute name='id'>a<xsl:value-of select="@docid"/></xsl:attribute>
								<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
								<img border='0' src="ipadandtab/img/toggle_minus.png">
									<xsl:attribute name='id'>img<xsl:value-of select="@docid"/></xsl:attribute>
								</img>
							</a>
						</xsl:when>
						<xsl:otherwise>
							<a href="" style="float:left; margin-top:-5px; margin-left:-8px">
								<xsl:attribute name='id'>a<xsl:value-of select="@docid"/></xsl:attribute>
								<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
								<img border='0' src="ipadandtab/img/toggle_plus.png">
									<xsl:attribute name='id'>img<xsl:value-of select="@docid"/></xsl:attribute>
								</img>
							</a>
						</xsl:otherwise>
					</xsl:choose>
				</xsl:if>
				<span style="margin-left:5px; width:97%; overflow:hidden; display:inline-block">
					<a target="_parent">
						<xsl:if test="not(hasresponse)">
							<xsl:attribute name="style">margin-left:10px</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;page=<xsl:value-of select="../../query/@currentpage"/></xsl:attribute>
						<xsl:attribute name="title" select="viewtext"/>
						<font class="font"  style="font-style:arial; ">
							<xsl:attribute name="id">font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
							<xsl:variable name='simbol'>'</xsl:variable>
							<xsl:variable name='ecr1'><xsl:value-of select="replace(viewtext,$simbol ,'&quot;')"/></xsl:variable>	
							<xsl:variable name='ecr2'><xsl:value-of select="replace($ecr1, '&#34;' ,'&quot;')"/></xsl:variable>	
							<script>
								text='<xsl:value-of select="$ecr2"/>';
								symcount= <xsl:value-of select="string-length(@viewtext)"/>;
								ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
								replaceVal="<img/>";
								text=text.replace("-->",replaceVal);
								$("#"+ids).html(text);
								$("font > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
								$("font > img").attr("style","vertical-align:middle");
							</script>
						</font>
					</a>	
				</span>
			</td>
		</tr>
		<xsl:apply-templates select="responses"/>
	</xsl:template>
	
	<xsl:template match="responses">
		<tr>
			<xsl:attribute name="class">response<xsl:value-of select="../@docid"/></xsl:attribute>
			<script>
				color=$(".response"+<xsl:value-of select="../@docid"/>).prev().attr("bgcolor");
			 	$(".response"+<xsl:value-of select="../@docid"/>).css("background",color);
			</script>
			<style type="text/css">
				div.Node * { vertical-align: middle }
			</style>
			<td/>
			<td/>
			<td colspan="4" nowrap="true">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	
	<xsl:template match="viewtext" mode="line">
		
	</xsl:template>
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; width:97%;">
			<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a  href="">
			<xsl:attribute name="href" select="@url"/>
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="@viewtext"/></xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:if test="@allcontrol = '0'">
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != '0'">
				<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0" style="vertical-align:top">
					<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/></xsl:attribute>
				</img> 
			</xsl:if>
			<font class="font"  style="font-style:arial; vertical-align:top; font-size:13px; padding-left:5px">
				<xsl:attribute name="id">font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
				<xsl:variable name='simbol'>'</xsl:variable>
				<xsl:variable name='ecr1'><xsl:value-of select="replace(viewtext,$simbol ,'&quot;')"/></xsl:variable>	
				<xsl:variable name='ecr2'><xsl:value-of select="replace($ecr1, '&#34;' ,'&quot;')"/></xsl:variable>	
				<!-- <script>
					text='<xsl:value-of select="$ecr2"/>';
					symcount= <xsl:value-of select="string-length(@viewtext)"/>;
					ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
					replaceVal="<img/>";
					text=text.replace("-1-1->",replaceVal);
					$("#"+ids).html(text);
					$("font > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
					$("font > img").attr("style","vertical-align:top; height:5px");
				</script> --><xsl:value-of select="viewtext"/>
			</font>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when test="following-sibling::entry">
				<img   src="/SharedResources/img/classic/tree_tee.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img  src="/SharedResources/img/classic/tree_corner.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="responses" mode="tree"/>

	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::entry and entry[@url]">
				<img  src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="parent::responses">
					<img  src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
				<xsl:if test="parent::entry">
					<img  src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>Проекты - Служебные записки</title>		
				<link rel="stylesheet" href="ipadandtab/css/outline.css" />
				<script language="javascript" src="ipadandtab/scripts/outline.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
			</head>			
			<body>
				<xsl:variable name="path" select="@skin"/>
				<xsl:if test="query/@flashdocid !=''">
					<script type="text/javascript">
						$("document").ready(
							function() {
								flashentry(<xsl:value-of select="query/@flashdocid"/><xsl:value-of select="query/@flashdoctype"/>);
							}
						);
					</script>
				</xsl:if>
				<input type="hidden">
					<xsl:attribute name="id">langinput</xsl:attribute>
					<xsl:attribute name="value" select="@lang"/>
				</input>
					<div id="view" style="background:#ffffff">
						<xsl:call-template name="refreshstat"/>	
						<br/>
						<table width="100%">
							<tr>
								<td>
									<xsl:if test="action[.='NEW_DOCUMENT']/@enable = 'true'">
										<a class="gray button" >
											<xsl:attribute name="href" select="newDocURL"/>
											<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
											<font><xsl:value-of select="action[.='NEW_DOCUMENT']/@caption"/></font>					
										</a>
									</xsl:if>
								</td>						
							</tr>
						</table>
						<xsl:call-template name="viewinfo"/>
						<table class="viewtable" style="width:100%; table-layout:fixed;">
							<tr class="th">
								<td style="text-align:left;"   width="2%" class="thcell">
									<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>&#xA0;&#xA0;					
								</td>
								<td width="5%"></td>
								<td width="92%" class="thcell">
									<xsl:value-of select="columns/column[@id = 'BRIEFCONTENT']/@caption"/>								
								</td>
							</tr>
							<xsl:if test="query/@ruleid != 'report_tasks'">
								<xsl:apply-templates select="query/entry" />
							</xsl:if>
							<xsl:if test="query/@ruleid = 'report_tasks'">
								<tr>
									<td style="text-align:left;"  width="2%" class="thcell">
										<input type="checkbox" id="chbox"/>&#xA0;&#xA0;					
									</td>
									<td width="5%"></td>
									<td width="92%" >
										<a href="Provider?type=document&amp;id=task_report&amp;key=">Задания</a>
									</td>
								</tr>
							</xsl:if>
						</table>
			 		</div>		
				</body>
			</html>
		</xsl:template>
</xsl:stylesheet>