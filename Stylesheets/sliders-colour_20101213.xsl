<?xml version="1.0"?>

<!-- Name: sliders-colour.xsl -->
<!-- Last Modified: 23/11/2010 -->
<!-- Last Modified By: JD -->
<!-- Description: Gives Simpled/Expanded View of Sliders in Colour -->
<!-- Depends Upon: slider-basic.xsl -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:include href="slider-basic.xsl"/>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">

		<fo:root>

			<fo:layout-master-set>

				<fo:simple-page-master master-name="first" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="4cm" margin-bottom="2cm" />
					<fo:region-before extent="4cm" />
					<fo:region-after extent="1cm" />

				</fo:simple-page-master>

				<fo:simple-page-master master-name="rest" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="1cm" margin-bottom="2cm" />
					<fo:region-before extent="0cm" />
					<fo:region-after extent="1cm" />

				</fo:simple-page-master>

			</fo:layout-master-set>

			<xsl:apply-templates select="Policy/Student" />

		</fo:root>

	</xsl:template>

	<xsl:template match="Student">

		<fo:page-sequence master-reference="first">

			<fo:static-content flow-name="xsl-region-before">

				<fo:table border-collapse="collapse" font-family="sans-serif" table-layout="fixed" width="100%">

					<fo:table-column column-width="70%" />
					<fo:table-column column-width="30%" />

					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding="1pt" text-align="start">
								<fo:block font-size="18pt"><xsl:value-of select="Surname" />, <xsl:value-of select="GivenName" /> (<xsl:value-of select="Form/Group/Code" />)</fo:block>
								<fo:block font-size="24pt" font-weight="bold" color="#666666"><xsl:value-of select="../Name" /></fo:block>
							</fo:table-cell>
							<fo:table-cell padding="1pt" text-align="end">
								<fo:block><fo:external-graphic src="Images/Crest-Colour-Small.png"/></fo:block>
							</fo:table-cell>
						</fo:table-row>
					</fo:table-body>

				</fo:table>

			</fo:static-content>

			<fo:static-content flow-name="xsl-region-after">

				<fo:block text-align="right" border-top="1pt solid black" padding-top="1mm">
					Page <fo:page-number/> of <fo:page-number-citation ref-id="studentEnd"/>
				</fo:block>

			</fo:static-content>

			<fo:flow flow-name="xsl-region-body">

				<fo:table border-collapse="collapse" font-size="12pt" font-family="sans-serif" table-layout="fixed" width="100%">

					<fo:table-column column-width="20%" />
					<fo:table-column column-width="40%" />
					<fo:table-column column-width="40%" />

					<fo:table-header font-weight="bold">

						<fo:table-row>
							<fo:table-cell padding="1pt">
								<fo:block></fo:block>
							</fo:table-cell>
							<fo:table-cell padding="1pt" text-align="end">
								<fo:block>Commitment</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="1pt" text-align="end">
								<fo:block>Attainment</fo:block>
							</fo:table-cell>
						</fo:table-row>

					</fo:table-header>

					<fo:table-body>

						<xsl:apply-templates select="Courses/Course" />

					</fo:table-body>

				</fo:table>

				<fo:block id="studentEnd"/>

			</fo:flow>

		</fo:page-sequence>

	</xsl:template>

	<xsl:template match="Course">

		<fo:table-row keep-together.within-column="always" >

			<fo:table-cell padding="1pt" display-align="center">
				<fo:block text-align="start" font-size="14pt" font-family="sans-serif" line-height="18pt" font-weight="bold">
					<xsl:value-of select="Code" />
				</fo:block>
				<fo:block text-align="end" font-size="10pt" font-family="sans-serif" line-height="12pt" color="#555555">
					<xsl:value-of select="Name" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell padding="1pt" display-align="center">
				<fo:block>
					<xsl:for-each select="Skills/Skill[Name='Commitment']">
						<fo:instream-foreign-object>
							<xsl:call-template name="Slider">
								<xsl:with-param name="_displayMode" select="'colour'" />
								<xsl:with-param name="_showAllBands" select="false()" />
								<xsl:with-param name="_showLabel" select="true()" />
								<xsl:with-param name="_showBandNames" select="true()" />
								<xsl:with-param name="_showBandPositions" select="true()" />
								<xsl:with-param name="_thickness" select="1" />
								<xsl:with-param name="_deltaPrevious" select="0.05" />
								<xsl:with-param name="_showPreviousMovement" select="true()" />
								<xsl:with-param name="_width" select="210" />
								<xsl:with-param name="_height" select="30" />
							</xsl:call-template>
						</fo:instream-foreign-object>
					</xsl:for-each>
				</fo:block>
			</fo:table-cell>

			<fo:table-cell padding="1pt" display-align="center">
				<fo:block>
					<xsl:for-each select="Skills/Skill[Name='Attainment']">
						<fo:instream-foreign-object>
							<xsl:call-template name="Slider">
								<xsl:with-param name="_displayMode" select="'colour'" />
								<xsl:with-param name="_showAllBands" select="false()" />
								<xsl:with-param name="_showLabel" select="false()" />
								<xsl:with-param name="_showBandNames" select="true()" />
								<xsl:with-param name="_showBandPositions" select="false()" />
								<xsl:with-param name="_thickness" select="1" />
								<xsl:with-param name="_deltaPrevious" select="0.05" />
								<xsl:with-param name="_showPreviousMovement" select="true()" />
								<xsl:with-param name="_width" select="210" />
								<xsl:with-param name="_height" select="30" />
							</xsl:call-template>
						</fo:instream-foreign-object>
					</xsl:for-each>
				</fo:block>
			</fo:table-cell>

		</fo:table-row>

		<xsl:apply-templates select="Skills/Skill[Name!='Attainment' and Name!='Commitment']" />

	</xsl:template>

	<xsl:template match="Skill">

		<xsl:choose>
			<xsl:when test="Name='Commitment'" />
			<xsl:when test="Name='Attainment'" />
			<xsl:otherwise>
				<fo:table-row>
					<fo:table-cell number-columns-spanned="2" padding="1pt" display-align="center">
						<fo:block text-align="end" font-size="9pt" font-family="sans-serif" line-height="10pt" color="#888888">
							<xsl:apply-templates select="Name" />
						</fo:block>
					</fo:table-cell>
					<fo:table-cell padding="1pt" display-align="center">
						<fo:block>
							<fo:instream-foreign-object>
								<xsl:call-template name="Slider">
									<xsl:with-param name="_displayMode" select="'colour'" />
									<xsl:with-param name="_showAllBands" select="false()" />
									<xsl:with-param name="_showLabel" select="false()" />
									<xsl:with-param name="_showBandNames" select="false()" />
									<xsl:with-param name="_showBandPositions" select="false()" />
									<xsl:with-param name="_showBackground" select="false()" />
									<xsl:with-param name="_thickness" select="1" />
									<xsl:with-param name="_deltaPrevious" select="0.05" />
									<xsl:with-param name="_showPreviousMovement" select="true()" />
									<xsl:with-param name="_width" select="210" />
									<xsl:with-param name="_height" select="20" />
								</xsl:call-template>
							</fo:instream-foreign-object>
						</fo:block>
					</fo:table-cell>
				</fo:table-row>
			</xsl:otherwise>
		</xsl:choose>

	</xsl:template>

</xsl:stylesheet>
