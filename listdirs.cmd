@echo off
rem this creates a file with the folders of given nesting with numerical parameter relative to the containing folder.
rem an attempt to have this result with a recursive function shows a weird behaviour.
rem while echoing to the shell perfectly fine, only first level nesting will be put to file.

rem setlocal
rem set currentLevel=0
rem set maxLevel=%1
rem if not defined maxLevel set maxLevel=1
rem :procFolder
rem pushd %1 2>nul
rem if %currentLevel% lss %maxLevel% (
rem   for /d %%F in (*) do (
rem     echo %%~fF
rem     echo %%~fF >> list.txt
rem     set /a currentLevel+=1
rem     call :procFolder "%%F"
rem     set /a currentLevel-=1
rem   )
rem )
rem popd

rem this is a bit untidy and the first two uses of %1 are unclear even if pushd %1 later gets its parameter by the call
rem the following solution works perfectly fine and much faster too thanks to stackoverflow user compo
set /a levels = %~1 + 1
(for /f tokens^=* %%G in ('%__APPDIR__%Robocopy.exe . . /e /l /lev:%levels% /nc /ns /nfl /njh /njs /xd .* 2^> nul') do echo %%G) 1> "list.txt"