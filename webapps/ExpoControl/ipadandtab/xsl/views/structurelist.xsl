<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Структура</xsl:variable>
	<xsl:output method="html" />
	<xsl:variable name="skin" select="request/@skin"/>
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
			<td>
			</td>
			<td colspan="4">
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>
	<xsl:template match="viewtext" mode="line">
	</xsl:template>
		<xsl:template match="*" mode="line">
			<xsl:if test="name(.) != 'userid'">	
				<div class="Node" style="height:100%">
					<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
					<xsl:call-template name="graft"/>
					<xsl:apply-templates select="." mode="item"/>
				</div>
				<xsl:apply-templates mode="line"/>
			</xsl:if>
		</xsl:template>

		<xsl:template match="entry" mode="item">
			<input type="checkbox" name="chbox" style="margin:0px; padding:0px; height:13px" >
				<xsl:attribute name="id" select="@docid"/>
				<xsl:attribute name="value" select="@doctype"/>
			</input>
			<a  href="" style="font-style:arial; font-size:12px; margin:0px 2px; color:#0857A6; text-decoration:none">
				<xsl:attribute name="href" select="@url"/>
				<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
				<xsl:attribute name="title" select="userid"/>
				<font class="font"><xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/></font>
			</a>
		</xsl:template>

		<xsl:template name="graft">
			<xsl:apply-templates select="ancestor::entry" mode="tree"/>
			<xsl:choose>
				<xsl:when test="following-sibling::*">
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_tee.gif"/>
				</xsl:when>
				<xsl:otherwise>
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_corner.gif"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
		
		<xsl:template match="responses" mode="tree"/>

		<xsl:template match="*" mode="tree">
			<xsl:choose>
				<xsl:when test="following-sibling::* and *[@url]">
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_bar.gif"/>
				</xsl:when>
				<xsl:otherwise>
					<img style="vertical-align:top;" src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:otherwise>
			</xsl:choose>
		</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>Структура</title>		
			</head>
			<body>
				<div id="viewcontent" style="margin-left:15px; margin-top:40px; border-top:1px solid #ccc">
					<div id="viewcontent-header" style="height:50px">
						<font class="viewtitle">
							<xsl:value-of select="columns/column[@id = 'CATEGORY']/@caption"/> - <xsl:value-of select="columns/column[@id = 'VIEW']/@caption"/>
						</font>
						<br/>
						<br/>
						<div class="button_panel">
							<span style="float:left; margin-left:3px; ">
								<a class="gray button" >
									<xsl:attribute name="href">javascript:window.location.href="Provider?type=structure&amp;id=organization&amp;key="; beforeOpenDocument()</xsl:attribute>
									<img src="/SharedResources/img/iconset/document_empty.png" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"></img>
									<font style="font-size:12px; vertical-align:top"><xsl:value-of select="columns/column[@id = 'BTNNEWDOCUMENT']/@caption"/></font>
								</a>
								<a class="gray button" style="margin-left:5px" >
									<xsl:attribute name="href">javascript:delGlossary("Avanti","1");</xsl:attribute>
									<img src="/SharedResources/img/classic/remove.gif" style="border:none; width:15px; height:15px; margin-right:3px; vertical-align:top"></img>
									<font  style="font-size:12px; vertical-align:top"><xsl:value-of select="columns/column[@id = 'BTNDELETE']/@caption"/></font>
								</a>
							</span>
						</div>
					</div>
					<br/>
					<br/>
					<div id="viewtablediv">
						<div id="tablecontent-structure">
							<xsl:for-each select="query/entry">
								<input type="checkbox" name="chbox">
									<xsl:attribute name="id" select="@docid"/>
									<xsl:attribute name="value" select="@doctype"/>
								</input>
								<font style="font-family:	Verdana,Arial,Helvetica,sans-serif; font-size:1em">
									<a href="" style="color:#0857A6; text-decoration:none; font-size:15px">
										<xsl:attribute name="href" select="@url"/>
										<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
									</a>
								</font>
								<table id="viewtable" style="border-collapse:collapse; border:0; font-size:0.85em">
									<xsl:apply-templates select="responses"/>
								</table>
								<br/>
							</xsl:for-each>
						</div>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>