@echo off
rem this creates a file with the folders of given nesting with numerical parameter relative to the containing folder.

rem ----------bof-----------
rem setlocal
rem set maxLevel=%1
rem if not defined maxLevel set maxLevel=1
rem set currentLevel=0
rem set output=%cd%\list.txt
rem call :procFolder
rem goto :eof
rem :procFolder
rem if "%1" neq "" pushd %1 2>nul
rem if %currentLevel% lss %maxLevel% (
rem   for /d %%F in (*) do (
rem     echo %%~fF >> %output%
rem     set /a currentLevel+=1
rem     call :procFolder "%%F"
rem     set /a currentLevel-=1
rem   )
rem )
rem popd
rem goto :eof
rem ----------eof-----------

rem after resolving some errors this works as intented, but during the learning process another approach was way more useful. 
rem the following solution works perfectly fine and much faster too thanks to stackoverflow user compo.
set /a levels = %~1 + 1
(for /f tokens^=* %%G in ('%__APPDIR__%Robocopy.exe . . /e /l /lev:%levels% /nc /ns /nfl /njh /njs /xd .* 2^> nul') do echo %%G) 1> "list.txt"