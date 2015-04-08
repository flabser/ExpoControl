<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:import href="../templates/docthread.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="request/document/captions/doctypemultilang/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@granddocid"/>
	<xsl:variable name="path" select="/request/@skin"/>
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
						Новая &#xA0;<xsl:value-of select="lower-case($doctype)" />  - 4ms workflow
					</title>
				</xsl:if>
				<xsl:call-template name="cssandjs" />
				<xsl:call-template name="showdocthread" />
				<xsl:if test="document/@editmode= 'edit'">
					<script>
						$(function() {
							$('#dateisp').datepicker({
								showOn: 'button',
								buttonImage: '/SharedResources/img/iconset/calendar.png',
								buttonImageOnly: true,
								regional:['ru']
							});
						$(".rof:not([readOnly]):first").focus();
						});
					</script>
					
				</xsl:if>
				<xsl:call-template name="markisread"/>
			</head>
			<body>
			
			<!-- панель акции -->	

				<div class="bar">
					<span style="width:83%; vertical-align:12px">
						<xsl:call-template name="saveKI" />
						 <xsl:if test="document/@status != 'new'">
		            		<xsl:call-template name="newkr" />
						</xsl:if>
					</span>
					<span>
						<xsl:attribute name="style">
							float:right
						</xsl:attribute>
		            	<xsl:call-template name="cancel"/>
		            </span>
		           
				</div>	
					
			<!-- заголовок -->	
				
				<div class="formtitle" style="display:inline">
					<xsl:value-of select="$doctype" />&#xA0;<xsl:value-of select="document/captions/createdate/@caption"/>&#xA0;<xsl:value-of select="document/fields/finishdate" />
				</div>
				<br/>
				<xsl:if test="document/@status != 'new'">
					<xsl:if test="document/@notesurl !=''">
							<table style="margin-top:10px">
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
			
					<xsl:variable name="filename" select="document/fields/pdocrtfcontent"/>
					<table>
							<tr>
								<td width="25%">
									<a href="">
										<xsl:attribute name="href">Provider?type=document&amp;id=<xsl:value-of select="document/fields/grandparform"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/></xsl:attribute>
										<font class="text" style="font-size:11px"><xsl:value-of select="document/fields/pdocviewtext/@caption"/></font>
									</a>
								</td>
								<td >
									<xsl:if test="$filename!=''">
										<a href="">
											<xsl:attribute name="href">Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid"/>&amp;key=<xsl:value-of select="document/fields/grandpardocid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
											<img src="/SharedResources/img/classic/icon_attachment.gif"/>
										</a>
									</xsl:if>
									<!--<a>
										<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
										<font class="text"><xsl:value-of select="substring(document/fields/pdocviewtext,1,80)"/></font>
									</a>
								--></td>	
								<td>
								</td>	
							</tr>
							
						</table>
					</xsl:if>
						
						
			<br/>
			<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded"> 				
				<table width="100%" class="st" >
					<xsl:attribute name="onselectstart">javascript: return false</xsl:attribute>
					<tr onClick="showHideForm('property','propImg')" onDblClick="showHideForm('property','propImg')" >
						<td width="98%">
							<font style="margin-left:2px">
								<xsl:value-of select="document/captions/properties/@caption"/>
							</font>
						</td>
						<td>
							<img id="propImg"  src="/SharedResources/img/classic/open.gif"/>
						</td>
					</tr>
				</table>

				<div display="block"  id="property"><br/>
					<table width="100%" border="0">
					<!--<tr>
						<td width="30%" class="fc">Исполнитель&#xA0;:</td>
						<td>
							<input type="text" name="execut" size="50" class="rof">
								 <xsl:if test="intexecut/@editmode!='edit'">
                                    <xsl:attribute name="readonly">readonly</xsl:attribute></xsl:if>
								<xsl:attribute name="value"><xsl:value-of select="intexecut"/></xsl:attribute>
							</input>
						</td>
					</tr>
						
					-->
						<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/executor/@caption"/><font style='color:#ff8141'>*</font>&#xA0;:
									<xsl:if test="document/@editmode ='edit'">
										<a href="">
											<xsl:attribute name="href">javascript:dialogBoxStructure('structure','false','intexecut','frm', 'intexecuttbl');</xsl:attribute>								
											<img src="/SharedResources/img/iconset/report_magnify.png"></img>
										</a>
									</xsl:if>
					
					</td>
					<td>
						<table id="intexecuttbl" width="380px"  style="border:1px solid #ccc">
							<tr>
								<td>
									<xsl:value-of select="document/fields/executor"/>&#xA0;
								</td>
							</tr>
						</table>
						<input type="hidden" id="executor" name="executor">					
							<xsl:attribute name="value"><xsl:value-of select="document/fields/executor/@attrval"/></xsl:attribute>
						</input>	
					</td>
							</tr>
					
					<!-- Дата исполнения -->
					<tr>
						<td class="fc"><xsl:value-of select="document/fields/finishdate/@caption"/> &#xA0;:</td>
						<td>
							<input type="text" name="finishdate"  id="finishdate" size="18" class="rof">
                                <xsl:attribute name="readonly">readonly</xsl:attribute>
								<xsl:attribute name="value"><xsl:value-of select="document/fields/finishdate"/></xsl:attribute>
							</input>							
						</td>
					</tr>
						
					
					<!--<tr>
						<td class="fc">Код&#xA0;:</td>							
						<td>
						<input type="text" name="ndelo"  id="ndelo" size="8" class="rof">
								<xsl:if test="dateisp/@editmode!='edit'">
                                    <xsl:attribute name="readonly">readonly</xsl:attribute></xsl:if>
								<xsl:attribute name="value"><xsl:value-of select="document/fields/ndelo"/></xsl:attribute>
							</input>	
						</td>
					</tr>
					<tr>
						<td class="fc">Номенклатура дел&#xA0;:</td>							
						<td>
						<input type="text" name="nomentype"  id="nomentype" size="40" class="rof">
								<xsl:if test="dateisp/@editmode!='edit'">
                                    <xsl:attribute name="readonly">readonly</xsl:attribute></xsl:if>
								<xsl:attribute name="value"><xsl:value-of select="document/fields/nomentype"/></xsl:attribute>
							</input>	
						</td>
					</tr>
					--><!-- Содержание отчета -->
					<tr>
						<td class="fc"><xsl:value-of select="document/fields/report/@caption"/> <font style='color:#ff8141'>*</font>&#xA0;:</td>							
						<td>
							<div>						
								<textarea  name="report" rows="10"  style="width:98%" onfocus="fieldOnFocus(this)" onblur="fieldOnBlur(this)" tabindex="1" class="rof">
								
									<xsl:if test="document/@editmode  !='edit'">
                                    	<xsl:attribute name="readonly">readonly</xsl:attribute>
                                    </xsl:if>
									<xsl:value-of select="document/fields/report" />
								</textarea>								
							</div>
						</td>
					</tr>
					
				
                        <xsl:if test="document/@status != 'new'">
									<tr>
										<td class="fc">
											<xsl:value-of select="document/fields/ndelo/@caption"/>&#xA0;:
										</td>
			            				<td>
                        					<input type="text" name="ndelo" size="10" class="rof">
                        						<xsl:if test="document/@editmode !='edit'">
                        							<xsl:attribute name="readonly">readonly</xsl:attribute>
                        						</xsl:if>
                            					<xsl:attribute name="value">
                            						<xsl:value-of select="document/fields/ndelo"/>
                            					</xsl:attribute>
                            				</input>
                        				</td>   					
									</tr>
								</xsl:if>
						
						<!-- Поле "Номенклатура дел" -->						
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/nomentype/@caption"/>&#xA0;: 
							</td>
							<td>
								<xsl:variable name="nomentype" select="document/fields/nomentype/@attrval"/>
								<select size="1" name="nomentype" style="margin-top:4px ;width:500px">
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
				 </table>
				 <br/>
				 </div>
				<input type="hidden" name="author" value=""> 
				<xsl:attribute name="value"><xsl:value-of select="document/fields/author/@attrval"/></xsl:attribute>
				</input> 
				<input type="hidden" name="type" value="save" />  
				<input type="hidden" name="id" value="ki" />
				<xsl:if test="document/@status!='new'">
					<input type="hidden" name="key">
						<xsl:attribute name="value"><xsl:value-of select="document/@docid" /></xsl:attribute>
					</input>
					</xsl:if>
				<input type="hidden" name="doctype">
					<xsl:attribute name="value"><xsl:value-of select="document/@doctype"/></xsl:attribute>
				</input>
				<input type="hidden" name="parentdocid">
					<xsl:attribute name="value"><xsl:value-of select="document/@parentdocid"/></xsl:attribute>
				</input>
				<input type="hidden" name="parentdoctype">
					<xsl:attribute name="value"><xsl:value-of select="document/@parentdoctype"/></xsl:attribute>
				</input>
				<input type="hidden" name="page">
						<xsl:attribute name="value"><xsl:value-of select="document/@openfrompage" /></xsl:attribute>
				</input>
				<xsl:if test="document/@status ='new'">
           			<input type="hidden" name="ndelo">
               			<xsl:attribute name="value">
               				<xsl:value-of select="document/fields/ndelo"/>
               			</xsl:attribute>
               		</input>
               	</xsl:if>
			  </form>
			 <form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
					<input type="hidden" name="type" value="rtfcontent" />
					<input type="hidden" name="formsesid">
						<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
					</input>
					<table width="100%" class="st">
						<xsl:attribute name="onselectstart">javascript: return false</xsl:attribute>
						<tr onClick="showHideForm('att','attImg')" onDblClick="showHideForm('att','attImg')" >
							<td  width="98%">
								<font style="margin-left:2px">
									<xsl:value-of select="document/captions/attachments/@caption"/>
								</font>
							</td>
							<td>
								<img id="attImg" src="/SharedResources/img/classic/open.gif"/>
							</td>
						</tr>
					</table>
					<div display="block" id="att">
						<br/>	
						<div id="attach" style="display:block;">
							<table style="border:0" id="upltable" width="100%">
								<xsl:if test="document/@editmode != 'readonly'">
									<tr>
										<td style="text-align:right" class="fc"><xsl:value-of select="document/captions/attachments/@caption"/>&#xA0;: </td>
										
										<td>
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
												<td ></td>
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
														<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid" />,'<xsl:value-of select='.'/>','<xsl:value-of select="$id"/>')</xsl:attribute>
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
											<td ></td>
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
	
	<!-- Функция запускающая получение view "хода исполнения" -->	
		<script>
			function onLoadActions(){
			$('docthread').innerHTML = '';		
			<xsl:if  test="@status!='new'">				
					var url = 'Provider';
					var pars = 'type=view&amp;id=responses&amp;key=<xsl:value-of select="$threaddocid"/>';
					var myAjax = new Ajax.Updater('docthread', url, {method: 'get', parameters: pars});											
			
			</xsl:if>
			}						
		     </script>		

	
	<!-- Область для размещения "хода исполнения" -->
            <xsl:if test="@status !='new'">
	             <table style="width:100%" class="st">
	             	<xsl:attribute name="onselectstart">javascript: return false</xsl:attribute>
         			 <tr onClick="showHideForm(docthread,docthreadImg)" onDblClick="showHideForm(docthread,docthreadImg)">
          				 <td width="98%">
           					<font style="width:25%">Ход исполнения </font>
           				</td>
           				<td>
           					<img id="docthreadImg"  src="sdimg/open.gif"/>
           				</td>
         			</tr>
         			</table>
         			<table>
          <tr>
             <td>
                    <a>	
		               <xsl:attribute name="href">Provider?type=document&amp;id=ki&amp;key=<xsl:value-of select="@docid"/></xsl:attribute>																		
		                 <img src="sdimg/refresh.gif" border="0" alt="обновить"/>
		           </a>
                           <div id="docthread" style="border-color:#6790b3; display:block">
                                             Загрузка хода исполнения...
                           </div>
           </td>
         </tr>
                </table>		
           </xsl:if>
			  <div style="position:absolute; margin-top:2%">
			  <hr  color="#CCCCCC"/>
			  <xsl:call-template name="authorrus"/>
			  <xsl:call-template name="authordep"/>
			  <div id="savemessage" style="display:none;position:absolute;left:20px;bottom:20px;border: 2px solid #6790b3;font-size:smaller;">
					Документ сохранен				
			  </div>
			  </div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>