<xsl:stylesheet version="1.0"
	xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/dmp">
		<w:hdr
			xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas"
			xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
			xmlns:o="urn:schemas-microsoft-com:office:office"
			xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships"
			xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math"
			xmlns:v="urn:schemas-microsoft-com:vml"
			xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing"
			xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing"
			xmlns:w10="urn:schemas-microsoft-com:office:word"
			xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main"
			xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml"
			xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup"
			xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk"
			xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml"
			xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape"
			mc:Ignorable="w14 wp14">
			<w:p w:rsidR="00603D2B" w:rsidRPr="00603D2B" w:rsidRDefault="00603D2B"
				w:rsidP="009B5DCF">
				<w:pPr>
					<w:pStyle w:val="Header" />
					<w:tabs>
						<w:tab w:val="clear" w:pos="4513" />
						<w:tab w:val="clear" w:pos="9026" />
						<w:tab w:val="right" w:pos="10484" />
					</w:tabs>
				</w:pPr>
				<w:r w:rsidRPr="00603D2B">
					<w:t>
						<xsl:value-of select="format/header" />
					</w:t>
				</w:r>
				<w:r w:rsidRPr="00603D2B">
					<w:tab />
				</w:r>
				<w:sdt>
					<w:sdtPr>
						<w:id w:val="1168209085" />
						<w:docPartObj>
							<w:docPartGallery w:val="Page Numbers (Top of Page)" />
							<w:docPartUnique />
						</w:docPartObj>
					</w:sdtPr>
					<w:sdtEndPr />
					<w:sdtContent>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="begin" />
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
							</w:rPr>
							<w:instrText xml:space="preserve"> PAGE </w:instrText>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="separate" />
						</w:r>
						<w:r w:rsidR="00BF4D30">
							<w:rPr>
								<w:bCs />
								<w:noProof />
							</w:rPr>
							<w:t>1</w:t>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="end" />
						</w:r>
						<w:r>
							<w:t xml:space="preserve"> /</w:t>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:t xml:space="preserve"> </w:t>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="begin" />
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
							</w:rPr>
							<w:instrText xml:space="preserve"> NUMPAGES  </w:instrText>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="separate" />
						</w:r>
						<w:r w:rsidR="00BF4D30">
							<w:rPr>
								<w:bCs />
								<w:noProof />
							</w:rPr>
							<w:t>1</w:t>
						</w:r>
						<w:r w:rsidRPr="00603D2B">
							<w:rPr>
								<w:bCs />
								<w:sz w:val="24" />
								<w:szCs w:val="24" />
							</w:rPr>
							<w:fldChar w:fldCharType="end" />
						</w:r>
					</w:sdtContent>
				</w:sdt>
			</w:p>
			<w:p w:rsidR="00603D2B" w:rsidRDefault="00603D2B">
				<w:pPr>
					<w:pStyle w:val="Header" />
				</w:pPr>
			</w:p>
		</w:hdr>
	</xsl:template>
</xsl:stylesheet>
