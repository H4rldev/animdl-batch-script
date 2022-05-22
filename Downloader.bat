@echo off

:init
type %~dp0\logo.txt
type %~dp0\credits.txt
pause
goto license

:license
cls
if exist "%ALLUSERSPROFILE%\animdlbatch\yes\yes.txt" (
   goto menu
) else (
   goto license2
)

:license2
type license.txt
echo Do you accept or decline the license?
echo  [Y.] [32mAccept[0m
echo  [N.] [31mDecline[0m
choice /C YN /N /M Choose: 
if %errorlevel% == 1 (
   echo yes > yes.txt
   mkdir %ALLUSERSPROFILE%\animdlbatch\yes
   move %~dp0\yes.txt %ALLUSERSPROFILE%\animdlbatch\yes
   goto menu
)
if %errorlevel% == 2 (
   exit
)

:menu
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
title Anim-DL Downloader :)
echo Choose action:
echo -----------------
echo # [1.] [32mDownload[0m #
echo # [2.] [32mStream[0m   #
echo # [3.] [32mGrab[0m     #
echo # [4.] [36mSchedule[0m #
echo # [5.] [36mSearch[0m   #
echo # [6.] [36mTest[0m     #
echo # [7.] [35mUpdate[0m   #
echo # [8.] [35mOptions[0m  #
echo -----------------
choice /C 12345678 /N /M Choose: 
if %errorlevel% == 1 (
   goto download
)
if %errorlevel% == 2 (
   goto stream
)
if %errorlevel% == 3 (
   echo test 3
   goto init
)
if %errorlevel% == 4 (
   echo test 4
   goto init
)
if %errorlevel% == 5 (
   echo test 5
   goto init
)
if %errorlevel% == 6 (
   echo test 6
   goto init
)
if %errorlevel% == 7 (
   echo test 7
   goto init
)
if %errorlevel% == 8 (
   echo test 8
   goto init
)

:choicedownload
cls
type %~dp0\logo.txt
echo 

:download
cls
type %~dp0\logo.txt
echo What's the name of the Anime you want to download?
set /p anime=Answer: 
goto download1 

:download1
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Choose a specific anime provider.
echo [Wait to use default] [default = animixplay]
echo -------------------
echo # [1.] [32mAnimixplay[0m #
echo # [2.] [32m9Anime[0m     #
echo # [3.] [32mAllAnime[0m   #
echo # [4.] [32mCrunchyroll[0m#
echo # [5.] [32mGogoAnime[0m  #
echo # [6.] [32mHaho [NSFW][0m#
echo # [7.] [32mTenshi.moe[0m #
echo # [8.] [32mZoro.to[0m    #
echo -------------------
choice /C 12345678 /N /T 10 /D 1 /M Choose: 
if %errorlevel% == 1 (
   set provider=animixplay
   goto download2
)
if %errorlevel% == 2 (
   set provider=9anime
   goto download2
)
if %errorlevel% == 3 (
   set provider=allanime
   goto download2
)
if %errorlevel% == 4 (
   set provider=crunchyroll
   goto download2
)
if %errorlevel% == 5 (
   set provider=gogoanime
   goto download2
)
if %errorlevel% == 6 (
   set provider=haho
   goto download2
)
if %errorlevel% == 7 (
   set provider=tenshi
   goto download2
)
if %errorlevel% == 8 (
   set provider=zoro
   goto download2
)

:download2
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo What quality? 
echo [No input = 1080p] 
echo [if quality is not available. It will either choose worst or best quality depending on choice]
echo  [1.] [32m1080p[0m
echo  [2.] [32m720p[0m
echo  [3.] [31m480p[0m
echo  [4.] [31m360p[0m
choice /C 1234 /N /T 10 /D 1 /M Choose: 
if %errorlevel% == 1 (
   set quality=1080/best
   goto download3
)
if %errorlevel% == 2 (
   set quality=720/480
   goto download3
)
if %errorlevel% == 3 (
   set quality=480/360
   goto download3
)
if %errorlevel% == 4 (
   set quality=360/worst
   goto download3
)

:download3
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to descripe a range of episodes?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /M Choose:
if %errorlevel% == 1 (
   goto download4range
)
if %errorlevel% == 2 (
   goto download4
)

:download4
animdl download "%provider%:%anime%" -q %quality%
goto finish

:download4range
cls 
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to specify a special prompt like latest episode or just do a range?
echo  [1.] [32mSpecial[0m 
echo  [2.] [32mRange[0m
echo  [3.] [32mBoth[0m
choice /C 12 /N /T 10 /D 2 /M Choose:
if %errorlevel% == 1 (
   goto download5special
)
if %errorlevel% == 2 (
   goto download5range
)
if %errorlevel% == 3 (
   goto download5both
)

:download5special
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input special parameter.
echo [latest or latest-number. Example: latest-2]
set /p special=Answer: 
goto download6special

:download5range
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input episode range.
echo [number-number or just number. Example: 10-11 or 11]
set /p range=Answer: 
goto download6range

:download5both
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input episode range.
echo [number-number or just number. Example: 10-11 or 11]
set /p range=Answer: 
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input special parameter.
echo [latest or latest-number. Example: latest-2]
set /p special=Answer: 
goto download6both


:download6special
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -s %special%
goto finish

:download6range
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -r %range%
goto finish

:download6both
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -r %range% -s %special%
goto finish

:finish
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Want to return to the start?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /M Choose:
if %errorlevel% == 1 (
   goto license
)
if %errorlevel% == 2 (
   exit
)