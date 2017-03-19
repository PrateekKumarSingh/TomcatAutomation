@echo off
REM Variable declaration
SET "TomcatDir=C:\Program Files (x86)\Apache Software Foundation\Tomcat 8.5\"
SET "FileToCheck=%TomcatDir%Update\Root.war"
SET "TomcatBinDir=%TomcatDir%bin\"
SET "TomcatWebAppDir=%TomcatDir%Webapps"
SET "SecondsToSleep=20"
SET "WgetDir=C:\Program Files (x86)\GnuWin32\bin\"
SET "PWD=%cd%"

REM Check the Root.war file inn Update folder
If exist "%FileToCheck%" (
Echo INFORMATION: Found an Update at "%FileToCheck%"
Echo INFORMATION: Stopping Tomcat server now.

REM Goto /Tomcat/Bin Directory
cd "%TomcatBinDir%"

REM Shutdown the Tomcat server
"%TomcatBinDir%Shutdown.bat">nul

REM Freeze the console for 20 secs and allow, Shutdown.bat to work in background
timeout /t 20 /nobreak
Echo INFORMATION: Backing-up current Root.war file.

REM Make a Backup folder in /Tomcat directory and copy the current Root.war to the /Tomcat/backup/ folder
mkdir "%TomcatDir%backup"
copy "%TomcatWebAppDir%\Root.war" "%TomcatDir%backup" /Y

REM Delete the /Tomcat/WebApp/Root/ folder
Echo INFORMATION: Removing old files "%TomcatWebAppDir%\root"
rmdir "%TomcatWebAppDir%\root" /s /q

REM Copy the Update found in the /Tomcat/update folder to /Tomcat/Webapps/ folder
Echo INFORMATION: Copying the update FROM "%FileToCheck%" TO "%TomcatWebAppDir%".
copy "%FileToCheck%" "%TomcatWebAppDir%" /Y

REM Restart the Tomcat server
Echo INFORMATION: Restarting Tomcat server now.
"%TomcatBinDir%Startup.bat">nul

REM Sleep for a minute to allow Tomcat server to come up
Echo INFORMATION: Sleeping for "%SecondsToSleep%" seconds, to allow Tomcat server to start.
timeout /t %SecondsToSleep% /nobreak 

"%PWD%\TestUpdate.bat"
PAUSE>nul
REM GOTO Test
) else (
echo INFORMATION: Update file not present at Location:"%TomcatDir%UPdate\"
echo INFORMATION: Script will Sit Idle and won't perform any operation
)
REM Remove the next line if you don't want batch script to wait for user prompt to EXIT
PAUSE>nul