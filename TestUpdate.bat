@echo off
REM Variable declaration
SET "WgetDir=C:\Program Files (x86)\GnuWin32\bin\"

Echo INFORMATION: Verifying the installation
cd "%WgetDir%

wget --server-response --output-document r.txt http://localhost:8080/services/software-install/get-status
SET /P Result=<r.txt

if "%Result%" == "SUCCESS" (
Echo INFORMATION: update was Successfully installed.    
) else (
Echo ERROR: Update installation has failed.
Echo INFORMATION: Shutting down Tomcat to revert changes using the backup 
REM timeout /t 20 /nobreak
cd "%TomcatBinDir%"s
REM Shutdown the Tomcat server
"%TomcatBinDir%Shutdown.bat">nul
REM Freeze the console for 20 secs and allow, Shutdown.bat to work in background
timeout /t 20 /nobreak
Echo INFORMATION: Deleting new installed files
rmdir "%TomcatWebAppDir%\root" /s /q
Echo INFORMATION: Copying the Old files from backup folder
copy "%TomcatDir%backup\root.war" "%TomcatWebAppDir%" /Y
Echo INFORMATION: Starting the Tomcat server..
"%TomcatBinDir%Startup.bat">nul
timeout /t %SecondsToSleep% /nobreak
Echo INFORMATION: All changes have been reverted.
)
