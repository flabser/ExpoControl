<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:import href="../templates/docthread.xsl"/>
	<xsl:variable name="doctype">
		<xsl:value-of select="request/document/captions/doctypemultilang/@caption"/>
	</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
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
						Новый &#xA0;<xsl:value-of select="lower-case($doctype)" />  - 4ms workflow
					</title>
				</xsl:if>
				<xsl:call-template name="cssandjs" />	
   				<xsl:call-template name="markisread"/>
   				<xsl:if test="document/@editmode= 'edit'">
					<script type="text/javascript">
						$(function() {
							$('#ctrldate').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								regional:['ru']
							});
							$(".rof:not([readOnly]):first").focus();
						});
					</script>	
					
				</xsl:if>
			</head>
			<body>
				<xsl:variable name="status" select="@status"/>
				<div class="bar">
					<span style="width:83%; vertical-align:12px">
						<xsl:call-template name="save" />
					</span>					
				    <span style="float:right">
						<xsl:call-template name="cancel" />
					</span>
				</div>		
				
				<!-- заголовок -->	
				
				<div class="formtitle">
				   <xsl:call-template name="doctitle" />										
				    <xsl:value-of select="maincorr"/>
				    <font size="2">&#xA0;<xsl:value-of select="parentbriefcont"/></font>&#xA0;
				    <xsl:if test="document/@status !='new'">
						<xsl:if test="document/fields/projecturl !=''">
							<table style="margin-top:10px">
								<tr>
									<td>
										<a href="" style="font-size:11px">
											<xsl:attribute name="href"><xsl:value-of select="replace(document/fields/projecturl, 'amp;', '')"/></xsl:attribute>
											<xsl:value-of select="document/fields/projectviewtext"/>
										</a>
									</td>
								</tr>
							</table>
						</xsl:if>	
					</xsl:if>	
				</div>
				
			<!--	 Форма		 -->
			<br/>
			<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
				
				<!-- Секция "Свойства" -->
				<div display="block"  id="property">
					<br/>
					<table width="100%" border="0" >
	
						<!--	 поля "Исходящий номер" и "Дата исходящего"		-->
						<tr>
							<td  class="fc">
								<xsl:value-of select="document/fields/vn/@caption"/> №&#xA0;:
							</td>
			           		<td>
                        		<input type="text" name="vn" size="10" class="rof">
                        		 	<xsl:attribute name="readonly">readonly</xsl:attribute>
                            		<xsl:attribute name="value"><xsl:value-of select="document/fields/vn"/></xsl:attribute>
                            	</input>&#xA0;
                            	<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
                            	<input type="text" name="dvn" size="18" class="rof">
	                            	<xsl:attribute name="readonly">readonly</xsl:attribute>
                                	<xsl:attribute name="value"><xsl:value-of select="document/fields/dvn"/></xsl:attribute>
                           		</input>
                        	</td>   					
						</tr>
						
						<!-- 	Поле "Получатель"	 -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/corr/@caption" />:
								<!--<xsl:if test="document/@editmode= 'edit'">
									--><a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('corresp','true','corr','frm', 'corrtbl');</xsl:attribute>
										<img src="/SharedResources/img/iconset/report_magnify.png"></img>
									</a>
								<!--</xsl:if>
							--></td>
							<td>
								<table id="corrtbl" width="380px" >
									<xsl:if test="not(document/fields/corr/entry)">
										<tr>
											<td style="border:1px solid #ccc" >
												<xsl:value-of select="document/fields/corr"/>&#xA0;
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="document/fields/corr/@islist ='true'">
										<xsl:for-each select="document/fields/corr/entry">
											<tr>
												<td style="border:1px solid #ccc" >
													<xsl:value-of select="."/>&#xA0;
												</td>
											</tr>
										</xsl:for-each>
									</xsl:if>
								</table>
								<xsl:if test="document/fields/corr/@islist ='true'">
									<xsl:for-each select="document/fields/corr/entry">
										<input type="hidden"  name="corr">
											<xsl:attribute name="value">
												<xsl:value-of select="./@attrval"/>
											</xsl:attribute>
										</input>	
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="not(document/fields/corr/entry)">
									<input type="hidden" id="corr" name="corr">
										<xsl:attribute name="value"><xsl:value-of select="document/fields/corr/@attrval"/></xsl:attribute>
									</input>
								</xsl:if>
							</td>
						</tr>
						
						<!-- Поле "Номер бланка" -->
						<tr>
							<td  class="fc">
								<xsl:value-of select="document/fields/blanknumber/@caption"/>&#xA0;:
							</td>
			            	<td>
                        		<input type="text" name="blanknumber" size="10" onkeypress="javascript:Numeric(this)" class="rof">
                        			<!--<xsl:if test="document/@editmode !='edit'">
	                            			<xsl:attribute name="readonly">readonly</xsl:attribute>
	                            		</xsl:if>  
	                            		 
                            		-->
                            		<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
                            		<xsl:attribute name="value"><xsl:value-of select="document/fields/blanknumber"/></xsl:attribute>
                           		</input>
                        	</td>   					
						</tr>
						
						<!-- Поля "количество листов" и "количество экземпляров" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/np/@caption"/>/<xsl:value-of select="document/fields/np2/@caption"/>&#xA0;:
							</td>
							<td>
								<input  style="width:5%" type="text" name="np" id="np" onkeypress="javascript:Numeric(this)"  class="rof">
									<!--<xsl:if test="document/@editmode !='edit'">
	                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
	                           		</xsl:if>                    			              		
									-->
									<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/np"/>
									</xsl:attribute>
								</input>	
								/
								<input  style="width:5%" type="text" name="np2" id="np2" onkeypress="javascript:Numeric(this)" class="rof">
									<!--<xsl:if test="document/@editmode !='edit'">
	                           			<xsl:attribute name="readonly">readonly</xsl:attribute>
	                           		</xsl:if>                    			              		
									-->
									<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/np2"/>
									</xsl:attribute>
								</input>	
							</td>
						</tr>
					
						<!-- Поле "Краткое содержание" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/briefcontent/@caption"/>&#xA0;:
							</td>
							<td>
								<textarea name="briefcontent" rows="5" cols="90">
									<xsl:attribute name="class">rof</xsl:attribute>	
									<!--<xsl:if test="document/@editmode !='edit'">								
										<xsl:attribute name="readonly">readonly</xsl:attribute>
									</xsl:if>
									-->
									<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
									<xsl:value-of select="document/fields/briefcontent" />
								</textarea>							
							</td>
						</tr>
					
						<!-- поле "Подписал" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/signedby/@caption"/>: 
								<!--<xsl:if test="document/@editmode ='edit'">
									--><a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('signers','false','signedby','frm', 'signedbytbl');</xsl:attribute>								
										<img src="/SharedResources/img/classic/picklist.gif" style="border:0;"/>			
									</a>
								<!--</xsl:if>
							--></td>
							<td>
								<table id="signedbytbl" width="380px"  style="border:1px solid #ccc">
									<tr>
										<td>
											<xsl:value-of select="document/fields/signedby"/>&#xA0;
										</td>
									</tr>
								</table>
								<input type="hidden" id="signedby" name="signedby">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/signedby/@attrval"/>
									</xsl:attribute>
								</input>	
							</td>
						</tr>
						
						<!-- Поле "Внутренние исполнители" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/intexec/@caption"/>: 
								<!--<xsl:if test="document/@editmode ='edit'">
									--><a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('structure','true','intexec','frm', 'intexectbl');</xsl:attribute>								
										<img src="/SharedResources/img/classic/picklist.gif" style="border:0;"/>			
									</a>
								<!--</xsl:if>
							--></td>
							<td>
								<table id="intexectbl" width="380px" >
									<xsl:if test="not(document/fields/intexec/entry)">
										<tr>
											<td style="border:1px solid #ccc" >
												<xsl:value-of select="document/fields/intexec"/>&#xA0;
											</td>
										</tr>
									</xsl:if>
									<xsl:if test="document/fields/intexec/@islist ='true'">
										<xsl:for-each select="document/fields/intexec/entry">
											<tr>
												<td style="border:1px solid #ccc" >
													<xsl:value-of select="."/>&#xA0;
												</td>
											</tr>
										</xsl:for-each>
									</xsl:if>
								</table>
								<xsl:if test="document/fields/intexec/@islist ='true'">
									<xsl:for-each select="document/fields/intexec/entry">
										<input type="hidden"  name="intexec">
											<xsl:attribute name="value">
												<xsl:value-of select="@attrval"/>
											</xsl:attribute>
										</input>	
									</xsl:for-each>
								</xsl:if>
								<xsl:if test="not(document/fields/intexec/entry)">
									<input type="hidden" id="intexec" name="intexec">
										<xsl:attribute name="value">
											<xsl:value-of select="document/fields/intexec/@attrval"/>
										</xsl:attribute>
									</input>
								</xsl:if>
							</td>
						</tr>
					
						<!-- Поле "Код" -->
						<!-- <tr>
							<td class="fc">
								<xsl:value-of select="document/fields/ndelo/@caption"/>&#xA0;:
							</td>
			            	<td>
                        		<input type="text" name="ndelo" size="10" class="rof">
                        			<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="readonly">readonly</xsl:attribute>
                        			</xsl:if>
                            		
                            		<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
                            		<xsl:attribute name="value">
                            			<xsl:value-of select="document/fields/ndelo"/>
                            		</xsl:attribute>
                            	</input>
                        	</td>   					
						</tr> -->
						
						<!-- Поле "Номенклатура дел" -->						
						<!-- <tr>
							<td class="fc">
								<xsl:value-of select="document/fields/nomentype/@caption"/>&#xA0;: 
							</td>
							<td>
								<select size="1" name="nomentype" style="margin-top:4px ;width:400px">
									<xsl:variable name="nomentype" select="document/fields/nomentype/@attrval"/>
									<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="disabled">disabled</xsl:attribute>
                        			</xsl:if>
									<xsl:for-each select="document/glossaries/N/query/entry">
										<option>
											<xsl:attribute name="value">
												<xsl:value-of select="@docid"/>
											</xsl:attribute>
											<xsl:if test="$nomentype = @docid">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>	
							</td>
						</tr>
				 -->
						<!-- поле "Является ответным на входящий документ" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/vnin/@caption"/> &#xA0;:
							</td>
			            	<td>
                        		<input type="text" name="vnin" size="25" class="rof">
                        			<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="readonly">readonly</xsl:attribute>
                        			</xsl:if>
                        			<xsl:if test="document/@editmode = 'edit'">
										<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
										<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
									</xsl:if>
                            		<xsl:attribute name="value"><xsl:value-of select="document/fields/vnin"/></xsl:attribute>
                           		</input>
                        	</td>   					
						</tr>
						
						<!-- Поле "Ответный входящий документ" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/backvnish/@caption"/> &#xA0;:
							</td>
			            	<td>
                        		<input type="text" name="backvnish" size="25" class="rof">
                        			<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="readonly">readonly</xsl:attribute>
                        			</xsl:if>
                            		<xsl:attribute name="value">
                            			<xsl:value-of select="document/fields/backvnish"/>
                            		</xsl:attribute>
                            	</input>
                        	</td>   					
						</tr>
						
						<!-- Поле "Язык документа" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/lang/@caption"/>&#xA0;:
							</td>
							<td>
								<select name="lang" class="rof">
									<!--<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="disabled">disabled</xsl:attribute>
                        			</xsl:if>
									--><option>
										<xsl:attribute name="value">1</xsl:attribute>
										<xsl:if test="document/fields/lang = '1'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Русский
									</option>
									<option>
										<xsl:attribute name="value">3</xsl:attribute>
										<xsl:if test="document/fields/lang = '2'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Казахский
									</option>
									<option>
										<xsl:attribute name="value">3</xsl:attribute>
										<xsl:if test="document/fields/lang = '3'">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										Казахский,русский
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
			
						<!-- Поле "Вид доставки" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/deliverytype/@caption"/>&#xA0;:
							</td>
							<td>
								<select name="deliverytype"  style="width:500px">
									<!--<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="disabled">disabled</xsl:attribute>
                        			</xsl:if>
									--><xsl:variable name="deliverytype" select="document/fields/deliverytype/@attrval"/>
									<xsl:for-each select="document/glossaries/deliverytype/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
											<xsl:if test="$deliverytype = @docid ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>	
							</td>
						</tr>
				
						<!-- Поле "Тип документа" -->
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/vid/@caption"/>&#xA0;:
							</td>
							<td>
								<xsl:variable name="vid" select="document/fields/vid/@attrval"/>
								<select name="vid" class="rof" style="width:500px">
									<!--<xsl:if test="document/@editmode !='edit'">
                        				<xsl:attribute name="disabled">disabled</xsl:attribute>
                        			</xsl:if>
									--><xsl:for-each select="document/glossaries/typedoc/query/entry">
										<option>
											<xsl:attribute name="value"><xsl:value-of select="@docid"/></xsl:attribute>
											<xsl:if test="$vid = @docid">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="@viewtext"/>
										</option>
									</xsl:for-each>
								</select>	
							</td>
						</tr>	
					</table>		
				</div>
				
				<!-- Секция "Содержание" -->
				<div display="block"  id="content">

						<!-- Основной текст -->
				<br/>
				<table width="100%">
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/content/@caption"/>&#xA0;:
						</td>
						<td>
							 <textarea id="txtDefaultHtmlArea" name="contentsource" cols="90" rows="25" >
							 	<xsl:call-template name="htmltagfindanddelete">
									<xsl:with-param name="string"><xsl:value-of select="document/fields/contentsource" /></xsl:with-param>
								</xsl:call-template>
							 </textarea>
						</td>
					</tr>
				</table>
				<br/>
			</div>
						
			<!--Скрытые поля для сохранения-->
				
			<input type="hidden" name="type" value="save"/>
			<input type="hidden" name="id" value="ish"/>
			<input type="hidden" name="din">
				<xsl:attribute name="value"><xsl:value-of select="document/fields/din"/></xsl:attribute>
			</input>
			<xsl:if test="document/@status!='new'">
				<input type="hidden" name="key">
					<xsl:attribute name="value"><xsl:value-of select="document/@docid"/></xsl:attribute>
				</input>
				<input type="hidden" name="doctype">
					<xsl:attribute name="value"><xsl:value-of select="document/@doctype"/></xsl:attribute>
				</input>
			</xsl:if>
		</form>
		          
			<!--       Вложения документа-->
		          
		<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
			<input type="hidden" name="type" value="rtfcontent" />
			<input type="hidden" name="formsesid">
				<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
			</input>
			<div display="block" id="att">
				<br/>	
					<div id="attach" style="display:block;">
						<table style="border:0" id="upltable" width="100%">
							<xsl:if test="document/@editmode != 'readonly'">
								<tr>
									<td class="fc">
										<xsl:value-of select="document/captions/attachments/@caption"/>&#xA0;:
									</td>
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
			<hr color="#CCCCCC" />
			<xsl:call-template name="authorrus" />
			<xsl:call-template name="authordep" />
		</body>	
	</html>
	</xsl:template>
</xsl:stylesheet>