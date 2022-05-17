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
   goto init
) else (
   goto init
)

:init
echo among