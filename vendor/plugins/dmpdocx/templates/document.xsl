<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<xsl:stylesheet version="1.0" xmlns:xsl="http://www.w3.org/1999/XSL/Transform">
  <xsl:template match="/dmp">
    <w:document xmlns:wpc="http://schemas.microsoft.com/office/word/2010/wordprocessingCanvas" xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006" xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships" xmlns:m="http://schemas.openxmlformats.org/officeDocument/2006/math" xmlns:v="urn:schemas-microsoft-com:vml" xmlns:wp14="http://schemas.microsoft.com/office/word/2010/wordprocessingDrawing" xmlns:wp="http://schemas.openxmlformats.org/drawingml/2006/wordprocessingDrawing" xmlns:w10="urn:schemas-microsoft-com:office:word" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main" xmlns:w14="http://schemas.microsoft.com/office/word/2010/wordml" xmlns:wpg="http://schemas.microsoft.com/office/word/2010/wordprocessingGroup" xmlns:wpi="http://schemas.microsoft.com/office/word/2010/wordprocessingInk" xmlns:wne="http://schemas.microsoft.com/office/word/2006/wordml" xmlns:wps="http://schemas.microsoft.com/office/word/2010/wordprocessingShape" mc:Ignorable="w14 wp14">
      <w:body>
        <w:p w:rsidR="00E07559" w:rsidRPr="002646F3" w:rsidRDefault="00B43521" w:rsidP="002646F3">
          <w:pPr>
            <w:pStyle w:val="ProjectTitle"/>
          </w:pPr>
          <w:r w:rsidRPr="002646F3">
            <w:drawing>
              <wp:anchor distT="0" distB="0" distL="114300" distR="114300" simplePos="0" relativeHeight="251658240" behindDoc="0" locked="0" layoutInCell="1" allowOverlap="1" wp14:anchorId="0DEB7743" wp14:editId="1D4B0AA7">
                <wp:simplePos x="0" y="0"/>
                <wp:positionH relativeFrom="column">
                  <wp:posOffset>0</wp:posOffset>
                </wp:positionH>
                <wp:positionV relativeFrom="paragraph">
                  <wp:posOffset>0</wp:posOffset>
                </wp:positionV>
                <wp:extent cx="2084400" cy="637200"/>
                <wp:effectExtent l="0" t="0" r="0" b="0"/>
                <wp:wrapSquare wrapText="bothSides"/>
                <wp:docPr id="1" name="Picture 1"/>
                <wp:cNvGraphicFramePr>
                  <a:graphicFrameLocks xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main" noChangeAspect="1"/>
                </wp:cNvGraphicFramePr>
                <a:graphic xmlns:a="http://schemas.openxmlformats.org/drawingml/2006/main">
                  <a:graphicData uri="http://schemas.openxmlformats.org/drawingml/2006/picture">
                    <pic:pic xmlns:pic="http://schemas.openxmlformats.org/drawingml/2006/picture">
                      <pic:nvPicPr>
                        <pic:cNvPr id="0" name="Picture 1"/>
                        <pic:cNvPicPr>
                          <a:picLocks noChangeAspect="1" noChangeArrowheads="1"/>
                        </pic:cNvPicPr>
                      </pic:nvPicPr>
                      <pic:blipFill>
                        <a:blip r:embed="rId8">
                          <a:extLst>
                            <a:ext uri="uk.ac.dcc.logo.dmp">
                              <a14:useLocalDpi xmlns:a14="http://schemas.microsoft.com/office/drawing/2010/main" val="0"/>
                            </a:ext>
                          </a:extLst>
                        </a:blip>
                        <a:srcRect/>
                        <a:stretch>
                          <a:fillRect/>
                        </a:stretch>
                      </pic:blipFill>
                      <pic:spPr bwMode="auto">
                        <a:xfrm>
                          <a:off x="0" y="0"/>
                          <a:ext cx="2084400" cy="637200"/>
                        </a:xfrm>
                        <a:prstGeom prst="rect">
                          <a:avLst/>
                        </a:prstGeom>
                        <a:noFill/>
                        <a:ln>
                          <a:noFill/>
                        </a:ln>
                      </pic:spPr>
                    </pic:pic>
                  </a:graphicData>
                </a:graphic>
                <wp14:sizeRelH relativeFrom="margin">
                  <wp14:pctWidth>0</wp14:pctWidth>
                </wp14:sizeRelH>
                <wp14:sizeRelV relativeFrom="margin">
                  <wp14:pctHeight>0</wp14:pctHeight>
                </wp14:sizeRelV>
              </wp:anchor>
            </w:drawing>
          </w:r>
          <w:r w:rsidRPr="002646F3">
            <w:t>
              <!-- Project Title -->
              <xsl:value-of select="project_name"/>
            </w:t>
          </w:r>
        </w:p>
        <w:p w:rsidR="002646F3" w:rsidRDefault="00B43521" w:rsidP="002646F3">
          <w:pPr>
            <w:pStyle w:val="ProjectDetails"/>
          </w:pPr>
          <xsl:if test="normalize-space(stage)">
            <w:r>
              <w:t>
                <xsl:value-of select="stage"/>
              </w:t>
            </w:r>
          </xsl:if>
          <xsl:if test="normalize-space(template_org)">
            <w:r>
              <w:br/>
              <w:t>
                <xsl:value-of select="template_org"/>
              </w:t>
            </w:r>
          </xsl:if>
          <xsl:if test="normalize-space(lead_org)">
            <w:r>
              <w:br/>
              <w:t>
                Lead Organisation: <xsl:value-of select="lead_org"/>
              </w:t>
            </w:r>
          </xsl:if>
          <xsl:if test="normalize-space(other_orgs)">
            <w:r>
              <w:br/>
              <w:t>
                Other organisations: <xsl:value-of select="other_orgs"/>
              </w:t>
            </w:r>
          </xsl:if>
          <xsl:if test="normalize-space(concat(project_start,project_end))">
            <w:r>
              <w:br/>
              <w:t>
                Project dates: <xsl:value-of select="project_start"/><xsl:if test="normalize-space(project_end)"> to <xsl:value-of select="project_end"/></xsl:if>
              </w:t>
            </w:r>
          </xsl:if>
          <xsl:if test="normalize-space(budget)">
            <w:r>
              <w:br/>
              <w:t>
                Budget: <xsl:value-of select="budget"/>
              </w:t>
            </w:r>
          </xsl:if>
        </w:p>
        <xsl:for-each select="section">
          <w:tbl>
            <w:tblPr>
              <w:tblStyle w:val="TableGrid"/>
              <w:tblW w:w="0" w:type="auto"/>
              <w:tblBorders>
                <w:top w:val="none" w:sz="0" w:space="0" w:color="auto"/>
                <w:left w:val="none" w:sz="0" w:space="0" w:color="auto"/>
                <w:bottom w:val="none" w:sz="0" w:space="0" w:color="auto"/>
                <w:right w:val="none" w:sz="0" w:space="0" w:color="auto"/>
                <w:insideH w:val="none" w:sz="0" w:space="0" w:color="auto"/>
                <w:insideV w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              </w:tblBorders>
              <w:tblLayout w:type="fixed"/>
              <w:tblLook w:val="04A0" w:firstRow="1" w:lastRow="0" w:firstColumn="1" w:lastColumn="0" w:noHBand="0" w:noVBand="1"/>
            </w:tblPr>
            <w:tblGrid>
              <w:gridCol w:w="532"/>
              <w:gridCol w:w="717"/>
              <w:gridCol w:w="3112"/>
              <w:gridCol w:w="6321"/>
            </w:tblGrid>
            <xsl:if test="normalize-space(heading)">
              <w:tr w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidTr="00844F3C">
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="532" w:type="dxa"/>
                    <w:shd w:val="clear" w:color="auto" w:fill="000000" w:themeFill="text1"/>
                    <w:noWrap/>
                  </w:tcPr>
                  <w:p w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                    <w:pPr>
                      <w:jc w:val="right"/>
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                    </w:pPr>
                    <w:r w:rsidRPr="00844F3C">
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                      <w:t>
                        <xsl:value-of select="@number"/>
                      </w:t>
                    </w:r>
                  </w:p>
                </w:tc>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="10150" w:type="dxa"/>
                    <w:gridSpan w:val="3"/>
                    <w:shd w:val="clear" w:color="auto" w:fill="000000" w:themeFill="text1"/>
                  </w:tcPr>
                  <w:p w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                    <w:pPr>
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                    </w:pPr>
                    <w:r w:rsidRPr="00844F3C">
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                      <w:t>
                        <xsl:value-of select="heading"/>
                      </w:t>
                    </w:r>
                  </w:p>
                </w:tc>
              </w:tr>
            </xsl:if>
            <xsl:for-each select="template_clause">
              <w:tr w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidTr="00844F3C">
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="532" w:type="dxa"/>
                    <w:noWrap/>
                  </w:tcPr>
                  <w:p w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                    <w:pPr>
                      <w:jc w:val="right"/>
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                    </w:pPr>
                    <w:r w:rsidRPr="00844F3C">
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                      <w:t>
                        <xsl:value-of select="question/@number"/>
                      </w:t>
                    </w:r>
                  </w:p>
                </w:tc>
                <w:tc>
                  <w:tcPr>
                    <w:tcW w:w="10150" w:type="dxa"/>
                    <w:gridSpan w:val="3"/>
                  </w:tcPr>
                  <w:p w:rsidR="00844F3C" w:rsidRPr="00844F3C" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                    <w:pPr>
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                    </w:pPr>
                    <w:r w:rsidRPr="00844F3C">
                      <w:rPr>
                        <w:b/>
                      </w:rPr>
                      <w:t>
                        <xsl:value-of select="question"/>
                      </w:t>
                    </w:r>
                  </w:p>
                </w:tc>
              </w:tr>
              <xsl:for-each select="dcc_clause">
                <w:tr w:rsidR="002646F3" w:rsidTr="00F916ED">
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="532" w:type="dxa"/>
                      <w:noWrap/>
                    </w:tcPr>
                    <w:p w:rsidR="002646F3" w:rsidRPr="00844F3C" w:rsidRDefault="002646F3" w:rsidP="00844F3C">
                      <w:pPr>
                        <w:jc w:val="right"/>
                      </w:pPr>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="717" w:type="dxa"/>
                    </w:tcPr>
                    <w:p w:rsidR="002646F3" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                      <w:r>
                        <w:t>
                          <xsl:value-of select="question/@number"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="3112" w:type="dxa"/>
                    </w:tcPr>
                    <w:p w:rsidR="002646F3" w:rsidRDefault="00844F3C" w:rsidP="00844F3C">
                      <w:r>
                        <w:t>
                          <xsl:value-of select="question"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                  <w:tc>
                    <w:tcPr>
                      <w:tcW w:w="6321" w:type="dxa"/>
                    </w:tcPr>
                    <w:p w:rsidR="002646F3" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C">
                      <w:r w:rsidR="00844F3C">
                        <w:t>
                          <xsl:value-of select="response"/>
                        </w:t>
                      </w:r>
                    </w:p>
                  </w:tc>
                </w:tr>
              </xsl:for-each>
            </xsl:for-each>
          </w:tbl>
        </xsl:for-each>
        <w:p w:rsidR="00B43521" w:rsidRDefault="00B43521" w:rsidP="00844F3C">
          <w:bookmarkStart w:id="0" w:name="_GoBack"/>
          <w:bookmarkEnd w:id="0"/>
        </w:p>
        <w:tbl>
          <w:tblPr>
            <w:tblStyle w:val="TableGrid"/>
            <w:tblW w:w="0" w:type="auto"/>
            <w:tblBorders>
              <w:top w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              <w:left w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              <w:bottom w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              <w:right w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              <w:insideH w:val="none" w:sz="0" w:space="0" w:color="auto"/>
              <w:insideV w:val="none" w:sz="0" w:space="0" w:color="auto"/>
            </w:tblBorders>
            <w:tblLayout w:type="fixed"/>
            <w:tblLook w:val="04A0" w:firstRow="1" w:lastRow="0" w:firstColumn="1" w:lastColumn="0" w:noHBand="0" w:noVBand="1"/>
          </w:tblPr>
          <w:tblGrid>
            <w:gridCol w:w="1101"/>
            <w:gridCol w:w="3859"/>
            <w:gridCol w:w="281"/>
            <w:gridCol w:w="1672"/>
            <w:gridCol w:w="3486"/>
          </w:tblGrid>
          <xsl:call-template name="signature_loop">
            <xsl:with-param name="limit"><xsl:value-of select="/dmp/format/signatures"/></xsl:with-param>
          </xsl:call-template>
        </w:tbl>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="009B5DCF"/>
        <w:sectPr w:rsidR="009B5DCF" w:rsidSect="00603D2B">
          <w:headerReference w:type="default" r:id="rId9"/>
          <w:footerReference w:type="default" r:id="rId10"/>
          <w:pgSz w:w="11906" w:h="16838"/>
          <w:pgMar w:top="720" w:right="720" w:bottom="720" w:left="720" w:header="567" w:footer="567" w:gutter="0"/>
          <w:cols w:space="708"/>
          <w:docGrid w:linePitch="360"/>
        </w:sectPr>
      </w:body>
    </w:document>
  </xsl:template>
  
  <xsl:template name="signature_loop">
  <xsl:param name="limit">1</xsl:param>
  <xsl:param name="i">1</xsl:param>
  <xsl:if test="$i &lt;= $limit">
    <w:tr w:rsidR="009B5DCF" w:rsidTr="009B5DCF" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
      <w:trPr>
        <w:trHeight w:val="454"/>
      </w:trPr>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1384" w:type="dxa"/>
          <w:vAlign w:val="bottom"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C">
          <w:r>
            <w:t>Signature</w:t>
          </w:r>
        </w:p>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3859" w:type="dxa"/>
          <w:tcBorders>
            <w:bottom w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="281" w:type="dxa"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1672" w:type="dxa"/>
          <w:vAlign w:val="bottom"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C">
          <w:r>
            <w:t>Date</w:t>
          </w:r>
        </w:p>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3486" w:type="dxa"/>
          <w:tcBorders>
            <w:bottom w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
    </w:tr>
    <w:tr w:rsidR="009B5DCF" w:rsidTr="009B5DCF" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
      <w:trPr>
        <w:trHeight w:val="454"/>
      </w:trPr>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1384" w:type="dxa"/>
          <w:vAlign w:val="bottom"/>
          <w:noWrap/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C">
          <w:r>
            <w:t>Print name</w:t>
          </w:r>
        </w:p>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3859" w:type="dxa"/>
          <w:tcBorders>
            <w:top w:val="single" w:sz="4" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="281" w:type="dxa"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1672" w:type="dxa"/>
          <w:vAlign w:val="bottom"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C">
          <w:r>
            <w:t>Role/Institution</w:t>
          </w:r>
        </w:p>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3486" w:type="dxa"/>
          <w:tcBorders>
            <w:top w:val="single" w:sz="4" w:space="0" w:color="auto"/>
            <w:bottom w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
    </w:tr>
    <w:tr w:rsidR="009B5DCF" w:rsidTr="009B5DCF" xmlns:w="http://schemas.openxmlformats.org/wordprocessingml/2006/main">
      <w:trPr>
        <w:trHeight w:val="454"/>
      </w:trPr>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1384" w:type="dxa"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3859" w:type="dxa"/>
          <w:tcBorders>
            <w:top w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="281" w:type="dxa"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="1672" w:type="dxa"/>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
      <w:tc>
        <w:tcPr>
          <w:tcW w:w="3486" w:type="dxa"/>
          <w:tcBorders>
            <w:top w:val="single" w:sz="4" w:space="0" w:color="auto"/>
          </w:tcBorders>
        </w:tcPr>
        <w:p w:rsidR="009B5DCF" w:rsidRDefault="009B5DCF" w:rsidP="00844F3C"/>
      </w:tc>
    </w:tr>
    <xsl:call-template name="signature_loop">
      <xsl:with-param name="limit"><xsl:value-of select="$limit"/></xsl:with-param>
      <xsl:with-param name="i"><xsl:value-of select="$i + 1"/></xsl:with-param>
    </xsl:call-template>
  </xsl:if>
</xsl:template>
</xsl:stylesheet>