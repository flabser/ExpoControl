<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="templates/view.xsl"/>
	<xsl:output method="html" encoding="utf-8" />
	<xsl:variable name="useragent" select="/request/@useragent"/>
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					4ms workflow - <xsl:value-of select="outline/*/entry[@current]/@caption"/>
				</title>
				<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
				<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/main_vertical.css"/>
				<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/main.css"/>
				<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/form.css"/>
				<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/outline_vertical.css"/>
				<link rel="stylesheet" media="all and (orientation:portrait)" href="ipadandtab/css/form_vertical.css"/>
				<link rel="stylesheet" media="all and (orientation:landscape) " href="ipadandtab/css/outline.css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.effects.core.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.datepicker-ru.js"/>
				<script type="text/javascript" src="ipadandtab/scripts/outline.js"></script>
				<script type="text/javascript" src="ipadandtab/scripts/view.js"/>
				<script type="text/javascript" src="ipadandtab/scripts/form.js"/>
				<script type="text/javascript" src="ipadandtab/scripts/swipe.js"/>
				<link type="text/css" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" rel="stylesheet" />
				<script src="ipadandtab/scripts/mobilyslider.js" type="text/javascript"/>
				<link href="ipadandtab/css/default.css" rel="stylesheet" type="text/css"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"/>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"/>
				<style type="text/css" media="all">
					body,ul,li {
						padding:0;
						margin:0;
						border:0;
					}
					
					body {
						font-size:12px;
						-webkit-user-select:none;
					    -webkit-text-size-adjust:none;
						font-family:helvetica;
					}
					
					#wrapper {
						padding-left:5px;
						padding-right:5px;
						width:100%;
						background:#fff;
					}
					#button_switch_view {
						margin-top:15px;
						margin-left:10px;
					}
					.togglebox1 {
						font-size: 1.2em;
						width: 100%;
						clear: both;
						margin-bottom:10px;
					}
					.togglebox1 .block {
						padding-top: 15px;
					}
				</style>
				<script>
					function onLoadActions(){
						$(".togglebox1").hide(); 
						$("#button_switch_view").toggle(
						      function () {
						        $(".outline_view").hide();
						        $(".togglebox1").show();
						        $(this).text("Перейти к списку документов")
						      },
						      function () {
						        $(".togglebox1").hide();
						        $(".outline_view").show();
						        $(this).text("Перейти к списку видов")
						      }
	    				);
						if(navigator.userAgent.indexOf("P1000")!=-1){
							$("body").addClass("small")
						}
						<xsl:choose>
							<xsl:when test="currentview/@type='search'">
								type = 'search'; 
								curPage = '<xsl:value-of select="currentview/@page" />'; 
								curlangOutline = '<xsl:value-of select="@lang"/>';
								doSearch('<xsl:value-of select="currentview/@keyword" />');								
							</xsl:when>
							<xsl:otherwise>
								type = '<xsl:value-of select="currentview/@type" />'; 
								viewid = '<xsl:value-of select="currentview/@id" />';
								command='<xsl:value-of select="currentview/@command" />';
								curPage = '<xsl:value-of select="currentview/@page" />'; 
								curlangOutline = '<xsl:value-of select="@lang"/>';
								refreshAction(); 
								refresher();
							</xsl:otherwise>
						</xsl:choose>
					}
				</script>
			</head>
			<body onLoad="javascript:onLoadActions();">
				<div class="content">
					<button class="gray button" id="button_switch_view"><a style="color:black">Перейти к списку видов</a></button>
					<span id="block_logout" style=" float:right; margin-top:15px; margin-right:10px">
						<a target="_parent"  href="Logout"  class="gray button">
						<font><xsl:value-of select="outline/fields/logout/@caption"/></font> 
					</a>
					</span>
					<div class="togglebox1">
						<div class="block">
							<div id="outline_category" style="background:#fff; height:100%;  font: 1em 'trebuchet MS', 'Lucida Sans', Arial; color:#0857A6; width:100%; border-top:1px solid #ccc">
								<xsl:for-each select="outline/entry">
									<div style="width:32%; display:inline-block; text-align:center; margin-top:5px;" class="category_caption"><font style="font-size:15px"><xsl:value-of select="@caption"/></font>
										<table style="width:80%; margin-left:5%">
											<xsl:for-each select="entry">
												<tr style="height:55px;">
													<td width="100%">
														<center>
															<a class="gray button" style="width:100%;">
																<xsl:attribute name="href" select="@url"/>
																<xsl:value-of select="@caption"/>
															</a> 
														</center>
													</td>
												</tr>
											</xsl:for-each>
										</table>
									</div>
								</xsl:for-each>
							</div>
						</div>
					</div>
					<div class="outline_view" id="view" style="margin-top:-25px; width:99%;padding-left:10px; padding-right:5px">
					</div>
				</div>
				<div id="userprofile" style="display:none" class="userinfo">
					<a target="_parent"  href="Provider?type=document&amp;id=userprofile">
						<img style="width:30px; height:30px">
							<xsl:attribute name="src">ipadandtab/img/users_settings.png</xsl:attribute>
						</img>
					</a>
					<font style="margin-left:5px; vertical-align:10px; font-size:14px" class="userinfo">
						<xsl:value-of select="currentuser"/>
					</font>
				</div>
				<div id="logout" style="display:none" >
					<a target="_parent"  href="Logout"  class="gray button">
						<font><xsl:value-of select="outline/fields/logout/@caption"/></font> 
					</a>
				</div>
			</body>
		</html>
	</xsl:template>
</xsl:stylesheet>