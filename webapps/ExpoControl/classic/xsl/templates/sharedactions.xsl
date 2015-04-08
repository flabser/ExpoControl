<?xml version="1.0" encoding="utf-8"?>
<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- кнопка показать xml документ  -->
	<xsl:template name="showxml">
		<xsl:if test="@debug=1">
			<button class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only">
				<xsl:attribute name="onclick">javascript:window.location = window.location + '&amp;onlyxml=1'</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_code.png" class="button_img"/>
					<font class="button_text">XML</font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка сохранения  -->
	<xsl:template name="save">
		<xsl:if test="document/actionbar/action[@id='save_and_close']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id='save_and_close']/@hint}" class="blue-button" id="btnsavedoc" style="margin-right:5px" autocomplete="off">
				<xsl:attribute name="onclick">javascript:SaveFormJquery()</xsl:attribute>
				<span>
					<font class="button_text"><xsl:value-of select="document/actionbar/action[@id='save_and_close']/@caption"/></font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка сформировать отчет -->
	<xsl:template name="filling_report">
		<xsl:if test="document/actionbar/action[@id='save_and_close']/@mode = 'ON'">
			<button title ="{document/actionbar/action[@id='save_and_close']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="margin-right:5px"  id="generatereport" autocomplete="off">
				<xsl:attribute name="onclick">javascript:fillingReport()</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
					<font class="button_text"><xsl:value-of select="document/actionbar/action[@id='save_and_close']/@caption"/></font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="newdiscussion">
		<xsl:if test="document/actions/action [.='COMPOSE_DISCUSSION']/@enable = 'true'">
			<button  title ="{document/actionbar/action[@id = 'COMPOSE_DISCUSSION']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" style="margin-right:5px" autocomplete="off">
				<xsl:attribute name="onclick">javascript:window.location.href="Provider?type=document&amp;id=discussion&amp;docid=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>"</xsl:attribute>
				<span>
					<img src="/SharedResources/img/comment/icons/comments_add.png" class="button_img"/>
					<font class="button_text">Создать обсуждение</font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>

	<!--кнопка закрыть-->
	<xsl:template name="cancelwithjson">
		<button title= "{document/actionbar/action[@id = 'close']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="canceldoc" autocomplete="off">
			<xsl:attribute name="onclick">javascript:<xsl:value-of select="document/actionbar/action[@id = 'close']/js"/></xsl:attribute>
			<span>
				<img src="/SharedResources/img/classic/icons/cross.png" class="button_img"/>
				<font class="button_text"><xsl:value-of select="document/actionbar/action[@id = 'close']/@caption"/></font>
			</span>
		</button>
	</xsl:template>
	
	<xsl:template name="get_document_accesslist">
		<!-- <xsl:if test="document/actionbar/action[@id ='get_document_accesslist']/@mode = 'ON'">
			<button style="margin-right:5px" title= "{document/actionbar/action[@id = 'get_document_accesslist']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off">
				<xsl:attribute name="onclick">javascript:<xsl:value-of select="document/actionbar/action[@id = 'get_document_accesslist']/js"/></xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_white_key.png" class="button_img"/>
					<font class="button_text"><xsl:value-of select="document/actionbar/action[@id = 'get_document_accesslist']/@caption"/></font>
				</span>
			</button>
		</xsl:if> -->
	</xsl:template>
	
	<!--кнопка закрыть-->
	<xsl:template name="cancel">
		<button title= "{document/captions/close/@hint}" class="blue-button" id="canceldoc" autocomplete="off">
			<xsl:attribute name="onclick">javascript:<xsl:value-of select="document/actionbar/action[@id = 'close']/js"/></xsl:attribute>
			<span>
				<font class="button_text"><xsl:value-of select="document/captions/close/@caption"/></font>
			</span>
		</button>
	</xsl:template>

	<!--кнопка ознакомить-->
	<xsl:template name="acquaint">
		<xsl:if test="document/actions/action [.='GRANT_ACCESS']/@enable = 'true'">
			<button title ="{document/actions/action [.='GRANT_ACCESS']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btngrantaccess" style="margin-right:5px" autocomplete="off">
				<xsl:attribute name="onclick">javascript:acquaint(<xsl:value-of select="document/@docid"/>,<xsl:value-of select="document/@doctype"/>)</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_white_get.png" class="button_img"/>
					<font class="button_text"><xsl:value-of select="document/actions/action [.='GRANT_ACCESS']/@caption"/></font>
				</span>
			</button>
			<script>
				acquaintcaption = '<xsl:value-of select="document/actions/action[.='GRANT_ACCESS']/@caption"/>';
			</script>
		</xsl:if>
	</xsl:template>

	<!--кнопка напомнить-->
	<xsl:template name="remind">
		<xsl:if test="document/actions/action [.='NOTIFY_EXECUTERS']/@enable = 'true'">
			<button title= "{document/actions/action [.='NOTIFY_EXECUTERS']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" id="btnremind" style="margin-right:5px" autocomplete="off">
				<xsl:attribute name="onclick">javascript:remind(<xsl:value-of select="document/@docid"/>,<xsl:value-of select="document/@doctype"/>)</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/clock_red.png" class="button_img"/>
					<font class="button_text"><xsl:value-of select="document/actions/action [.='NOTIFY_EXECUTERS']/@caption"/></font>
				</span>
			</button>
			<script>
				remindcaption = '<xsl:value-of select="document/actions/action[.='NOTIFY_EXECUTERS']/@caption"/>';
			</script>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="projects_buttons">
		<!-- кнопка "сохранить как черновик" -->
		<xsl:if test="document/actionbar/action[@id ='save_as_draft']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='save_as_draft']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btnsavedraft" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:savePrjAsDraft('<xsl:value-of select="history/entry[@type = 'page'][last()]" />')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/disk.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='save_as_draft']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "отправить на подпись" -->
		<xsl:if test="document/actionbar/action[@id ='send']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='send']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btnsendsign" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:saveAndSend('<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_white_edit.png" class="button_img" />
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='send']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "отправить на согласование" -->
		<xsl:if test="document/actionbar/action[@id ='to_coordinate']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='to_coordinate']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btntocoordinate" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:saveAndCoord('<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_white_go.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='to_coordinate']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "подписать" -->
		<xsl:if test="document/actionbar/action[@id ='sign_yes']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='sign_yes']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btnsign" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:decision('yes','<xsl:value-of select="document/@docid"/>','sign_yes','<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/accept.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='sign_yes']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "отклонить" -->
		<xsl:if test="document/actionbar/action[@id ='sign_no']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='sign_no']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btnsignno" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:decision('no','<xsl:value-of select="document/@docid"/>','sign_no','<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/cancel.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='sign_no']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "согласен" -->
		<xsl:if test="document/actionbar/action[@id ='coord_yes']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='coord_yes']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btncoordyes" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:decision('yes','<xsl:value-of select="document/@docid"/>','coord_yes','<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/tick.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='coord_yes']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "не согласен" -->
		<xsl:if test="document/actionbar/action[@id ='coord_no']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id ='coord_no']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btncoordno" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:decision('no','<xsl:value-of select="document/@docid"/>','coord_no','<xsl:value-of select="history/entry[@type = 'page'][last()]"/>')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/delete.png" class="button_img"/>
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id ='coord_no']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
		<!-- кнопка "остановить документ" -->
		<xsl:if test="document/actionbar/action[@id='stop_document']/@mode = 'ON'">
			<button title="{document/actionbar/action[@id='stop_document']/@hint}" class="ui-button ui-widget ui-state-default ui-corner-all ui-button-text-only" autocomplete="off" id="btnstopdoc" style="margin-right:5px">
				<xsl:attribute name="onclick">javascript:stopdocument('<xsl:value-of select="document/@docid" />')</xsl:attribute>
				<span>
					<img src="/SharedResources/img/classic/icons/page_white_delete.png" class="button_img" />
					<font class="button_text">
						<xsl:value-of select="document/actionbar/action[@id='stop_document']/@caption"/>
					</font>
				</span>
			</button>
		</xsl:if>
	</xsl:template>
	
	<xsl:template name="ECPsign">
	<!--  	<xsl:if test="document/@sign != '1'">
			<button>
				<xsl:attribute name="onclick">edsApp.sign('<xsl:value-of select="@id"/>', this); return false;</xsl:attribute>
				<img src="/SharedResources/img/iconset/page_edit.png" class="button_img"/>
				<font style="font-size:12px; vertical-align:top">Добавить ЭЦП</font>
			</button>
		</xsl:if>-->
	</xsl:template>
</xsl:stylesheet>