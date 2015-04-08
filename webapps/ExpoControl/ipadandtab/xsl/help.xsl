<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:template match="/request/content">
		<script language="javascript" src="classic/scripts/form.js"/>
		<link rel="stylesheet" href="classic/css/actionbar.css"/>
		<link rel="stylesheet" href="/SharedResources/css/reset.css"/>
		<html>
			<body style="font-family: Verdana, arial, helvetica, sans-serif">
				<title>Справка </title>
				<div class="help_bar">
					<span>
						<img style="margin: 20px 0 0 5px" src="classic/img/4ms-logo.png"/>
						&#xA0;
						<b>Категория: </b>
						<xsl:value-of select="content/category"/>
						<a style="float:right; margin: 45px 5px 0 0">
							<xsl:attribute name="href">javascript:CancelForm('')</xsl:attribute>
							<img src="/SharedResources/img/iconset/cross.png" style="border:0;"></img>
							<font class="button" style="font-family:verdana; font-size:1.0em; margin-left:5px">Закрыть</font>
						</a>
					</span>
				</div>
				<div style="font-family:verdana;">
					<xsl:for-each select="content/*">
						<xsl:choose>
							<xsl:when test="name() = 'topic'">
								<div
									style="font-family:verdana; font-size:15pt; text-align:left; width:80%; margin-top:15px; margin-left:5px">
									<b>
										<xsl:value-of select="."/>
									</b>
									<br/>
								</div>
							</xsl:when>
							<xsl:when test="name() = 'image'">
								<br/>
								<center>
									<img name="helpimg" src="{.}" style="margin-left:35px; width:65%; border: 1px solid black"/>
								</center>
								<br/>
							</xsl:when>
							<xsl:when test="name() = 'imagetitle'">
								<br/>
								<center>
									<b style="font-size:13px">
										<xsl:value-of select="."/>
									</b>
								</center>
								<br/>
							</xsl:when>
							<xsl:when test="name() = 'chapter'">
								<div style="font-family:verdana; font-size:14px; text-align:left; width:90%; margin-top:10px; margin-left:35px">
									<xsl:value-of select="."/>
								</div>
							</xsl:when>
							<xsl:otherwise></xsl:otherwise>
						</xsl:choose>
					</xsl:for-each>
					<br/>
					<table width="80%" border="0" style="font-family:verdana; font-size:9px;">
						<tr>
							<td colspan="2" class="formtitle">
								<b>Рекомендуется к просмотру:</b>
							</td>
						</tr>
					</table>
					<hr color="#6790b3"/>
					<table>
						<xsl:for-each select="seealso">
							<tr>
								<td width="10%">
									<a href="{.}">
										<xsl:value-of select="."/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
					<!--> Глоссарий< -->
					<table width="80%" border="0" style="margin-top:8px; font-size:10.8pt;">
						<xsl:for-each select="glossary/link2">
							<tr>
								<td width="10%">
									<a href="{substring-after(.,'$')}">
										<xsl:value-of select="substring-before(.,'$')"/>
									</a>
								</td>
							</tr>
						</xsl:for-each>
					</table>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>