<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:import href="../templates/docthread.xsl" />
	<xsl:variable name="doctype">
		<xsl:choose>
			<xsl:when test="request/document/fields/tasktype = 'RESOLUTION'">
				<xsl:value-of select="request/document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="not (request/document/fields/tasktype)  and  request/document/@parentdocid != '' and request/document/@parentdoctype != 897 and  request/document/@parentdocid != 0">
				<xsl:value-of select="request/document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="request/document/fields/tasktype ='CONSIGN'">
				<xsl:value-of select="request/document/captions/kp/@caption"/>
			</xsl:when>
			<xsl:when test="request/document/@parentdocid = 0">
				<xsl:value-of select="request/document/captions/task/@caption"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="request/document/captions/kp/@caption"/>
			</xsl:otherwise>
		</xsl:choose>
	</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:output method="html" encoding="windows-1251"/>
	<xsl:template match="/request">
		<html>
			<head>
				<xsl:if test="document/@status != 'new'">
					<title>
						<xsl:value-of select="document/@viewtext"/> - 4ms workflow 
					</title>
				</xsl:if>
				<xsl:if test="document/@status = 'new'">
					<title>
						<xsl:choose>
							<xsl:when test="lower-case($doctype) = 'резолюция'">
								Новая
							</xsl:when>
							<xsl:otherwise>
								Новое
							</xsl:otherwise>
						</xsl:choose>
						 &#xA0;<xsl:value-of select="lower-case($doctype)" />  - 4ms workflow
					</title>
				</xsl:if>
				<xsl:call-template name="cssandjs"/>
				<xsl:call-template name="showdocthread"/>
				<xsl:if test="document/@editmode= 'edit'">
					<script>
						$(function() {
							$('#ctrldate').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								regional:['ru'],
								showAnim: ''
							});
						});
					</script>
				</xsl:if>
				<xsl:call-template name="markisread"/>
			</head>
			<body>
				<xsl:if test="@status!='new'">
					<xsl:attribute name="onLoad">javascript:onLoadActions()</xsl:attribute>
				</xsl:if>
				<!-- панель акции -->
				<div class="bar">
					<span style="width:83%; vertical-align:12px">
						<xsl:if test="document/fields/allcontrol !=0">
							<xsl:if test="document/@editmode!='noaccess'">
								<xsl:call-template name="saveKR"/>
							</xsl:if>
						</xsl:if>
						<xsl:if test="document/@status!='new'">
							<xsl:if test="document/fields/allcontrol !=0">
								<xsl:choose>
									<xsl:when test="document/fields/tasktype ='RESOLUTION'">
										<xsl:call-template name="newkp" />
									</xsl:when>
									<xsl:when test="document/fields/tasktype ='CONSIGN'">
										<xsl:call-template name="newkp" />
									</xsl:when>
									<xsl:when test="document/fields/tasktype = 'TASK'">
										<xsl:call-template name="newkp" />
									</xsl:when>
									<xsl:otherwise>
										<xsl:call-template name="newkr" />
									</xsl:otherwise>
								</xsl:choose>
								<xsl:call-template name="newki" />
							</xsl:if>
						</xsl:if>
						
						<!--	кнопка "напомнить"	-->		
						<xsl:call-template name="remind"/>
						
						<!--	кнопка "ознакомить"	-->		
						<xsl:call-template name="acquaint"/>
						
					</span>
					<span style="float:right">
					<xsl:call-template name="cancel" />
					</span>
					
				</div>

				<!-- заголовок -->
				<div class="formtitle" style="display:inline">
					<table class="formtitle" width="100%">
						<tr>
							<td width="83%"  class="resolTitle">
								<xsl:call-template name="isresol" />
							</td>
							<td>
								<xsl:if test="document/@status!= 'new'">
									<font class="controlStatus" > <xsl:value-of select="document/fields/allcontrol/@caption"/> </font>
										<font class="controlStatus">
											<xsl:choose>
												<xsl:when test="document/fields/allcontrol=1">
													<xsl:attribute name="style">color:red</xsl:attribute>
													<xsl:value-of select="document/captions/incontrol/@caption"/>
												</xsl:when>
												<xsl:when test="document/fields/allcontrol=0">
													<xsl:value-of select="document/captions/removedofcontrol/@caption"/>
												</xsl:when>
											</xsl:choose>
										</font>
								</xsl:if>
								
							</td>
						</tr>
						<tr>
							<td>
							</td>
							<td style="text-align:right">
								<xsl:if test="document/fields/isold = 1">
									<font  style="font-size:15px; color:red">
											Устаревший 
									</font>
								</xsl:if>
							</td>
						</tr>
					</table>
					<xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>
					<xsl:if test="document/@status!= 'new'">
						
						<xsl:if test="document/fields/grandpardocid !=''">
							<table>
								<tr>
									<td width="25%">
										<a href="" >
											<xsl:attribute name="href">Provider?type=document&amp;id=<xsl:value-of select="document/fields/grandparform"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/></xsl:attribute>
											<font class="text" style="font-size:15px"><xsl:value-of select="document/fields/pdocviewtext/@caption"/></font>
										</a>
									</td>
									<td >
										<xsl:if test="$filename!=''">
											<a href="">
												<xsl:attribute name="href">Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
												<img src="/SharedResources/img/classic/icon_attachment.gif"/>
											</a>
										</xsl:if>
									</td>	
									<td>
									</td>	
								</tr>
							</table>
						</xsl:if>
					</xsl:if>				
				</div>
				<!-- Форма -->
				<br/>
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
					<div display="block"  id="property">
						<br/>
						<!-- Автор резолюции -->
						<table width="100%" border="0">
							<xsl:if test="document/@parentdocid = 0 and document/@status != 'new'">
								<tr>
									<td class="fc">
										<font style="vertical-align:top">
											<xsl:value-of select="document/fields/taskvn/@caption"/> :
										</font>
									</td>
									<td>
										<table>
											<tr>
												<td style="background:#ffffff; border:1px solid #ccc; width:170px; height:16px; padding:3px 3px 3px 5px;">
													<xsl:if test="document/@editmode != 'edit'">
														<xsl:attribute name="style">background:none; border:1px solid #ccc; width:170px; height:16px; padding:3px 3px 3px 5px; </xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/fields/taskvn"/>
												</td>
											</tr>
										</table>
										<input type="hidden" name="taskvn" value="{document/fields/taskvn}"/>
									</td>
								</tr>
							</xsl:if>
							<!-- Дата резолюции -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/taskdate/@caption"/> :
								</td>
								<td>
									<table>
										<tr>
											<td style="background:#ffffff; border:1px solid #ccc; width:170px; height:16px; padding:3px 3px 3px 5px;">
												<xsl:if test="document/@editmode != 'edit'">
													<xsl:attribute name="style">background:none; border:1px solid #ccc; width:170px; height:16px; padding:3px 3px 3px 5px;</xsl:attribute>
												</xsl:if>
												<xsl:value-of select="document/fields/taskdate"/>
											</td>
										</tr>
									</table>
									<input type="hidden" name="taskdate" value="{document/fields/taskdate}"/>
								</td>
							</tr>
							<tr>
								<td class="fc">
									<font style="vertical-align:top">
										<xsl:value-of select="document/fields/taskauthor/@caption"/> : </font>
									<xsl:if test="document/@editmode='edit'">
										<xsl:if test="document/fields/allcontrol !=0">
										<a>
											<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','false','taskauthor','frm', 'taskauthortbl');</xsl:attribute>
											<img src="/SharedResources/img/iconset/report_magnify.png"></img>	
										</a>
										</xsl:if>
									</xsl:if>
								</td>
								<td>
									<table id="taskauthortbl">
										<tr>
											<td style="background:#ffffff; border:1px solid #ccc; width:500px; height:16px; padding:3px 3px 3px 5px;">
												<xsl:value-of select="document/fields/taskauthor"/>&#xA0;</td>
											</tr>
									</table>
									<input type="hidden" id="taskauthor" name="taskauthor" >
									<xsl:attribute name="value"><xsl:value-of select="document/fields/taskauthor/@attrval"/></xsl:attribute>
									</input>
								</td>
							</tr>
							<tr>
								<td class="fc">
									<font style="vertical-align:top">
										<xsl:value-of select="document/fields/executors/@caption"/> 
										<font style='color:#ff8141'>*</font>&#xA0;:
									</font>
									<xsl:if test="document/@status = 'new'">
										<xsl:if test="document/fields/allcontrol !=0">
										<a href="">
											<xsl:attribute name="href">javascript:dialogBoxStructure('bossandemppicklist','true','executor','frm', 'intexectbl');</xsl:attribute>								
											<img src="/SharedResources/img/iconset/report_magnify.png"></img>			
										</a>
										</xsl:if>
									</xsl:if>
								</td>
								<td>
									<table id="intexectbl">
										<xsl:if test="document/fields/executors/entry/user =''">
											<tr><td style="background:#ffffff; border:1px solid #ccc; width:500px; height:16px; padding:3px 3px 3px 5px;"><xsl:value-of select="executor"/>&#xA0;</td></tr>
										</xsl:if>
										<xsl:if test="not(document/fields/executors/entry/user)">
											<tr><td style="background:#ffffff; border:1px solid #ccc; width:500px; height:16px; padding:3px 3px 3px 5px;"><xsl:value-of select="executor"/>&#xA0;</td></tr>
										</xsl:if>
										<xsl:for-each select="document/fields/executors/entry">
											<tr><xsl:variable name="num" select="position()"/><td style="background:#ffffff; border:1px solid #ccc; width:500px; height:16px; padding:3px 3px 3px 5px;" ><xsl:value-of select="user"/>&#xA0;</td><td><xsl:if test="$num =1 and ../../../../document/@parentdocid = 0"><img src='/SharedResources/img/iconset/bullet_yellow.png' style='height:16px' title='ответственный'/></xsl:if></td></tr>
										</xsl:for-each>
									</table>
										<xsl:for-each select="document/fields/executors/entry">
													<input type="hidden" name="executor" id="controlres{position()}" value="{user/@attrval}`{responsible}`{execpercent}`{resetdate}`{resetauthor/@attrval}"/>
										</xsl:for-each>
								</td>
							</tr>
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/content/@caption"/> <font style='color:#ff8141'>*</font>&#xA0;:</td>
								<td style="padding-top:5">
									<div>
										<textarea id="txtDefaultHtmlArea" name="content" rows="25"  style="width:512px" >
											<xsl:call-template name="htmltagfindanddelete">
												<xsl:with-param name="string"><xsl:value-of select="document/fields/content" />
												</xsl:with-param>
											</xsl:call-template>
										</textarea>
									</div>
								</td>
							</tr>
							
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/comment/@caption"/>&#xA0;:</td>
								<td style="padding-top:5">
									<div>
										<textarea name="comment" rows="5"  tabindex="4" class="rof" style="width:512px">
											<xsl:if test="document/@editmode='noaccess'">
												<xsl:attribute name="readonly">readonly</xsl:attribute>
											</xsl:if>
											<xsl:if test="document/fields/allcontrol = 0">
												<xsl:attribute name="readonly">readonly</xsl:attribute>
											</xsl:if>
											<xsl:if test="document/fields/allcontrol != 'noaccess'">
												<xsl:if test="document/fields/allcontrol != 0">
														<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
														<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
												</xsl:if>
											</xsl:if>
											<xsl:value-of select="document/fields/comment" />
										</textarea>
									</div>
								</td>
							</tr>
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/controltype/@caption"/>&#xA0;:</td>
								<td>
									<xsl:variable name="controltype" select="document/fields/controltype/@attrval"/>
									<select size="1" name="controltype" style="width:512px;">
										<xsl:if test="document/@editmode='noaccess'">
											<xsl:attribute name="disabled"></xsl:attribute>
										</xsl:if>
										<xsl:if test="document/fields/allcontrol = 0">
												<xsl:attribute name="disabled"></xsl:attribute>
										</xsl:if>
										<xsl:for-each select="document/glossaries/controltype/query/entry">
											
												<option>
													<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
													<xsl:if test="$controltype = @docid">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="@viewtext" />
												</option>
											
										</xsl:for-each>
									</select>
								</td>
							</tr>
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/ctrldate/@caption"/>&#xA0;:</td>
								<td>
									<input type="text" name="ctrldate" maxlength="10" class="rof" value="{substring(document/fields/control/ctrldate,1,10)}">
										<xsl:if test="document/@editmode='edit'">
											<xsl:if test="document/fields/allcontrol != 0">
												<xsl:attribute name="id">ctrldate</xsl:attribute>
											</xsl:if>
										</xsl:if>
									</input>
									
								</td>
							</tr>
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/cyclecontrol/@caption"/>&#xA0;:</td>
								<td>
									<table>
										<tr>
											<td>
												<input type="radio" name="cyclecontrol" value="1">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol  = '1'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/@status  = 'new'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/onceonly/@caption"/>
												</input>
											</td>
											<td>
												<input type="radio" name="cyclecontrol" value="2">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol  = '2'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/daily/@caption"/>
												</input>
											</td>
											<td>
												<input type="radio" name="cyclecontrol" value="3">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol  = '3'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/weekly/@caption"/>
												</input>
											</td>
										</tr>
										<tr>
											<td>
												<input type="radio" name="cyclecontrol" value="4">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol  = '4'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/monthly/@caption"/>
												</input>
											</td>
											<td>
												<input type="radio" name="cyclecontrol" value="5">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/document/fields/cyclecontrol  = '5'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/quarterly/@caption"/>
												</input>
											</td>
											<td>
												<input type="radio" name="cyclecontrol" value="6">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol  = '6'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/semiannual/@caption"/>
												</input>
											</td>
											<td>
												<input type="radio" name="cyclecontrol" value="7">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/allcontrol = 0">
														<xsl:attribute name="disabled"></xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/cyclecontrol = '7'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="document/captions/annually/@caption"/>
												</input>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="fc">Снять с контроля&#xA0;:</td>
								<td>
									<table id="intexectable" class="tablefield" style="width:98%; border:1px solid #ccc " >
										<tr style=" border:1px solid #ccc ">
											<td style="text-align:center; width:3%; ">№</td>
											<td style="text-align:center; width:37%"><xsl:value-of select="document/captions/performer/@caption"/></td>
											<td style="text-align:center; width:20%"><xsl:value-of select="document/captions/date/@caption"/></td>
											<td style="text-align:center; width:37%"><xsl:value-of select="document/captions/removedby/@caption"/></td>
											<td style="text-align:center; width:3%"></td>
										</tr>
										<xsl:for-each select="document/fields/executors/entry">
											<tr>
												<td style="width:3%;text-align:center">
													<xsl:value-of select="position()"/>
												</td>
												<td>
													<xsl:value-of select="user" />
													
													<input  type="hidden">
														<xsl:attribute name="id">idContrExec<xsl:value-of select="position()"/></xsl:attribute>	
														<xsl:attribute name="value"><xsl:value-of select="user/@attrval"/></xsl:attribute>
													</input>
												</td>
												<td>
													
													<xsl:attribute name="id">controlOffDate<xsl:value-of select="position()"/></xsl:attribute>
													<xsl:value-of select="resetdate"/>
													
												</td>
												<td>
													
													<xsl:attribute name="id">idCorrControlOff<xsl:value-of select="position()"/></xsl:attribute>											
													<xsl:value-of select="resetauthor"/>
													
												</td>
												<td>
													<xsl:attribute name="id">switchControl<xsl:value-of select="position()"/></xsl:attribute>
													<xsl:variable name="pos" select="position()"/>
														<xsl:if test="../../../actions/action [.='RESET_CONTROL']/@enable = 'true'">
															<xsl:choose>
																<xsl:when test="string-length(resetauthor) != 0">
																	<a href="">
																		<xsl:attribute name="href">javascript:controlOn(<xsl:value-of select='$pos'/>)</xsl:attribute>
																		<img  title="Поставить на контроль" src="/SharedResources/img/classic/tick.gif"/></a>
																</xsl:when>
																<xsl:otherwise>
																	<a href="">
																		<xsl:attribute name="href">javascript:controlOff(<xsl:value-of select='$pos'/>)</xsl:attribute>
																		<img  title="Снять с контроля" src="/SharedResources/img/classic/exec_control.gif"/>
																	</a>
																</xsl:otherwise>
															</xsl:choose>
														</xsl:if>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</td>
								</tr>
							</table>
							<br/>
						
					</div>
					 
						<div display="none" style="display:none; margin-left:2%" id="execution"><br/>
							<a href="">
								<xsl:attribute name="href">
									<xsl:if test="document/@parentdoctype = 896">Provider?type=document&amp;id=sz&amp;key=<xsl:value-of select="document/@parentdocid"/></xsl:if>
									<xsl:if test="document/@parentdoctype = 897">Provider?type=document&amp;id=kr&amp;key=<xsl:value-of select="document/@parentdocid"/></xsl:if>
								</xsl:attribute>
								<font style="font-family:arial; font-size:0.9em;">
									<xsl:value-of select="document/fields/pdocviewtext"/>	
								</font>
							</a>
							
							<table id="executionTbl">
							</table>
							<br/>
						</div>    
						
					<!-- Скрытые поля -->
					<input type="hidden" name="isresol">
						<xsl:attribute name="value"><xsl:value-of select="isresol" /></xsl:attribute>
					</input>
					
					<input type="hidden" name="type" value="save" />
					<input type="hidden" name="id" value="kr" />
					<input type="hidden" name="author">
						<xsl:attribute name="value"><xsl:value-of select="document/fields/author/@attrval" /></xsl:attribute>
					</input>
					<input type="hidden" name="taskvn">
						<xsl:attribute name="value"><xsl:value-of select="document/fields/taskvn" /></xsl:attribute>
					</input>
					<input type="hidden" name="allcontrol">
						<xsl:attribute name="value"><xsl:value-of select="document/fields/allcontrol" /></xsl:attribute>
					</input>
					
					<input type="hidden" name="tasktype">
						<xsl:choose>
							<xsl:when test="document/fields/tasktype = 'RESOLUTION'">
								<xsl:attribute name="value">RESOLUTION</xsl:attribute>
							</xsl:when>
							<xsl:when test="document/fields/parenttasktype=''">
								<xsl:attribute name="value">RESOLUTION</xsl:attribute>
							</xsl:when>
							<xsl:otherwise>
								<xsl:attribute name="value">CONSIGN</xsl:attribute>
							</xsl:otherwise>
						</xsl:choose>
					</input>
					<input type="hidden" name="doctype">
						<xsl:attribute name="value"><xsl:value-of select="document/@doctype" /></xsl:attribute>
					</input>
					
					<input type="hidden" name="key">
						<xsl:attribute name="value"><xsl:value-of select="document/@docid" /></xsl:attribute>
					</input>
					
					<input type="hidden" name="parentdocid">
						<xsl:attribute name="value"><xsl:value-of select="document/@parentdocid" /></xsl:attribute>
					</input>
					<input type="hidden" name="parentdoctype">
						<xsl:attribute name="value"><xsl:value-of select="document/@parentdoctype" /></xsl:attribute>
					</input>
					<input type="hidden" name="page">
						<xsl:attribute name="value"><xsl:value-of select="document/@openfrompage" /></xsl:attribute>
					</input>
					
					<xsl:for-each select="extexecid/item">
						<input type="hidden" name="extexecid" id="extexecid">
							<xsl:attribute name="value"><xsl:value-of select="." /></xsl:attribute>
						</input>
					</xsl:for-each>

				</form>
				<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
					<input type="hidden" name="type" value="rtfcontent" />
					<input type="hidden" name="formsesid">
						<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
					</input>
					<div display="block" id="att">
						<xsl:call-template name="attach"/>
					</div>
				</form>
				<div id="executers" style="display:none">
					<table style="width:100%">
						<xsl:for-each select="document/fields/executors/entry">
							
								<tr>
									<td>
										<input type="checkbox" name="chbox">
											<xsl:attribute name="value"><xsl:value-of select="user"/></xsl:attribute>
											<xsl:attribute name="id"><xsl:value-of select="user/@attrval"/></xsl:attribute>
											<xsl:if test="user/@attrval =''">
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:if>
										</input>	
									</td>
									<td>
										<font class="font"  style="font-family:verdana; font-size:13px; margin-left:2px">
											<xsl:if test="user/@attrval =''">
												<xsl:attribute name="color">gray</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="user"/> 
										</font>
									</td>
								</tr>
						</xsl:for-each>
					</table>
				</div>
				<input type="hidden" id="currentuser">
					<xsl:attribute name="value"><xsl:value-of select="@userid"/></xsl:attribute>
				</input>
				<input type="hidden" id="localusername">
					<xsl:attribute name="value"><xsl:value-of select="@username"/></xsl:attribute>
				</input>
				<xsl:call-template name="ECPsignFields"/>
				<hr color="#CCCCCC" />
				<xsl:call-template name="authorrus" />
				<xsl:call-template name="authordep" />
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>