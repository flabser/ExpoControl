<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype">Департамент</xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>Департамент</title>
				<xsl:call-template name="cssandjs"/>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div id="docwrapper">
					<div class="formwrapper">
						
						<div class="button_panel" style="margin:5px 0px 5px 5px;">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<a class="gray button" style="margin-left:10px">
									<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm',&quot;<xsl:value-of select="history/entry[@type='outline'][last()]"/>&quot;)</xsl:attribute>
									<font>Сохранить и закрыть</font>
								</a>
								<xsl:if test="document/@status !='new'">
									<a class="gray button" style="margin-left:10px">
										<xsl:attribute name="href">javascript:window.location.href="Provider?type=structure&amp;id=department&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
										<font>Новый департамент</font>
									</a>
									<a class="gray button" style="margin-left:10px">
										<xsl:attribute name="href">javascript:window.location.href="Provider?type=structure&amp;id=employer&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
										<font>Новый сотрудник</font>
									</a>
								</xsl:if>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both; border-bottom:1px solid #ccc"/>
						<div class="formtitle">
							<div style="font: 1em 'trebuchet MS', 'Lucida Sans', Arial; color:#0857A6; margin-top:0.5em; ">
					           <xsl:call-template name="doctitleBoss"/>											
							</div>
						</div>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block"  id="property">
										<br/>
										<table width="100%" border="0">
											<tr>
												<td class="fc">Название :</td>
									            <td>
						                            <input type="text" name="fullname" value="{document/fields/fullname}" size="65" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:600px; border:1px solid #ccc">
						                              	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
						                            </input>
						                       </td>   					
											</tr>
											<tr>
												<td class="fc">Сокращенное название :</td>
									            <td>
						                        	<input type="text" name="shortname" value="{document/fields/shortname}" size="65" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
						                            	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
						                           </input>
						                       </td>   					
											</tr>
											<xsl:if test="document/@status !='new'">
												<tr>
													<td  class="fc">Организация :
														<!--<a href="">
															<xsl:attribute name="href">javascript:dialogBoxStructureFull('organization','false','organization','frm', 'orgtable');</xsl:attribute>								
															<img src="/SharedResources/img/classic/picklist-add.gif"></img>				
														</a>
													-->
													</td>
									            	<td>
						                        		<table id="orgtable">
						                        			<tr>
						                                		<td style="background:#ffffff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
						                                			<xsl:if test="document/@editmode != 'edit'">
																		<xsl:attribute name="readonly">readonly</xsl:attribute>
																		<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
																	</xsl:if>
						                                 			<xsl:value-of select="document/fields/organization"/>&#xA0;</td>
						                                 		</tr>
						                                 </table>
						                                 <input type="hidden" name="organization" size="30" class="rof" value="{document/fields/organization/@attrval}"/>
						                           </td>   					
												</tr>
											</xsl:if>
											<tr>
												<td class="fc">Тип подразделения :
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('subdivision','false','subdivision','frm', 'subdivisiontable');</xsl:attribute>								
														<img src="/SharedResources/img/iconset/report_magnify.png"/>			
													</a>
												</td>
													
									            <td>
						                        	<table id="subdivisiontable">
						                        		<tr>
						                                	<td style="background:#fff; padding:3px 3px 3px 5px; width:600px; border:1px solid #ccc">
						                                		<xsl:if test="document/@editmode != 'edit'">
																	<xsl:attribute name="readonly">readonly</xsl:attribute>
																	<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px; border:1px solid #ccc</xsl:attribute>
																</xsl:if>
						                                 		<xsl:value-of select="document/fields/subdivision"/>&#xA0;</td>
						                                 	</tr>
						                                 </table>
						                                 <input type="hidden" name="subdivision" size="30" class="rof" value="{document/fields/subdivision/@attrval}"/>
						                                 <input type="hidden" id="subdivisioncaption" size="30" class="rof">
						                                    <xsl:attribute name="value">Тип подразделения</xsl:attribute>
						                                 </input>
						                           </td>   					
											</tr>
											<tr>
												<td class="fc">Комментарий :</td>
									            <td>
						                                 <textarea class="rof" rows="4" name="comment" value="{document/fields/comment}" cols="45" style="background:#fff; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc">
						                                 	<xsl:if test="document/@editmode != 'edit'">
																<xsl:attribute name="readonly">readonly</xsl:attribute>
																<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc</xsl:attribute>
															</xsl:if>
						                                 	<xsl:value-of select="document/fields/comment"/>
						                                 </textarea>
						                           </td>   					
											</tr>   
											<tr>
												<td class="fc"> Уровень в должностной иерархии :</td>
									            <td>
						                            <input type="text" name="rank" value="{document/fields/rank}" size="20" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc">
						                              	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
						                               	<xsl:attribute name="onkeydown">javascript:Numeric(this)</xsl:attribute>
						                            </input>
						                        </td>   					
											</tr>
											<tr>
												<td  class="fc">Индекс :</td>
									            <td>
						                          	<input type="text" name="index" value="{document/fields/index}" size="20" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc">
						                              	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
						                            </input>
						                       </td>   					
											</tr>   
											<tr>
												<td  class="fc">Группы :</td>
									            <td>
						                           <xsl:for-each select="document/glossaries/group/query/entry">
						                           		<input type="checkbox" name="group" value="{@docid}">
						                           			<xsl:if test="../../../../fields/group/@islist = 'true' and ../../../../fields/group/*/@attrval = @docid">
						                           				<xsl:attribute name="checked">checked</xsl:attribute>
						                           			</xsl:if>
						                           			<xsl:if test="../../../../fields/group[not(@islist)] and ../../../../fields/group/@attrval = @docid">
						                           				<xsl:attribute name="checked">checked</xsl:attribute>
						                           			</xsl:if>
						                           			<xsl:value-of select="name"/>
						                           		</input>
						                           		<br/>
						                           </xsl:for-each>
						                        </td>   					
											</tr>
										</table>		
						      		</div>   
								    <input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="department"/>		
									<input type="hidden" name="key" value="{document/@docid}"/> 
									<input type="hidden" name="doctype" value="{document/@doctype}"/> 
									<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/> 
									<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/> 
			          			</form>
							</div>
						</div>
						<div style="height:10px"/>
					</div>
				</div>
			</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>