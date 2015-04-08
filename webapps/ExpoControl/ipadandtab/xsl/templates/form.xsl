<?xml version="1.0" encoding="windows-1251"?>
	<!-- 
SmartDoc v. 1.2
Набор шаблонов для форм
Copyright F labs's (c) 
Author Kairat 
-->
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<!-- Тип документа -->
	<xsl:template name="doctitle">
		<xsl:value-of select="$doctype" />
		&#xA0;
		<xsl:value-of select="document/fields/vn" />
		&#xA0;<xsl:value-of select="document/fields/dvn/@caption" />&#xA0;
		<xsl:value-of select="document/fields/dvn" />
	</xsl:template>
	
	<xsl:template name="doctitleprj">
		<xsl:value-of select="$doctype" />
		&#xA0;
		<xsl:value-of select="document/fields/vn" />
		&#xA0;<xsl:value-of select="document/fields/projectdate/@caption"/>&#xA0;
		<xsl:value-of select="document/fields/projectdate" />
	</xsl:template>

	<!-- Набор javascript библиотек -->
	<xsl:template name="cssandjs">
		<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/main_vertical.css"/>
		<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/form_vertical.css"/>
		<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/form.css"/>
		<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/main.css"/>
		<link rel="stylesheet" href="ipadandtab/css/actionbar.css" />
		<link rel="stylesheet" href="ipadandtab/css/dialogs.css" />
		<link type="text/css" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" rel="stylesheet" />
		<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/urlEncode.js" ></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js./ui/jquery.ui.resizable.js"></script>
		<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"></script>
		<script language="javascript" src="ipadandtab/scripts/form.js"></script>
		<script language="javascript" src="ipadandtab/scripts/coord.js"></script>
		<script language="javascript" src="ipadandtab/scripts/dialogs.js"></script>
		<script language="javascript" src="ipadandtab/scripts/outline.js"></script>
	</xsl:template>
	<xsl:template name="doctitleBoss">
		<font><xsl:value-of select="$doctype"/> - <xsl:value-of select="document/fields/fullname"/></font>	
	</xsl:template>
	<!-- Тип документа (для задании) -->
	<xsl:template name="isresol">
		<xsl:choose>
			<xsl:when test="document/fields/tasktype='RESOLUTION'">
				<xsl:value-of select="document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="document/fields/parenttasktype=''">
				<xsl:value-of select="document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="not (document/fields/tasktype)  and  document/@parentdocid != '' and document/@parentdoctype != 897 and  document/@parentdocid != 0">
				<xsl:value-of select="document/captions/kr/@caption"/>
			</xsl:when>
			<xsl:when test="document/@parentdocid = 0">
				<xsl:value-of select="document/captions/task/@caption"/>
			</xsl:when>
			<xsl:otherwise>
				<xsl:value-of select="document/captions/kp/@caption"/>
			</xsl:otherwise>
		</xsl:choose>
		
		&#xA0;<xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
		<xsl:value-of select="document/fields/taskdate" />
	</xsl:template>
	
	<!-- Поле "Автор документа" -->
	<xsl:template name="authorrus">
		<div style="position:absolute;  font-size:15px; color:#0857A6; right:2%; margin-top:2px">
			<xsl:value-of select="document/fields/author/@caption"/>:
			<xsl:value-of select="document/fields/author" />
		</div>
		<br></br>
	</xsl:template>
	
	<xsl:template name="authordep">
		<div style="position:absolute; font-size:14px; color:#0857A6; right:2%; margin-top:2px">
			<b><xsl:value-of select="document/fields/authordep" /></b>
		</div>
	</xsl:template>
	
	<xsl:template name="markisread">
		<xsl:if test="document/@isread = 0">
			<script>
				markRead(<xsl:value-of select="document/@doctype"/>, <xsl:value-of select="document/@docid"/>);
			</script>
		</xsl:if>
	</xsl:template>
	
	
	<xsl:template name="attach">
		<div id="attach" style="display:block;">
			<table style="border:0; border-collapse:collapse" id="upltable" width="99%">
				<xsl:if test="document/@editmode != 'readonly'">
					<tr>
						<td class="fc">
							<xsl:value-of select="document/captions/attachments/@caption" />
							&#xA0;:
						</td>
						<td>
							<input type="file" size="50" border="#CCC" name="fname" />
							&#xA0;
							<a id="upla">
								<xsl:attribute name="href">javascript:submitFile('upload', 'upltable', 'fname')</xsl:attribute>
								<font style="font-size:13px">
									<xsl:value-of select="document/captions/attach/@caption" />
								</font>
							</a>
						</td>
						<td></td>
					</tr>
				</xsl:if>
				<xsl:variable name='docid' select="document/@docid" />
				<xsl:variable name='doctype' select="document/@doctype" />
				<xsl:variable name='formsesid' select="formsesid" />
				<xsl:choose>
					<xsl:when test="document/fields/rtfcontent/@islist = 'true'">
						<xsl:for-each select="document/fields/rtfcontent/entry">
							<tr>
								<xsl:variable name='id' select='position()' />
								<xsl:variable name='filename' select='.'/>
								<xsl:variable name="extension" select="tokenize(lower-case($filename), '\.')[last()]" />
								<xsl:variable name="resolution">
									<script>
										return $(document).width();
									</script>
								</xsl:variable>
								<xsl:attribute name='id'>
									<xsl:value-of select='$id' />
								</xsl:attribute>
								<td class="fc"></td>
								<td colspan="2" >
									<div class="test" style="width:90%; overflow:hidden; display:inline-block">
									
									<xsl:choose>
										<xsl:when test="$extension = 'jpg' or $extension = 'jpeg' or $extension = 'gif'
										 or $extension = 'bmp' or $extension = 'png' or $extension = 'tif'">
											<img class="imgAtt">
												<xsl:attribute name="onload">checkImage(this)</xsl:attribute>
												<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
												<xsl:attribute name='title' select='$filename'/>
												<script>
													$(".imgAtt").attr("css","max-width:200px")
												</script>
											</img>
											<a href='' style="vertical-align:top; margin-left:8px">
												<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid" />,'<xsl:value-of select='.' />','<xsl:value-of select="$id" />')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:10px; height:10px" />
											</a>
										</xsl:when>
										<xsl:when test="$extension = 'txt'">
											<xsl:variable name='rtfid'>rtftext<xsl:value-of select="$id"/></xsl:variable>
											<a>
												<xsl:attribute name='id' select="$rtfid"/>
												<xsl:attribute name='title' select="$filename"/>
												<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
											</a>
											<script>
												$.ajax({
													type: "GET",
													url: "Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/>",
													success: function(response){
														$("#<xsl:value-of select="$rtfid"/>").attr("innerHTML", (response.length > 300) ? response.substr(0, 298)+"...":response);
													}
												});
											</script>
										</xsl:when>
										<xsl:otherwise>
											<img src="" style="margin-right:5px">
												<xsl:attribute name="src">/SharedResources/img/iconset/file_extension_<xsl:value-of select="$extension"/>.png</xsl:attribute>
												<xsl:attribute name="onerror">javascript:changeAttIcon(this)</xsl:attribute>
											</img>
											<a style="vertical-align:5px">
												<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/>	</xsl:attribute>
												<xsl:value-of select='$filename'/>
											</a>
											&#xA0;&#xA0;
											<a href='' style="vertical-align:5px">
												<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid" />,'<xsl:value-of select='.' />','<xsl:value-of select="$id" />')</xsl:attribute>
												<img src="/SharedResources/img/iconset/cross.png" style="width:10px; height:10px" />
											</a>
										</xsl:otherwise>
									</xsl:choose>
									</div>
								</td>
							</tr>
						</xsl:for-each>
					</xsl:when>
					<xsl:when test="document/fields/rtfcontent !=''">
						<xsl:variable name="filename" select="document/fields/rtfcontent" />
						<tr>
							<xsl:variable name='id' select='position()' />
							<xsl:attribute name='id'><xsl:value-of select='$id' /></xsl:attribute>
							<xsl:variable name="extension" select="tokenize(lower-case($filename), '\.')[last()]" />
							<td class="fc"></td>
							<td>
								<xsl:choose>
									<xsl:when test="$extension = 'jpg' or $extension = 'jpeg' or $extension = 'gif'
									 or $extension = 'bmp' or $extension = 'png' or $extension = 'tif'">
										<img style="max-width:900px; width:85%">
											<xsl:attribute name="onload">checkImage(this)</xsl:attribute>
											<xsl:attribute name='src'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
											<xsl:attribute name='title' select='$filename'/>
										</img>
										<a href='' style="vertical-align:top; margin-left:8px;">
											<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid" />,'<xsl:value-of select='$filename' />','<xsl:value-of select="$id" />')</xsl:attribute>
											<img src="/SharedResources/img/iconset/cross.png" style="width:10px; height:10px" />
										</a>
									</xsl:when>
									<xsl:when test="$extension = 'txt'">
										<xsl:variable name='rtfid'>rtftext<xsl:value-of select="$id"/></xsl:variable>
										<a>
											<xsl:attribute name='id' select="$rtfid"/>
											<xsl:attribute name='title' select="$filename"/>
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/></xsl:attribute>
										</a>
										<script>
											$.ajax({
												type: "GET",
												url: "Provider?type=getattach&amp;formsesid=<xsl:value-of select="$formsesid"/>&amp;doctype=<xsl:value-of select="$doctype"/>&amp;key=<xsl:value-of select="$docid"/>&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename'/>",
												success: function(response){
													$("#<xsl:value-of select="$rtfid"/>").attr("innerHTML", (response.length > 300) ? response.substr(0, 298)+"...":response);
												}
											});
										</script>
									</xsl:when>
									<xsl:otherwise>
										<img src="" style="margin-right:5px">
											<xsl:attribute name="src">/SharedResources/img/iconset/file_extension_<xsl:value-of select="$extension"/>.png</xsl:attribute>
											<xsl:attribute name="onerror">javascript:changeAttIcon(this)</xsl:attribute>
										</img>
										<a href='' style="vertical-align:6px">
											<xsl:attribute name='href'>Provider?type=getattach&amp;formsesid=<xsl:value-of select="formsesid" />&amp;key=<xsl:value-of select="$docid" />&amp;doctype=<xsl:value-of select="$doctype" />&amp;field=rtfcontent&amp;file=<xsl:value-of select='$filename' /></xsl:attribute>
											<xsl:value-of select='document/fields/rtfcontent' />
										</a>
										&#xA0;
										<a href='' style="vertical-align:5px">
											<xsl:attribute name='href'>javascript:deleterow(<xsl:value-of select="$formsesid" />,'<xsl:value-of select='$filename' />','<xsl:value-of select="$id" />')</xsl:attribute>
											<img src="/SharedResources/img/iconset/cross.png" style="width:10px; height:10px" />
										</a>
									</xsl:otherwise>
								</xsl:choose>
							</td>
							<td>
							</td>
						</tr>
					</xsl:when>
				</xsl:choose>
			</table>
			<br />
			<br />
		</div>
	</xsl:template>
	
	<xsl:template name="doctitleGlossary">
		<font>
			<xsl:value-of select="$doctype"/> - <xsl:value-of select="document/fields/name"/>
		</font>	
	</xsl:template>
	
	<xsl:template name="ECPsignFields">
		<input type="hidden" name="sign" id="sign" value="{sign}" style="width:100%;" />
		<input type="hidden" name="signedfields" id="signedfields" value="{signedfields}" style="width:100%;" />
		<!-- <APPLET CODE="kz.flabs.eds.applet.EDSApplet" NAME="edsApplet" ARCHIVE="eds.jar, commons-codec-1.3.jar" HEIGHT="1" WIDTH="1">
			<param name="ARCHIVE" value="/eds.jar, /commons-codec-1.3.jar" />
		</APPLET> -->

		<xsl:if test="document/@canbesign='1111'">
			<script type="text/javascript" src="/edsApplet/js/jquery.blockUI.js" charset="utf-8"></script>
        	<script type="text/javascript" src="/edsApplet/js/crypto_object.js" charset="utf-8"></script>
        	<script type="text/javascript">
				edsApp.init();
			</script>
		</xsl:if>
	</xsl:template>
	<xsl:template name="htmltagfindanddelete">
		<xsl:param name="string"/>
			<xsl:variable name="text" select="replace(lower-case($string), '&lt;[^>]*>','')" />
			<xsl:variable name="text" select="replace(lower-case($text), '&amp;nbsp;',' ')" />
			<xsl:variable name="text" select="replace(lower-case($text), '&amp;lt;','&lt;')" />
			<xsl:variable name="text" select="replace(lower-case($text), '&amp;gt;','&gt;')" />
		<xsl:value-of select="$text"/>
	</xsl:template>
</xsl:stylesheet>