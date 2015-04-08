<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/docthread.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:variable name="doctype">
		<xsl:value-of select="request/document/captions/doctypemultilang/@caption"/>
	</xsl:variable>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:variable name="threaddocid" select="document/@granddocid" />
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
			</head>
			<body>
    			
				
				
				<!-- панель акции -->
				
				<div class="bar">
					<span style="width:82%;">
			
		<!--		кнопка "сохранить как черновик"			-->	
				<xsl:if test="document/actions/action [.='SAVE_AS_DRAFT']/@enable = 'true'">
					<a style="vertical-align:12px">
						<xsl:attribute name="class">gray button form</xsl:attribute>
						<xsl:attribute name="href">javascript:savePrjAsDraft('<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
						<font>
							<xsl:value-of select="document/actions/action [.='SAVE_AS_DRAFT']/@caption"/>
						</font>
					</a>&#xA0;
				</xsl:if>
					
			<!--		кнопка "остановить документ"			-->
				
				<xsl:if test="document/actions/action [.='STOP_DOCUMENT']/@enable = 'true'">
					<a style="vertical-align:12px">
						<xsl:attribute name="class">gray button form</xsl:attribute>
						<xsl:attribute name="href">javascript:stopdocument('<xsl:value-of select="document/@docid"/>',<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
						<img src="/SharedResources/img/iconpage/page_delete.png" style="border:none"/>
						<font>
							<xsl:value-of select="document/actions/action [.='STOP_DOCUMENT']/@caption"/>
						</font>
					</a>&#xA0;
				</xsl:if>
						
			<!--		кнопка "отправить на подпись"			-->
				
					<xsl:if test="document/actions/action [.='SEND']/@enable = 'true'">
						<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:saveAndSend('<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='SEND']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
					
		<!--		кнопка "отправить на согласование"			-->
					<xsl:if test="document/actions/action [.='TO_COORDINATE']/@enable = 'true'">
						<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:saveAndCoord('<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='TO_COORDINATE']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
							
								
					<!--		кнопка "подписать"			-->	
					<xsl:if test="document/actions/action [.='SIGN_YES']/@enable = 'true'">
						<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:decision('yes','<xsl:value-of select="document/@docid" />','sign_yes','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='SIGN_YES']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
									
					<!--		кнопка "отклонить"			-->
					<xsl:if test="document/actions/action [.='SIGN_NO']/@enable = 'true'">
						<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:decision('no','<xsl:value-of select="document/@docid" />','sign_no','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='SIGN_NO']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
					
					<!--		кнопка "согласен"			-->
					<xsl:if test="document/actions/action [.='COORD_YES']/@enable = 'true'">
						<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:decision('yes','<xsl:value-of select="document/@docid" />','coord_yes','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='COORD_YES']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
									
					<!--		кнопка "не согласен"			-->		
					<xsl:if test="document/actions/action [.='COORD_NO']/@enable = 'true'">
						<a style="vertical-align:12px">
							a<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="href">javascript:decision('no','<xsl:value-of select="document/@docid" />','coord_no','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
							<font>
								<xsl:value-of select="document/actions/action [.='COORD_NO']/@caption"/>
							</font>
						</a>&#xA0;
					</xsl:if>
				</span>
				<span style="float:right">
			        		<!--		кнопка "закрыть"			-->
			     	<xsl:call-template name="cancel" />
			     </span>
						
			</div>
										
								<!-- заголовок -->	
												
					<table style="width:100%; border-collapse:collapse" class="formtitle">
						<tr>
							<td width="75%">
								<xsl:call-template name="doctitleprj"/>						
							</td>
							<td style="text-align:right">
								<font style="font-size:0.5em"><xsl:value-of select="document/fields/docversion/@caption"/>:&#xA0;<b><xsl:value-of select="document/fields/docversion"/></b></font>
								<font style="font-size:0.5em; font-style: arial; margin-left:10px;">
									<xsl:value-of select="document/fields/docstatus/@caption"/>статус :
								</font>
								
								<!--		статус согласования документа			-->
								
								<font style="font-size:0.5em; font-style: arial">
									<b> 
										<xsl:choose>
											<xsl:when test="document/fields/coordstatus='351'">
												<xsl:attribute name="title">Черновик</xsl:attribute>
												Черновик
											</xsl:when>
											<xsl:when test="document/fields/coordstatus='352'">
												<xsl:attribute name="title">Проект на согласовании</xsl:attribute>
												На согласовании
											</xsl:when>
											<xsl:when test="document/fields/coordstatus='353'">
												<xsl:attribute name="title">Проект прошел все этапы согласования</xsl:attribute>
												Согласованный
											</xsl:when>
											<xsl:when test="document/fields/coordstatus='354'">
												<xsl:attribute name="title">Проект был отклонен</xsl:attribute>
												Отклонен
											</xsl:when>
											<xsl:when test="document/fields/coordstatus='360'">
												<xsl:attribute name="title">Проект пересмотрен в новой редакции</xsl:attribute>
												Новая версия
											</xsl:when>	
											<xsl:when test="document/fields/coordstatus='355'">
												<xsl:attribute name="title">Проект ожидает подпись &#xA0;<xsl:value-of select="signerdisplay"/></xsl:attribute>
												Ожидает подпись
											</xsl:when>	
											<xsl:when test="document/fields/coordstatus='356'">
												<xsl:attribute name="title">Проект подписан &#xA0;<xsl:value-of select="signerdisplay"/></xsl:attribute>
												Подписан
											</xsl:when>	
											<xsl:when test="document/fields/coordstatus='357'">
												<xsl:attribute name="title">Проект подписан &#xA0;<xsl:value-of select="signerdisplay"/></xsl:attribute>
												Подписан
											</xsl:when>	
											<xsl:when test="coordstatus='358'">
												<xsl:attribute name="title">Проект не требует согласования</xsl:attribute>
												Не требующий согласования
											</xsl:when>	
											<xsl:when test="coordstatus='359'">
												<xsl:attribute name="title">Проект был просрочен во время согласования</xsl:attribute>
												Просрочен
											</xsl:when>																										
										</xsl:choose>
									</b>	
								</font>
							</td>
						</tr>
					</table>	
					<xsl:if test="document/@status !='new'">
						<xsl:if test="document/fields/regdocurl !=''">
							<table style="margin-top:10px">
								<tr>
									<td>
										<a href="" style="font-size:11px">
											<xsl:attribute name="href"><xsl:value-of select="replace(document/fields/regdocurl, 'amp;', '')"/></xsl:attribute>
											<xsl:value-of select="document/fields/regdocviewtext"/>
										</a>
									</td>
								</tr>
							</table>
						</xsl:if>		
					</xsl:if>	
																			
			<!-- Форма документа -->
			<br/>
					<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
						<div   id="property" >
							<table width="100%" border="0">
					
							<!--		кем будет подписан			-->
								<tr>
									<td class="fc">
										<font style="vertical-align:top">
											<xsl:value-of select="document/fields/signer/@caption"/>&#xA0;: 
										</font>
										<xsl:if test="document/@editmode= 'edit'">
											<a>
												<xsl:attribute name="href">javascript:dialogBoxStructure('signers','false','signer','frm', 'signertbl');</xsl:attribute>
												<img src="/SharedResources/img/iconset/report_magnify.png"></img>
											</a>
										</xsl:if>
									</td>
									<td>
										<table id="signertbl" width="500px"  style="border:1px solid #ccc">
											<xsl:if test="document/@status='new'">
												<tr>
													<td>
														<xsl:value-of select="signers/entry/signer"/>&#xA0;
													</td>
												</tr>
											</xsl:if>
											<xsl:for-each select="document/fields/coordblocks/entry">
												<xsl:if test="@type='327'">
													<tr>
														<td>
															<xsl:value-of select="signers/entry/user"/>&#xA0;
														</td>
													</tr>
												</xsl:if>
											</xsl:for-each>							
										</table>
										<xsl:for-each select="document/fields/coordblocks/entry">
											<xsl:if test="@type='327'">
												<input type="hidden" id='coordBlockSign' name="coordBlock">
													<xsl:attribute name="value"><xsl:value-of select="@num"/>`tosign`0`<xsl:value-of select="signers/entry/user/@attrval"/>`<xsl:value-of select="status"/></xsl:attribute>
												</input>
											</xsl:if>
										</xsl:for-each>
										<script>
											if ($("#signertbl tr").length &lt; 1){
												$("#signertbl").append("<tr><td>&#xA0;</td></tr>");
 											}
										</script>
									</td>
								</tr>
								
						<!--		вид доставки			-->
								
								<tr>
									<td class="fc">
										<xsl:value-of select="document/fields/deliverytype/@caption"/>&#xA0;: 
									</td>
									<td>
										<xsl:variable name="deliverytype" select="document/fields/deliverytype"/>
										<select size="1" name="deliverytype" style="margin-top:4px; width:500px">
											<xsl:if test="document/@editmode != 'edit'">
												<xsl:attribute name="disabled">disabled</xsl:attribute>
											</xsl:if>
											<xsl:for-each select="document/glossaries/deliverytype/query/entry">
												<option>
													<xsl:if test="$deliverytype = viewtext">
														<xsl:attribute name="selected">selected</xsl:attribute>
													</xsl:if>
													<xsl:value-of select="@viewtext"/>
												</option>
											</xsl:for-each>
										</select>	
										<xsl:if test="document/@editmode !='edit'">
											<input type="hidden" name="deliverytype">
												<xsl:attribute name="value">
													<xsl:value-of select="$deliverytype"/>
												</xsl:attribute>
											</input>
										</xsl:if>
									</td>
								</tr>
								
						<!-- Получатель -->
						
							
								<tr>
									<td class="fc"><xsl:value-of select="document/fields/recipients/@caption"/>&#xA0;: 
										<xsl:if test="document/@editmode= 'edit'">
											<a href="">
												<xsl:attribute name="href">javascript:dialogBoxStructure('corresp','true','recipient','frm', 'recipienttbl');</xsl:attribute>								
												<img src="/SharedResources/img/iconset/report_magnify.png"></img>		
											</a>
										</xsl:if>
									</td>
									<td>
										<table id="recipienttbl" width="500px">
											<xsl:for-each select="document/fields/recipients/entry">
												<tr>
													<td style="border:1px solid #ccc">
														<xsl:value-of select="user"/>&#xA0;
													</td>
												</tr>
											</xsl:for-each>
											<xsl:if test="not(document/fields/recipients[node()])"> 
												<xsl:attribute name="style">border:1px solid #ccc</xsl:attribute>
												<tr><td>&#xA0;</td></tr>
											</xsl:if>
										</table>
										<xsl:for-each select="document/fields/recipients/entry">
											<input type="hidden" id="recipient" name="recipient">
												<xsl:attribute name="value"><xsl:value-of select="user/@attrval"/></xsl:attribute>
											</input>	
										</xsl:for-each>
									</td>
								</tr>
						
						<!-- Папка -->	
											
								<tr>
									<td class="fc">
										<xsl:value-of select="document/fields/docfolder/@caption"/>&#xA0;:
									</td>
									<td>	
										<select size="1" name="docfolder" style="margin-top:4px">
											<xsl:if test="document/@editmode= 'noaccess'">
												<xsl:attribute name="disabled">true</xsl:attribute>
											</xsl:if>
											<option>БЕЗ НАЗВАНИЯ</option>
											<xsl:for-each select="_spravdocfolder/item">
												<xsl:if  test=".!=''">	
   										 			<option>
	   										 			<xsl:attribute name="value"><xsl:value-of select="."/></xsl:attribute>
	   										 			<xsl:if  test="../../docfolder/item =.">
   											 				<xsl:attribute name="selected">selected</xsl:attribute>
   										 				</xsl:if>
   										 				<xsl:value-of select="."/>   										 	
   										 			</option>
   												 </xsl:if>
   											</xsl:for-each>
   										</select>
   										<xsl:if test="document/@editmode !='edit'">
											<input type="hidden" name="docfolder">
												<xsl:attribute name="value">
													<xsl:value-of select="document/fields/docfolder/item"/>
												</xsl:attribute>
											</input>
										</xsl:if>								
									</td>
								</tr>	
						
						<!-- Краткое содержание -->
						
								<tr>
									<td class="fc">
										<xsl:value-of select="document/fields/briefcontent/@caption"/>&#xA0;:
									</td>
									<td style="padding-top:5">
										<div>						
											<textarea  name="briefcontent" rows="5"  class="rof" onfocus="fieldOnFocus(this)" onblur="fieldOnBlur(this)" tabindex="1" style="width:85%">
												<xsl:if test="document/@editmode= 'noaccess'">
													<xsl:attribute name="disabled">true</xsl:attribute>
												</xsl:if>	
										 		<xsl:if test="briefcontent/@editmode!='edit'">
                                    				<xsl:attribute name="readonly">readonly</xsl:attribute></xsl:if>
												<xsl:value-of select="document/fields/briefcontent" />
											</textarea>								
										</div>
										<xsl:if test="document/@editmode !='edit'">
											<input type="hidden" name="briefcontent">
												<xsl:attribute name="value">
													<xsl:value-of select="document/fields/briefcontent" />
												</xsl:attribute>
											</input>
										</xsl:if>	
									</td>
								</tr>
								
						<!-- Поле "Код" -->
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
                        						<xsl:if test="document/@editmode = 'edit'">
													<xsl:attribute name="onfocus">fieldOnFocus(this)</xsl:attribute>
													<xsl:attribute name="onblur">fieldOnBlur(this)</xsl:attribute>
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
								<font style="vertical-align:top">
									<xsl:value-of select="document/fields/nomentype/@caption"/>&#xA0;: 
								</font>
								<xsl:if test="document/@editmode ='edit'">
									<a href="">
										<xsl:attribute name="href">javascript:dialogBoxStructure('n','false','nomentype','frm', 'nomentypetbl');</xsl:attribute>								
										<img src="/SharedResources/img/iconset/report_magnify.png"></img>			
									</a>
								</xsl:if>
							</td>
							<td>
								<table id="nomentypetbl" width="500px;" style="border:1px solid #ccc;">
									<xsl:attribute name="title"><xsl:value-of select="document/fields/nomentype"/></xsl:attribute>
									<tr>
										<td>
											<xsl:value-of select="document/fields/nomentype"/>&#xA0;
										</td>
									</tr>
								</table>
								<input type="hidden" id="nomentype" name="nomentype">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/nomentype/@attrval"/>
									</xsl:attribute>
								</input>
							</td>
						</tr>
						<!--Дополнительно -->
						
								<tr>
									<td class="fc"><xsl:value-of select="document/captions/more/@caption"/>&#xA0;:</td>							
									<td style="padding-top:5">
										<input type="checkbox" name="autosendtosign" id="autosendtosign">	
											<xsl:if test="document/@editmode= 'noaccess'">
												<xsl:attribute name="disabled">true</xsl:attribute>
											</xsl:if>
											<xsl:if test="document/@status ='new'">												
												<xsl:attribute name="value">1</xsl:attribute>
											</xsl:if>
											<xsl:if  test="document/fields/autosendtosign = '1'">
												<xsl:attribute name="checked">checked</xsl:attribute>
												<xsl:attribute name="value">1</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="document/fields/autosendtosign/@caption"/>												
										</input>
										<br/>
										<input type="checkbox" name="autosendaftersign" id="autosendaftersign">	
											<xsl:if test="document/@editmode= 'noaccess'">
												<xsl:attribute name="disabled">true</xsl:attribute>
											</xsl:if>													
											<xsl:if test="document/@status ='new'">												
												<xsl:attribute name="value">1</xsl:attribute>
											</xsl:if>
											<xsl:if  test="document/fields/autosendaftersign = '1'">
												<xsl:attribute name="checked">checked</xsl:attribute>
												<xsl:attribute name="value">1</xsl:attribute>
											</xsl:if>
											<xsl:value-of select="document/fields/autosendaftersign/@caption"/>														
										</input>
									</td>
								</tr>						
							</table>
							<br/>
						</div>
						<!-- Секция содержание  -->
						
						<div display="block"  id="content">
						
						<!-- Содержание -->
							<table style="width:100%">
								<tr>
									<td class="fc"><xsl:value-of select="document/fields/contentsource/@caption"/>&#xA0;:</td>
									<td>
										<textarea id="txtDefaultHtmlArea" name="contentsource"  rows="25" style="width:85%" >
											<xsl:call-template name="htmltagfindanddelete">
												<xsl:with-param name="string"><xsl:value-of select="document/fields/contentsource" />
												</xsl:with-param>
											</xsl:call-template>
										</textarea>
									</td>
								</tr>
							</table>
							<br/>
						</div>
					
					<!--	секция	"согласование"			-->
					
					<div display="block"  id="coord"><br/>
					
					<!--		кнопки "добавить" и "удалить" блок согласования			-->
					
						<xsl:if test="document/@editmode= 'edit'">
							<xsl:if test="document/fields/coordstatus = 351">
									<table>
										<tr>
											<td>
												<a class="gray button form" href="javascript:addCoord()">
													<font style="vertical-align: 5px; margin-left:5px"><xsl:value-of select="document/captions/addblock/@caption"/></font>
												</a>
											</td>
											<td>
												&#xA0;&#xA0;<a class="gray button form" href="javascript:delCoord()">
													<font style="vertical-align: 5px; margin-left:5px"><xsl:value-of select="document/captions/removeblock/@caption"/></font>
												</a>
											</td>
										</tr>
									</table>
									<br/>
								</xsl:if>
						</xsl:if>
						
						<!--		таблица отображения блоков согласования			-->
							
						<table id="coordTableView" style="border-collapse:collapse; width:97%">
							<tr class="thcoord"  style="text-align:center; background-color:#dde0ec; ">
								<td width="1%"><input type="checkbox" id="allchbox" onClick="checkAll(this);"/></td>
								<td width="2%">№</td>
								<td width="12%"><xsl:value-of select="document/captions/type/@caption"/></td>
								<td width="48%"><xsl:value-of select="document/captions/contributors/@caption"/></td>
								<td width="11%"><xsl:value-of select="document/captions/waittime/@caption"/></td>
								<td width="19%"><xsl:value-of select="document/captions/statuscoord/@caption"/></td>
							</tr>
							<xsl:for-each select="document/fields/coordblocks/entry">
								<xsl:if test="@type !=327">
								<tr class="trblockCoord">
								<td style="border-bottom: 1px solid lightgray">
									<input type="checkbox" name="chbox" >
										<xsl:attribute name="id">
											<xsl:value-of select="position()"/>
										</xsl:attribute>
									</input>
									<xsl:for-each select="coordinators/entry">
										<br/>
									</xsl:for-each>
								</td>
								<td style="text-align:center; border-bottom: 1px solid lightgray">
									<xsl:value-of select="position()"/>
									<xsl:for-each select="coordinators/entry">
										<br/>
									</xsl:for-each>
								</td>
								<td style="border-bottom: 1px solid lightgray; text-align:center">
									<xsl:choose>
										<xsl:when test="@type=328">
										  <xsl:value-of select="../../../../document/captions/parcoord/@caption"/>
										</xsl:when>
										<xsl:when test="@type=329">
											<xsl:value-of select="../../../../document/captions/sercoord/@caption"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="../../../../document/captions/typenotdefined/@caption"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="coordinators/entry">
										<br/>
									</xsl:for-each>
								</td>
								<td style="border-bottom: 1px solid lightgray">
									<table>
										
									<xsl:for-each select="coordinators/entry">
									<tr>
										<td style="text-align:right"><xsl:value-of select="user"/> - </td>
										<td></td>
										<td>
										<xsl:choose>
											<xsl:when test="decision=341">
												<xsl:value-of select="../../../../../../document/captions/agree/@caption"/>
											</xsl:when>
											<xsl:when test="decision=342">
												<xsl:value-of select="../../../../../../document/captions/disagree/@caption"/>
											</xsl:when>	
											<xsl:otherwise>
												<xsl:value-of select="../../../../../../document/captions/awairesponse/@caption"/>
											</xsl:otherwise>			
										</xsl:choose>
										</td>
										<td>
											<xsl:choose>
												<xsl:when test="string-length(comment) &lt; 20">
													<xsl:if test="string-length(comment)!= 0">
														 , Комментарий: <xsl:value-of select="comment"/>
													</xsl:if>
												</xsl:when>
												<xsl:when test="string-length(comment) &gt; 20">
													<a href="">
														<xsl:attribute name="href">javascript:dialogMsg("messagecomment")</xsl:attribute>
														комментарий
													</a>
													<input type="hidden" id="messagecomment">
														<xsl:attribute name="value">
															<xsl:value-of select='comment'/>
														</xsl:attribute>
													</input>
												</xsl:when>
											</xsl:choose>
										</td>
										</tr>
									</xsl:for-each>
									
									</table>						
								</td>
								<td style="border-bottom: 1px solid lightgray; text-align:center">
									<xsl:choose>
										<xsl:when test="delaytime = 0">
											<xsl:value-of select="../../../../document/captions/unlimtimecoord/@caption"/>
										</xsl:when>
										<xsl:otherwise>
											<xsl:value-of select="delaytime"/>
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="coordinators/entry">
										<br/>
									</xsl:for-each>
								</td>
								<td style="border-bottom: 1px solid lightgray; text-align:center">
									
									<xsl:choose>
										<xsl:when test="status =365">
											<xsl:value-of select="../../../../document/captions/oncoordinating/@caption"/>
										</xsl:when>
										<xsl:when test="status =366">
											<xsl:value-of select="../../../../document/captions/complete/@caption"/>
										</xsl:when>
										<xsl:when test="status =367">
											<xsl:value-of select="../../../../document/captions/expectbegincoord/@caption"/>
										</xsl:when>
										<!--<xsl:when test="status =366">
											Ожидает согласования
										</xsl:when>
										--><xsl:otherwise>
											Не определен
										</xsl:otherwise>
									</xsl:choose>
									<xsl:for-each select="coordinators/entry">
										<br/>
									<input type="hidden">
										<xsl:attribute name="value"><xsl:value-of select="user/@attrval"/></xsl:attribute>
										<xsl:attribute name="class"><xsl:value-of select="user/@attrval"/></xsl:attribute>
									</input>
									</xsl:for-each>
									<input type="hidden" name="coordBlock" >
										<xsl:attribute name="value"><xsl:value-of select="@num"/>`<xsl:choose><xsl:when test="@type=328">par</xsl:when><xsl:when test="@type=329">ser</xsl:when></xsl:choose>`<xsl:value-of select="delaytime"/>`<xsl:for-each select="coordinators/entry"><xsl:value-of select="user/@attrval"/><xsl:if test="following-sibling::*">^</xsl:if></xsl:for-each>`<xsl:value-of select="status"/></xsl:attribute>
									</input>
									
								</td>
							</tr>	
							</xsl:if>
							</xsl:for-each>
							
						</table>
					<br/>
				</div>
							<!-- Скрытые поля  для сохранения формы-->	
											
				<xsl:for-each select="document/fields/coordblocks/entry">
					<xsl:if test="@type='327'">
						<input type="hidden" id='signer' >
							<xsl:attribute name="value"><xsl:value-of select="signers/entry/user/@attrval"/></xsl:attribute>
						</input>
					</xsl:if>
				</xsl:for-each>							
				<input type="hidden" name="type" value="save" />  
				<input type="hidden" name="id" value="outdocprj" />
				<input type="hidden" name="key">
					<xsl:attribute name="value"><xsl:value-of select="document/@docid"/></xsl:attribute>
				</input>
				<input type="hidden" name="projectdate">
					<xsl:attribute name="value"><xsl:value-of select="document/fields/projectdate"/></xsl:attribute>
				</input>
				<input type="hidden" name="coordstatus" id="coordstatus">
					<xsl:attribute name="value"><xsl:value-of select="document/fields/coordstatus"/></xsl:attribute>
				</input>  	
				<input type="hidden" name="docversion" id="docversion">
					<xsl:attribute name="value"><xsl:value-of select="document/fields/docversion"/></xsl:attribute>
				</input>  	
				<input type="hidden" name="action" id="action"/>  				
			</form>	
			
			<!--		секция "вложения"		-->
				
			<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
					<input type="hidden" name="type" value="rtfcontent" />
					<input type="hidden" name="formsesid">
						<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
					</input>
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
		<div style="margin-top:5%">
			<hr  color="#CCCCCC"/>				
			<xsl:call-template name="authorrus"/>	
			<xsl:call-template name="authordep"/>
		</div>
		<table style="display:none" id="extraCoordTable">
		</table>
		<table style="display:none" id="notesTable">
			<tr></tr>
		</table>
	</body>
</html>
</xsl:template>
</xsl:stylesheet>