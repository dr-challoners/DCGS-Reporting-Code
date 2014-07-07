<?xml version="1.0" encoding="utf-8"?>
<xsl:transform xmlns:xsl="http://www.w3.org/1999/XSL/Transform" xmlns:math="http://exslt.org/math" extension-element-prefixes="math" version="2.0" >

	<xsl:output method="xml" indent="yes"/>

	<xsl:template name="Slider">

		<!-- SVG Image Parameters -->
		<!-- Overall SVG Image Width -->
		<xsl:param name="_width" select="400"/>

		<!-- Overall SVG Image Height -->
		<xsl:param name="_height" select="50"/>

		<!-- X-Dimension Margin Size -->
		<xsl:param name="_marginX" select="1" />

		<!-- Y-Dimension Margin Size -->
		<xsl:param name="_marginY" select="1" />


		<!-- Slider Parameters -->
		<!-- Slider Border Width -->
		<xsl:param name="_thickness" select="2" />

		<!-- Slider Marker Width -->
		<xsl:param name="_markerX" select="$_width div 20" />

		<!-- Slider Marker Height (Normally Calculated to ensure Equalateral) -->
		<xsl:param name="_markerY" select="$_markerX * math:cos(30 * (math:constant('PI', 10) div 180))" />

		<!-- Slider Previous Height -->
		<xsl:param name="_previousY" select="$_height div 5" />

		<!-- Slider Previous Width (Normally Calculated to ensure Equalateral -->
		<xsl:param name="_previousX" select="($_previousY div 2) * math:sin(60 * (math:constant('PI', 10) div 180))" />


		<!-- General Visualisation Parameters -->
		<!-- Whether Band/Boundary Names are shown [true()|false()] -->
		<xsl:param name="_showBandNames" select="true()"/>

		<!-- Whether Band/Boundary Positions are shown rather than Names -->
		<!-- (Show Band Names must be set to true() as well [true()|false()] -->
		<xsl:param name="_showBandPositions" select="false()"/>

		<!-- Whether All Bands/Boundaries are shown, or just relevant [true()|false()] -->
		<xsl:param name="_showAllBands" select="false()"/>

		<!-- Whether Background Label is shown [true()|false()] -->
		<xsl:param name="_showLabel" select="true()"/>

		<!-- Previous Delta (Show previous if delta larger than this, set to greater than 1 to hide previous)  -->
		<xsl:param name="_deltaPrevious" select="0.1"/>

		<!-- Whether Previous Point is shown [true()|false()]  -->
		<xsl:param name="_showPreviousMovement" select="false()"/>

		<!-- Display Mode [colour|bw]  -->
		<xsl:param name="_displayMode" select="'colour'"/>

		<!-- Whether to Show Background [true()|false()]  -->
		<xsl:param name="_showBackground" select="true()"/>

		<!-- Internal Template Variables -->
		<xsl:variable name="_value" select="Value"/>
		<xsl:variable name="_label" select="Label"/>
		<xsl:variable name="_name" select="Name"/>
		<xsl:variable name="_previous" select="Previously/Value[1]"/>

		<svg
			width="{$_width}"
			height="{$_height}"
			xmlns="http://www.w3.org/2000/svg">

			<style type="text/css" >
				<![CDATA[

					rect.border-colour
						{
							fill: #908DA7;
							stroke: #302E3C;
						}

					rect.border-bw
						{
							fill: none;
							stroke: #121212;
						}

					rect.background-colour
						{
							fill: #D1CC7D;
						}

					rect.background-bw
						{
							fill: #C3C3C3;
						}

						line.boundary-colour
						{
							stroke: #C3C3C3;
							stroke-dasharray: 3 2;
						}
					line.boundary-bw
						{
							stroke: #C3C3C3;
							stroke-dasharray: 3 2;
						}

					text.boundary-colour
						{
							fill: #FFFFFF;
							font-family: sans-serif;
							text-anchor: middle;
						}

					text.boundary-bw
						{
							fill: #888888;
							font-family: sans-serif;
							text-anchor: middle;
						}

					text.background-colour
						{
							fill: #FFFFFF;
							font-family: sans-serif;
							text-anchor: start;
						}

					text.background-bw
						{
							fill: #888888;
							font-family: sans-serif;
							text-anchor: start;
						}

					polygon.marker-colour polygon.previousMarker-colour
						{
							fill: #12004B;
						}

					polygon.marker-bw polygon.previousMarker-bw
						{
							fill: #000000;
						}

					path.up-colour
						{
							stroke: #00FF00;
							stroke-dasharray: 4 2;
							fill: none;
						}

					path.up-bw, path.down-bw
						{
							stroke: #444444;
							stroke-dasharray: 4 2;
							fill: none;
						}

					marker.up-colour
						{
							fill: #00FF00;
						}

					marker.up-bw, marker.down-bw
						{
							fill: #444444;
						}

					path.down-colour
						{
							stroke: #FF0000;
							stroke-dasharray: 4 2;
							fill: none;
						}

					marker.down-colour
						{
							fill: #FF0000;
						}

				]]>
			</style>

			<title>Slider for <xsl:value-of select="Code"/></title>
			<desc>Slider Image for <xsl:value-of select="Code"/> Course</desc>

				<defs>

					<marker id="arrow-down" class="down-{$_displayMode}" viewBox="0 0 {math:cos(30 * (math:constant('PI', 10) div 180))} 1" refX="0.5" refY="0.5" markerHeight="3" markerWidth="{3 * math:cos(30 * (math:constant('PI', 10) div 180))}" markerUnits="strokeWidth" orient="auto">
						<polyline points="0,0 {math:cos(30 * (math:constant('PI', 10) div 180))},0.5 0,1" />
					</marker>

					<marker id="arrow-up" class="up-{$_displayMode}" viewBox="0 0 {math:cos(30 * (math:constant('PI', 10) div 180))} 1" refX="0.5" refY="0.5" markerHeight="3" markerWidth="{3 * math:cos(30 * (math:constant('PI', 10) div 180))}" markerUnits="strokeWidth" orient="auto">
						<polyline points="0,0 {math:cos(30 * (math:constant('PI', 10) div 180))},0.5 0,1" />
					</marker>

					<marker id="circle-down" class="down-{$_displayMode}" viewBox="0 0 1 1" refX="0.5" refY="0.5" markerHeight="2" markerWidth="2" markerUnits="strokeWidth" orient="auto">
						<circle cx="0.5" cy="0.5" r="0.5" />
					</marker>

					<marker id="circle-up" class="up-{$_displayMode}" viewBox="0 0 1 1" refX="0.5" refY="0.5" markerHeight="2" markerWidth="2" markerUnits="strokeWidth" orient="auto">
						<circle cx="0.5" cy="0.5" r="0.5" />
					</marker>

				</defs>

			<xsl:variable name="_canvasWidth" select="$_width - ($_marginX * 2)" />
			<xsl:variable name="_canvasHeight" select="$_height - ($_marginY * 2)" />

			<!-- Working within Margins Here -->
			<svg x="{$_marginX}" y="{$_marginY}" width="{$_canvasWidth}" height="{$_canvasHeight}">

				<!-- Draw Slider Border -->
				<rect
					class="border-{$_displayMode}"
					x="{$_thickness div 2}"
					y="{$_markerY div 2}"
					width="{$_canvasWidth - $_thickness}"
					height="{$_canvasHeight - (($_thickness div 2) + ($_markerY div 2))}"
					rx="{$_canvasWidth div 50}"
					ry="{$_canvasWidth div 50}"
					stroke-width="{$_thickness}"
				/>

				<xsl:variable name="_plotWidth" select="$_canvasWidth - ($_thickness * 2)" />
				<xsl:variable name="_plotHeight" select="$_canvasHeight - (($_thickness * 1.5) + ($_markerY div 2))" />

				<!-- Working within Plot/Rectangle Internal Here -->
				<svg x="{$_thickness}" y="{($_thickness div 2) + ($_markerY div 2)}" width="{$_plotWidth}" height="{$_plotHeight}">

					<xsl:variable name="_bandWidth" select="1 div (count(Bands/Band) - 1)"/>
					<xsl:for-each select="Bands/Band">

						<xsl:variable name="_bandOffset" select="Value"/>

						<xsl:if test="$_showAllBands or ($_value &lt; ($_bandOffset + $_bandWidth))">

							<xsl:if test="$_bandOffset &gt; 0 and $_bandOffset &lt; 1"><line
								class="boundary-{$_displayMode}"
								x1="{$_bandOffset * $_plotWidth}"
								y1="0"
								x2="{$_bandOffset * $_plotWidth}"
								y2="{$_plotHeight}" /></xsl:if>
							<xsl:if test="$_bandOffset &lt; 1 and $_showBandNames">
							<text
								class="boundary-{$_displayMode}"
								x="{($_bandOffset + ($_bandWidth div 2)) * $_plotWidth}"
								y="{($_plotHeight div 2) + ($_plotHeight div 3)}"
								font-size="{$_plotHeight div 2}px">
								<xsl:if test="not($_showBandPositions)"><xsl:value-of select="Name"/></xsl:if>
								<xsl:if test="$_showBandPositions"><xsl:value-of select="position()"/></xsl:if>
							</text></xsl:if>

						</xsl:if>

					</xsl:for-each>

					<xsl:variable name="_backgroundOffset" select="Background/Value"/>
					<xsl:variable name="_backgroundWidth" select="Background/Width"/>
					<xsl:if test="$_showBackground and $_backgroundWidth&gt;0"><rect
						class="background-{$_displayMode}"
						x="{$_backgroundOffset * $_plotWidth}"
						y="{$_plotHeight div 16}"
						width="{$_backgroundWidth * $_plotWidth}"
						height="{$_plotHeight div 4}"/></xsl:if>

					<xsl:if test="$_showLabel"><text
						class="background-{$_displayMode}"
						x="{$_plotHeight div 20}"
						y="{($_plotHeight div 2) + ($_plotHeight div 3)}"
						font-size="{$_plotHeight div 2}px">
						<xsl:value-of select="$_label"/></text></xsl:if>

				</svg>

				<!-- Working within Plot Width Here -->
				<svg x="{$_thickness}" y="0" width="{$_plotWidth}" height="{$_canvasHeight}">

				<polygon
					class="marker-{$_displayMode}"
					points="{($_value * $_plotWidth) - ($_markerX div 2)},0
						{$_value * $_plotWidth},{$_markerY}
						{($_value * $_plotWidth) + ($_markerX div 2)},0" />

					<xsl:if test="($_value - $_previous &gt; $_deltaPrevious) or ($_value - $_previous &lt; (0 - $_deltaPrevious))">

						<xsl:if test="not($_showPreviousMovement)">

							<polygon
								class="previousMarker-{$_displayMode}"
								points="{($_previous * $_plotWidth) - ($_previousX div 2)},0
								{$_previous * $_plotWidth},{$_previousY}
								{($_previous * $_plotWidth) + ($_previousX div 2)},0" />

						</xsl:if>

						<xsl:if test="$_showPreviousMovement">

							<xsl:choose>
								<xsl:when test="$_value &lt; $_previous">
									<path
										class="down-{$_displayMode}"
										d="M{$_previous * $_plotWidth} {$_markerY div 2} Q {($_value * $_plotWidth) + $_previousX + ((($_previous - $_value) div 2) * $_plotWidth)} 0, {($_value * $_plotWidth) + ($_markerX div 2)} {$_markerY div 2}"
										stroke-width="{$_previousY div 3}" marker-start="url(#circle-down)" marker-end="url(#arrow-down)"/>
								</xsl:when>
								<xsl:otherwise>
									<path
										class="up-{$_displayMode}"
										d="M{$_previous * $_plotWidth} {$_markerY div 2} Q {($_value * $_plotWidth) + $_previousX + ((($_previous - $_value) div 2) * $_plotWidth)} 0, {($_value * $_plotWidth) - ($_markerX div 2)} {$_markerY div 2}"
										stroke-width="{$_previousY div 3}" marker-start="url(#circle-up)" marker-end="url(#arrow-up)"/>
								</xsl:otherwise>
							</xsl:choose>

						</xsl:if>

					</xsl:if>

				</svg>

			</svg>

		</svg>

	</xsl:template>

</xsl:transform>
