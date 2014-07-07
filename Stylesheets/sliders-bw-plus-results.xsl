<?xml version="1.0"?>

<!-- Name: sliders-bw-plus-results.xsl -->
<!-- Last Modified: 13/12/2010 -->
<!-- Last Modified By: JD -->
<!-- Description: Gives Simpled/Expanded View of Sliders in Black/White|Greyscale with Results (if available) -->
<!-- Depends Upon: slider-basic.xsl -->

<xsl:stylesheet version="2.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:fo="http://www.w3.org/1999/XSL/Format">

	<xsl:include href="slider-basic.xsl"/>
	<xsl:output method="xml" indent="yes"/>

	<xsl:template match="/">

		<fo:root>

			<fo:layout-master-set>

				<fo:simple-page-master master-name="first" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="4cm" margin-bottom="2.5cm" />
					<fo:region-before extent="4cm" />
					<fo:region-after extent="1.5cm" />

				</fo:simple-page-master>

				<fo:simple-page-master master-name="rest" page-height="29.7cm" page-width="21cm" margin-top="1cm" margin-bottom="1cm" margin-left="1cm" margin-right="1cm">

					<fo:region-body margin-top="1cm" margin-bottom="2.5cm" />
					<fo:region-before extent="0cm" />
					<fo:region-after extent="1.5cm" />

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

				<fo:block border-top="1pt solid black">

				<fo:table table-layout="fixed" width="100%">

					<fo:table-column column-width="88%" />
					<fo:table-column column-width="12%" />

					<fo:table-body>

						<fo:table-row>

							<fo:table-cell font-size="8pt">
								<fo:block text-align="start" padding="2pt">1 = Poor, 2 = Below Expectations, 3 = Satisfactory, 4 = Good, 5 = Very Good</fo:block>
								<fo:block text-align="start" padding="2pt" font-size="7pt">Main Triangle = Current Position, Smaller Triangle (not always present) = Previous Position, Background Bar = Statistically Predicted Attainment Range (may change between reporting/profile cycles due to collected data and updated statistical models)</fo:block>
							</fo:table-cell>

							<fo:table-cell>
								<fo:block text-align="right" padding="2pt" font-size="9pt">
									Page <fo:page-number/> of <fo:page-number-citation ref-id="studentEnd"/>
								</fo:block>
							</fo:table-cell>

						</fo:table-row>

					</fo:table-body>

				</fo:table>

			</fo:block>

			</fo:static-content>

			<fo:flow flow-name="xsl-region-body">

				<fo:table border-collapse="collapse" font-size="12pt" font-family="sans-serif" table-layout="fixed" width="100%">

					<fo:table-column column-width="20%" />
					<fo:table-column column-width="80%" />

					<fo:table-body>

						<fo:table-row>
							<fo:table-cell padding="1pt">
								<fo:block></fo:block>
							</fo:table-cell>
							<fo:table-cell>

								<fo:table border-collapse="collapse" font-size="12pt" font-family="sans-serif" table-layout="fixed" width="100%">

									<fo:table-column column-width="50%" />
									<fo:table-column column-width="50%" />

									<fo:table-body>

										<fo:table-row>
											<fo:table-cell padding="1pt" text-align="center">
												<fo:block>Commitment</fo:block>
											</fo:table-cell>
											<fo:table-cell padding="1pt" text-align="center">
												<fo:block>Attainment</fo:block>
											</fo:table-cell>
										</fo:table-row>

									</fo:table-body>

								</fo:table>

							</fo:table-cell>

						</fo:table-row>

						<xsl:apply-templates select="Courses/Course[Name!='Registration']" />

					</fo:table-body>

				</fo:table>

				<fo:block id="studentEnd"/>

			</fo:flow>

		</fo:page-sequence>

	</xsl:template>

	<xsl:template match="Course">

		<fo:table-row keep-together.within-column="always">

			<fo:table-cell padding="1pt">

				<fo:block text-align="start" font-size="11pt" font-family="sans-serif" line-height="12pt" color="#555555" padding-top="14px">
					<xsl:value-of select="Name" />
				</fo:block>

				<!-- Exam Results -->
				<xsl:apply-templates select="Results/Result[Type='Exams']" />

			</fo:table-cell>

			<fo:table-cell>
				<fo:table border-collapse="collapse" font-size="12pt" font-family="sans-serif" table-layout="fixed" width="100%">

					<fo:table-column column-width="50%" />
					<fo:table-column column-width="50%" />

					<fo:table-body>

						<fo:table-row>
							<fo:table-cell padding="1pt" text-align="center">
								<fo:block>
								<xsl:for-each select="Skills/Skill[Name='Commitment']">
									<fo:instream-foreign-object>
										<xsl:call-template name="Slider">
											<xsl:with-param name="_displayMode" select="'bw'" />
											<xsl:with-param name="_showAllBands" select="true()" />
											<xsl:with-param name="_showLabel" select="false()" />
											<xsl:with-param name="_showBandNames" select="true()" />
											<xsl:with-param name="_showBandPositions" select="true()" />
											<xsl:with-param name="_showBackground" select="false()" />
											<xsl:with-param name="_thickness" select="1" />
											<xsl:with-param name="_deltaPrevious" select="0.05" />
											<xsl:with-param name="_showPreviousMovement" select="false()" />
											<xsl:with-param name="_width" select="210" />
											<xsl:with-param name="_height" select="30" />
										</xsl:call-template>
									</fo:instream-foreign-object>
								</xsl:for-each>
							</fo:block>
							</fo:table-cell>
							<fo:table-cell padding="1pt" text-align="center">
									<fo:block>
										<xsl:for-each select="Skills/Skill[Name='Attainment']">
											<fo:instream-foreign-object>
												<xsl:call-template name="Slider">
													<xsl:with-param name="_displayMode" select="'bw'" />
													<xsl:with-param name="_showAllBands" select="true()" />
													<xsl:with-param name="_showLabel" select="false()" />
													<xsl:with-param name="_showBandNames" select="true()" />
													<xsl:with-param name="_showBandPositions" select="false()" />
													<xsl:with-param name="_thickness" select="1" />
													<xsl:with-param name="_deltaPrevious" select="0.05" />
													<xsl:with-param name="_showPreviousMovement" select="false()" />
													<xsl:with-param name="_width" select="210" />
													<xsl:with-param name="_height" select="30" />
												</xsl:call-template>
											</fo:instream-foreign-object>
										</xsl:for-each>
									</fo:block>
							</fo:table-cell>
						</fo:table-row>
						<xsl:for-each select="Skills/Skill[Name!='Attainment' and Name!='Commitment']">
							<fo:table-row>
								<fo:table-cell padding="1pt" display-align="center">
									<fo:block text-align="end" font-size="9pt" font-family="sans-serif" line-height="10pt" color="#888888">
										<xsl:apply-templates select="Name" />
									</fo:block>
								</fo:table-cell>
								<fo:table-cell padding="1pt" display-align="center">
									<fo:block>
										<fo:instream-foreign-object>
											<xsl:call-template name="Slider">
												<xsl:with-param name="_displayMode" select="'bw'" />
												<xsl:with-param name="_showAllBands" select="true()" />
												<xsl:with-param name="_showLabel" select="false()" />
												<xsl:with-param name="_showBandNames" select="false()" />
												<xsl:with-param name="_showBandPositions" select="false()" />
												<xsl:with-param name="_showBackground" select="false()" />
												<xsl:with-param name="_thickness" select="1" />
												<xsl:with-param name="_deltaPrevious" select="0.05" />
												<xsl:with-param name="_showPreviousMovement" select="false()" />
												<xsl:with-param name="_width" select="210" />
												<xsl:with-param name="_height" select="20" />
											</xsl:call-template>
										</fo:instream-foreign-object>
									</fo:block>
								</fo:table-cell>
							</fo:table-row>
						</xsl:for-each>

					</fo:table-body>
				</fo:table>

			</fo:table-cell>

		</fo:table-row>

	</xsl:template>

	<xsl:template match="Result">

		<fo:block text-align="start" font-size="9pt" font-family="sans-serif" line-height="10pt" color="#888888" padding-top="12px">
			Exam Result: <fo:inline color="#111111" font-weight="bold"><xsl:value-of select="Value" /></fo:inline>%
		</fo:block>

	</xsl:template>

</xsl:stylesheet>