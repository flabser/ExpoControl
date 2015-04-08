<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:import href="../templates/form.xsl"/>
	<xsl:import href="../templates/sharedactions.xsl"/>
	<xsl:import href="../templates/docthread.xsl"/>
	<xsl:variable name="doctype"><xsl:value-of select="request/document/captions/doctypemultilang/@caption"/></xsl:variable>
	<xsl:variable name="threaddocid" select="document/@docid"/>
	<xsl:variable name="path" select="/request/@skin"/>
	<xsl:output method="html" encoding="windows-1251" />
	
	<xsl:template match="/request">
		<html>
			<head>
				<title>
					<xsl:value-of select="document/@viewtext"/> - 4ms workflow 
				</title>
				<xsl:call-template name="cssandjs"/>
				
   				<xsl:call-template name="markisread"/>
			</head>
			<body>
				<script type="text/javascript">
        			$(function() {
        				$(".rof:not([readOnly]):first").focus();
        			});
    			</script>
    		
				<xsl:variable name="status" select="@status"/>
				<div class="bar">
					<span style="width:82%;">
						<xsl:call-template name="showxml"/>
						<xsl:call-template name="newkr" />
						<xsl:call-template name="newki" />
						
						<!--		кнопка "ознакомить"			-->		
						<xsl:call-template name="acquaint"/>
					</span>
					<span style="float:right" >
			        	<xsl:call-template name="cancel" />
			     	</span>	
				</div>	
				<div class="formtitle">
					<xsl:call-template name="doctitle"/>											
				    <xsl:value-of select="maincorr"/>&#xA0;
				    <font size="2">
				    	<xsl:value-of select="parentbriefcont"/>
				    </font>&#xA0;
				   
						<xsl:if test="document/@notesurl !=''">
							<table style="margin-top:10px">
								<tr>
									<td>
										<a href="" class="gray button">
											<xsl:attribute name="href"><xsl:value-of select="document/@notesurl"/></xsl:attribute>
											<xsl:value-of select="document/fields/openinlotus/@caption"/>
										</a>
									</td>
								</tr>
							</table>
						</xsl:if>	
						<xsl:if test="document/fields/projecturl !=''">
							<table style="margin-top:10px">
								<tr>
									<td>
										<a href="" class="gray button">
											<xsl:attribute name="href"><xsl:value-of select="replace(document/fields/projecturl, 'amp;', '')"/></xsl:attribute>
											<xsl:value-of select="document/fields/projectviewtext"/>
										</a>
									</td>
								</tr>
							</table>
						</xsl:if>	
							
				</div>
				<br/>
				<form action="Provider" name="frm" method="post" id="frm" enctype="application/x-www-form-urlencoded">
					
					
						
						<table width="90%" border="0"  style="border-collapse: collapse">
							<tr>
								<td width="30%" class="fc">№&#xA0;:</td>
			            		<td>
                                	<input type="text" name="vn" size="10" class="rof" style="margin-left:2px">
                                		<xsl:attribute name="readonly">readonly</xsl:attribute>  
                                    	<xsl:attribute name="value"><xsl:value-of select="document/fields/vn"/></xsl:attribute>
                                    </input>&#xA0;
                                    <xsl:value-of select="document/fields/dvn/@caption"/>&#xA0;
                                    <input type="text" name="dvn" size="18" class="rof" style="margin-left:2px">
										<xsl:attribute name="readonly">readonly</xsl:attribute>
                                       	<xsl:attribute name="value"><xsl:value-of select="document/fields/dvn"/></xsl:attribute>
                                    </input>
                           		</td>   					
							</tr>
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/signer/@caption"/>&#xA0;:
								</td>
								<td>
									<input  type="text"  id="signer"  class="rof" readonly="readonly" style="margin-left:2px; width:500px">                   			              		
										<xsl:attribute name="value">
											<xsl:value-of select="document/fields/signer"/>
										</xsl:attribute>
									</input>	
									<input type="hidden"  id="signer"/>                   			              		
								</td>
						    </tr>
						 	<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/recipient/@caption"/>&#xA0;:
								</td>
								<td>
						     		<xsl:choose>
										<xsl:when test="document/fields/recipient/@islist = 'true'">
											<table width="100%">
												<xsl:for-each select="document/fields/recipient/entry">
													<tr>													
														<td>
															<input type="text"  id="recipient"  class="rof" readonly="readonly"  style="margin-left:2px; width:500px" >                   			              		
																<xsl:attribute name="value">
																	<xsl:value-of select="."/>
																</xsl:attribute>
															</input>	
															<input type="hidden"  id="recipient">
																<xsl:attribute name="value">
																	<xsl:value-of select="@attval"/>
																</xsl:attribute>
															</input>                   			              		
														</td>
													</tr>
												</xsl:for-each>
											</table>
										</xsl:when>
										<xsl:otherwise>
											<input type="text"  id="recipient"  class="rof" readonly="readonly"  style="margin-left:2px; width:500px">                   			              		
												<xsl:attribute name="value">
													<xsl:value-of select="document/fields/recipient"/>
												</xsl:attribute>
											</input>	
											<input type="hidden"  id="recipient"/>                   			              		
										</xsl:otherwise>
									</xsl:choose>
								</td>
							</tr>
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/briefcontent/@caption"/>&#xA0;:
								</td>
								<td>
									<textarea name="briefcontent" rows="5"  style="margin-left:2px; width:85%">
										<xsl:attribute name="readonly">readonly</xsl:attribute>
										<xsl:attribute name="class">rof</xsl:attribute>									
										<xsl:value-of select="document/fields/briefcontent" />
									</textarea>							
								</td>
							</tr>
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/vnish/@caption"/>&#xA0;:
								</td>
								<td>
									<a>
										<xsl:attribute name="href">Provider?type=document&amp;id=ish&amp;key=<xsl:value-of select="document/vnish"/></xsl:attribute>
										<xsl:value-of select="vnish/item/@alt"/>
									</a>																
								</td>
							</tr>
							<tr>
								<td class="fc">
									<xsl:value-of select="document/fields/ctrldate/@caption"/>&#xA0;:
								</td>
								<td>
									<input type="text" id="ctrldate" name="ctrldate" size="18"  class="rof" style="margin-left:2px">
                                   		<xsl:attribute name="readonly">readonly</xsl:attribute>
										<xsl:attribute name="value">
											<xsl:value-of select="document/fields/ctrldate"/>
										</xsl:attribute>
									</input>								
								</td>
							</tr>						
					
							<!--	 Содержание 	-->
							
								<tr>
									<td class="fc"><xsl:value-of select="document/fields/contentsource/@caption"/>&#xA0;:</td>
									<td>
										<textarea  name="contentsource"  rows="25"  style="width:85%">
											<xsl:value-of select="document/fields/contentsource" />
										</textarea>
									</td>
								</tr>
							</table>
							<br/>
						
						<xsl:if test="document/@status !='new'">
								
						<div display="none" style="display:none; margin-left:2%; width:80%" id="execution">
							<font style="font-style:arial; font-size:13px">
								<xsl:value-of select="document/@viewtext"/>
							</font>
							
							<table id="executionTbl">
							</table>
							<br/>
						</div>
					</xsl:if>
					
		       </form>
		       <form action="Uploader" name="upload" id="upload" method="post" enctype="multipart/form-data" >
					<input type="hidden" name="type" value="rtfcontent" />
					<input type="hidden" name="formsesid">
						<xsl:attribute name="value"><xsl:value-of select="formsesid"/></xsl:attribute>
					</input>
					
					
						
						
							<table style="border:0" id="upltable" width="90%">
								<tr>
									<td class="fc">
										<xsl:value-of select="document/captions/attachments/@caption"/>&#xA0;:
									</td>
									<td>
										<input type="file" size="50" class="rof" name="fname"/>&#xA0;
										<xsl:if test="document/@editmode != 'readonly'">
											<a id="upla">
												<xsl:attribute name="href">javascript:submitFile('upload', 'upltable', 'fname')</xsl:attribute>
												<font style="font-size:13px">
													<xsl:value-of select="document/captions/attach/@caption"/>
												</font>
											</a>
										</xsl:if>
									</td>
									<td></td>
								</tr>
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
											<td></td>
										</tr>
									</xsl:when>
								</xsl:choose>
							</table>
							<br/>
							<br/>
					
				</form>
		        <div style="width:100%; border-top:1px solid #777777; height:5%;">
		        	<div style="width:100%;  padding:1em;">
		        		<xsl:call-template name="authorrus"/> 
	    	    		<xsl:call-template name="authordep"/>
	    	    	</div>
		        </div>
            	
			</body>	
		</html>
	</xsl:template>
</xsl:stylesheet>