<?xml version="1.0"?>
<xsl:stylesheet
	version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
	xmlns:d="http://docbook.org/ns/docbook"
	xmlns:ds="https://www.cardina1.red/_ns/docbook/stylesheet"
	exclude-result-prefixes="xsl d ds"
>

<xsl:import href="layouts/xsl/docbook/xsl/docbook.xsl" />
<xsl:import href="layouts/xsl/easy-html.xsl" />

<!-- set output format -->
<xsl:output method="xml" encoding="utf-8" indent="yes" omit-xml-declaration="yes" />

<xsl:template match="/"><xsl:apply-templates /></xsl:template>

<!-- Customization of docbook stylesheet. -->
<xsl:template match="d:abbrev | d:acronym" mode="ds:attr-custom">
	<xsl:call-template name="ds:attr-custom" />
	<xsl:if test="@title">
		<xsl:attribute name="title">
			<xsl:value-of select="@title" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template match="d:date" mode="ds:attr-custom">
	<xsl:call-template name="ds:attr-custom" />
	<xsl:if test="@datetime">
		<xsl:attribute name="datetime">
			<xsl:value-of select="@datetime" />
		</xsl:attribute>
	</xsl:if>
</xsl:template>

<xsl:template name="permalink">
	<xsl:param name="node" select="." />
	<xsl:param name="id" select="$node/@xml:id" />

	<xsl:variable name="normalized-id" select="normalize-space($id)" />
	<xsl:if test="$normalized-id != ''">
		<xsl:element name="a" namespace="{$ds:html-ns}">
			<xsl:attribute name="class">
				<xsl:text>permalink</xsl:text>
			</xsl:attribute>
			<xsl:attribute name="href">
				<xsl:text>#</xsl:text>
				<xsl:value-of select="$normalized-id" />
			</xsl:attribute>
			<xsl:comment />
		</xsl:element>
	</xsl:if>
</xsl:template>

<xsl:template match="d:title" mode="ds:section-heading-inner">
	<xsl:apply-templates />
	<xsl:variable name="sect-id">
		<xsl:apply-templates select="." mode="ds:section-id" />
	</xsl:variable>
	<xsl:call-template name="permalink">
		<xsl:with-param name="id" select="$sect-id" />
	</xsl:call-template>
</xsl:template>

<xsl:template match="d:term" mode="ds:inner">
	<xsl:apply-templates />
	<xsl:call-template name="permalink" />
</xsl:template>

<!-- TODO: Treat source URI of `d:blockquote`. -->

</xsl:stylesheet>