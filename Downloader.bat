@echo off
type %~dp0\logo.txt
title Anim-DL Downloader :)

:checkforinstallfiles
if exist "%~dp0\install" (
   rd /S /Q "%~dp0\install\"
   if exist "%~dp0\install.bat" (
      del /F /Q "%~dp0\install.bat"
      goto init
   ) else (
      goto init
   )
) else (
   if exist "%~dp0\install.bat" (
      del /F /Q "%~dp0\install.bat"
   ) else (
      goto update
   )
)

:init
echo Choose action:
echo ==============================
echo = [1.] [[32mInstall[0m]  =
echo = [2.] [[32mStream[0m]   =
echo = [3.] [[32m[0m]