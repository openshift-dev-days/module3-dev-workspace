<?xml version="1.0" encoding="UTF-8"?>
<xsl:stylesheet xmlns:xsl="http://www.w3.org/1999/XSL/Transform" version="2.0">
    <xsl:output method="xml" indent="yes"/>
    <xsl:decimal-format name="euro" decimal-separator="," grouping-separator="."/>

    <xsl:template match="/">


<div style="display: flex; justify-content: flex-start; align-items: flex-start; width: 100%; max-width: 1200px; margin: 0 auto; gap: 0px;">
    <div style="flex: 0 0 100%;">
      <h3>Policy no: <xsl:value-of select="/PolicyDocument/PolicyNumber"/></h3>
      <span style="margin-right: 200px;">Date of issue:</span>

      <span>                
            <xsl:variable name="dateofissue" select="/PolicyDocument/DateOfIssue"/>
            <xsl:value-of select="concat(substring($dateofissue, 5, 2), '/', substring($dateofissue, 7, 2), '/', substring($dateofissue, 1, 4))"/>
      </span>
      <br/>
    </div>
</div>

<br/>
<br/>
<br/>
<br/>

<div style="flex: 0 0 30px; display: flex; justify-content: flex-start; align-items: flex-start; width: 100%; max-width: 1200px; margin: 0 auto; gap: 0px;">
    <div style="flex: 0 0 300px;">

      <h3>Insurer:</h3>
      <xsl:value-of select="/PolicyDocument/Insurer/Name"/><br/>
      <xsl:value-of select="/PolicyDocument/Insurer/Address/Street"/><br/>
      <xsl:value-of select="/PolicyDocument/Insurer/Address/City"/>, <xsl:value-of select="concat(/PolicyDocument/Insurer/Address/State,' ',/PolicyDocument/Insurer/Address/PostalCode)"/><br/>
      <br/>
      <xsl:variable name="tax" select="/PolicyDocument/Insurer/TaxId"/>
      Tax Id: <xsl:value-of select="concat(substring($tax,1,3), '-', substring($tax,4,2), '-', substring($tax,6,4))"/><br/>
      IBAN: <xsl:value-of select="/PolicyDocument/Insurer/IBAN"/><br/>
    </div>
    <div style="flex: 0 0 300px; display: flex; justify-content: left;">
      <div>
        <h3>Policyholder:</h3>
      <xsl:value-of select="/PolicyDocument/Policyholder/Name"/><br/>
      <xsl:value-of select="/PolicyDocument/Policyholder/Address/Street"/><br/>
      <xsl:value-of select="/PolicyDocument/Policyholder/Address/City"/>, <xsl:value-of select="concat(/PolicyDocument/Policyholder/Address/State,' ',/PolicyDocument/Policyholder/Address/PostalCode)"/><br/>
      <br/>
      <xsl:variable name="tax" select="/PolicyDocument/Policyholder/TaxId"/>
      Tax Id: <xsl:value-of select="concat(substring($tax,1,3), '-', substring($tax,4,2), '-', substring($tax,6,4))"/><br/>

      </div>
    </div>
</div>


<h3>COVERAGE DETAILS</h3>
<table>
    <thead>
        <tr>
            <th>No.</th>
            <th>Description</th>
            <th style="text-align:right;">Qty</th>
            <th style="text-align:right;">UM</th>
            <th style="width:12%; text-align:right;">Net price</th>
            <th style="width:13%; text-align:right;">Net worth</th>
            <th style="width:12%; text-align:right;">VAT [%]</th>
            <th style="text-align:right;">Gross worth</th>
        </tr>
    </thead>
    <tbody>
        <xsl:for-each select="/PolicyDocument/Items/Item">
            <tr>
                <td><xsl:value-of select="Number"/>.</td>
                <td><xsl:value-of select="Description"/></td>
                <td style="text-align:right;"><xsl:value-of select="format-number(Quantity,'####,00', 'euro')"/></td>
                <td style="text-align:right;"><xsl:value-of select="lower-case(UnitOfMeasure)"/></td>
                <td style="text-align:right;"><xsl:value-of select="format-number(NetPrice,  '####,00', 'euro')"/></td>
                <td style="text-align:right;"><xsl:value-of select="format-number(NetWorth,  '####,00', 'euro')"/></td>
                <td style="text-align:right;"><xsl:value-of select="VATPercentage"/>%</td>
                <td style="text-align:right;"><xsl:value-of select="format-number(GrossWorth,'####,00', 'euro')"/></td>
            </tr>
        </xsl:for-each>
    </tbody>
</table>

<h3>SUMMARY</h3>
<table>
    <thead>
        <tr>
            <th style="width:30%;"></th>
            <th style="text-align:right;">VAT [%]</th>
            <th style="text-align:right;">Net worth</th>
            <th style="text-align:right;">VAT</th>
            <th style="text-align:right;">Gross worth</th>
        </tr>
    </thead>
    <tbody>
        <tr>
            <td></td>
            <td style="text-align:right;"><xsl:value-of select="/PolicyDocument/Summary/VATPercentage"/>%</td>
            <td style="text-align:right;"><xsl:value-of select="format-number(/PolicyDocument/Summary/NetWorth,  '####,00', 'euro')"/></td>
            <td style="text-align:right;"><xsl:value-of select="format-number(/PolicyDocument/Summary/VATAmount,'####,00', 'euro')"/></td>
            <td style="text-align:right;"><xsl:value-of select="format-number(/PolicyDocument/Summary/GrossWorth,'####,00', 'euro')"/></td>
        </tr>
        <tr style="text-align:right; font-weight:bold">
            <td >Total</td>
            <td></td>
            <td>$ <xsl:value-of select="format-number(/PolicyDocument/Summary/NetWorth,  '####,00', 'euro')"/></td>
            <td>$ <xsl:value-of select="format-number(/PolicyDocument/Summary/VATAmount,'####,00', 'euro')"/></td>
            <td>$ <xsl:value-of select="format-number(/PolicyDocument/Summary/GrossWorth,'####,00', 'euro')"/></td>
        </tr>
    </tbody>
</table>



    </xsl:template>
</xsl:stylesheet>