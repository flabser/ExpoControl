<?xml version="1.0" ?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform"> 
	<xsl:import href="../templates/view.xsl"/>	
	<xsl:variable name="viewtype">Вид</xsl:variable>
	<xsl:output method="html"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="useragent" select="request/@useragent"/>
	<xsl:template match="query/entry">
		<xsl:variable name="num" select="position()"/>
		<tr class="{@docid}" id="{@docid}{@doctype}" onmouseover="javascript:elemBackground(this,'EEEEEE')" onmouseout="elemBackground(this,'FFFFFF')">
			<xsl:attribute name="bgcolor">#FFFFFF</xsl:attribute>
			<xsl:if test="@isread = '0'">
				<xsl:attribute name="style">font-weight:bold</xsl:attribute>
			</xsl:if>
			<script>
				$("."+<xsl:value-of select="@docid"/>).dblclick( function(event){
  					if (event.target.nodeName != "INPUT"){
  						beforeOpenDocument();
  						window.location = '<xsl:value-of select="@url"/>'
  					}
				});
			</script>
			<td style="text-align:center; border:1px solid #ccc" width="3%" >
				<input type="checkbox" name="chbox" id="{@docid}" value="{@doctype}"/>
			</td>
			<td  nowrap="nowrap" colspan="2" style="border:1px solid #ccc">
				<div  style="overflow:hidden; width:99%;">&#xA0;
					<a  href="{@url}" title="{@viewtext}" class="doclink">
						<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
						<xsl:if test="@isread = '0'">
							<xsl:attribute name="style">font-weight:bold</xsl:attribute>
						</xsl:if>
						<xsl:value-of select="viewcontent/viewtext1"/>
					</a>
				</div>
			</td>
			
		</tr>
	</xsl:template>
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>Мои задания</title>		
				<link rel="stylesheet" href="classic/css/outline.css"/>	
				<script language="javascript" src="classic/scripts/outline.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
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
				<input type="hidden" id="langinput" value="{@lang}"/>
				<div id="view" style="background:#ffffff">
						<xsl:call-template name="refreshstat"/>	
						<br/>
						<table width="100%">
							<tr>
								<td>
									<xsl:if test="action[.='NEW_DOCUMENT']/@enable = 'true'">
										<a class="gray button" >
											<xsl:attribute name="href" select="newDocURL"/>
											<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
											<font><xsl:value-of select="action[.='NEW_DOCUMENT']/@caption"/></font>					
										</a>
									</xsl:if>
								</td>						
							</tr>
						</table>
						<xsl:call-template name="viewinfo"/>
						<table class="viewtable" style="width:100%; table-layout:fixed;">
							<tr class="th">
								<td style="text-align:center;"   width="5%" class="thcell">
									<input type="checkbox" id="allchbox" onClick="checkAll(this);"/>&#xA0;&#xA0;					
								</td>
								<td width="5%"></td>
								<td width="92%" class="thcell">
									<xsl:value-of select="columns/column[@id = 'BRIEFCONTENT']/@caption"/>								
								</td>
							</tr>
							<xsl:if test="query/@ruleid != 'report_tasks'">
								<xsl:apply-templates select="query/entry" />
							</xsl:if>
							<xsl:if test="query/@ruleid = 'report_tasks'">
								<tr>
									<td style="text-align:left;"  width="2%" class="thcell">
										<input type="checkbox" id="chbox"/>&#xA0;&#xA0;					
									</td>
									<td width="5%"></td>
									<td width="92%" >
										<a href="Provider?type=document&amp;id=task_report&amp;key=">Задания</a>
									</td>
								</tr>
							</xsl:if>
						</table>
			 		</div>		
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>