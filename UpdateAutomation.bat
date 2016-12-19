@echo off

SET FileToCheck="P:\Freelancing\Root.war"
SET TomcatBinDir="C:\Program Files\Apache Software Foundation\Tomcat 8.5\bin\"

If exist %FileToCheck% (
Echo %FileToCheck% exists, Stopping Tomcat now.
%TomcatBinDir%Shutdown.bat

) else (File not there.Sit Idle)

PAUSE>nul
