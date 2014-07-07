echo off
rem ***************************************************************
rem
rem Information
rem -----------
rem Script: Publish-Report-PDFs.bat
rem Creation Date: 09/12/2010
rem Last Modified: 09/12/2010
rem
rem *****************************
rem
rem Description
rem -----------
rem Generates & Publishes PDF Report files from a Particular Directory
rem
rem ***************************************************************
rem
rem Arguments
rem ---------
rem 1 = Start Directory
rem 2 = Group Names File (e.g. Year-7-Groups.txt)
rem 3 = Output Directory
rem 4 = Output Types File (e.g. Output-Normal.txt)
rem
rem ***************************************************************

echo off & setlocal enabledelayedexpansion

for /F "tokens=*" %%G in (%2) do (
 for /F "tokens=*" %%O in (%4) do (
  call Generate-Report-PDFs.bat "%1\%%G" sliders-%%O.xsl %%O & copy /Y /V %1\%%G\%%O_Printable.pdf %3\%%G_%%O.pdf
 )
)