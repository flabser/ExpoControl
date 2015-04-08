<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	
	<xsl:template match="/request">
		<div style="font-size:14px; width:100%; ">
			<center>
			<table style="font-size:22px; margin-top:10px; ">
				<tr>
					<td>
						страница: 
					</td>
					<td>
						<xsl:if test="query/@currentpage != 1">
							<xsl:attribute name="style">width:40px; border:1px solid #ccc;  height:40px; text-align:center</xsl:attribute>
							<a href="" style="text-decoration:none; color:#ccc; ">
								<xsl:attribute name="href">javascript:selectPage(<xsl:value-of select='query/@currentpage - 1'/>,'<xsl:value-of select="query/@ruleid"/>')</xsl:attribute>
								&lt;
							</a>
						</xsl:if>
					</td>
					<td style="width:40px; text-align:center">
						<xsl:value-of select="query/@currentpage"/>
					</td>
					<td>
						<xsl:if test="query/@currentpage != query/@maxpage">
							<xsl:attribute name="style">width:40px; border:1px solid #ccc;  height:40px; text-align:center</xsl:attribute>
							<a style="text-decoration:none; color:#ccc;">
								<xsl:attribute name="href">javascript:selectPage(<xsl:value-of select='query/@currentpage + 1'/>,'<xsl:value-of select="query/@ruleid"/>')</xsl:attribute>
								>
							</a>
						</xsl:if>
					</td>
					<td style="width:70px; text-align:center">
						 из <xsl:value-of select="query/@maxpage"/>
					</td>
				</tr>
			</table>
			</center>
		</div>
		<br/>
		<xsl:for-each select="query/entry">
			<div style="display:block; width:99%; text-align:left; line-height:50px; margin-left:10px; border-bottom:1px solid  #cdcdcd" name="itemStruct">
				<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
				<input class='chbox' type='hidden' name='chbox'>
					<xsl:attribute name="id"><xsl:value-of select="@docid"/></xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
				</input>
				<input type="checkbox" name="chbox">
					<xsl:attribute name="onchange">javascript:entrySelect(this)</xsl:attribute>
					<xsl:attribute name="value"><xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/></xsl:attribute>
					<xsl:attribute name="id"><xsl:value-of select="@docid"/></xsl:attribute>
				</input>	
				<font class="font"  style="font-family:verdana;  font-size:15px; margin-left:10px">
					<xsl:attribute name="title"><xsl:value-of select="@docid"/></xsl:attribute>
					<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>
				</font>
			</div>
			
		</xsl:for-each>
	</xsl:template>

	

	
</xsl:stylesheet>