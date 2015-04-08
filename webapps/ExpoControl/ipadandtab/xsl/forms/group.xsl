<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype">Группа пользователя</xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:variable name="editmode" select="request/document/@editmode"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>Группа пользователя</title>
				<xsl:call-template name="cssandjs"/>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div id="docwrapper">
					<div class="formwrapper">
						<div class="button_panel" style=" margin:5px 0px 5px 5px;">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<a class="gray button form" style="margin-left:10px;">
									<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm',&quot;<xsl:value-of select="history/entry[@type='outline'][last()]"/>&quot;)</xsl:attribute>
									<font>Сохранить и закрыть</font>
								</button>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
		  				<div style="clear:both"/>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block"  id="property">
										<br/>
										<table width="80%" border="0" >
											<tr>
												<td class="fc">Название :</td>
									            <td>
					                                 <input type="text" name="groupname" value="{document/fields/groupname}" size="59" class="rof" onkeypress="javascript:maxCountSymbols (this, 32, event, true)" style="background:#fff; padding:3px 3px 3px 5px; width:350px">
					                                 	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:350px</xsl:attribute>
														</xsl:if>
					                                 </input>
					                           </td>   					
											</tr>
									      	<tr>
												<td class="fc">Описание :</td>
								            	<td>
					                                 <textarea class="rof" rows="4" name="description" value="{document/fields/description}" cols="45" style="background:#fff; padding:3px 3px 3px 5px; width:600px">
					                                 	<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px</xsl:attribute>
														</xsl:if>
					                                 	<xsl:value-of select="document/fields/description"/>
					                                 </textarea>
					                           </td>   					
											</tr> 
											<tr>
												<td class="fc">Владелец группы :
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','false','ownergroup','frm', 'ownergrouptbl');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</td>
												<td>
													<table id="ownergrouptbl">
														<tr>
															<td style="background:#fff; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="style">background:none; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/ownergroup"/>&#xA0;
															</td>
														</tr>
													</table>
													<input type="hidden" id="ownergroup" name="ownergroup" value="{document/fields/ownergroup/@attrval}"/>
													<input type="hidden" id="ownergroupcaption" value="Владелец группы"/>
												</td>
											</tr> 
											<tr>
											<td class="fc">Участники группы :
												<a href="">
													<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','true','members','frm', 'memberstbl');</xsl:attribute>
													<img src="/SharedResources/img/iconset/report_magnify.png"/>
												</a>
											</td>
											<td>
												<table id="memberstbl">
													<xsl:for-each select="document/fields/members[not(@islist)]">
														<tr>
															<td style="background:#fff; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="style">background:none; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
													<xsl:for-each select="document/fields/members[@islist ='true']/entry">
														<tr>
															<td style="background:#fff; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="style">background:none; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
													<xsl:if test="document/@status = 'new'">
														<tr>
															<td style="background:#fff; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;">
																<xsl:if test="document/@editmode != 'edit'">
																	<xsl:attribute name="style">background:none; border:1px solid #ccc; width:600px; height:16px; padding:3px 3px 3px 5px;</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/members"/>&#xA0;
															</td>
														</tr>
													</xsl:if>
												</table>
												<xsl:if test="not(document/fields/members[node()])">
													<input type="hidden" id="members" name="members" value="{document/fields/members/@attrval}"/>
												</xsl:if>
												<xsl:for-each select="document/fields/members">
													<input type="hidden" id="members" name="members" value="{./@attrval}"/>
												</xsl:for-each>
												<xsl:for-each select="document/fields/members/entry">
													<input type="hidden" id="members" name="members" value="{./@attrval}"/>
												</xsl:for-each>
												<input type="hidden" id="memberscaption" value="Участники группы"/>
											</td>
										</tr> 
										<tr>
											<td class="fc">Роли :</td>
								            <td>
					                           <xsl:for-each select="document/glossaries/role/query/entry">
					                           		<input type="checkbox" name="role" value="{@docid}">
					                           			<xsl:if test="../../../../fields/role/@islist = 'true' and ../../../../fields/role/*/@attrval = @docid">
					                           				<xsl:attribute name="checked">checked</xsl:attribute>
					                           			</xsl:if>
					                           			<xsl:if test="../../../../fields/role[not(@islist)] and ../../../../fields/role/@attrval = @docid">
					                           				<xsl:attribute name="checked">checked</xsl:attribute>
					                           			</xsl:if>
					                           			&#xA0;
					                           			<xsl:value-of select="name"/>
					                           			<br/>
					                           		</input>
					                           </xsl:for-each>
					                        </td>   					
										</tr> 
									</table>		
					       		</div>   
					       		<input type="hidden" name="type" value="save"/>
								<input type="hidden" name="id" value="Group"/>		
								<input type="hidden" name="key" value="{document/@docid}"/> 
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