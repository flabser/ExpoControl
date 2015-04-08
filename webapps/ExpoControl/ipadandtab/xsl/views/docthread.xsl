<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" />
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="request/history">
	</xsl:template>
	<xsl:template match="responses">
		<tr>
			<xsl:attribute name="name">child</xsl:attribute>
			<xsl:attribute name="class">response<xsl:value-of select="entry/@docid"/></xsl:attribute>
			<xsl:attribute name="id"><xsl:value-of select="entry/@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
			<style type="text/css">
				div.Node * { 
					vertical-align: middle;
				}
			 	A{
					text-decoration:none;
				}
			 	A:hover{
					text-decoration:underline;
				}
			</style>
			<td></td>
			<td></td>
			<td colspan="4" nowrap="true" id="parentdoccell">
				<script>
					parentTrCountCell=$("#parentdoccell").parent("tr").prev("tr").children("td").length;
					$("#parentdoccell").attr("colspan",parentTrCountCell - 2);
				</script>
				<xsl:apply-templates mode="line"/>
			</td>
		</tr>
	</xsl:template>

	<xsl:template match="viewtext" mode="line">
	</xsl:template>
	<xsl:template match="entry" mode="line">
		<div class="Node" style="overflow:hidden; width:99%">
			<xsl:attribute name="id"><xsl:value-of select="@docid"/><xsl:value-of select="@doctype"/></xsl:attribute>
			<xsl:call-template name="graft"/>
			<xsl:apply-templates select="." mode="item"/>
		</div>
		<xsl:apply-templates mode="line"/>
	</xsl:template>

	<xsl:template match="entry" mode="item">
		<a href="">
			<xsl:if test="$useragent = 'FIREFOX'">
				<xsl:attribute name="style">font-size:11px; vertical-align:2px</xsl:attribute>
			</xsl:if>
			<xsl:attribute name="href"><xsl:value-of select="@url"/></xsl:attribute>
			<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
			<xsl:attribute name="title"><xsl:value-of select="@viewtext"/></xsl:attribute>
			<xsl:if test="@isread = 0">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<xsl:for-each select="viewicon">
				<xsl:choose>
					<xsl:when test=".= 'ATTACH'">
						&#xA0;	<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0">
									<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/> </xsl:attribute>
								</img> 
					</xsl:when>
					<xsl:when test=".= 'RESET'">
						&#xA0;<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0"/>
					</xsl:when>
				</xsl:choose>
			</xsl:for-each>
			<xsl:if test="@allcontrol = 0">
				<img id="control" title="Документ снят с контроля" src="/SharedResources/img/iconset/tick_small.png" border="0" style="margin-left:3px"/>&#xA0;
			</xsl:if>
			<xsl:if test="@hasattach != 0">
				<img id="atach" src="/SharedResources/img/classic/icon_attachment.gif" border="0">
					<xsl:attribute name="title">Вложений в документе: <xsl:value-of select="@hasattach"/> </xsl:attribute>
				</img> 
			</xsl:if>
			<font class="font"  style="font-style:arial; vertical-align:top; padding-left:5px">
				<xsl:value-of select="viewtext"/> 
			</font>
		</a>
	</xsl:template>

	<xsl:template name="graft">
		<xsl:apply-templates select="ancestor::entry" mode="tree"/>
		<xsl:choose>
			<xsl:when  test="following-sibling::entry">
				<img  src="/SharedResources/img/classic/tree_tee.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img  src="/SharedResources/img/classic/tree_corner.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
	
	<xsl:template match="*" mode="tree">
		<xsl:choose>
			<xsl:when test="following-sibling::entry and entry[@url]">
				<img  src="/SharedResources/img/classic/tree_bar.gif"/>
			</xsl:when>
			<xsl:otherwise>
				<img src="/SharedResources/img/classic/tree_spacer.gif"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:template>
</xsl:stylesheet>