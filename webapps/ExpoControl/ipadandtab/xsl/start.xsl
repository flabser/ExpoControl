<?xml version="1.0" encoding="utf-8"?>

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:output method="html" encoding="utf-8"/>
	<xsl:template match="/request/content">
		<html>
			<head>
				<title>
					<xsl:value-of select="content/org" /> - 4ms workflow
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<xsl:if test="../@useragent = 'IPAD_SAFARI'">
					<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/main_vertical.css"/>
					<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/main.css"/>
				</xsl:if>
				<xsl:if test="../@useragent = 'P1000'">
					<link rel="stylesheet" media="all and (orientation:landscape) and (max-device-height: 600px)" href="ipadandtab/css/main_small.css"/>
					<link rel="stylesheet" media="all and (orientation:portrait) and (max-device-height: 600px)" href="ipadandtab/css/main_small_vertical.css"/>
				</xsl:if>
				<script type="text/javascript"  src="ipadandtab/scripts/start.js"/>
				<script type="text/javascript"  src="ipadandtab/scripts/form.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<link type="text/css" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" rel="stylesheet" />
			</head>
			<body onKeyDown="key(event)" class="start_page_body">
				<script>
					if(navigator.userAgent.indexOf("P1000")!=-1){
						$("body").addClass("small")
					}
				</script>
				<form action="Login" method="post" id="frm" name="form">
					<xsl:if test="../@userid = 'anonymous'">
						<div class="authfields">
							<center>
								<table style="width:80%; margin-top:8%">
									<tr>
										<td style="text-align:right" width="40%" class="fieldcaption"><xsl:value-of select="captions/user/@caption"/> :</td>
										<td>
											<input type="text" name="login" id="login" value="" style="width:85%"/>
											
										</td>
									</tr>
									<tr>
										<td style="text-align:right" class="fieldcaption"><xsl:value-of select="captions/password/@caption"/> :</td>
										<td>
											<input type="password"  name="pwd" value="" id="pwd" style="width:85%"/>
										</td>
									</tr>
									<tr>
										<td style="text-align:right"></td>
										<td class="fieldcaption">
											<input type="checkbox" id="cbx" name="noauth" style="margin-top:8px;"/>
											<span>
												<xsl:value-of select="captions/anothercomp/@caption"/>
											</span>	
										</td>
									</tr>
									<tr>
										<td style="text-align:right"></td>
										<td>
											<a class="gray button" style="width:80%; margin-top:5%">
												<xsl:attribute name="href">javascript:ourSubmit("default")</xsl:attribute>
												Войти
											</a>
										</td>
									</tr>
								</table>
							</center>
							</div>
						</xsl:if>
						<xsl:if test="../@userid != 'anonymous'">
							<div class="authfields">
								<center>
									<table style="width:80%; margin-top:60px">
										<tr>
											<td  style="text-align:center"  class="fieldcaption">
												<font style="font-size:1.3em">
													 <b><xsl:value-of select="../@username"/></b>
												</font>
											</td>
										</tr>
										<tr>
											<td>
												<center>
													<a class="gray button" style="width:100px; margin-top:45px">
														<xsl:attribute name="href">javascript:ourSubmit("auth")</xsl:attribute>
														<xsl:value-of select="captions/login/@caption"/>
													</a>
													<a class="gray button" href="Logout" style="margin-left:5px">
														<xsl:attribute name="title" select="captions/logout/@caption"/>
														<xsl:value-of select="captions/logout/@caption"/>
													</a>
												</center>
											</td>
										</tr>
									</table>
								</center>
							</div>
							<input type="hidden" size="30" name="login" id="login">
								<xsl:attribute name="value" select="../@userid"/>
							</input>
							<input type="hidden" size="30" name="pwd" value="" id="pwd"/>
						</xsl:if>
					<div id="foooter" class="footer">
						<br/>
						<img src="classic/img/4ms.png" style="border:none;"/>&#xA0;
						<font><xsl:value-of select="content/version"/>&#xA0;&#169;&#xA0;2011&#xA0;</font>							
						<a style="margin-left:1em">
							<xsl:attribute name="href">Provider?type=static&amp;id=help_category_list</xsl:attribute>
						    <img src="/SharedResources/img/classic/help.gif" style="border:none;"/>									
				    	</a>&#xA0;&#xA0;
						<span style="right:10; margin-top:5px; position:absolute">
							<xsl:value-of select="captions/lang/@caption"/> :	
						<select name="lang" id="lang"  style="font-size:0.8em">
							<xsl:variable name='chinese' select="captions/chinese/@caption"/>
								<xsl:variable name='currentlang' select="../@lang"/>
								<xsl:attribute name="onchange">javascript:changeSystemSettings(this)</xsl:attribute>
								<xsl:for-each select="glossaries/langs/entry">
									<option>
										<xsl:attribute name="value"><xsl:value-of select="id"/></xsl:attribute>
										<xsl:if test="$currentlang = id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:if test="id = 'CHN'">
											<xsl:value-of select="$chinese"/>
										</xsl:if>
										<xsl:if test="id != 'CHN'">
											<xsl:value-of select="name"/>
										</xsl:if>
									</option>
								</xsl:for-each>
							</select>&#xA0;
						 	<xsl:value-of select="captions/skin/@caption"/> :
							<select name="skin" id="skin" style="font-size:0.8em">
								<xsl:variable name='currentskin' select="../@skin"/>
								<xsl:attribute name="onchange">javascript:changeSystemSettings(this)</xsl:attribute>
								<xsl:for-each select="glossaries/skins/entry">
									<option>
										<xsl:attribute name="value"><xsl:value-of select="id"/></xsl:attribute>
										<xsl:if test="$currentskin = id">
											<xsl:attribute name="selected">selected</xsl:attribute>
										</xsl:if>
										<xsl:value-of select="name"/>
									</option>
								</xsl:for-each>
							</select>
						</span>									
					</div>
				</form>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>
