<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype">Тип контроля</xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>Тип контроля</title>
				<xsl:call-template name="cssandjs"/>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div id="docwrapper">
					<div class="formwrapper">
					
					<div class="button_panel" style=" margin:5px 0px 5px 5px;" >
						<span style="float:left">
							<xsl:call-template name="showxml"/>
							<a class="gray button form">
								<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm',&quot;<xsl:value-of select="history/entry[@type='outline'][last()]"/>&quot;)</xsl:attribute>
								<font>Сохранить и закрыть</font>
							</a>
						</span>
						<span style="float:right; margin-right:5px">
							<xsl:call-template name="cancel" />
						</span>
					</div>
					<div style="clear:both; border-bottom:1px solid #ccc"/>
					<div  class="formtitle">
					    <div style="font: 1em 'trebuchet MS', 'Lucida Sans', Arial; color:#0857A6; margin-top:0.5em; ">
					    	<xsl:call-template name="doctitleGlossary"/>
					    </div>											
					</div>
		  		 	
					<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
					<div style="clear:both"/>
						<div  id="tabs-1">
							<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
								<div display="block" id="property">
									<br/>
									<table width="100%" border="0" >
										<tr>
											<td class="fc">Тип контроля :</td>
								            <td>
					                        	<input type="text" value="{document/fields/name}" name="name" size="30" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:300px">
					                        		<xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px</xsl:attribute>
													</xsl:if>
					                           </input>
					                    	</td>   					
										</tr>
								       <tr>
											<td class="fc">Код :</td>
											<td>
			                                	<input type="text" name="code" value="{document/fields/code}" size="10" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:300px">
				                                    <xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="readonly">readonly</xsl:attribute>
														<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px</xsl:attribute>
													</xsl:if>
				                                    <xsl:attribute name="onkeydown">javascript:Numeric(this)</xsl:attribute>
			                                	</input>
		                           			</td> 
								       </tr>
									</table>		
					       		</div>   
						    	<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="ControlType"/>		
								<input type="hidden" name="key" value="{document/@docid}"/> 
		          			</form>
		      			</div>
		      	</div>
		      	</div>
			</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>