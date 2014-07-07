<?xml version="1.0"?>

<!-- Name: sliders-bw.xsl -->
<!-- Last Modified: 23/11/2010 -->
<!-- Last Modified By: JD -->
<!-- Description: Gives Simpled/Expanded View of Sliders in Black/White|Greyscale -->
<!-- Depends Upon: slider-basic.xsl -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:include href="slider-basic.xsl"/>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">

		<fo:root>

			<fo:layout-master-set>

				<fo:simple-page-master master-name="first" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="4cm" margin-bottom="1cm" />
					<fo:region-before extent="4cm" />
					<fo:region-after extent="1cm" />

				</fo:simple-page-master>

				<fo:simple-page-master master-name="rest" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="1cm" margin-bottom="2cm" />
					<fo:region-before extent="0cm" />
					<fo:region-after extent="2cm" />

				</fo:simple-page-master>

			</fo:layout-master-set>

			<xsl:apply-templates select="Policy/Student" />

		</fo:root>

	</xsl:template>

	<xsl:template match="Student">

		<fo:page-sequence master-reference="first">

			<fo:static-content flow-name="xsl-region-before">

				<fo:table border-collapse="collapse" font-family="sans-serif" table-layout="fixed" width="100%">

					<fo:table-column column-width="20%" />
					<fo:table-column column-width="80%" />

					<fo:table-body>
						<fo:table-row>
							<fo:table-cell padding="1pt" text-align="start">
								<fo:block><fo:external-graphic src="Images/Crest-BW-Small.png"/></fo:block>
							</fo:table-cell>
							<fo:table-cell padding="1pt" text-align="start">
								<fo:block font-size="18pt"><xsl:value-of select="Surname" />, <xsl:value-of select="GivenName" /> (<xsl:value-of select="Form/Group/Code" />)</fo:block>
								<fo:block font-size="24pt" font-weight="bold" color="#666666"><xsl:value-of select="../Name" /></fo:block>
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
					<fo:table-column column-width="80%" />

					<fo:table-body>

						<xsl:apply-templates select="Courses/Course[count(Comments/Comment) &gt; 0]" />

					</fo:table-body>

				</fo:table>

				<fo:block id="studentEnd"/>

			</fo:flow>

		</fo:page-sequence>

	</xsl:template>

	<xsl:template match="Course">

		<fo:table-row keep-together.within-column="always">

			<fo:table-cell padding="1pt" padding-after="10pt">
				<fo:block text-align="start" font-size="12pt" font-family="sans-serif" line-height="12pt" color="#555555">
					<xsl:value-of select="Name" />
				</fo:block>
			</fo:table-cell>

			<fo:table-cell padding="1pt" padding-after="10pt">
				<xsl:for-each select="Comments/Comment">
					<fo:block font-size="11pt" font-weight="bold">
						<xsl:value-of select="Type" /> from <xsl:value-of select="Staff" />
					</fo:block>
					<fo:block padding-after="10pt" font-size="10pt" text-align="justify"><xsl:value-of select="Value" /></fo:block>
				</xsl:for-each>
			</fo:table-cell>

		</fo:table-row>

	</xsl:template>

</xsl:stylesheet>
