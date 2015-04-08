<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:variable name="doctype">Сотрудник</xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>Сотрудник</title>
				<xsl:call-template name="cssandjs"/>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div id="docwrapper">
					<div class="formwrapper">
						
						<!-- заголовок -->
						<div class="button_panel" style=" margin:5px 0px 5px 5px;">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<a class="gray button form" style="margin-left:10px;">
									<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm',&quot;<xsl:value-of select="history/entry[@type='outline'][last()]"/>&quot;)</xsl:attribute>
									<font>Сохранить и закрыть</font>
								</a>
								<xsl:if test="document/@status !='new'">
									<a class="gray button form" style="margin-left:10px">
										<xsl:attribute name="href">javascript:window.location.href="Provider?type=structure&amp;id=department&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
										<font>Новый департамент</font>
									</a>
									<a class="gray button form" style="margin-left:10px">
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
							<div style="font: 1em 'trebuchet MS', 'Lucida Sans', Arial; color:#0857A6; margin-top:0.5em;">
								<xsl:call-template name="doctitleBoss"/>
							</div>
						</div>
						<div style="-moz-border-radius:0px;height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block" id="property">
										<br/>
										<table width="100%" border="0">
											<tr>
												<td class="fc">Полное имя :</td>
												<td>
													<input type="text" name="fullname" value="{document/fields/fullname}" size="45" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:600px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:600px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Сокращенное имя :</td>
												<td>
													<input type="text" name="shortname" value="{document/fields/shortname}" style="background:#fff; padding:3px 3px 3px 5px; width:400px" class="rof">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">UserID :</td>
												<td>
													<input type="text" name="userid" value="{document/fields/userid}" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:400px">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Пароль :</td>
												<td>
													<input type="password" value="" name="password" style="background:#fff; padding:3px 3px 3px 5px; width:300px" class="rof">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Повтор пароля :</td>
												<td>
													<input type="password" value="" name="password" style="background:#fff; padding:3px 3px 3px 5px; width:300px" class="rof">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Redirect URL : 1</td>
												<td>
													<input type="text" name="app" size="20" value="{document/fields/redirect/entry[1]}" style="background:#fff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
													&#xA0;
													<input type="text" name="redirecturl" value="{document/fields/redirect/entry[1]/@url}" size="60" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">2</td>
												<td>
													<input type="text" name="app" value="{document/fields/redirect/entry[2]}" size="20" style="background:#fff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
													&#xA0;
													<input type="text" name="redirecturl" value="{document/fields/redirect/entry[2]/@url}" size="60" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">3</td>
												<td>
													<input type="text" name="app" size="20" value="{document/fields/redirect/entry[3]}" style="background:#fff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<xsl:if test="document/@editmode = 'edit'">
															<xsl:attribute name="style">background:#ffffff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
													&#xA0;
													<input type="text" name="redirecturl" value="{document/fields/redirect/entry[3]/@url}" size="60" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">4</td>
												<td>
													<input type="text" name="app" value="{document/fields/redirect/entry[4]}" size="20" style="background:#fff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<xsl:if test="document/@editmode = 'edit'">
															<xsl:attribute name="style">background:#ffffff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
													&#xA0;
													<input type="text" name="redirecturl" value="{document/fields/redirect/entry[4]/@url}" size="60" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">5</td>
												<td>
													<input type="text" name="app" value="{document/fields/redirect/entry[5]}" size="20" style="background:#fff; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:200px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
													&#xA0;
													<input type="text" name="redirecturl" value="{document/fields/redirect/entry[5]/@url}" size="60" style="background:#fff; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:400px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>

												</td>
											</tr>
											<xsl:if test="document/@status !='new'">
												<tr>
													<td class="fc">Организация :
													</td>
													<td>
														<table id="orgtable">
															<tr>
																<td style="background:#fff; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc">
																	<xsl:if test="document/@editmode != 'edit'">
																		<xsl:attribute name="readonly">readonly</xsl:attribute>
																		<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc</xsl:attribute>
																	</xsl:if>
																	<xsl:value-of select="document/fields/organization"/>
																	&#xA0;
																</td>
															</tr>
														</table>
														<input type="hidden" name="organization" value="{document/fields/organization/@attrval}" size="30" class="rof"/>
													</td>
												</tr>
											</xsl:if>
											<tr>
												<td class="fc"> Департамент :
													<a href="">
														<xsl:attribute name="href">javascript:dialogBoxStructure('deptpicklist','false','depid','frm', 'depttable');</xsl:attribute>
														<img src="/SharedResources/img/iconset/report_magnify.png"/>
													</a>
												</td>

												<td>
													<table id="depttable">
														<tr>
															<td style="background:#fff; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc">
																<xsl:if test="document/@editmode != 'edit'">
																	<xsl:attribute name="readonly">readonly</xsl:attribute>
																	<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:300px; border:1px solid #ccc</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="document/fields/depid"/>&#xA0;
															</td>
														</tr>
													</table>
													<input type="hidden" name="depid" size="30" class="rof" value="{document/fields/depid/@attrval}"/>
													<input type="hidden" id="depidcaption" size="30" class="rof" value="Департамент"/>
												</td>
											</tr>
											<tr>
												<td class="fc">Должность :</td>
												<td>
													<select name="post" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:312px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:312px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<xsl:variable name="post" select="document/fields/post/@attrval"/>
														<option value="">
															<xsl:attribute name="value"></xsl:attribute>
															<xsl:attribute name="selected">selected</xsl:attribute>
														</option>
														<xsl:for-each select="document/glossaries/post/query/entry">
															<option value="{@docid}">
																<xsl:if test="$post=@docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
												</td>
											</tr>
											<tr>
												<td class="fc">Телефон :</td>
												<td>
													<input type="text" name="phone" value="{document/fields/phone}" size="20" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Ранг :</td>
												<td>
													<input type="text" name="rank" value="{document/fields/rank}" size="20" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<xsl:attribute name="onkeydown">javascript:Numeric(this)</xsl:attribute>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Индекс :</td>
												<td>
													<input type="text" name="index" value="{document/fields/index}" size="20" class="rof" style="background:#fff; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td class="fc">Рассылка уведомлений :</td>
												<td>
													<select name="sendto" style="background:#fff; padding:3px 3px 3px 5px; width:311px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="disabled">disabled</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:311px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<option value="1">
															<xsl:if test="document/fields/sendto =1">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															Пользователю и замещающему
														</option>
														<option value="2">
															<xsl:if test="document/fields/sendto =2">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															Только пользователю
														</option>
														<option value="3">
															<xsl:if test="document/fields/sendto =3">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															Только замещающему
														</option>
														<option value="4">
															<xsl:if test="document/fields/sendto =4">
																<xsl:attribute name="selected">selected</xsl:attribute>
															</xsl:if>
															Отключить
														</option>
													</select>
												</td>
											</tr>
											<tr>
												<td class="fc">Комментарий :</td>
												<td>
													<textarea class="rof" rows="4" value="{document/fields/comment}" name="comment" cols="45" style="background:#fff; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc">
														<xsl:if test="document/@editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="style">background:none; padding:3px 3px 3px 5px; width:301px; border:1px solid #ccc</xsl:attribute>
														</xsl:if>
														<xsl:value-of select="document/fields/comment"/>
													</textarea>
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
															</xsl:if>&#xA0;
															<xsl:value-of select="name"/>
															<br/>
														</input>
													</xsl:for-each>
												</td>
											</tr>
										</table>
									</div>
									<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="id" value="employer"/>
									<input type="hidden" name="key" value="{document/@docid}"/>
									<input type="hidden" name="doctype" value="{document/@doctype}"/>
									<input type="hidden" name="parentdoctype" id="parentdoctype" value="{document/@parentdoctype}"/>
									<input type="hidden" name="parentdocid" id="parentdocid" value="{document/@parentdocid}"/>
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