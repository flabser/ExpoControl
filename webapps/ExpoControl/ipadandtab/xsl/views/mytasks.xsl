<?xml version="1.0" ?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Мои задания</xsl:variable>
	<xsl:output method="html" />

		<xsl:variable name="useragent" select="request/@useragent"/>
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
			<td></td>
			<td></td>
			<td colspan="4" nowrap="true">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; width:97%; margin-top:2%">
			<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a  href="" style="vertical-align:6px">
			<xsl:if test="$useragent = 'FIREFOX'">
				<xsl:attribute name="style">font-size:11px; vertical-align:2px</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="@viewtext"/></xsl:attribute>
			<xsl:if test="@isread = 0">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:if test="@allcontrol = 0">
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0">
					<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/> </xsl:attribute>
				</img> 
			</xsl:if>
			<font class="font"  style="font-style:arial;">
				<xsl:attribute name="id">font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
				<xsl:variable name='simbol'>'</xsl:variable>
				<xsl:variable name='ecr1'><xsl:value-of select="replace(@viewtext,$simbol ,'&quot;')"/></xsl:variable>	
				<xsl:variable name='ecr2'><xsl:value-of select="replace($ecr1, '&#34;' ,'&quot;')"/></xsl:variable>	
				<script>
					text='<xsl:value-of select="$ecr2"/>';
					symcount= <xsl:value-of select="string-length(@viewtext)"/>;
					ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
					replaceVal="<img/>";
					text=text.replace("-->",replaceVal);
					$("#"+ids).html(text);
					$("font > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
				</script>
			</font>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when test="following-sibling::*">
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
			<xsl:when test="following-sibling::* and *[@url]">
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
				<title>Мои задания</title>		
				<link rel="stylesheet" href="classic/css/outline.css" />	
				<script language="javascript" src="classic/scripts/outline.js" ></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"></script>
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
					<xsl:attribute name="value"><xsl:value-of select="@lang"/></xsl:attribute>
				</input>
				<div id="view">
					<xsl:call-template name="refreshstat"/>	
					<br/>
					<xsl:call-template name="viewinfo"/>
					<table class="viewtable" style="width:100%; table-layout:fixed;">
						<tr class="th">
							<td style="text-align:center" width="4%" class="thcell">
								<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>					
							</td>
							<td width="4%">&#xA0;</td>
							<td width="92%" class="thcell"><xsl:value-of select="columns/column[@id = 'BRIEFCONTENT']/@caption"/>								
							</td>
						</tr>
						<xsl:for-each select="query/entry">
							<tr>
								<xsl:if test="@isread = 0">
									<xsl:attribute name="style">font-weight:bold</xsl:attribute>
								</xsl:if>
								<xsl:attribute name="class"><xsl:value-of select="@docid"/></xsl:attribute>
								<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
								<td  class="thcell" style="text-align:center">
									<input type="checkbox" name="chbox">	
										<xsl:attribute name="id">
											<xsl:value-of select="@docid"/>
										</xsl:attribute>
									</input>
								</td>
								<td>
									<xsl:if test="allcontrol = 0">
										<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0" style="margin-left:3px"/>&#xA0;
									</xsl:if>
									<xsl:if test="hasattachment='true'">
										<img id="atach" src="/SharedResources/img/classic/attach.gif" border="0"/> 
									</xsl:if>
								</td>
								<td class="thcell" style="text-align:left" nowrap="true">
									
          								<xsl:if test="@hasresponse='1'">
          									<xsl:choose>
          										<xsl:when test="entry[responses]">
													<a href="" style="margin-left:0.5%">
														<xsl:attribute name='id'>a<xsl:value-of select="@docid"/></xsl:attribute>
														<xsl:attribute name='href'>javascript:closeResponses(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
														<img border='0' src="ipadandtab/img/toggle_minus.png">
															<xsl:attribute name='id'>img<xsl:value-of select="@docid"/></xsl:attribute>
														</img>
													</a>
												</xsl:when>
												<xsl:otherwise>
													<a href="" style="margin-left:0.5%">
														<xsl:attribute name='id'>a<xsl:value-of select="@docid"/></xsl:attribute>
														<xsl:attribute name='href'>javascript:openParentDocView(<xsl:value-of select="@docid"/>, <xsl:value-of select="@doctype"/>,<xsl:value-of select="position()"/>,1)</xsl:attribute>
														<img border='0' src="ipadandtab/img/toggle_plus.png">
															<xsl:attribute name='id'>img<xsl:value-of select="@docid"/></xsl:attribute>
														</img>
													</a>
												</xsl:otherwise>
											</xsl:choose>
										</xsl:if>
										<span style="margin-left:10px; display:inline-block; width:98%; overflow:hidden">
											<a target="_parent">
												<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
												<xsl:attribute name="href"><xsl:value-of select="@url"/>&amp;page=<xsl:value-of select="../../query/@currentpage"/></xsl:attribute>
												<xsl:attribute name="title"><xsl:value-of select="@viewtext"/></xsl:attribute>
												<font class="font"  style="font-style:arial;">
													<xsl:attribute name="id">font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
													<xsl:variable name='simbol'>'</xsl:variable>
													<xsl:variable name='ecr1'><xsl:value-of select="replace(@viewtext,$simbol ,'&quot;')"/></xsl:variable>	
													<xsl:variable name='ecr2'><xsl:value-of select="replace($ecr1, '&#34;' ,'&quot;')"/></xsl:variable>	
													<script>
														text='<xsl:value-of select="$ecr2"/>';
														symcount= <xsl:value-of select="string-length(@viewtext)"/>;
														ids="font<xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/>";
														replaceVal="<img/>";
														text=text.replace("-->",replaceVal);
														$("#"+ids).html(text);
														$("font > img").attr("src","/SharedResources/img/classic/arrow_blue.gif");
													</script>
												</font>
											</a>	
										</span>	
								</td>
							</tr>
							<xsl:apply-templates select="responses" />
						</xsl:for-each>
					</table>
		 		</div>		
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>