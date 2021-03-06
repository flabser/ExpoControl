<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="responses">
		<xsl:apply-templates mode="line"/>
	</xsl:template>
	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) != 'userid'">
			<tr name="child">
				<td>
					<table  width="100%" style="border-collapse:collapse" class="tbl{@doctype}">
						<tr>
							<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
							<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
							<xsl:attribute name="style">cursor:pointer</xsl:attribute>
							<td style="text-align:left">
								<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
								<xsl:call-template name="graft"/>
								<xsl:apply-templates select="." mode="item"/>
							</td>
							<xsl:if test="@hasresponse='true'">
								<xsl:apply-templates mode="line"/>
							</xsl:if>	
						</tr>
					</table>
				</td>
			</tr>
			<xsl:if test="@hasresponse !='true'">
				<xsl:apply-templates mode="line"/>
			</xsl:if>
		</xsl:if>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<input type="radio" name="chbox" value="{viewcontent/viewtext1}" id="{@docid}"/>
		<font class="font" style="font-family:verdana; font-size:11px; margin-left:3px">
			<xsl:if test="userid =''">
				<xsl:attribute name="color">gray</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="replace(viewcontent/viewtext1,'&amp;quot;','&#34;')"/>	
		</font>
	</xsl:template>

	<xsl:template name="graft">
		<img src="/SharedResources/img/classic/tree_spacer.gif"/>
	</xsl:template>
	
	<xsl:template match="*" mode="tree">
		<img src="/SharedResources/img/classic/tree_spacer.gif"/>
	</xsl:template>
	
	<xsl:template match="/request">
		<div style="font-size:14px; width:100%;">
			<font style="font-size:14px;">
				<xsl:value-of select="columns/column[@id='PAGE']"/>:
				<xsl:if test="query/@currentpage != 1">
					<a href="" style="text-decoration:none">
						<xsl:attribute name="href">javascript:selectPage(<xsl:value-of select='query/@currentpage - 1'/>,'<xsl:value-of select="query/@ruleid"/>')</xsl:attribute>
						&lt;
					</a>
				</xsl:if>
				<xsl:value-of select="query/@currentpage"/>
				<xsl:if test="query/@currentpage != query/@maxpage">
					<a style="text-decoration:none">
						<xsl:attribute name="href">javascript:selectPage(<xsl:value-of select='query/@currentpage + 1'/>,'<xsl:value-of select="query/@ruleid"/>')</xsl:attribute>
						>
					</a>
				</xsl:if>
				<xsl:value-of select="concat(columns/column[@id='FROM'],query/@maxpage)"/>
			</font>
		</div>
		<xsl:for-each select="query/entry">
			<table width="100%" style="border-collapse:collapse" class="tblCorr{@docid}">
				<tr>
					<td style="text-align:left">
						<xsl:choose>
							<xsl:when test="responses[node()]">
								<a href="" style="margin-left:3px" id="a{@categoryid}{@doctype}">
									<xsl:attribute name='href'>javascript:collapsChapterCorr('<xsl:value-of select="@categoryid"/>','<xsl:value-of select="position()"/>','<xsl:value-of select="@url"/>', <xsl:value-of select="@doctype"/>,<xsl:value-of select="../@currentpage"/>)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/minus.png" id="img{@categoryid}{@doctype}"/>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="" style="margin-left:3px" id="a{@categoryid}{@doctype}">
									<xsl:attribute name='href'>javascript:expandChapterCorr('<xsl:value-of select="@categoryid"/>','<xsl:value-of select="position()"/>','<xsl:value-of select="@url"/>', <xsl:value-of select="@doctype"/>,<xsl:value-of select="../@currentpage"/>)</xsl:attribute>
									<img border='0' src="/SharedResources/img/classic/1/plus.png" id="img{@categoryid}{@doctype}"/>
								</a>
							</xsl:otherwise>
						</xsl:choose>
						<img style="margin-left:5px" src="/SharedResources/img/classic/icons/building.png"/>
						<font class="font"  style="font-family:verdana; font-size:12px; margin-left:3px; width:100%">
							<xsl:value-of select="@viewtext"/>
						</font>
					</td>
				</tr>
				<xsl:apply-templates select="responses"/>
			</table>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>