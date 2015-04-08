<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:import href="../templates/docthread.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="request/document/captions/doctypemultilang/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:output method="html" encoding="windows-1251" />
	<xsl:template match="/request">
		<html>
			<head>
				<xsl:call-template name="cssandjs" />
				<xsl:if test="document/@status != 'new'">
					<title>
						<xsl:value-of select="document/@viewtext"/> - 4ms workflow 
					</title>
				</xsl:if>
				<xsl:if test="document/@status = 'new'">
					<title>
						Новый документ &#xA0;<xsl:value-of select="lower-case($doctype)" />  - 4ms workflow
					</title>
				</xsl:if>
				<xsl:if test="document/@editmode = 'edit'">
					<script>
						$(function() {
							$('#ctrldate').datepicker({
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
				<xsl:call-template name="markisread"/>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div class="bar">
					
					<span style="width:82%; vertical-align:12px">
						<xsl:call-template name="save"/>
						<xsl:call-template name="newkr" />
						<xsl:call-template name="newki" />
					</span>
					<span style="float:right">
			        	<xsl:call-template name="cancel" />
			        </span>
				</div>		
				<div class="formtitle">
				    <xsl:call-template name="doctitle"/>											
					<xsl:value-of select="maincorr"/>
				    <font size="2">&#xA0;<xsl:value-of select="parentbriefcont"/></font>&#xA0;
				    
				<!--  кнопка "Открыть документ в lotus notes"   -->
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
				<!--  форма документа   -->
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
					
				<!-- секция "Свойства"   -->
					<div display="block"  id="property">
						<br/>
						<table width="100%" border="0" >
						
				<!--  поля "Входящий номер" и "Дата входящего"   -->
						<tr>
							<td width="30%" class="fc"><xsl:value-of select="document/fields/vn/@caption"/> №&#xA0;:</td>
			            	<td>
                        		<input type="text" name="vn" size="10" class="rof">
	                            	<xsl:attribute name="readonly">readonly</xsl:attribute>
                                	<xsl:attribute name="value">
                                		<xsl:value-of select="document/fields/vn"/>
                                	</xsl:attribute>
                            	</input>&#xA0;
                            	<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
                            	<input type="text" name="dvn" size="20" class="rof">
	                            	<xsl:attribute name="readonly">readonly</xsl:attribute>
                               		<xsl:attribute name="value">
                               			<xsl:value-of select="document/fields/dvn"/>
                               		</xsl:attribute>
                            	</input>
     				    	</td>   					
						</tr>
						
				<!--  поле "Ф.И.О."   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/fio/@caption"/>&#xA0;:
							</td>
							<td>
								<input style="width:55%" type="text"  name="fio" id="fio"  class="rof"> 
									<xsl:if test="document/@editmode !='edit'">
	                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            	</xsl:if>   
	                            	<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>               			              		
									<xsl:attribute name="value"><xsl:value-of select="document/fields/fio"/></xsl:attribute>
								</input>	
							</td>
						</tr>
						
				<!--  поле "Адрес"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/address/@caption"/>&#xA0;:
							</td>
							<td>
								<input style="width:55%" type="text"  id="address" name="address" class="rof" >
									<xsl:if test="document/@editmode !='edit'">
	                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            	</xsl:if>
	                          	  	<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>                   			              		
									<xsl:attribute name="value"><xsl:value-of select="document/fields/address"/></xsl:attribute>
								</input>	
							</td>
						</tr>
						
				<!--  поле "Получатель"   -->
						<tr>
							<td class="fc"><xsl:value-of select="document/fields/recipient/@caption"/>&#xA0;: 
								<xsl:if test="document/@editmode = 'edit'">
									<a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('structure','false','recipient','frm', 'recipienttbl');</xsl:attribute>								
										<img src="/SharedResources/img/iconset/report_magnify.png"></img>			
									</a>
								</xsl:if>
							</td>
							<td>
								<table id="recipienttbl" width="500px"  style="border:1px solid #ccc">
									<tr><td><xsl:value-of select="document/fields/recipient"/>&#xA0;</td></tr>
								</table>
								<input type="hidden" id="corr" name="recipient">
									<xsl:attribute name="value"><xsl:value-of select="document/fields/recipient/@attrval"/></xsl:attribute>
								</input>	
							</td>
						</tr>
						
				<!--  поле "Категория"   -->
						<tr>
							<td class="fc"><xsl:value-of select="document/fields/cat/@caption"/>&#xA0;:</td>
							<td>
								<xsl:variable name="cat" select="document/fields/cat/@attrval"/>
								<select name="cat" class="rof" style="width:500px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<xsl:for-each select="document/glossaries/cat/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
												<xsl:if test="$cat = @docid">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>
							</td>
						</tr>
						
				<!--  поле "Тип документа"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/vid/@caption"/>&#xA0;:
							</td>
							<td>
								<xsl:variable name="typedoc" select="document/fields/typedoc/@attrval"/>
								<select name="vid" class="rof" style="width:500px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<xsl:for-each select="document/glossaries/typedoc/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
												<xsl:if test="$typedoc = @docid">
													<xsl:attribute name="selected">selected</xsl:attribute>
												</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>	
							</td>
						</tr>
						
				<!--  поле "Краткое содержание"   -->
						<tr>
							<td class="fc"><xsl:value-of select="document/fields/briefcontent/@caption"/>&#xA0;:</td>
							<td>
								<textarea name="briefcontent" rows="5" cols="90" class="rof">
									<xsl:if test="document/@editmode !='edit'">
	                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            	</xsl:if> 
	                            	<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="document/fields/briefcontent" />
								</textarea>							
							</td>
						</tr>
						
				<!--  поле "Примечание"   -->
						<tr>
							<td class="fc"><xsl:value-of select="document/fields/remark/@caption"/>&#xA0;:</td>
							<td>
								<textarea name="remark" rows="4" cols="90" class="rof">
									<xsl:if test="document/@editmode !='edit'">
	                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            	</xsl:if> 
	                            	<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="document/fields/remark" />
								</textarea>							
							</td>
						</tr>
						
				<!--  поле "Результат рассмотрения"   -->
						<tr>
							<td class="fc"><xsl:value-of select="document/fields/resultview/@caption"/>&#xA0;:</td>
							<td>
								<select name="resultview" class="rof" style="width:311px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<option>
										<xsl:attribute name="value">0</xsl:attribute>
										<xsl:if test="document/fields/resultview = 0">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
									</option>
									<option>
										<xsl:attribute name="value">1</xsl:attribute>
										<xsl:if test="document/fields/resultview = 1">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Разъяснено
									</option>
									<option>
										<xsl:attribute name="value">2</xsl:attribute>
										<xsl:if test="document/fields/resultview = 2">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Удовлетворено
									</option>
									<option>
										<xsl:attribute name="value">3</xsl:attribute>
										<xsl:if test="document/fields/resultview = 3">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Отказано
									</option>
								</select>
							</td>
						</tr>
						
				<!--  поле "Район/регион"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/regionview/@caption"/>&#xA0;:
							</td>
							<td>
								<xsl:variable name="regionview" select="document/fields/regionview/@attrval"/>
								<select name="regionview" class="rof" style="width:311px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<xsl:for-each select="document/glossaries/city/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
											<xsl:if test="$regionview = @docid">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>		
							</td>
						</tr>
						
				<!--  поле "Телефон"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/phone/@caption"/>&#xA0;:
							</td>
							<td>
								<input size="48" type="text" name="phone" id="phone"  class="rof">    
									<xsl:if test="document/@editmode !='edit'">
	                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
	                           		</xsl:if>
	                           		<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>                   			              		
									<xsl:attribute name="value"><xsl:value-of select="document/fields/phone"/></xsl:attribute>
								</input>	
							</td>
						</tr>

				<!--  поля "Вид обращения"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/otype/@caption"/>&#xA0;:
							</td>
							<td>
								<select name="private" class="rof" style="width:180px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<option>
										<xsl:attribute name="value">1</xsl:attribute>
										<xsl:if test="document/fields/private = 1">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Индивидуальное
									</option>
									<option>
										<xsl:attribute name="value">2</xsl:attribute>
										<xsl:if test="document/fields/private = 2">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Коллективное
									</option>
								</select>
								<select name="otype" style="margin-left:2%; width:130px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<option>
										<xsl:attribute name="value">1</xsl:attribute>
										<xsl:if test="document/fields/otype = 1">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Письменно
									</option>
									<option>
										<xsl:attribute name="value">2</xsl:attribute>
										<xsl:if test="document/fields/otype = 2">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Устно
									</option>
								</select>
							</td>
						</tr>
						
				<!--  поле "Характер вопроса"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/har/@caption"/>&#xA0;:
							</td>
							<td>
								<xsl:variable name="har" select="document/fields/har/@attrval"/>
								<select name="har" class="rof" style="width:420px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<xsl:for-each select="document/glossaries/har/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
											<xsl:if test="$har = @docid">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>		
							</td>
						</tr>
						
				<!--  поле "Язык обращения"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/lang/@caption"/>&#xA0;:
							</td>
							<td>
								<select name="lang" class="rof" style="width:150px">
									<xsl:if test="document/@editmode != 'edit'">
										<xsl:attribute name="disabled"></xsl:attribute>
									</xsl:if>
									<option>
										<xsl:attribute name="value">1</xsl:attribute>
										<xsl:if test="document/fields/lang = '1'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Русский
									</option>
									<option>
										<xsl:attribute name="value">2</xsl:attribute>
										<xsl:if test="document/fields/lang = '2'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Английский
									</option>
									<option>
										<xsl:attribute name="value">3</xsl:attribute>
										<xsl:if test="document/fields/lang = '3'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Казахский
									</option>
									<option>
										<xsl:attribute name="value">4</xsl:attribute>
										<xsl:if test="document/fields/lang = '4'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Другой
									</option>
								</select>	
							</td>
						</tr>


				<!--  поля "Количество листов/экземпляров"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/np/@caption"/>/
								<xsl:value-of select="document/fields/np2/@caption"/>&#xA0;:
							</td>
							<td>
								<input  style="width:5%" type="text" name="np" id="np" onkeypress="javascript:Numeric(this)"  class="rof">
									<xsl:if test="document/@editmode !='edit'">
	                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
	                           		</xsl:if> 
	                           		<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>                      			              		
									<xsl:attribute name="value"><xsl:value-of select="document/fields/np"/></xsl:attribute>
								</input>/
								<input  style="width:5%" type="text" name="np2" id="np2" onkeypress="javascript:Numeric(this)" class="rof">
									<xsl:if test="document/@editmode !='edit'">
	                            		<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            	</xsl:if>
	                            	<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>                       			              		
									<xsl:attribute name="value"><xsl:value-of select="document/fields/np2"/></xsl:attribute>
								</input>	
							</td>
						</tr>
						
				<!--  поле "Срок исполнения"   -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/ctrldate/@caption"/>&#xA0;:
							</td>
							<td>
								<input type="text" id="ctrldate" name="ctrldate" size="18" class="rof" >
	                            	<xsl:attribute name="readonly">readonly</xsl:attribute>
									<xsl:attribute name="value"><xsl:value-of select="document/fields/ctrldate"/></xsl:attribute>
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
				<!-- скрыте поля документа   -->				
				<input type="hidden" name="type" value="save" />
				<input type="hidden" name="id" value="L" />
				<input type="hidden" name="doctype">
					<xsl:attribute name="value"><xsl:value-of select="document/@doctype" /></xsl:attribute>
				</input>
				<xsl:if test="document/@status !='new'">
					<input type="hidden" name="key">
						<xsl:attribute name="value"><xsl:value-of select="document/@docid" /></xsl:attribute>
					</input>
					<input type="hidden" name="parentdocid">
						<xsl:attribute name="value"><xsl:value-of select="document/@parentdocid" /></xsl:attribute>
					</input>
					<input type="hidden" name="parentdoctype">
						<xsl:attribute name="value"><xsl:value-of select="document/@parentdoctype" /></xsl:attribute>
					</input>
				</xsl:if>
				<input type="hidden" name="page">
					<xsl:attribute name="value"><xsl:value-of select="document/@openfrompage" /></xsl:attribute>
				</input>       
		     </form>
		    
		    <!--  форма "Вложения документа"  -->
		     <form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
				<input type="hidden" name="type" value="rtfcontent" />
				<input type="hidden" name="formsesid">
					<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
				</input>
				<div display="block" id="att">
					<div id="attach" style="display:block;">
						<table style="border:0" id="upltable" width="100%">
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
												</div>
											</td>
											<td>
												<a href=''>
													<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="$docid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='.'/></xsl:attribute>
													<xsl:value-of select="../../../../document/captions/openattach/@caption"/>
												</a>&#xA0;&#xA0;
												<a href=''>
													<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid"/>,'<xsl:value-of select='.'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
													<xsl:value-of select="../../../../document/captions/delattach/@caption"/>
												</a>
											</td>
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
	        <hr color="#CCCCCC"/>
            <xsl:call-template name="authorrus"/> 
            <xsl:call-template name="authordep"/>
			</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>