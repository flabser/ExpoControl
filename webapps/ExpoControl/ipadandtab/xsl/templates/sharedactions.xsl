<?xml version="1.0" encoding="windows-1251"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
	
	<!-- кнопка показать xml документ  -->
	<xsl:template name="showxml">
		<xsl:if test="@debug=1">
			<a style="margin-left:5; vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">javascript:window.location = window.location + '&amp;onlyxml=1'</xsl:attribute>
				<font>XML</font>
			</a>&#xA0;
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка сохранения  -->
	
	<xsl:template name="save">
		<xsl:if test="document/actions/action [.='SAVE']/@enable = 'true'">
			<a style="vertical-align:12px">
				<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>')</xsl:attribute>
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:choose>
					<xsl:when test="@id='ish' and document/fields/vn = ''">
						<font><xsl:value-of select="document/captions/regdoc/@caption"/></font>
					</xsl:when>
					<xsl:when test="@id='ISH' and document/fields/vn = ''">
						<font><xsl:value-of select="document/captions/regdoc/@caption"/></font>
					</xsl:when>
					<xsl:otherwise>
						<font><xsl:value-of select="document/actions/action [.='SAVE']/@caption"/></font>
					</xsl:otherwise>
				</xsl:choose>
			</a>&#xA0;
		</xsl:if>
			
	</xsl:template>
	
	<!-- кнопка сохранения карточки резолюции  -->
	<xsl:template name="saveKR">
		<xsl:if test="document/actions/action [.='SAVE']/@enable = 'true'">
			<a style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][last()],'/SmartDocWebKMG/')"/>', 'kr')</xsl:attribute>
				<font><xsl:value-of select="document/actions/action [.='SAVE']/@caption"/></font>
			</a>&#xA0;
		</xsl:if>
			
	</xsl:template>
	
	<!-- кнопка сохранения карточки исполнения  -->
	<xsl:template name="saveKI">
		<xsl:if test="document/actions/action [.='SAVE']/@enable = 'true'">
			<a style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">javascript:SaveFormJquery('frm','frm','<xsl:value-of select="substring-after(history/entry[@type eq 'outline'][1],'/SmartDocWebKMG/')"/>', 'ki')</xsl:attribute>
				<font><xsl:value-of select="document/actions/action [.='SAVE']/@caption"/></font>
			</a>&#xA0;
		</xsl:if>
	</xsl:template>
	
	<!-- кнопка новой резолюции  -->
	<xsl:template name="newkr">
		<xsl:if test="document/actions/action [.='COMPOSE_TASK']/@enable = 'true'">
			<a id="taskLink" style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">Provider?type=document&amp;id=kr&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>&amp;page=null</xsl:attribute>
				<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
				<font><xsl:value-of select="document/actions/action [.='COMPOSE_TASK']/@caption"/></font>					
			</a>&#xA0;
		</xsl:if>
	</xsl:template>

	<!-- кнопка нового перепоручения  -->
	<xsl:template name="newkp">
		<xsl:if test="document/actions/action [.='COMPOSE_TASK']/@enable = 'true'">
			<a id="taskLink" style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">Provider?type=document&amp;id=kr&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>&amp;page=null</xsl:attribute>
				<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
				<font><xsl:value-of select="document/captions/kp/@caption"/></font>					
			</a>&#xA0;	
		</xsl:if>
	</xsl:template>

	<!-- кнопка карточка исполнения  -->
	<xsl:template name="newki">
		<xsl:if test="document/actions/action [.='COMPOSE_EXECUTION']/@enable = 'true'">
			<a id="executionLink" style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">Provider?type=document&amp;id=ki&amp;key=&amp;parentdocid=<xsl:value-of select="document/@docid"/>&amp;parentdoctype=<xsl:value-of select="document/@doctype"/>&amp;page=null</xsl:attribute>
				<xsl:attribute name="onclick">javascript:beforeOpenDocument()</xsl:attribute>
				<font><xsl:value-of select="document/actions/action [.='COMPOSE_EXECUTION']/@caption"/></font>					
			</a>&#xA0;
		</xsl:if>
	</xsl:template>
	
	<!-- 	кнопка сформировать отчет -->
	<xsl:template name="filling_report">
		<xsl:if test="document/actions/action [.='SAVE']/@enable = 'true'">
			<a style="vertical-align:12px">
				<xsl:attribute name="class">gray button form</xsl:attribute>
				<xsl:attribute name="href">javascript:fillingReport()</xsl:attribute>
				<font><xsl:value-of select="document/actions/action [.='SAVE']/@caption"/></font>
			</a>
		</xsl:if>
	</xsl:template>
	
	<!--кнопка закрыть-->
	<xsl:template name="cancel">
		<a style="vertical-align:12px">
			<xsl:attribute name="class">gray button form</xsl:attribute>
			<xsl:attribute name="id">cancel</xsl:attribute>
			<xsl:attribute name="href">javascript:CancelForm()</xsl:attribute>
			<font><xsl:value-of select="document/captions/close/@caption"/></font>					
		</a>
	</xsl:template>

	<!--кнопка ознакомить-->
<xsl:template name="acquaint">
	<xsl:if test="document/actions/action [.='GRANT_ACCESS']/@enable = 'true'">
		<a style="vertical-align:12px">
			<xsl:attribute name="class">gray button form</xsl:attribute>
			<xsl:attribute name="href">javascript:acquaint(<xsl:value-of select="document/@docid"/>,<xsl:value-of select="document/@doctype"/>)</xsl:attribute>
			<font><xsl:value-of select="document/actions/action [.='GRANT_ACCESS']/@caption"/></font>					
		</a>&#xA0;
	</xsl:if>
		
</xsl:template>

	<!--кнопка напомнить-->
<xsl:template name="remind">
	<xsl:if test="document/actions/action [.='NOTIFY_EXECUTERS']/@enable = 'true'">
		<a style="vertical-align:12px">
			<xsl:attribute name="class">gray button form</xsl:attribute>
			<xsl:attribute name="href">javascript:remind(<xsl:value-of select="document/@docid"/>,<xsl:value-of select="document/@doctype"/>)</xsl:attribute>
			<font><xsl:value-of select="document/actions/action [.='NOTIFY_EXECUTERS']/@caption"/></font>					
		</a>&#xA0;
	</xsl:if>
</xsl:template>
</xsl:stylesheet>