<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:import href="../templates/docthread.xsl" />
	<xsl:variable name="doctype">
		Отчет
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
						новый
						
						 &#xA0;<xsl:value-of select="lower-case($doctype)" />  - 4ms workflow
					</title>
					
				</xsl:if>
				<xsl:call-template name="cssandjs" />
				<script type="text/javascript" src="/SharedResources/jquery/js/jhtmlarea/scripts/jHtmlArea-0.7.0.js"></script>
	    			<link rel="Stylesheet" type="text/css" href="/SharedResources/jquery/js/jhtmlarea/style/jHtmlArea.css" />
					<style type="text/css">
    					div.jHtmlArea .ToolBar ul li a.custom_disk_button 
    					{
    						background: url(images/disk.png) no-repeat;
      						background-position: 0 0;
    					}
    					div.jHtmlArea { border: solid 1px #ccc; }
   					</style>
				
				
				<xsl:call-template name="showdocthread" />
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
							$("textarea:not([readOnly]):first").focus();
						});
					</script>
					<script>
						$(function() {
							var dates = $( "#ctrldatefrom, #ctrldateto" ).datepicker({
							defaultDate: "+1w",
							changeMonth: true,
							numberOfMonths: 1,
							onSelect: function( selectedDate ) {
								var option = this.id == "ctrldatefrom" ? "minDate" : "maxDate",
								instance = $( this ).data( "datepicker" ),
								date = $.datepicker.parseDate(
								instance.settings.dateFormat ||
								$.datepicker._defaults.dateFormat,
								selectedDate, instance.settings );
								dates.not( this ).datepicker( "option", option, date );
								}
						});
						});
					</script>
					<script>
						$(function() {
							var dates = $( "#taskdatefrom, #taskdateto" ).datepicker({
							defaultDate: "+1w",
							changeMonth: true,
							numberOfMonths: 1,
							onSelect: function( selectedDate ) {
								var option = this.id == "taskdatefrom" ? "minDate" : "maxDate",
								instance = $( this ).data( "datepicker" ),
								date = $.datepicker.parseDate(
								instance.settings.dateFormat ||
								$.datepicker._defaults.dateFormat,
								selectedDate, instance.settings );
								dates.not( this ).datepicker( "option", option, date );
								}
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
					<span style=" vertical-align:12px; float:left">
						<xsl:call-template name="showxml"/>
						<xsl:if test="document/fields/allcontrol !=0">
							<xsl:if test="document/@editmode ='edit'">
								<xsl:call-template name="filling_report"/>
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
					<span style="float:right" class="bar_right_panel">
						<xsl:call-template name="cancel" />
					</span>
				</div>

				<!-- заголовок -->
				<div class="formtitle" style="display:inline">
					<table class="formtitle" width="100%">
						<tr>
							<td width="85%" >
								Отчет
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
				<br/>
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
					<div display="block"  id="property">
						<br/>
						<!-- Автор резолюции -->
						<table width="100%" border="0">
							<xsl:if test="document/@parentdocid = 0 and document/@status != 'new' ">
								<tr>
									<td class="fc">
										<font style="vertical-align:top">
											<xsl:value-of select="document/fields/taskvn/@caption"/> 
											&#xA0;: </font>
									</td>
									<td>
										<input type="text" id="taskvn" name="taskvn" readonly="readonly" width="200px">
											<xsl:attribute name="value"><xsl:value-of select="document/fields/taskvn"/></xsl:attribute>
										</input>
									</td>
								</tr>
							</xsl:if>
							<tr>
								<td class="fc">
									<font style="vertical-align:top">
										<xsl:value-of select="document/fields/taskauthor/@caption"/> 
										<font style='color:#ff8141'>*</font>&#xA0;: </font>
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
									<table id="taskauthortbl" width="600px"  style="border:1px solid #ccc">
										<tr><td><xsl:value-of select="document/fields/taskauthor"/>&#xA0;</td></tr>
									</table>
									<input type="hidden" id="taskauthor" name="taskauthor" >
									<xsl:attribute name="value"><xsl:value-of select="document/fields/taskauthor/@attrval"/></xsl:attribute>
									</input>
								</td>
							</tr>
							<!-- Дата резолюции -->
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/taskdate/@caption"/>&#xA0;:</td>
								<td>
									&#xA0;<label for="from">c</label>&#xA0;
									<input type="text" id="taskdatefrom" name="taskdatefrom" readonly="readonly">
										<xsl:attribute name="value"><xsl:value-of select="document/fields/taskdatefrom"/></xsl:attribute>
									</input>
									&#xA0;<label for="to">по</label>&#xA0;
										<input type="text" id="taskdateto" name="taskdateto"  readonly="readonly">
											<xsl:attribute name="value"><xsl:value-of select="document/fields/taskdateto"/></xsl:attribute>
										</input>
								</td>
							</tr>
							<!--  <tr>
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
									<table id="intexectbl" width="600px" >
										<xsl:if test="document/fields/executors/entry/user =''">
											<tr><td style="border:1px solid #ccc" ><xsl:value-of select="executor"/>&#xA0;</td></tr>
										</xsl:if>
										<xsl:if test="not(document/fields/executors/entry/user)">
											<tr><td style="border:1px solid #ccc" ><xsl:value-of select="executor"/>&#xA0;</td></tr>
										</xsl:if>
										<xsl:for-each select="document/fields/executors/entry">
											<tr><xsl:variable name="num" select="position()"/><td style="border:1px solid #ccc" ><xsl:value-of select="user"/>&#xA0;</td><td><xsl:if test="$num =1 and ../../../../document/@parentdocid = 0"><img src='/SharedResources/img/iconset/bullet_yellow.png' style='height:16px' title='ответственный'/></xsl:if></td></tr>
										</xsl:for-each>
									</table>
										<xsl:for-each select="document/fields/executors/entry">
										<input type="hidden"  name="executor">
											<xsl:attribute name="id">controlres<xsl:value-of select="position()"/></xsl:attribute>
											<xsl:attribute name="value"><xsl:value-of select="user/@attrval"/>`<xsl:value-of select="resetdate"/>`<xsl:value-of select="resetauthor/@attrval"/>`<xsl:value-of select="responsible"/></xsl:attribute>
										</input>	
										</xsl:for-each>
								</td>
							</tr>
							<xsl:if test="document/@parentdocid = 0 or document/fields/parenttasktype = 'TASK'">
								<tr>
									<td class="fc"><xsl:value-of select="document/captions/briefcontent/@caption"/>&#xA0;:</td>
									<td style="padding-top:5">
										<div>
											<textarea name="briefcontent" rows="2" cols="81"  tabindex="3" class="rof">
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
												<xsl:value-of select="document/fields/briefcontent" />
											</textarea>
										</div>
									</td>
								</tr>
							</xsl:if>-->
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/controltype/@caption"/>&#xA0;:</td>
								<td>
									<xsl:variable name="controltype" select="document/fields/controltype/@attrval"/>
									<select size="1" name="controltype" style="margin-top:4px">
										<xsl:if test="document/@editmode !='edit'">
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
							<!-- <tr>
								<td class="fc"><xsl:value-of select="document/fields/ctrldate/@caption"/>&#xA0;:</td>
								<td>
									<input type="text"  name="ctrldate" size="7" maxlength="10" class="rof">
											<xsl:if test="document/@editmode='edit'">
												<xsl:if test="document/fields/allcontrol != 0">
													<xsl:attribute name="id">ctrldate</xsl:attribute>
												</xsl:if>
											</xsl:if>
											
											<xsl:attribute name="value"><xsl:value-of select="document/fields/ctrldate" /></xsl:attribute>
									</input>
									
								</td>
							</tr> -->
							<tr>
								<td class="fc"><xsl:value-of select="document/fields/ctrldate/@caption"/>&#xA0;:</td>
								<td>
										&#xA0;<label for="from">c</label>&#xA0;
										<input type="text" id="ctrldatefrom" name="ctrldatefrom" readonly="readonly">
											<xsl:attribute name="value"><xsl:value-of select="document/fields/ctrldatefrom"/></xsl:attribute>
										</input>
										&#xA0;<label for="to">по</label>&#xA0;
										<input type="text" id="ctrldateto" name="ctrldateto"  readonly="readonly">
											<xsl:attribute name="value"><xsl:value-of select="document/fields/ctrldateto"/></xsl:attribute>
										</input>

									
								</td>
							</tr>
							 <tr>
								<td class="fc">Тип файла отчета&#xA0;:</td>
								<td>
									<table>
										<tr>
											<td>
												<input type="radio" name="typefilereport" value="1">
													<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
													<xsl:if test="document/@editmode !='edit'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/typefilereport  = '1'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/@status  = 'new'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													PDF
												</input>
											</td>
											<td>
												<input type="radio" name="typefilereport" value="2">
													<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
													<xsl:if test="document/@editmode !='edit'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/typefilereport  = '2'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													XLS
												</input>
											</td>
											<td>
												<input type="radio" name="typefilereport" value="3">
													<xsl:attribute name="onclick">javascript: reportsTypeCheck(this)</xsl:attribute>
													<xsl:if test="document/@editmode !='edit'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/typefilereport  = '3'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													HTML
												</input>
											</td>
										</tr>
									</table>
								</td>
							</tr>
							<tr>
								<td class="fc">Открыть отчет в&#xA0;:</td>
								<td>
									<table>
										<tr>
											<td> 
												<input type="radio" name="disposition" value="attachment">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/openreportwith  = 'attachment'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/@status  = 'new'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													нативном  приложении
												</input>
											</td>
											<td>
												<input type="radio" name="disposition" value="inline">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/openreportwith  = 'inline'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													окне браузера
												</input>
											</td>
										</tr>
									</table>
								</td>
							</tr> 
							 <!-- <tr>
								<td class="fc">Открыть отчет в&#xA0;:</td>
								<td>
									<table>
										<tr>
											<td>
												<input type="radio" name="openreportwith" value="1">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/openreportwith  = '1'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/@status  = 'new'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													нативном  приложении
												</input>
											</td>
											<td>
												<input type="radio" name="openreportwith" value="2">
													<xsl:if test="document/@editmode='noaccess'">
														<xsl:attribute name="disabled">disabled</xsl:attribute>
													</xsl:if>
													<xsl:if test="document/fields/openreportwith  = '2'">
														<xsl:attribute name="checked">checked</xsl:attribute>
													</xsl:if>
													окне браузера
												</input>
											</td>
										</tr>
									</table>
								</td>
							</tr> -->
							
							<!-- <tr>
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
							</tr> -->
							<!-- <tr>
								<td class="fc">Снять с контроля&#xA0;:</td>
								<td>
									<table id="intexectable" class="tablefield" style="width:750px" border="1">
										<tr>
											<td style="text-align:center; width:3%">№</td>
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
								</tr> -->
						</table>
					</div>
					 
					<!-- <table width="100%" class="st">
						<xsl:attribute name="onselectstart">javascript: return false</xsl:attribute>
						<tr>
							<xsl:attribute name="onclick">showHideForm('execution','executionImg'); showExecution(<xsl:value-of select="document/@parentdocid"/>, <xsl:value-of select="document/@parentdoctype"/>, <xsl:value-of select="document/@docid"/><xsl:value-of select="document/@doctype"/>)</xsl:attribute>
							<xsl:attribute name="onDblclick">showHideForm('execution','executionImg'); showExecution(<xsl:value-of select="document/@parentdocid"/>, <xsl:value-of select="document/@parentdoctype"/>, <xsl:value-of select="document/@docid"/><xsl:value-of select="document/@doctype"/>)</xsl:attribute>
							<td width="98%" >
								<font style="margin-left:2px">
									<xsl:value-of select="document/captions/progress/@caption"/>
								</font>
							</td>
							<td>
								<img id="executionImg"  src="/SharedResources/img/classic/close.gif"/>
							</td>
						</tr>
					</table>
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
						</div>     -->
						
					<!-- Скрытые поля -->
					<input type="hidden" name="isresol">
						<xsl:attribute name="value"><xsl:value-of select="isresol" /></xsl:attribute>
					</input>
					
					<input type="hidden" name="type" value="save" />
					<input type="hidden" name="id" value="kr" />
					<input type="hidden" name="author">
						<xsl:attribute name="value"><xsl:value-of select="document/fields/author/@attrval" /></xsl:attribute>
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
				<hr color="#CCCCCC" />
				<!-- <xsl:call-template name="authorrus" />
				<xsl:call-template name="authordep" /> -->
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>