<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl" />
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:variable name="doctype" select="request/document/captions/addressee/@caption"/>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="editmode" select="/request/document/@editmode"/>
	<xsl:variable name="status" select="/request/document/@status"/>
	<xsl:output method="html" encoding="utf-8" doctype-public="-//W3C//DTD XHTML 1.0 Transitional//EN"
		doctype-system="http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd" indent="yes"/>
	<xsl:variable name="skin" select="request/@skin"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="concat('Expo Контроль доступа - ',document/fields/title)"/>
				</title>
				<xsl:call-template name="cssandjs"/>
				<script type="text/javascript">
					$(document).ready(function(){hotkeysnav()})
   					<![CDATA[
   						function hotkeysnav() {
							$(document).bind('keydown', function(e){
			 					if (e.ctrlKey) {
			 						switch (e.keyCode) {
									   case 66:
									   		<!-- клавиша b -->
									     	e.preventDefault();
									     	$("#canceldoc").click();
									      	break;
									   case 83:
									   		<!-- клавиша s -->
									     	e.preventDefault();
									     	$("#btnsavedoc").click();
									      	break;
									   case 85:
									   		<!-- клавиша u -->
									     	e.preventDefault();
									     	window.location.href=$("#currentuser").attr("href")
									      	break;
									   case 81:
									   		<!-- клавиша q -->
									     	e.preventDefault();
									     	window.location.href=$("#logout").attr("href")
									      	break;
									   case 72:
									   		<!-- клавиша h -->
									     	e.preventDefault();
									     	window.location.href=$("#helpbtn").attr("href")
									      	break;
									   default:
									      	break;
									}
			   					}
							});
							$("#canceldoc").hotnav({keysource:function(e){ return "b"; }});
							$("#btnsavedoc").hotnav({keysource:function(e){ return "s"; }});
							$("#currentuser").hotnav({ keysource:function(e){ return "u"; }});
							$("#logout").hotnav({keysource:function(e){ return "q"; }});
							$("#helpbtn").hotnav({keysource:function(e){ return "h"; }});
						}
					]]>
				</script>
				<xsl:if test="document/@editmode = 'edit'">
					<script>
						var _calendarLang = "<xsl:value-of select="/request/@lang"/>";
						$(function() {
							$('#birthdate, #regdate').datepicker({
								showOn: 'button',
								buttonImage: 'classic/img/event_grey_30.png',
								buttonImageOnly: true,
								regional:['ru'],
								showAnim: '',
								changeYear : true,
								changeMonth : true,
								monthNames: calendarStrings[_calendarLang].monthNames,
								monthNamesShort: calendarStrings[_calendarLang].monthNamesShort,
								dayNames: calendarStrings[_calendarLang].dayNames,
								dayNamesShort: calendarStrings[_calendarLang].dayNamesShort,
								dayNamesMin: calendarStrings[_calendarLang].dayNamesMin,
								weekHeader: calendarStrings[_calendarLang].weekHeader,
								yearSuffix: calendarStrings[_calendarLang].yearSuffix,
								yearRange: '-100y:+0y',
								maxDate : 0
							});
						});
					</script>
				</xsl:if>
			</head>
			<body>
				<div id="docwrapper">
					<xsl:call-template name="documentheader"/>	
					<div class="formwrapper">
						<div class="formtitle">
							<div class="title" style="font-size:29px; color:#444344">
								Посетитель  - <xsl:value-of select="concat(document/fields/surname,' ',document/fields/name,' ', document/fields/patronymic)"/>
							</div>
						</div>
						<div class="button_panel">
							<span style="float:left">
								<xsl:call-template name="showxml"/>
								<xsl:call-template name="save"/>
							</span>
							<span style="float:right; margin-right:5px">
								<xsl:call-template name="cancel"/>
							</span>
						</div>
						<div style="clear:both"/>
						<div style="-moz-border-radius:0px; height:1px; width:100%; margin-top:10px;"/>
						<div style="clear:both"/>
						<div id="tabs">
							<ul class="ui-tabs-nav ui-helper-reset ui-helper-clearfix ui-widget-header ui-corner-all">
								<li class="ui-state-default ui-corner-top">
									<a href="#tabs-1">
										<xsl:value-of select="document/captions/properties/@caption"/>
									</a>
								</li>
							</ul>
							<div class="ui-tabs-panel" id="tabs-1">
								<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
									<div display="block" id="property">
										<br/>
										
										<table width="80%" border="0">
											<tr>
												<td rowspan="9" style="width:190px; min-width:190px; vertical-align:top">
													<div style="width:190px;  max-height:190px; vertical-align:top; margin-left:30px; display:inline-block; cursor:pointer">
														<xsl:attribute name="onclick">javascript:$("#fileInput").click()</xsl:attribute>
														<xsl:variable name='id' select='document/fields/rtfcontent/entry/@hash'/>
														<xsl:variable name='filename' select='document/fields/rtfcontent/entry/@filename'/>
														<xsl:variable name="resolution"/>
														<xsl:variable name='formsesid' select="formsesid"/>
														<xsl:attribute name='id' select="$id"/>
														<xsl:if test="document/fields/rtfcontent/entry/@filename !=''">
															<img id="photoid" class="imgAtt" style="border:1px solid #ccc; max-width:190px; max-height:190px;">
																<xsl:attribute name="title">Изменить фото посетителя</xsl:attribute>
																<xsl:attribute name="onload">checkImage(this)</xsl:attribute>
																<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="document/@doctype"/>&amp;key=<xsl:value-of select="document/fields/rtfcontent/entry/@id"/>&amp;field=rtfcontent&amp;id=rtfcontent&amp;id=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
															</img>
														</xsl:if>
														<xsl:if test="not(document/fields/rtfcontent/entry)">
															<img id="photoid" class="imgAtt" style="border:1px solid #ccc; max-width:190px; max-height:190px;">
																<xsl:attribute name="title">Изменить фото посетителя</xsl:attribute>
																<xsl:attribute name='src'>classic/img/no_photo_user.png</xsl:attribute>
															</img>
														</xsl:if>
														
													</div>
												</td>
												<td width="30%" class="fc">№ ID  :</td>
												<td>
													<input type="text" name="personalid" value="{document/fields/personalid}" size="50" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/surname/@caption"/> :</td>
												<td>
													<input type="text" name="surname" value="{document/fields/surname}" size="50" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/name/@caption"/> :</td>
												<td>
													<input type="text" name="name" value="{document/fields/name}" size="50" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/patronymic/@caption"/> :</td>
												<td>
													<input type="text" name="patronymic" value="{document/fields/patronymic}" size="50" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/birthdate/@caption"/> :</td>
												<td>
													<input type="text" id="birthdate" name="birthdate" value="{substring(document/fields/birthdate,1,10)}" class="td_editable" readonly="readonly" style="width:64px; vertical-align:top">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/regdate/@caption"/> :</td>
												<td>
													<input type="text" id="regdate" name="regdate" value="{substring(document/fields/regdate,1,10)}" class="td_editable" readonly="readonly" style="width:64px; vertical-align:top">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/sex/@caption"/> :</td>
												<td>
													<select name="sex" style="width:120px" class="select_editable">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">select_noteditable</xsl:attribute>
														</xsl:if>
														<option value="1">
															<xsl:if test="document/fields/sex = '1'">
																<xsl:attribute name="selected" select="'selected'"/>
															</xsl:if>
															Мужской
														</option>
														<option value="0">
															<xsl:if test="document/fields/sex = '0'">
																<xsl:attribute name="selected" select="'selected'"/>
															</xsl:if>
															Женский
														</option>
													</select>
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/citizenship/@caption"/> :</td>
												<td>
													<select name="citizenship" class="select_editable" style="width:500px" autocomplete="off">
														<xsl:for-each select="document/glossaries/citizenship/query/entry">
															<option value="{@docid}">
																<xsl:if test="/request/document/fields/citizenship = @docid">
																	<xsl:attribute name="selected">selected</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="viewcontent/viewtext1"/>
															</option>
														</xsl:for-each>
													</select>
													<!-- <input type="text" name="citizenship" value="{document/fields/citizenship}" size="50" class="td_editable" style="width:400px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input> -->
												</td>
											</tr>
											<tr>
												<td width="30%" class="fc"><xsl:value-of select="document/captions/rfid/@caption"/> :</td>
												<td>
													<input type="text" name="rfid" value="{document/fields/rfid}" size="50" class="td_editable" style="width:600px">
														<xsl:if test="$editmode != 'edit'">
															<xsl:attribute name="readonly">readonly</xsl:attribute>
															<xsl:attribute name="class">td_noteditable</xsl:attribute>
														</xsl:if>
													</input>
												</td>
											</tr>
											<!-- поле "Выбор объекта" -->
										<tr>
											<td class="fc" colspan="2" style="vertical-align:top">
												<font style="vertical-align:top">
													<xsl:value-of select="document/captions/objectswhichacces/@caption"/> :
												</font>
												<xsl:if test="$editmode = 'edit'">
													<img src="classic/img/add_box_grey_24.png" style="cursor:pointer; vertical-align:top">
														<xsl:attribute name="onclick">javascript:dialogBoxStructure('objects','true','object','frm', 'objecttbl');</xsl:attribute>
													</img>
												</xsl:if>
											</td>
											<td>
												<table id="objecttbl" style="border-spacing:0px 3px; margin-top:-3px">
													<xsl:if test="not(document/fields/objects)">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																&#xA0;
															</td>
														</tr>
													</xsl:if>
													<xsl:for-each select="document/fields/objects">
														<tr>
															<td style="width:600px;" class="td_editable">
																<xsl:if test="$editmode != 'edit'">
																	<xsl:attribute name="class">td_noteditable</xsl:attribute>
																</xsl:if>
																<xsl:value-of select="."/>&#xA0;
															</td>
														</tr>
													</xsl:for-each>
												</table>
												<xsl:for-each select="document/fields/objects">
													<input type="hidden" value="{./@attrval}" name="object"/>
												</xsl:for-each>
												<input type="hidden" id="objectcaption" value="{document/captions/objectswhichacces/@caption}"/>
											</td>
										</tr>
										</table>
									</div>
									<input type="hidden" name="type" value="save"/>
									<input type="hidden" name="parentdocid" value="{document/@parentdocid}"/>
									<input type="hidden" name="parentdoctype" value="{document/@parentdoctype}"/>
									<input type="hidden" name="id" value="visitor"/>
									<input type="hidden" name="key" value="{document/@docid}"/>
									<input type="hidden" name="char_enc" value="UTF-8"/>
								</form>
							</div>
							<div id="attach" style="display:none;">
							<form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data">
								<table style="border:0; border-collapse:collapse" id="upltable" width="99%">
									<xsl:if test="$editmode = 'edit'">
										<tr>
											<td class="fc">
												<xsl:value-of select="document/captions/attachments/@caption"/>:
											</td>
											<td>
												<input type="file" size="60" border="#CCC" name="fname" id="fileInput">
													<xsl:attribute name="onchange">javascript:submitPhoto('upload', 'upltable', 'fname'); ajaxFunction()</xsl:attribute>
												</input>&#xA0;
												<br/>
											</td>
											<td></td>
										</tr>
									</xsl:if>
								</table>
								<input type="hidden" name="type" value="rtfcontent"/>
								<input type="hidden" name="formsesid" value="{formsesid}"/>
							</form>
			<br/>
			<br/>
		</div>
						</div>
						<div style="height:10px"/>
					</div>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>