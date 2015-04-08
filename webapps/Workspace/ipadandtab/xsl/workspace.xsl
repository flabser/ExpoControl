<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">

	<xsl:output method="html" encoding="utf-8" indent="no" />
	<xsl:variable name="skin" select="request/@skin" />
	<xsl:variable name="useragent" select="/request/@useragent" />

	<xsl:template match="/request">
		<xsl:text disable-output-escaping="yes">&lt;</xsl:text>!DOCTYPE html<xsl:text disable-output-escaping="yes">&gt;</xsl:text>
		<html>
			<head>
				<title>NextBase - WorkSpace </title>
				<meta name="viewport" content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" />
				<link type="text/css" rel="stylesheet" href="/SharedResources/css/normalize.css" />

				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js" />
				<script type="text/javascript" src="ipadandtab/scripts/start.js" />
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js" />
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js" />
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js" />
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js" />
				<link type="text/css" rel="stylesheet" href="ipadandtab/css/main.css" />
				<link type="text/css" rel="stylesheet" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" />
			</head>
			<body>
				<header class="header">
					<ul>
						<li class="brand">
							<xsl:value-of select="content/content/org" />
						</li>
						<li class="sign-in">
							<xsl:if test="@userid != 'anonymous'">
								<div class="user">
									<xsl:value-of select="@username" />
									<a href="Logout" class="btn-logout ui-button ui-widget ui-state-default ui-button-text-only ui-corner-all">
										Выйти
									</a>
								</div>
							</xsl:if>
							<xsl:if test="@userid = 'anonymous'">
								<div class="form-group">
									<form action="Login" method="post" id="frm" name="form">
										<input type="hidden" name="type" value="login" />
										<fieldset class="fieldset">
											<ol class="fieldset-container">
												<li class="control-group">
													<label class="control-label" for="login">
														<xsl:value-of select="content/captions/user/@caption" />
													</label>
													<span class="controls">
														<input type="text" name="login" id="login" value="" required="required" />
													</span>
												</li>
												<li class="control-group">
													<label class="control-label" for="pwd">
														<xsl:value-of select="content/captions/password/@caption" />
													</label>
													<span class="controls">
														<input type="password" name="pwd" id="pwd" value="" required="required" />
													</span>
												</li>
											</ol>
											<div class="sign-in-fieldset-bottom">
												<button type="submit" class="btn-submit ui-button ui-widget ui-state-default  ui-button-text-only ui-corner-all">
													<xsl:value-of select="content/captions/login/@caption" />
												</button>
												<label class="noauth">
													<input type="checkbox" id="cbx" name="noauth" value="1" />
													<xsl:value-of select="content/captions/anothercomp/@caption" />
												</label>
											</div>
										</fieldset>
									</form>
								</div>
							</xsl:if>
						</li>
					</ul>
					<div class="clearfix"></div>
				</header>

				<div class="clearfix"></div>
				<section class="app-list">
					<xsl:if test="@userid = 'anonymous'">
						<a href="javascript:void(0)" class="app desctop ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
							<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd;</xsl:attribute>
							<xsl:attribute name="onclick">infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
							<div class="ui-button-text">
								<xsl:if test="logo = ''">
									<div style="padding-top:25px; height:50px; width:100%; text-align:left;">
										<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
											<xsl:value-of select="apptype" />
										</font>
									</div>
									<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
										<font style="font: 16px Verdana, Geneva, sans-serif;">
											<xsl:value-of select="description" />
										</font>
									</div>
								</xsl:if>
							</div>
						</a>
						<a href="javascript:void(0)" class="app desctop ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
							<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd;</xsl:attribute>
							<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
							<div class="ui-button-text">
								<xsl:if test="logo = ''">
									<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
										<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
											<xsl:value-of select="apptype" />
										</font>
									</div>
									<div style="position:absolute; bottom:20px; left:0px; right:0px; text-align:center">
										<font style="font: 16px Verdana, Geneva, sans-serif;">
											<xsl:value-of select="description" />
										</font>
									</div>
								</xsl:if>
							</div>
						</a>
						<a href="javascript:void(0)" class="app desctop ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
							<xsl:attribute name="style">background:#efefef;opacity:0.85; border: 1px dashed #ccc; color:#cdcdcd;</xsl:attribute>
							<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
							<div class="ui-button-text">
								<xsl:if test="logo = ''">
									<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
										<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
											<xsl:value-of select="apptype" />
										</font>
									</div>
									<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
										<font style="font: 16px Verdana, Geneva, sans-serif;">
											<xsl:value-of select="description" />
										</font>
									</div>
								</xsl:if>
							</div>
						</a>
					</xsl:if>
					<xsl:if test="@userid != 'anonymous'">
						<xsl:for-each select="content/glossaries/apps/entry">
							<a href="javascript:void(0)" class="app ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only"
								title="{description}-{orgname}">
								<xsl:if test="@mode = 'off'">
									<xsl:attribute name="style">background:#eee; border: 1px solid #ccc; color:#cdcdcd;</xsl:attribute>
									<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
								</xsl:if>
								<xsl:if test="@mode = 'on'">
									<xsl:attribute name="href">/<xsl:value-of select="redirect" /></xsl:attribute>
								</xsl:if>
								<div class="ui-button-text">
									<xsl:if test="logo != ''">
										<div style="padding-top:25px; height:50px; width:100%; text-align:left">
											<img src="/SharedResources/logos/{logo}" style="max-height:64px; max-width:64px; float:left; margin: 0px 15px 7px 5px;">
												<xsl:if test="@mode = 'off'">
													<xsl:attribute name="style">opacity:0.5</xsl:attribute>
													<xsl:attribute name="onclick">javascript:infoDialog("Для перехода в приложение необходимо пройти авторизацию");</xsl:attribute>
												</xsl:if>
											</img>
											<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
												<xsl:value-of select="apptype" />
											</font>
										</div>
										<div style="position:absolute; bottom:20px;left:0px; right:0px;text-align:center">
											<font style="font: 16px Verdana, Geneva, sans-serif;">
												<xsl:value-of select="description" />
											</font>
										</div>
									</xsl:if>
									<xsl:if test="logo = ''">
										<div style="padding-top:25px; height:50px; width:100%; text-align:left; ">
											<font style="font:12px Verdana; font-weight:normal; vertical-align:top">
												<xsl:value-of select="apptype" />
											</font>
										</div>
										<div style="position:absolute; bottom:20px; left:0px; right:0px;text-align:center">
											<font style="font: 16px Verdana, Geneva, sans-serif;">
												<xsl:value-of select="description" />
											</font>
										</div>
									</xsl:if>
								</div>
							</a>
						</xsl:for-each>
					</xsl:if>
				</section>

				<footer class="footer">
					<div class="clearfix"></div>
					<span class="vers">
						<xsl:value-of select="concat('v. ', content/content/version, ' build: ', content/content/build)" />
					</span>
					<img class="logo">
						<xsl:attribute name="src">/SharedResources/logos/<xsl:value-of select="content/content/img" /></xsl:attribute>
						<xsl:if test="@userid != 'anonymous'">
							<xsl:attribute name="class">logo gray</xsl:attribute>
						</xsl:if>
					</img>
				</footer>
			</body>
		</html>
	</xsl:template>

</xsl:stylesheet>
