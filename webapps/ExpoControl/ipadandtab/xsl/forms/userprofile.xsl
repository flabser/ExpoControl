<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/sharedactions.xsl" />
	<xsl:output method="html" encoding="windows-1251"/>	   
	<xsl:template match="request">
		<xsl:variable name="path" select="/request/@skin"/>
		<html>
	  		<head>
	 			<title>Сотрудник: <xsl:value-of select="document/fields/fullname"/> - 4ms workflow</title>
	     		<link rel="stylesheet" href="ipadandtab/css/main.css" />
				<link rel="stylesheet" href="ipadandtab/css/form.css" />
				<link rel="stylesheet" href="ipadandtab/css/actionbar.css" />
				<link rel="stylesheet" href="ipadandtab/css/dialogs.css" />
				<script language="javascript" src="ipadandtab/scripts/form.js"></script>
				<link type="text/css" href="/SharedResources/jquery/css/base/jquery-ui-1.8.2.redmont.css" rel="stylesheet" />
				<script type="text/javascript" src="/SharedResources/jquery/js/jquery-1.4.2.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.core.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.widget.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.mouse.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.draggable.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.position.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/ui/jquery.ui.dialog.js"></script>
				<script type="text/javascript" src="/SharedResources/jquery/js/cookie/jquery.cookie.js"></script>

				<script type="text/javascript">
					$(document).ready(function(){

						(function(){
							$("#btnPwdChange").click(function(){
								$("#passdlg").dialog({
									title: "Смена пароля",
									modal: true,
									width: 400
								});
							});
						})();
		
						$("#btnpwdok").click(function(){
							var perror = "";
							var oldpwd = $('#oldpwd').val();
							var newpwd = $('#cnewpwd').val();
							var rnewpwd = $('#rnewpwd').val();
		
							if( oldpwd == '' ) {
								perror = "Введите текущий пароль";
							} else if( newpwd == '' ) {
								perror = "Введите новый пароль";
							} else if( rnewpwd == ''){
								perror = "Подтвердите новый пароль";
							} else if (newpwd != rnewpwd) {
								perror = "Повтор пароля не верный";
							} else if (newpwd == oldpwd) {
								perror = "Операция не имеет смысла";
							} else if (3 > newpwd.length) {
								perror = "Пароль слишком короткий.";
							}
		
							if (perror==''){
								$('#pass').toggle(true);
								$("#btnPwdChange").toggle(false);
								$('#newpwd').val(newpwd).attr('name', 'newpwd');
								$('#newpwd').after('<input type="hidden" name="oldpwd" value="'+oldpwd+'"/>');
								$("#passdlg").dialog('close');
							} else {
								alert(perror);
							}
						});
		
						$("#btndlgclose").click(function(){
							$("#passdlg").dialog('close');
						});
						if ($.cookie("refresh") != null){
							$("[name=refresh] #"+$.cookie("refresh")).attr("selected","selected")
						}
						if ($.cookie("pagesize") != null){
							$("[name=countdocinview] #countdocinview"+$.cookie("pagesize")).attr("selected","selected")
						}
					});
				</script>
	    	</head>
	    	<body>  
            	<div class="bar">
             		<span style="width:92%; ">
             			<a style="vertical-align:12px">
							<xsl:attribute name="class">gray button form</xsl:attribute>
							<xsl:attribute name="id">saveuserprofile</xsl:attribute>
							<xsl:attribute name="href">javascript:saveUserProfile()</xsl:attribute>
							<font ><xsl:value-of select="document/captions/saveandclose/@caption"/></font>
						</a>&#xA0;
					</span>
					<span >
						<xsl:attribute name="style">
							float:right; 
						</xsl:attribute>
	            		<xsl:call-template name="cancel"/>
	            	</span>
 	         	</div>            			     
             	<div class="formtitle">
             		Сотрудник - <xsl:value-of select="document/fields/fullname"/>
             	</div>
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded" >
				<div display="block"  id="property"><br/>
	      	    	<table width="100%" border="0" style="margin-top:8px">
				 		<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/department/@caption"/>&#xA0;:
							</td>
							<td>
								<table  style="width:60%; border:1px solid #ccc">
									<tr>
										<td>
											<xsl:value-of select="document/fields/department"/>&#xA0;
										</td>
									</tr>
								</table>
							</td>
						</tr>					
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/post/@caption"/>&#xA0;:
							</td>
							<td>
								<table  style="width:60%; border:1px solid #ccc">
									<tr>
										<td>
											<xsl:value-of select="document/fields/post"/>&#xA0;
										</td>
									</tr>
								</table>
							</td>
			    		</tr>
			    		<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/shortname/@caption"/>&#xA0;:
							</td>
							<td>
								<table  style="width:60%; border:1px solid #ccc">
									<tr>
										<td>
											<xsl:value-of select="document/fields/shortname"/>&#xA0;
										</td>
									</tr>
								</table>
							</td>
						</tr>					
		        		<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/fullname/@caption"/>&#xA0;:
							</td>
							<td>
								<table  style="width:60%; border:1px solid #ccc">
									<tr>
										<td>
											<xsl:value-of select="document/fields/fullname"/>&#xA0;
										</td>
									</tr>
								</table>
							</td>
						</tr>		
			    		<tr>
							<td class="fc">ID&#xA0;:</td>
							<td>
								<input  style="width:50%; border:1px solid #ccc" name="userid">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/userid"/>
									</xsl:attribute>
								</input>
							</td>
						</tr>		
						<tr>
							<td class="fc">Старый пароль&#xA0;:</td>
							<td>
								<input style="border:1px solid #ccc; width:50%;"  id="oldpwd" name="oldpwd"  type="password">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/password"/>
									</xsl:attribute>
								</input>
								<!--<span id="pass" style="display:none;padding-left:10px;color:red;">Пароль будет изменен после сохранения!</span>
								<a id="btnPwdChange" style="color:blue;cursor:pointer;margin-left:1em;text-decoration:underline;">Сменить пароль</a>
							--></td>
						</tr>
						<tr>
							<td class="fc">Новый пароль&#xA0;:</td>
							<td>
								<input style="border:1px solid #ccc; width:50%;" id="newpwd" name="pwd"   type="password">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/password"/>
									</xsl:attribute>
								</input>
								<!--<span id="pass" style="display:none;padding-left:10px;color:red;">Пароль будет изменен после сохранения!</span>
								<a id="btnPwdChange" style="color:blue;cursor:pointer;margin-left:1em;text-decoration:underline;">Сменить пароль</a>
							--></td>
						</tr>
						<tr>
							<td class="fc">Повтор нового пароля&#xA0;:</td>
							<td>
								<input style="border:1px solid #ccc; width:50%;" id="newpwd2"  name="pwd2" type="password">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/password"/>
									</xsl:attribute>
								</input>
								<!--<span id="pass" style="display:none;padding-left:10px;color:red;">Пароль будет изменен после сохранения!</span>
								<a id="btnPwdChange" style="color:blue;cursor:pointer;margin-left:1em;text-decoration:underline;">Сменить пароль</a>
							--></td>
						</tr>
						<tr>
							<td class="fc">
								<xsl:value-of select="document/fields/notesname/@caption"/>&#xA0;:
							</td>
							<td>
								<input  style="border:1px solid #ccc; width:50%">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/notesname"/>
									</xsl:attribute>
								</input>
							</td>
						</tr>
						<tr>
							<td class="fc">JID&#xA0;:</td>
							<td>
								<input style="border:1px solid #ccc; width:50%" id="jid"  name="jid" type="text">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/jid"/>
									</xsl:attribute>
								</input>
								<!--<span id="pass" style="display:none;padding-left:10px;color:red;">Пароль будет изменен после сохранения!</span>
								<a id="btnPwdChange" style="color:blue;cursor:pointer;margin-left:1em;text-decoration:underline;">Сменить пароль</a>
							--></td>
						</tr>		
	            		<tr>
							<td class="fc">E-mail&#xA0;:</td>
							<td width="69%">
								<input style="border:1px solid #ccc; width:50%" id="email"   name="email" type="text">
									<xsl:attribute name="value">
										<xsl:value-of select="document/fields/email"/>
									</xsl:attribute>
								</input>
							</td>
						</tr>	
	                 </table>
	                 <br/>
	           </div>
	      <!-- 	<div style="font-family:verdana;" >
					<table width="80%" border="0" style="margin-top:8px">
						<tr>
   	                		<td class="st" style="font-size:10.8pt; colspan:2">Notes-Адрес, замещающие&#xA0; </td>            
	                	</tr>
	                </table>
	            </div>  -->
				<div display="block"  id="settings">
			  				
				<!--
				 <table style="  margin-left:195px">
				<tr class="tt">				
				        	<td>Рассылать уведомления&#xA0;: </td>
						    <td class="rr">
								<input type="radio"  name="sendto" value="sendtomeandreplacer">
									<xsl:if  test="sendto = 'sendtomeandreplacer'">
									 <xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>					
							Пользователю и замещающему	
							   </input>								
							</td>
				</tr>
				<tr class="tt">
				            <td>
				            </td>
				            <td class="rr">
								<input type="radio" name="sendto" value="sendtoreplacer">
												Только замещающему
									<xsl:if  test="sendto = 'sendtoreplacer'">
									 <xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>														 					
								</input>
							</td>			     
	         	</tr>
	         	<tr class="tt">
				            <td>
				            </td>
				            <td class="rr">
								<input type="radio" name="sendto" value="sendtome">
												Только пользователю
									<xsl:if  test="sendto = 'sendtome'">
									 <xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>														 					
								</input>
							</td>			     
	         	</tr>
				<tr class="tt">
							<td>
							</td>
	      				    <td class="rr">
				                 <input type="radio" name="sendto" value="sendnever"> Отключить
								    <xsl:if  test="sendto = 'sendnever'">
									 <xsl:attribute name="checked">checked</xsl:attribute>
									</xsl:if>																				
								</input>
						     </td>					
	             </tr>
	             </table>
	          -->
	       			
	       			
	         			<table style="width:100%; margin-left:2%">
	             			<tr>	
				    			<td class="fc">
				    				<xsl:value-of select="document/fields/countdocinview/@caption"/>&#xA0;:
				    			</td>
					   			<td>
									<select name="countdocinview" id="countdocinview">
										<option>
											<xsl:attribute name="id">countdocinview10</xsl:attribute>
											<xsl:if test="document/fields/countdocinview = '10' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>10
										</option>
										<option>
											<xsl:attribute name="id">countdocinview20</xsl:attribute>
											<xsl:if test="document/fields/countdocinview = '20' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>20
										</option>
										<option>
											<xsl:attribute name="id">countdocinview30</xsl:attribute>
											<xsl:if test="document/fields/countdocinview = '30' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>30
										</option>
										<option>
											<xsl:attribute name="id">countdocinview50</xsl:attribute>
											<xsl:if test="document/fields/countdocinview = '50' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>50
										</option>
									</select>
								</td>
							</tr>
	             			<tr>	
				    			<td class="fc">
				    				Периодичность обновления документов в виде&#xA0;:
				    			</td>
					   			<td>
									<select name="refresh" id="refresh">
										<option id="3">
											<xsl:if test="document/fields/refresh = '3' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">3</xsl:attribute>
											3 мин.
										</option>
										<option id="5">
											<xsl:if test="document/fields/refresh = '5' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">5</xsl:attribute>
											5 мин.
										</option>
										<option id="10">
											<xsl:if test="document/fields/refresh = '10' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">10</xsl:attribute>
											10 мин.
										</option>
										<option id="15">
											<xsl:if test="document/fields/refresh = '15' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">15</xsl:attribute>
											15 мин.
										</option>
										<option id="20">
											<xsl:if test="document/fields/refresh = '20' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">20</xsl:attribute>
											20 мин.
										</option>
										<option id="30">
											<xsl:if test="document/fields/refresh = '30' ">
												<xsl:attribute name="selected">selected</xsl:attribute>
											</xsl:if>
											<xsl:attribute name="value">30</xsl:attribute>
											30 мин.
										</option>
									</select>
								</td>
							</tr>
	       				</table>
	       				<input type="hidden" name="type" value="save_userprofile" />
						<input type="hidden" name="id" value="userprofile" />
	       			
	        	</div>
	        	</form>
	        </body>
	        <hr  color="#CCCCCC"/>
	        
	<!--<table id="passdlg" width="400px" cellpadding="2" cellspacing="0" style="display:none;">
		<tr>
			<td width="180px"></td>
			<td width="220px">&#xA0;</td>
		</tr>
		<tr>
			<td>Текущий пароль:</td>
			<td>
				<input type="password" name="oldpwd" id="oldpwd" style="width:97%; border:1px solid #889;">
					<xsl:attribute name="value"><xsl:value-of
						select="document/fields/password" /></xsl:attribute>
				</input>
			</td>
		</tr>
		<tr>
			<td>Новый пароль:</td>
			<td>
				<input type="password" name="cnewpwd" id="cnewpwd" style="width:97%; border:1px solid #889;" />
			</td>
		</tr>
		<tr>
			<td>Подтвердите новый пароль:</td>
			<td>
				<input type="password" name="rnewpwd" id="rnewpwd" style="width:97%; border:1px solid #889;" />
			</td>
		</tr>
		<tr>
			<td colspan="2">
				<div align="right" style="border-top:1px solid #CCC;padding-top:6px;margin-top:4px;">
					<button id="btnpwdok">Сменить пароль</button>
					<button id="btndlgclose">Отмена</button>
				</div>
			</td>
		</tr>
	</table>
    	--></html>
	</xsl:template>
</xsl:stylesheet>
	