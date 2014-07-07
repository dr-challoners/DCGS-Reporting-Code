echo off
rem ***************************************************************
rem
rem Information
rem -----------
rem Script: Generate-Report-PDFs.bat
rem Creation Date: 23/11/2010
rem Last Modified: 23/11/2010
rem
rem *****************************
rem
rem Description
rem -----------
rem Generates PDF Report files from a Particular Directory
rem
rem ***************************************************************
rem
rem Arguments
rem ---------
rem 1 = Start Directory
rem 2 = Stylesheet Transform (FO) To Use
rem 3 = Suffix To Use (on Output)
rem
rem ***************************************************************

(for %%A in (%1\*.xml) do call Binaries\Fop\fop -xml "%%A" -xsl %2 -pdf "%%~dpA%%~nA_%3.pdf") & Binaries\Pdf_TK\pdftk.exe "%~1\*_%3.pdf" cat output "%~1\%3_Printable.pdf"