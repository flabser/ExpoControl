<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	<xsl:template name="search">
		<!--<input type="text" id="searchInput" class="search_input" size="30">
				<xsl:attribute name="value">
					<xsl:value-of select="query/@keyword"/>
				</xsl:attribute>
			</input> 
  			<script>
  				$("#searchInput").keydown(function(e){
  					if (e.which ==13){ search(); }
  				});
  			</script> 
 		<a href="javascript:openCloseAdvSearchDiv()">
 			<img src="/SharedResources/img/iconset/cog.png" title="Расширенный поиск" />
		</a>
		--><!--<a href="javascript:search()" >
			<img src="/SharedResources/img/iconset/magnifier.png" /> 
		</a>
		
			<a class="gray button" href="javascript:search()" style="margin-left:3px">
				Найти...
			</a>
		
		<div id="advancedSearchDiv" style="border:2px solid #ccc; background:#ffffff; display:none; margin-top:3.5%; right:0;  width:53%; position:absolute; height:100px;">
			<table style=" font-size:12px; width:100%">
				<tr>
					<td> 
						<input type="checkbox" name="typefinddoc" value="in">Входящий</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="ish" style="margin-left:12.4%">Исходящий</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="in">Карточка исполнения</input>&#xA0;
					</td>
				</tr>
				<tr style="height:28px">
					<td> 
						<input type="checkbox" name="typefinddoc" value="in">Служебная записка</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="prj">Проект</input>&#xA0;
						<input type="checkbox" name="typefinddoc" value="in" style="margin-left:5.2%">Резолюция</input>&#xA0;
					</td>
				</tr>
				<tr>
					<td> 
						<b>Дата создания:</b>
 					</td>
 				</tr>
 				<tr>
 					<td>
 						&#xA0;с &#xA0;
 						<input type="text" id="fromdate" name="fromdate" size="14" class="rof" style="height:22px">
							<xsl:attribute name="readonly">readonly</xsl:attribute>
							<xsl:attribute name="value">
								<xsl:value-of select="document/fields/from" />
							</xsl:attribute>
						</input>&#xA0;
 						по&#xA0;
 						<input type="text" id="todate" name="todate" size="14" class="rof" style="height:22px">
							<xsl:attribute name="readonly">readonly</xsl:attribute>
							<xsl:attribute name="value">
								<xsl:value-of select="document/fields/to" />
							</xsl:attribute>
						</input>&#xA0;
 						<input type="checkbox" name="control" value="1">Контрольный</input>&#xA0;
 						<script>
							$(function() {
								$('#fromdate').datepicker({
									showOn: 'button',
									buttonImage: '/SharedResources/img/iconset/calendar.png',
									buttonImageOnly: true,
									regional:['ru'],
									showAnim: ''
								});
								$('#todate').datepicker({
									showOn: 'button',
									buttonImage: '/SharedResources/img/iconset/calendar.png',
									buttonImageOnly: true,
									regional:['ru'],
									showAnim: ''
								});
							});
						</script>
 					</td>
 				</tr>
 			</table>
 		</div> -->
	</xsl:template>
	
	<xsl:template name="viewinfo">
		<table style="width:99%; height:35px" class="time">
			<tr>
				<td width="33%">
					<span style="font-size: 1em ">
						<xsl:value-of select="columns/column[@id = 'PAGE']/@caption"/>:&#xA0;<xsl:value-of select="query/@currentpage"/>  &#xA0;<xsl:value-of select="columns/column[@id = 'FROM']/@caption"/>  &#xA0;<xsl:value-of select="query/@maxpage"/>
					</span>
				</td>
				<td width="33%">
					<xsl:call-template name="prepagelist"/>
				</td>
				<td width="33%" style="text-align:right; font-size: 1em  ">
					<xsl:value-of select="columns/column[@id = 'DOCUMENTS']/@caption"/>: <xsl:value-of select="query/@count"/>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<xsl:template name="prepagelist">
		<xsl:if test="query/@maxpage !=1">
			<table style="margin-top:10px;" class="navigation_view">
				<xsl:variable name="curpage" select="query/@currentpage"/>
				<xsl:variable name="prevpage" select="$curpage -1 "/>
				<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
            	<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
				<tr>
					<xsl:if test="query/@currentpage>1">
						<td class="navigation_table_cell">
							<a href="">
								<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',1)</xsl:attribute>
								<font>&lt;&lt;</font>
							</a>
						</td>
						<td class="navigation_table_cell">
							<a href="">
								<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$prevpage"/>)</xsl:attribute>
								<font>&lt;</font>
							</a>
						</td>
					</xsl:if>
					<xsl:call-template name="pagenavig"/>
					<xsl:if test="query/@maxpage > 15">
						<xsl:variable name="beforecurview" select="substring-before(@id,'.')"/> 
                		<xsl:variable name="aftercurview" select="substring-after(@id,'.')"/> 
						<td>
							<select>
								<xsl:attribute name="onChange">javascript:updateView(&quot;<xsl:value-of select="@type"/>&quot;,&quot;<xsl:value-of select="@id"/>&quot;,this.value)</xsl:attribute>
			 					<xsl:call-template name="combobox"/>
			 				</select>
			 			</td>
					</xsl:if>
				</tr>
			</table>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="headerSlider">
			<div class="outline_navigation_footer" id="outline_navigation_footer" style="width:100%; border-bottom:1px ridge #ccc; background-color:#fcfcfc; height:40px;">
				<center>
				</center>
			</div>
	</xsl:template>
	
	
	<xsl:template name="refreshstat">
		<xsl:call-template name="headerSlider"/>
		<table style="margin-top:20px; width:100%">
			<tr>
				<td>
					<font class="viewtitle"><xsl:value-of select="columns/column[@id = 'CATEGORY']/@caption"/> - <xsl:value-of select="columns/column[@id = 'VIEW']/@caption"/></font>
				</td>
				<td id="block_user_info"  style="text-align:right">
				</td>
				
			</tr>
			</table>
			<table style="margin-top:10px; width:100%">
			<tr>
				<td  style="text-align:left" class="userinfo">
				</td>
				<td align="right">
						<xsl:call-template name="search"/>
				</td>	
			</tr>
			
			<tr>
				<td>
					<font class="time">
						<xsl:value-of select="columns/column[@id = 'UPDATES']/@caption"/>:&#xA0;<xsl:value-of select="query/@time"/>
					</font>
				</td>
				<td>
				</td>
			</tr>
		</table>
	</xsl:template>
	
	<!--	навигатор по страницам -->
	<xsl:template name="pagenavig">
 		<xsl:param name="i" select="1"/>  <!-- счетчик количества страниц отображаемых в навигаторе  -->
 		<xsl:param name="n" select="15"/> <!-- количество страниц отображаемых в навигаторе -->
  		<xsl:param name="z" select="query/@maxpage -14"/>
  		<xsl:param name="f" select="15"/>
 		<xsl:param name="c" select="query/@currentpage"/> <!-- текущая страница в виде -->
 		<xsl:param name="startnum" select="query/@currentpage - 7"/> 
  		<xsl:param name="d" select="query/@maxpage - 14"/>	<!-- переменная для вычисления начального номера страницы в навигаторе  -->
  		<xsl:param name="currentpage" select="query/@currentpage"/>
  		<xsl:param name="maxpage" select="query/@maxpage"/>
  		<xsl:param name="nextpage" select="$currentpage + 1"/>
  		<xsl:param name="prevpage" select="$currentpage - 1"/>
  		<xsl:param name="curview" select="@id"/> 
  		<xsl:param name="direction" select="query/@direction"/> 
		<xsl:choose>
			<xsl:when test="$maxpage>15">
				<xsl:choose>
					<xsl:when test="$maxpage - $currentpage &lt; 7">
						<xsl:if test="$i != $n+1">
							<xsl:if test="$z &lt; $maxpage + 1">
								<td  class="navigation_table_cell">
									<xsl:if test="$z=$currentpage">
    									<xsl:attribute name="class">navigation_table_cell_currentpage</xsl:attribute>
    								</xsl:if>
									<a href="">
   										<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$z"/>)</xsl:attribute>
   			 								<font>
    											<xsl:value-of select="$z"/>
    										</font>
   									</a>
								</td>
							</xsl:if>
      						<xsl:call-template name="pagenavig">
	        					<xsl:with-param name="i" select="$i + 1"/>
	        					<xsl:with-param name="n" select="$n"/>
	        					<xsl:with-param name="z" select="$z+1"/>
      						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td  class="navigation_table_cell">
     								<a href="">
      									<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
      									<font> > </font>
      								</a>
      							</td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font> >> </font>
       								</a>
						        </td>
							</xsl:if>
   						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$currentpage &lt; 7">
								<xsl:if test="$i=1">
									<xsl:if test="$currentpage = 1">
										<td style="border:none">
										</td>
										<td  style="border:none">
										</td>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<td class="navigation_table_cell">
											<xsl:if test="$i=$currentpage">
    											<xsl:attribute name="class">navigation_table_cell_currentpage</xsl:attribute>
    										</xsl:if>
											<a href="">
   				 								<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$i"/>)</xsl:attribute>
												<font>
    												<xsl:value-of select="$i"/>
    											</font>
						   					</a>
										</td>
									</xsl:if>
      								<xsl:call-template name="pagenavig">
	        							<xsl:with-param name="i" select="$i + 1"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
      								</xsl:call-template>
      							</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<xsl:if test="$startnum !=0">
											<td  class="navigation_table_cell">
												<xsl:if test="$startnum=$currentpage">
    												<xsl:attribute name="class">navigation_table_cell_currentpage</xsl:attribute>
    											</xsl:if>
												<a href="">
   				 									<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$startnum"/>)</xsl:attribute>
													<font>
    													<xsl:value-of select="$startnum"/>
    												</font>
						   						</a>
											</td>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$startnum != 0">
      									<xsl:call-template name="pagenavig">
											<xsl:with-param name="i" select="$i + 1"/>
	        								<xsl:with-param name="n" select="$n"/>
	        								<xsl:with-param name="c" select="$c+1"/>
	        								<xsl:with-param name="startnum" select="$c - 6"/>
      									</xsl:call-template>
      								</xsl:if>
									<xsl:if test="$startnum = 0">
      									<xsl:call-template name="pagenavig">
										<xsl:with-param name="i" select="$i"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
	        							<xsl:with-param name="startnum" select="$c - 6"/>
      								</xsl:call-template>
      							</xsl:if>
      						</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td  class="navigation_table_cell">
      								<a href="">
     									<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
     									<font> > </font>
     								</a>
							    </td>
       							<td  class="navigation_table_cell">
       								<a href="">
       									<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font> >> </font>
       								</a> 
							    </td>
							</xsl:if>
  						</xsl:if>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$i=1">
					<xsl:if test="$currentpage = 1">
						<td  style="border:none">
						</td>
						<td  style="border:none">
						</td>
					</xsl:if>
				</xsl:if>
				<xsl:if test="$i != $n+1">
					<xsl:if test="$i &lt; $maxpage + 1">
						<td  class="navigation_table_cell">
							<xsl:if test="$i=$currentpage">
    							<xsl:attribute name="class">navigation_table_cell_currentpage</xsl:attribute>
    						</xsl:if>
							<a href="">
   								<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$i"/>)</xsl:attribute>
   			 					<font>
    								<xsl:value-of select="$i"/>
    							</font>
						    </a>
						</td>
					</xsl:if>
      				<xsl:call-template name="pagenavig">
	        			<xsl:with-param name="i" select="$i + 1"/>
	        			<xsl:with-param name="n" select="$n"/>
	        			<xsl:with-param name="c" select="$c+1"/>
      				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$currentpage != $maxpage">
					<xsl:if test="$i = $n+1">
						<td  class="navigation_table_cell">
      						<a href="">
      							<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
      							<font> > </font>
      						</a>
					    </td>
       					<td  class="navigation_table_cell">
       						<a href="">
       							<xsl:attribute name="href">javascript:updateView('view','<xsl:value-of select="@id"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       							<font> >> </font>
       						</a> 
						</td>
					</xsl:if>
   				</xsl:if>
   			</xsl:otherwise>
  		 </xsl:choose>
 	 </xsl:template>
 	 
 	 <xsl:template name="pagenavigSearch">
 		<xsl:param name="i" select="1"/>  <!-- счетчик количества страниц отображаемых в навигаторе  -->
 		<xsl:param name="n" select="15"/> <!-- количество страниц отображаемых в навигаторе -->
  		<xsl:param name="z" select="query/@maxpage -14"/>
  		<xsl:param name="f" select="15"/>
 		<xsl:param name="c" select="query/@currentpage"/> <!-- текущая страница в виде -->
 		<xsl:param name="startnum" select="query/@currentpage - 7"/> 
  		<xsl:param name="d" select="query/@maxpage - 14"/>	<!-- переменная для вычисления начального номера страницы в навигаторе  -->
  		<xsl:param name="currentpage" select="query/@currentpage"/>
  		<xsl:param name="maxpage" select="query/@maxpage"/>
  		<xsl:param name="nextpage" select="$currentpage + 1"/>
  		<xsl:param name="prevpage" select="$currentpage - 1"/>
  		<xsl:param name="curview" select="@id"/> 
  		<xsl:param name="keyword" select="query/@keyword"/> 
  		<xsl:param name="direction" select="query/@direction"/> 
		<xsl:choose>
			<xsl:when test="$maxpage>15">
				<xsl:choose>
					<xsl:when test="$maxpage - $currentpage &lt; 7">
						<xsl:if test="$i != $n+1">
							<xsl:if test="$z &lt; $maxpage + 1">
								<td>
									<a href="">
   										<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$z"/>)</xsl:attribute>
   			 								<font style="font-size:12px">
    											<xsl:if test="$z=$currentpage">
    												<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    											</xsl:if>
    											<xsl:value-of select="$z"/>
    										</font>
   									</a>&#xA0;
								</td>
							</xsl:if>
      						<xsl:call-template name="pagenavigSearch">
	        					<xsl:with-param name="i" select="$i + 1"/>
	        					<xsl:with-param name="n" select="$n"/>
	        					<xsl:with-param name="z" select="$z+1"/>
      						</xsl:call-template>
						</xsl:if>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
     								<a href="">
      									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
      									<font style="font-size:12px"> > </font>
      								</a>&#xA0;
      							</td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font style="font-size:12px"> >> </font>
       								</a> &#xA0;
						        </td>
							</xsl:if>
   						</xsl:if>
					</xsl:when>
					<xsl:otherwise>
						<xsl:choose>
							<xsl:when test="$currentpage &lt; 7">
								<xsl:if test="$i=1">
									<xsl:if test="$currentpage = 1">
										<td>
											&#xA0;&#xA0;&#xA0;&#xA0;	
										</td>
										<td>
											&#xA0;&#xA0;&#xA0;
										</td>
									</xsl:if>
								</xsl:if>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<td>
											<a href="">
   				 								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$i"/>)</xsl:attribute>
												<font style="font-size:12px">
    												<xsl:if test="$i=$currentpage">
    													<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    												</xsl:if>
    												<xsl:value-of select="$i"/>
    											</font>
						   					</a>&#xA0;
										</td>
									</xsl:if>
      								<xsl:call-template name="pagenavigSearch">
	        							<xsl:with-param name="i" select="$i + 1"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
      								</xsl:call-template>
      							</xsl:if>
							</xsl:when>
							<xsl:otherwise>
								<xsl:if test="$i != $n+1">
									<xsl:if test="$i &lt; $maxpage + 1">
										<xsl:if test="$startnum !=0">
											<td>
												<a href="">
   				 									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$startnum"/>)</xsl:attribute>
													<font style="font-size:12px">
    													<xsl:if test="$startnum=$currentpage">
    														<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    													</xsl:if>
    													<xsl:value-of select="$startnum"/>
    												</font>
						   						</a>&#xA0;
											</td>
										</xsl:if>
									</xsl:if>
									<xsl:if test="$startnum != 0">
      									<xsl:call-template name="pagenavigSearch">
											<xsl:with-param name="i" select="$i + 1"/>
	        								<xsl:with-param name="n" select="$n"/>
	        								<xsl:with-param name="c" select="$c+1"/>
	        								<xsl:with-param name="startnum" select="$c - 6"/>
      									</xsl:call-template>
      								</xsl:if>
									<xsl:if test="$startnum = 0">
      									<xsl:call-template name="pagenavigSearch">
										<xsl:with-param name="i" select="$i"/>
	        							<xsl:with-param name="n" select="$n"/>
	        							<xsl:with-param name="c" select="$c+1"/>
	        							<xsl:with-param name="startnum" select="$c - 6"/>
      								</xsl:call-template>
      							</xsl:if>
      						</xsl:if>
						</xsl:otherwise>
					</xsl:choose>
						<xsl:if test="$currentpage != $maxpage">
							<xsl:if test="$i = $n+1">
		 						<td>
      								<a href="">
     									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$nextpage"/>)</xsl:attribute>
     									<font style="font-size:12px"> > </font>
     								</a>&#xA0;
							    </td>
       							<td>
       								<a href="">
       									<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/>)</xsl:attribute>
       									<font style="font-size:12px"> >> </font>
       								</a> &#xA0;
							    </td>
							</xsl:if>
  						</xsl:if>
						
					</xsl:otherwise>
				</xsl:choose>
			</xsl:when>
			<xsl:otherwise>
				<xsl:if test="$i=1">
					<xsl:if test="$currentpage = 1">
						<td>
							&#xA0;&#xA0;&#xA0;&#xA0;	
						</td>
						<td>
							&#xA0;&#xA0;&#xA0;
						</td>
					</xsl:if>
				</xsl:if>
				<xsl:if test="$i != $n+1">
					<xsl:if test="$i &lt; $maxpage + 1">
						<td>
							<a href="">
   								<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$i"/> )</xsl:attribute>
   			 					<font style="font-size:12px">
    								<xsl:if test="$i=$currentpage">
    									<xsl:attribute name="style">font-weight:bold;font-size:1.3em</xsl:attribute>
    								</xsl:if>
    								<xsl:value-of select="$i"/>
    							</font>
						    </a>&#xA0;
						</td>
					</xsl:if>
      				<xsl:call-template name="pagenavigSearch">
	        			<xsl:with-param name="i" select="$i + 1"/>
	        			<xsl:with-param name="n" select="$n"/>
	        			<xsl:with-param name="c" select="$c+1"/>
      				</xsl:call-template>
				</xsl:if>
				<xsl:if test="$currentpage != $maxpage">
					<xsl:if test="$i = $n+1">
						<td>
      						<a href="">
      							<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>', <xsl:value-of select="$nextpage"/>)</xsl:attribute>
      							<font style="font-size:12px"> > </font>
      						</a>&#xA0;
					    </td>
       					<td>
       						<a href="">
       							<xsl:attribute name="href">javascript:doSearch('<xsl:value-of select="$keyword"/>',<xsl:value-of select="$maxpage"/> );</xsl:attribute>
       							<font style="font-size:12px"> >> </font>
       						</a> &#xA0;
						</td>
					</xsl:if>
   				</xsl:if>
   			</xsl:otherwise>
  		 </xsl:choose>
 	 </xsl:template>
 	 
 	 
	 <xsl:template name="combobox">
		<xsl:param name="i" select="1"/>
		<xsl:param name="k" select="query/@currentpage"/>
 		<xsl:param name="n" select="query/@maxpage + 1"/>
		<xsl:choose>
			<xsl:when test="$n > $i">
				<option>
 					<xsl:attribute name="value"> <xsl:value-of select="$i"/></xsl:attribute>
 					<xsl:if test="$k=$i">
 						<xsl:attribute name="selected">true</xsl:attribute>
 					</xsl:if>
 					<xsl:value-of select="$i"/>
 				</option>
				<xsl:call-template name="combobox">
	        		<xsl:with-param name="i" select="$i + 1"/>
	        		<xsl:with-param name="n" select="$n"/>
	        		<xsl:with-param name="k" select="query/@currentpage"/>
	        	</xsl:call-template>
		 	</xsl:when>
 		</xsl:choose>
	 </xsl:template>
	 
</xsl:stylesheet>