<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:import href="../templates/docthread.xsl" />
	<xsl:variable name="doctype">
		<xsl:value-of select="request/document/captions/doctypemultilang/@caption"/>
	</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@docid" />
	<xsl:output method="html" encoding="windows-1251" />
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
						Новый &#xA0;<xsl:value-of select="lower-case($doctype)" />   - 4ms workflow
					</title>
				</xsl:if>
				<xsl:call-template name="cssandjs" />
				<xsl:call-template name="markisread"/>
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
							$('#din').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								regional:['ru'],
								showAnim: ''
							});
							$(".rof:not([readOnly]):first").focus();
						});
						
					</script>
					
				</xsl:if>
			</head>
			<body>
				<xsl:variable name="status" select="@status" />
				<div class="bar">
					<span style="width:82%; ">
						<xsl:call-template name="save" />
						<xsl:call-template name="newkr" />
						<xsl:call-template name="newki" />
						<xsl:call-template name="acquaint"/>
						<xsl:if test="document/@status !='new'">
							<a style="vertical-align:12px">
								<xsl:attribute name="class">gray button form</xsl:attribute>
								<xsl:attribute name="href">Provider?type=document&amp;id=outdocprj&amp;key=&amp;parentdocid=&amp;page=null<xsl:value-of select="document/@docid" />&amp;parentdoctype=<xsl:value-of select="document/@doctype" /></xsl:attribute>
								<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
								<font>Ответный исходящий</font>
							</a>
						</xsl:if>
					</span>
					<span style="float:right">
						<xsl:call-template name="cancel" />
					</span>
				</div>
				<div class="formtitle">
					<xsl:call-template name="doctitle" />
					<xsl:value-of select="maincorr" />
					<font size="2">
						&#xA0;<xsl:value-of select="parentbriefcont" />&#xA0;
					</font>
					<xsl:if test="document/@status !='new'">
						<xsl:if test="document/@notesurl !=''">
							<table style="margin-top:5px">
								<tr>
									<td>
										<a href="" style="font-size:11px">
											<xsl:attribute name="href"><xsl:value-of select="document/@notesurl"/></xsl:attribute>
											<xsl:value-of select="document/fields/openinlotus/@caption"/>
										</a>
									</td>
								</tr>
							</table>
						</xsl:if>	
					</xsl:if>		
				</div>
				<br/>
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
					
					
					<!--  секция "свойства"   -->
					
					<div display="block" id="property">
						
						<table width="100%" border="0">
							
					<!--  поля "Входящий номер" и "дата входящего"   -->		
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/vn/@caption"/>&#xA0;№ :
								</td>
								<td>
									<input type="text" name="vn" size="10" class="rof" readonly="readonly" value="{document/fields/vn}"/>
									&#xA0;<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
									<input type="text" name="dvn" size="18" class="rof">
										<xsl:attribute name="readonly">readonly</xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="document/fields/dvn" /></xsl:attribute>
									</input>
								</td>
							</tr>
							
					<!--  поля "Исходящий номер" и "Дата исходящего"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/in/@caption" />&#xA0;№ :
								</td>
								<td>
									<input type="text" class="rof" name="in" size="10">
										<xsl:if test="document/@editmode != 'edit'">
											<xsl:attribute name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="document/@editmode = 'edit'">
											<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
											<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of select="document/fields/in" /></xsl:attribute>
									</input>&#xA0;
									<xsl:value-of select="document/fields/din/@caption"/>&#xA0;
									<input type="text" id="din" name="din" size="9" class="rof">
										<xsl:attribute name="value"><xsl:value-of select="document/fields/din" /></xsl:attribute>
										<xsl:attribute name="readonly">readonly</xsl:attribute>
									</input>
								</td>
							</tr>
							
					<!--  поле "Откуда поступил"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/corr/@caption"/>&#xA0;
									<font style='color:#ff8141'>*</font> &#xA0;:
									<xsl:if test="document/@editmode='edit'">
										<a>
											<xsl:attribute name="href">javascript:dialogBoxStructure('corresp','false','corr','frm', 'corresptbl');</xsl:attribute>
											<img src="/SharedResources/img/iconset/report_magnify.png"></img>
										</a>
									</xsl:if>
								</td>
								<td>
									<table id="corresptbl" width="500px" >
										<tr>
											<td style="border:1px solid #ccc">
												<xsl:value-of select="document/fields/corr" /> &#xA0;
											</td>
										</tr>
									</table>
									<input type="hidden" id="corr" name="corr">
										<xsl:attribute name="value"><xsl:value-of select="document/fields/corr/@attrval" /></xsl:attribute>
									</input>
								</td>
							</tr>
							
					<!--  поле "Кому адресован"   -->
							<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/recipient/@caption" />:
								<xsl:if test="document/@editmode= 'edit'">
									<a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('structure','true','recipient','frm', 'recipienttbl');</xsl:attribute>
										<img src="/SharedResources/img/iconset/report_magnify.png"></img>
									</a>
								</xsl:if>
							</td>
							<td>
								<table id="recipienttbl" width="500px" >
									<xsl:if test="not(document/fields/recipient/entry)">
										<tr>
											<td style="border:1px solid #ccc" >
												<xsl:value-of select="document/fields/recipient"/>&#xA0;
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="document/fields/recipient/@islist ='true'">
										<xsl:for-each select="document/fields/recipient/entry">
											<tr>
												<td style="border:1px solid #ccc" >
													<xsl:value-of select="."/>&#xA0;
												</td>
											</tr>
										</xsl:for-each>
									</xsl:if>
								</table>
								<xsl:if test="document/fields/recipient/@islist ='true'">
									<xsl:for-each select="document/fields/recipient/entry">
										<input type="hidden"  name="recipient">
											<xsl:attribute name="value">
												<xsl:value-of select="./@attrval"/>
											</xsl:attribute>
										</input>	
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="not(document/fields/recipient/entry)">
									<input type="hidden" id="recipient" name="recipient">
										<xsl:attribute name="value"><xsl:value-of select="document/fields/recipient/@attrval"/></xsl:attribute>
									</input>
								</xsl:if>
							</td>
						</tr>
							
					<!--  поле "Тип документа"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/vid/@caption" /> &#xA0;:
								</td>
								<td>
									<select size="1" name="vid" style="margin-top:4px; width:420px">
										<xsl:variable name="vid" select="document/fields/vid/@attrval"/>
										<xsl:if test="document/@editmode != 'edit'">
											<xsl:attribute name="disabled"></xsl:attribute>
										</xsl:if>
										<xsl:for-each select="document/glossaries/vid/query/entry">
											<option>
												<xsl:attribute name="value"><xsl:value-of select="@docid" /></xsl:attribute>
												<xsl:if test="$vid=@docid">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>
												<xsl:value-of select="@viewtext" />
											</option>
										</xsl:for-each>
									</select>
								</td>
							</tr>
							
							<!-- Поле "Вид доставки" -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/deliverytype/@caption"/>&#xA0;:
								</td>
								<td>
									<xsl:variable name="deliverytype" select="document/fields/deliverytype/@attrval"/>
									<select size="1" name="deliverytype" style="margin-top:4px; width:420px">
										<xsl:if test="document/@editmode !='edit'">
                        					<xsl:attribute name="disabled">disabled</xsl:attribute>
                        				</xsl:if>
										<xsl:for-each select="document/glossaries/deliverytype/query/entry">
											<option>
												<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
												<xsl:if test="$deliverytype = @docid">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>
												<xsl:value-of select="@viewtext"/>
											</option>
										</xsl:for-each>
									</select>
									<xsl:if test="document/@editmode !='edit'">
										<input type="hidden" name="deliverytype">
											<xsl:attribute name="value">
												<xsl:value-of select="document/fields/deliverytype/@attrval"/>
											</xsl:attribute>											
										</input>
									</xsl:if>
								</td>
							</tr>
							
							<!--  поле "Краткое содержание"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/briefcontent/@caption" /> &#xA0;:
								</td>
								<td>
									<textarea name="briefcontent" rows="5" cols="90">
										<xsl:if test="document/@editmode != 'edit'">
											<xsl:attribute name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="document/@editmode = 'edit'">
											<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
											<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="class">rof</xsl:attribute>
										<xsl:value-of select="document/fields/briefcontent" />
									</textarea>
								</td>
							</tr>
							
							
					<!--  поле "Примечание"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/remark/@caption" /> &#xA0;:
								</td>
								<td>
									<textarea name="remark" rows="4" cols="90">
										<xsl:if test="document/@editmode != 'edit'">
											<xsl:attribute name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="document/@editmode = 'edit'">
											<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
											<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="class">rof</xsl:attribute>
										<xsl:value-of select="document/fields/remark" />
									</textarea>
								</td>
							</tr>
							
						
					<!--  поле "Является ответным на"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/vnish/@caption" /> &#xA0;:
								</td>
								<td>
									<a>
										<xsl:attribute name="href">Provider?type=document&amp;id=ish&amp;key=<xsl:value-of
											select="vnish" /></xsl:attribute>
										<xsl:value-of select="vnish/item/@alt" />
									</a>
								</td>
							</tr>
							
							
					<!--  поле "Ответный исходящий"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/backvnin/@caption" /> &#xA0;:
								</td>
								<td>
									<a>
										<xsl:attribute name="href">Provider?type=document&amp;id=ish&amp;key=<xsl:value-of
											select="backvnin" /></xsl:attribute>
										<xsl:value-of select="backvnin/item/@alt" />
									</a>
								</td>
							</tr>
							
							
					<!--  поле "Язык обращения"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/lang/@caption" /> &#xA0;:
								</td>
								<td>
									<select size="1" name="lang" style="margin-top:4px;">
										<xsl:if test="document/@editmode != 'edit'">
											<xsl:attribute name="disabled"></xsl:attribute>
										</xsl:if>
										<option>
											<xsl:attribute name="value">1</xsl:attribute>
											<xsl:if test="document/fields/lang=1">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											Русский
										</option>
										<option>
											<xsl:attribute name="value">2</xsl:attribute>
											<xsl:if test="document/fields/lang=2">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											Английский
										</option>
										<option>
											<xsl:attribute name="value">3</xsl:attribute>
											<xsl:if test="document/fields/lang=3">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											Казахский
										</option>
										<option>
											<xsl:attribute name="value">4</xsl:attribute>
											<xsl:if test="document/fields/lang=4">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											Другой
										</option>
									</select>
								</td>
							</tr>
							
							
					<!--  поле "Количество листов"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/np/@caption" /> &#xA0;:
								</td>
								<td>
									<input type="text" name="np" size="5" class="rof" onkeypress="javascript:Numeric(this)">
										<xsl:if test="document/@editmode !='edit'">
											<xsl:attribute name="readonly">readonly</xsl:attribute>
										</xsl:if>
										<xsl:if test="document/@editmode = 'edit'">
											<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
											<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
										</xsl:if>
										<xsl:attribute name="value"><xsl:value-of select="document/fields/np" /></xsl:attribute>
									</input>
								</td>
							</tr>
							
							
						<!--  поле "Срок исполнения"   -->
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/ctrldate/@caption" />&#xA0;:
								</td>
								<td>
									<input type="text" id="ctrldate" name="ctrldate" size="9" class="rof">
										<xsl:attribute name="readonly">readonly</xsl:attribute>
										<xsl:attribute name="value"><xsl:value-of select="document/fields/ctrldate" /></xsl:attribute>
									</input>
								</td>
							</tr>
						</table>
					</div>
					<xsl:if test="document/@status !='new'">
				
						<div display="none" style="display:none; margin-left:2%; width:80%" id="execution"><br/>
							<font style="font-style:arial; font-size:13px">
								<xsl:value-of select="document/@viewtext"/>
							</font>
							
							<table id="executionTbl">
							</table>
							<br/>
						</div>    
					</xsl:if>
					<!--  Скрытые поля документа    -->
					<input type="hidden" name="type" value="save" />
					<input type="hidden" name="id" value="in" />
					<input type="hidden" name="author">
						<xsl:attribute name="value">
							<xsl:value-of select="document/fields/author/@attrval" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="allcontrol">
						<xsl:attribute name="value">
							<xsl:value-of select="document/fields/allcontrol" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="doctype">
						<xsl:attribute name="value">
							<xsl:value-of select="document/@doctype" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="key">
						<xsl:attribute name="value">
							<xsl:value-of select="document/@docid" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="parentdocid">
						<xsl:attribute name="value">
							<xsl:value-of select="document/@parentdocid" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="parentdoctype">
						<xsl:attribute name="value">
							<xsl:value-of select="document/@parentdoctype" />
						</xsl:attribute>
					</input>
					<input type="hidden" name="page">
						<xsl:attribute name="value">
							<xsl:value-of select="document/@openfrompage" />
						</xsl:attribute>
					</input>
				</form>
				
				<!--  форма "Вложения"   -->
				<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
					<input type="hidden" name="type" value="rtfcontent" />
					<input type="hidden" name="formsesid">
						<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
					</input>
					
				<!--  Секция "Вложения"   -->
					
					<div display="block" id="att">
							
						<div id="attach" style="display:block;">
							<table style="border:0" id="upltable" width="100%">
								<xsl:if test="document/@editmode != 'readonly'">
									<tr>
										<td class="fc"><xsl:value-of select="document/captions/attachments/@caption"/>&#xA0;: </td>
										<td >
											<input type="file" size="50" border="#CCC" name="fname"/>&#xA0;
											<a id="upla">
												<xsl:attribute name="href">javascript:submitFile('upload', 'upltable', 'fname')</xsl:attribute>
												<font style="font-size:13px">
													<xsl:value-of select="document/captions/attach/@caption"/>
												</font>
											</a>
										</td>
										<td></td>
									</tr>
								</xsl:if>
								<xsl:variable name='docid' select="document/@docid"/>
								<xsl:variable name='doctype' select="document/@doctype"/>
								<xsl:variable name='formsesid' select="formsesid"/>
								<xsl:choose>
									<xsl:when test="document/fields/rtfcontent/@islist = 'true'">
										<xsl:for-each select="document/fields/rtfcontent/entry">
											<tr>
												<xsl:variable name='id' select='position()'/>
												<xsl:attribute name='id'><xsl:value-of select='$id'/></xsl:attribute>
												<td class="fc"></td>
												<td>
													<div style='display:inline; border:1px solid #CCC; width:47.7%'>
														<xsl:value-of select='.'/>
													</div>&#xA0;
													<a href=''>
														<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="$docid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='.'/></xsl:attribute>
														<xsl:value-of select="../../../../document/captions/openattach/@caption"/>
													</a>&#xA0;&#xA0;
													<a href=''>
														<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid"/>,'<xsl:value-of select='.'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
														<xsl:value-of select="../../../../document/captions/delattach/@caption"/>
													</a>
												</td>
												<td></td>
											</tr>
										</xsl:for-each>
									</xsl:when>
									<xsl:when test="document/fields/rtfcontent !=''">
										<xsl:variable name="filename" select="document/fields/rtfcontent"/>
										<tr>
											<xsl:variable name='id' select='position()'/>
											<xsl:attribute name='id'><xsl:value-of select='$id'/></xsl:attribute>
											<td class="fc"></td>
											<td>
												<div style='display:inline;  border:1px solid #CCC; width:47.7%'>
													<xsl:value-of select='document/fields/rtfcontent'/>
												</div>&#xA0;
												<a href=''>
													<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="$docid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
													<xsl:value-of select="document/captions/openattach/@caption"/>
												</a>&#xA0;&#xA0;
												<a href=''>
													<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid"/>,'<xsl:value-of select='$filename'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
													<xsl:value-of select="document/captions/delattach/@caption"/>
												</a>
											</td>
											<td>
											</td>
										</tr>
									</xsl:when>
								</xsl:choose>
							</table>
							<br/><br/>
						</div>
					</div>
				</form>
				<hr color="#CCCCCC" />
				
				<!--  поля "Автор документа и департамент автора"   -->
				<xsl:call-template name="authorrus" />
				<xsl:call-template name="authordep" />
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>