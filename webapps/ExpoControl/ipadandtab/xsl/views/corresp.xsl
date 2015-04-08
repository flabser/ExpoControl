<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	
	<xsl:template match="responses">
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="*" mode="line">
		<xsl:if test="name(.) != 'userid'">
			<tr name="child" style="height:35px">
				<td>
					<table  width="100%" style="border-collapse:collapse">
						<xsl:attribute name="class">tbl<xsl:value-of select="@doctype"/></xsl:attribute>
						<tr class="entry_tr">
							<xsl:attribute name="style">cursor:pointer</xsl:attribute>
							<td>
								<xsl:if test="@doctype=894">
									<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="@docid"/>')</xsl:attribute>
								</xsl:if>
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
		<xsl:if test="@doctype = 894">					
			<input type="radio" name="chbox">
				<xsl:attribute name="onchange">javascript:entrySelectForTable(this)</xsl:attribute>
				<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
				<xsl:attribute name="id"><xsl:value-of select="@docid"/></xsl:attribute>
			</input>
		</xsl:if>
		<font class="font"  style="font-family:verdana; font-size:14px; margin-left:6px">
			<xsl:if test="userid =''">
				<xsl:attribute name="color">gray</xsl:attribute>
			</xsl:if>
			<xsl:value-of select="replace(@viewtext,'&amp;quot;','&#34;')"/>	
		</font>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when test="following-sibling::*">
				<img  src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img  src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::*">
				<xsl:if test="not(following-sibling::*[@doctype=891])">
					<img  src="/SharedResources/img/classic/tree_spacer.gif"/>
				</xsl:if>
			</xsl:when>
			<xsl:otherwise>
				<img src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
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
		<xsl:for-each select="query/entry">
			<table width="100%"  style="border-collapse:collapse">
				<xsl:attribute name="class">tblCorr</xsl:attribute>
				<tr height="40px">
					<td>
						<xsl:choose>
							<xsl:when test="responses[node()]">
								<a href="" style="margin-left:15px">
									<xsl:attribute name='id'>a<xsl:value-of select="@docid" /><xsl:value-of select="@doctype" /></xsl:attribute>
									<xsl:attribute name='href'>javascript:collapsChapterCorr('<xsl:value-of select="@viewtext" />','<xsl:value-of select="position()" />','<xsl:value-of select="@url" />', <xsl:value-of select="@doctype" />)</xsl:attribute>
									<img border='0' src="ipadandtab/img/toggle_minus_small.png" style="width:20px">
										<xsl:attribute name='id'>img<xsl:value-of select="@docid" /><xsl:value-of select="@doctype" /></xsl:attribute>
									</img>
								</a>
							</xsl:when>
							<xsl:otherwise>
								<a href="" style="margin-left:15px">
									<xsl:attribute name='id'>a<xsl:value-of select="@doctype" /></xsl:attribute>
									<xsl:attribute name='href'>javascript:expandChapterCorr('<xsl:value-of select="@viewtext" />','<xsl:value-of select="position()" />','<xsl:value-of select="@url" />', <xsl:value-of select="@doctype" />,<xsl:value-of select="../@currentpage" />)</xsl:attribute>
									<img src="ipadandtab/img/toggle_plus_small.png" style="width:20px">
										<xsl:attribute name='id'>img<xsl:value-of select="@doctype" /></xsl:attribute>
									</img>
								</a>
							</xsl:otherwise>
					</xsl:choose>
					<font class="font"  style="font-family:verdana; font-size:15px; margin-left:10px; vertical-align:6px ">
							<xsl:value-of select="@viewtext"/>
					</font>
					&#xA0;
					<font style="font-family:verdana; font-size:13px; color:gray; vertical-align:8px ">
						[<xsl:value-of select="@count"/>]
					</font>
				</td>
			</tr>
			<xsl:apply-templates select="responses" />
		</table>
	</xsl:for-each>
</xsl:template>
</xsl:stylesheet>