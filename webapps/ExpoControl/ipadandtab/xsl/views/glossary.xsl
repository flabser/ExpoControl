<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">glossary</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:template match="/request">
		<div style="font-size:14px; width:100%; ">
			<font style="font-size:14px;">
				страница: 
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
					 из <xsl:value-of select="query/@maxpage"/>
			</font>
		</div>
		<xsl:for-each select="query/entry">
			<div style="display:block; width:100%; text-align:left" name="itemStruct">
				<xsl:attribute name="onmouseover">javascript:entryOver(this)</xsl:attribute>
				<xsl:attribute name="onmouseout">javascript:entryOut(this)</xsl:attribute>
				<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
				<xsl:attribute name="style">cursor:pointer; text-align:left</xsl:attribute>
				<input class='chbox' type='hidden' name='chbox'>
					<xsl:attribute name="id"><xsl:value-of select="@docid"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
				</input>
				<input type="radio" name="chbox">
					<xsl:attribute name="value"><xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/></xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of select="@docid"/></xsl:attribute>
				</input>	
				<font class="font"  style="font-family:verdana; font-size:13px; margin-left:2px">
					<xsl:attribute name="title"><xsl:value-of select="@docid"/></xsl:attribute>
					<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>
				</font>
			</div>
		</xsl:for-each>
	</xsl:template>
</xsl:stylesheet>