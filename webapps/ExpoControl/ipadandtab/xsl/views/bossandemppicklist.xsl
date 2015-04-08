<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:variable name="doctype">structure</xsl:variable>
	<xsl:output method="html" encoding="utf-8"/>	
	<xsl:template match="/request/history">
	</xsl:template>
	
	<xsl:template match="/request[@id !='signers'][@id !='workdocsigners']/query/entry/viewtext">
	</xsl:template>
	<xsl:template match="/request[@id !='signers'][@id !='workdocsigners']/query/entry/responses">
		<div style="display:block; text-align:left; " name="itemStruct">
				<xsl:attribute name="style"> width:100%; line-height:40px; text-align:left; border-bottom:1px solid  #cdcdcd</xsl:attribute>
				<center><xsl:value-of select="../viewtext"/></center>
		</div>
		<xsl:for-each select="descendant::entry">
			<xsl:sort select="@viewtext"/>
			<xsl:if test='@doctype = 889'>
				<div style="display:block; text-align:left; " name="itemStruct">
						<xsl:if test="userid !=''">
							<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="style"> width:100%; line-height:50px; text-align:left; border-bottom:1px solid  #cdcdcd</xsl:attribute>
						<input class='chbox' type='hidden' name='chbox'>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
						</input>
						<input type="checkbox" name="chbox" style="margin-left:25px;">
							<xsl:attribute name="onchange">javascript:entrySelect(this)</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>	
						<font class="font"  style="font-family:'trebuchet MS', 'Lucida Sans', Arial; font-size:14px; margin-left:10px; ">
							<xsl:attribute name="title"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="color">gray</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="@viewtext"/>
						</font>
					</div>
				</xsl:if>
			</xsl:for-each>
		</xsl:template>
		
		<xsl:template match="/request[@id='workdocsigners']/query">
			<xsl:if test="../@id = 'workdocsigners'">
			<xsl:for-each select="descendant::entry">
				<xsl:sort select="@viewtext"/>
				<xsl:if test='@doctype = 889'>
					<div style="display:block; width:100%; text-align:left" name="itemStruct">
						<xsl:if test="userid !=''">
							<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="style"> width:100%; line-height:50px; text-align:left; border-bottom:1px solid  #cdcdcd</xsl:attribute>
						<input class='chbox' type='hidden' name='chbox'>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
						</input>
						<input type="checkbox" name="chbox" style="margin-left:25px;">
							<xsl:attribute name="onchange">javascript:entrySelect(this)</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>	
						<font class="font"  style="font-family:'trebuchet MS', 'Lucida Sans', Arial; font-size:14px; margin-left:10px; ">
							<xsl:attribute name="title"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="color">gray</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="@viewtext"/>
						</font>
					</div>
				</xsl:if>
			</xsl:for-each>
			</xsl:if>
		</xsl:template>
		
		<xsl:template match="/request[@id='signers']/query">
			<xsl:if test="../@id = 'signers'">
			<xsl:for-each select="descendant::entry">
				<xsl:sort select="@viewtext"/>
				<xsl:if test='@doctype = 889'>
					<div style="display:block; width:100%; text-align:left" name="itemStruct">
						<xsl:if test="userid !=''">
							<xsl:attribute name="ondblclick">javascript:pickListSingleOk('<xsl:value-of select="userid"/>')</xsl:attribute>
						</xsl:if>
						<xsl:attribute name="style"> width:100%; line-height:50px; text-align:left; border-bottom:1px solid  #cdcdcd</xsl:attribute>
						<input class='chbox' type='hidden' name='chbox'>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
						</input>
						<input type="checkbox" name="chbox" style="margin-left:25px;">
							<xsl:attribute name="onchange">javascript:entrySelect(this)</xsl:attribute>
							<xsl:attribute name="value"><xsl:value-of select="@viewtext"/></xsl:attribute>
							<xsl:attribute name="id"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="disabled">disabled</xsl:attribute>
							</xsl:if>
						</input>	
						<font class="font"  style="font-family:verdana; font-size:13px; margin-left:2px">
							<xsl:attribute name="title"><xsl:value-of select="userid"/></xsl:attribute>
							<xsl:if test="userid =''">
								<xsl:attribute name="color">gray</xsl:attribute>
							</xsl:if>
							<xsl:value-of select="@viewtext"/>
						</font>
					</div>
				</xsl:if>
			</xsl:for-each>
			</xsl:if>
		</xsl:template>
		
	</xsl:stylesheet>