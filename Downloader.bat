@echo off

:init
if exist "%~dp0\install\" (
   goto removeinstallfiles
) else (
   if exist "%~dp0\install.bat" (
      goto removeinstallfiles
   ) else (
      goto init2
   )
)


:removeinstallfiles
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to remove your remainging install files?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /M Choose: 
if %errorlevel% == 1 (
   goto removeinstallfiles2
)
if %errorlevel% == 2 (
   goto init2
)

:removeinstallfiles2
if exist "%~dp0\install.bat" (
   del /F /Q install.bat
   if exist "%~dp0\install\" (
      RD /S /Q "%~dp0\install"
   ) else (
      goto init2
   )
) else (
   if exist "%~dp0\install" (
      RD /S /Q "%~dp0\install"
      goto init2
   ) else (
      goto init2
   )
)

:init2
cls
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
echo --------------------------------------------
echo # [1.] [32mDownload[0m                            #
echo # [Download anime.]                        #
echo # [2.] [32mStream[0m                              #
echo # [Stream anime.]                          #
echo # [3.] [36mSchedule[0m                            #
echo # [Look at upcoming releases.]             #
echo # [4.] [36mSearch[0m                              #
echo # [Search for anime without downloading.]  #
echo # [5.] [36mTest[0m                                #
echo # [Test providers to see what works best.] #
echo # [6.] [35mOther Options[0m                       #
echo # [Show other options.]                    #
echo --------------------------------------------
choice /C 123456 /N /M Choose: 
if %errorlevel% == 1 (
   goto download
)
if %errorlevel% == 2 (
   goto stream
)
if %errorlevel% == 3 (
   goto schedule
)
if %errorlevel% == 4 (
   goto search
)
if %errorlevel% == 5 (
   goto test
)
if %errorlevel% == 6 (
   goto options
)

:test
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl test
pause
goto license

:schedule
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl schedule
pause
goto license

:search
cls
type %~dp0\logo.txt
type %~dp0\credits.txt

echo Enter search term
set /p searchterm=Here: 
goto search2

:search2
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl search %searchterm%
goto search3

:search3
Would you like to search once more?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /T 10 /D Y /M Choose: 
if %errorlevel% == 1 (
   goto search
)
if %errorlevel% == 2 (
   goto finish
)
:download
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo What's the name of the Anime you want to download?
set /p anime=Answer: 
goto providerdownload

:providerdownload
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
   goto qualitydownload
)
if %errorlevel% == 2 (
   set provider=9anime
   goto qualitydownload
)
if %errorlevel% == 3 (
   set provider=allanime
   goto qualitydownload
)
if %errorlevel% == 4 (
   set provider=crunchyroll
   goto qualitydownload
)
if %errorlevel% == 5 (
   set provider=gogoanime
   goto qualitydownload
)
if %errorlevel% == 6 (
   set provider=haho
   goto qualitydownload
)
if %errorlevel% == 7 (
   set provider=tenshi
   goto qualitydownload
)
if %errorlevel% == 8 (
   set provider=zoro
   goto qualitydownload
)

:qualitydownload
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
   goto downloadselection
)
if %errorlevel% == 2 (
   set quality=720/480
   goto downloadselection
)
if %errorlevel% == 3 (
   set quality=480/360
   goto downloadselection
)
if %errorlevel% == 4 (
   set quality=360/worst
   goto downloadselection
)

:downloadselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to descripe a range of episodes?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /M Choose:
if %errorlevel% == 1 (
   goto downloadselection2
)
if %errorlevel% == 2 (
   goto downloadend
)

:downloadend
animdl download "%provider%:%anime%" -q %quality%
goto finish

:downloadselection2
cls 
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to specify a special prompt like latest episode or just do a range?
echo  [1.] [32mSpecial[0m 
echo  [2.] [32mRange[0m
echo  [3.] [32mBoth[0m
choice /C 12 /N /T 10 /D 2 /M Choose:
if %errorlevel% == 1 (
   goto downloadspecialselection
)
if %errorlevel% == 2 (
   goto downloadrangeselection
)
if %errorlevel% == 3 (
   goto downloadbothselection
)

:downloadspecialselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input special parameter.
echo [latest or latest-number. Example: latest-2]
set /p special=Answer: 
goto downloadspecial

:downloadrangeselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input episode range.
echo [number-number or just number. Example: 10-11 or 11]
set /p range=Answer: 
goto downloadrange

:downloadbothselection
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
goto downloadboth


:downloadspecial
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -s %special%
goto finish

:downloadrange
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -r %range%
goto finish

:downloadboth
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl download "%provider%:%anime%" -q %quality% -r %range% -s %special%
goto finish

:stream
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo What's the name of the Anime you want to stream?
set /p anime=Answer: 
goto providerstream

:providerstream
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
   goto qualitystream
)
if %errorlevel% == 2 (
   set provider=9anime
   goto qualitystream
)
if %errorlevel% == 3 (
   set provider=allanime
   goto qualitystream
)
if %errorlevel% == 4 (
   set provider=crunchyroll
   goto qualitystream
)
if %errorlevel% == 5 (
   set provider=gogoanime
   goto qualitystream
)
if %errorlevel% == 6 (
   set provider=haho
   goto qualitystream
)
if %errorlevel% == 7 (
   set provider=tenshi
   goto qualitystream
)
if %errorlevel% == 8 (
   set provider=zoro
   goto qualitystream
)

:qualitystream
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
   goto streamselection
)
if %errorlevel% == 2 (
   set quality=720/480
   goto streamselection
)
if %errorlevel% == 3 (
   set quality=480/360
   goto streamselection
)
if %errorlevel% == 4 (
   set quality=360/worst
   goto streamselection
)

:streamselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to descripe a range of episodes?
echo  [Y.] [32mYes[0m
echo  [N.] [31mNo[0m
choice /C YN /N /M Choose:
if %errorlevel% == 1 (
   goto streamselection2
)
if %errorlevel% == 2 (
   goto streamend
)

:streamend
animdl stream "%provider%:%anime%" -q %quality%
goto finish

:streamselection2
cls 
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Would you like to specify a special prompt like latest episode or just do a range?
echo  [1.] [32mSpecial[0m 
echo  [2.] [32mRange[0m
echo  [3.] [32mBoth[0m
choice /C 12 /N /T 10 /D 2 /M Choose:
if %errorlevel% == 1 (
   goto streamspecialselection
)
if %errorlevel% == 2 (
   goto streamrangeselection
)
if %errorlevel% == 3 (
   goto streambothselection
)

:streamspecialselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input special parameter.
echo [latest or latest-number. Example: latest-2]
set /p special=Answer: 
goto streamspecial

:streamrangeselection
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Input episode range.
echo [number-number or just number. Example: 10-11 or 11]
set /p range=Answer: 
goto streamrange

:streambothselection
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
goto streamboth


:streamspecial
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl stream "%provider%:%anime%" -q %quality% -s %special%
goto finish

:streamrange
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl stream "%provider%:%anime%" -q %quality% -r %range%
goto finish

:streamboth
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
animdl stream "%provider%:%anime%" -q %quality% -r %range% -s %special%
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

:options
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo -----------------------------
echo #          Options          #
echo #     [1.] [32mUpdate[0m           #
echo #     [2.] [31mUninstall[0m        #
echo #     [3.] [32mReturn[0m           #
echo -----------------------------
choice /C 12 /N /M Choose:
if %errorlevel% == 1 (
   goto update
)
if %errorlevel% == 2 (
   goto uninstall
)
if %errorlevel% == 3 (
   goto license
)

:uninstall
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Retrieving uninstall file.
powershell.exe -c "invoke-webrequest 'https://raw.githubusercontent.com/H4rldev/animdl-batch-script-install-files/master/uninstall.bat' -outfile .\uninstall.bat"
goto uninstall2

:uninstall2
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo uninstall file should be retrieved, open it to update.
pause
exit

:update
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Retrieving file.
powershell.exe -c "invoke-webrequest 'https://raw.githubusercontent.com/H4rldev/animdl-batch-script-install-files/master/update.bat' -outfile .\update.bat"
goto update2

:update2
cls
type %~dp0\logo.txt
type %~dp0\credits.txt
echo Update file should be retrieved, open it to update.
pause
exit
