<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="templates/view.xsl"/>	
	<xsl:output method="html" encoding="utf-8" />
	<xsl:template match="/request">
			<html>
			<head>
				<title>Поиск</title>		
				<link rel="stylesheet" href="classic/css/outline.css" />	
				<script language="javascript" src="classic/scripts/outline.js" ></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.8.2.custom.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery.min.js" ></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery.ui.min.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"></script>
			</head>			
				<body>
					<div id="view">
						<xsl:call-template name="search"/>
						<div style="width:80%">
							<table>
								<tr>
									<td>
										<font class="viewtitle">Поиск</font>
									</td>
								</tr>
								<tr>
									<td>
										<font class="viewtitle"><span class="time">Найдено документов:&#xA0;<xsl:value-of select="count(searchresult/entry)"/>&#xA0;</span></font>
									</td>
								</tr>
								<tr>
									<td>
										<br/>
									</td>
								</tr>
								<tr>
									<td>
										<a href="javascript:window.history.back()">Вернуться к списку документов</a>
									</td>
								</tr>
							</table>
						</div>
						<br/>
						<xsl:if test="query/@maxpage !=1">
							<table>
								<xsl:variable name="curpage" select="query/@currentpage"/>
								<xsl:variable name="prevpage" select="$curpage -1 "/>
								<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
               					<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
								<tr>
									<xsl:if test="query/@currentpage>1">
										<td>
											<a href="">
												<xsl:attribute name="href">javascript:doSearch('view','<xsl:value-of select="@id"/>',1)</xsl:attribute>
												<font style="font-size:12px">&lt;&lt;</font>
											</a>&#xA0;
										</td>
										<td>
											<a href="">
												<xsl:attribute name="href">javascript:doSearch('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$prevpage"/>)</xsl:attribute>
												<font style="font-size:12px">&lt;</font>
											</a>&#xA0;
										</td>
									</xsl:if>
									<xsl:call-template name="pagenavigSearch">
										
									</xsl:call-template>
									<xsl:if test="query/@maxpage > 15">
										<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
                						<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
										<td>
											<select>
												<xsl:attribute name="onChange">javascript:doSearch('view','<xsl:value-of select="@id"/>',this.value)</xsl:attribute>
			 									<xsl:call-template name="combobox"/>
			 								</select>
			 							</td>
									</xsl:if>
								</tr>
							</table>
						</xsl:if>
						<table class="viewtable" style="margin-top:2%; width:100%">
							<tr class="th">
								<td style="text-align:left;"   width="4%" class="thcell">
									<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>&#xA0;&#xA0;					
								</td>
								<td width="2%">
								</td>
								<td width="6%" class="thcell"> №										
								</td>
								<td width="85%" class="thcell">Краткое содержание							
								</td>
							</tr>
							<xsl:for-each select="query/entry">
								<tr>
									<xsl:if test="@notread = 1">
										<xsl:attribute name="style">font-weight:bold</xsl:attribute>
									</xsl:if>
									<td style="text-align:left;" class="thcell">
										<input type="checkbox" name="chbox">	
											<xsl:attribute name="id">
												<xsl:value-of select="@docid"/>
											</xsl:attribute>
										</input>&#xA0;&#xA0;
									</td>
									<td></td>
									<td style="text-align:left">
										<xsl:value-of select="position()"/>
									</td>
									<td>
										<a href="" target="_parent">
											<xsl:attribute name="href">
												<xsl:value-of select="@url"/>
											</xsl:attribute>
											<xsl:value-of select="@viewtext"/>
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