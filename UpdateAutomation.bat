@echo off

SET "TomcatDir=C:\Program Files (x86)\Apache Software Foundation\Tomcat 8.5\"
SET "FileToCheck=%TomcatDir%Update\Root.war"
SET "TomcatBinDir=%TomcatDir%bin\"
SET "TomcatWebAppDir=%TomcatDir%Webapps"
SET "SecondsToSleep=60"

If exist "%FileToCheck%" (
Echo "INFORMATION : Found an Update at %FileToCheck% , Stopping Tomcat server now."
cd "%TomcatBinDir%"
"%TomcatBinDir%Shutdown.bat">nul
timeout /t 20 /nobreak
Echo "INFORMATION : Backing-up current Root.war file."
mkdir "%TomcatDir%backup"
copy "%TomcatWebAppDir%\Root.war" "%TomcatDir%backup" /Y

Echo "INFORMATION : Removing old files %TomcatWebAppDir%\root"
rmdir "%TomcatWebAppDir%\root" /s /q
Echo "INFORMATION : Copying the update FROM '%FileToCheck%' TO '%TomcatWebAppDir%'."
copy "%FileToCheck%" "%TomcatWebAppDir%" /Y
Echo INFORMATION : Restarting Tomcat server now.
"%TomcatBinDir%Startup.bat">nul
Echo "INFORMATION : Sleeping for %SecondsToSleep% seconds, to allow Tomcat server to start."
timeout /t %SecondsToSleep% /nobreak
) else (echo Update file unpresent. Sit Idle)
