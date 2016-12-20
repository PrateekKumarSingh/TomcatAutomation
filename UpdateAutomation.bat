@echo off

SET "FileToCheck=c:\data\Freelancing\Root.war"
SET "TomcatBinDir=C:\Program Files\Apache Software Foundation\Tomcat 8.5\bin\"

If exist "%FileToCheck%" (
Echo %FileToCheck% exists, Stopping Tomcat now.
"%TomcatBinDir%Shutdown.bat"
copy "c:\data\Freelancing\ROOT.war" "C:\Program Files\Apache Software Foundation\Tomcat 8.5\bin"
PAUSE>nul
) else (echo File not there. Sit Idle)

PAUSE>nul
