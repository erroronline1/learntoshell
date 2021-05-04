@ECHO OFF
REM backup srcfldr into zip file specified by destfldr and filename + backupdate

REM ############ POWERSHELL OPTION ###################
REM this could be done with a powershell script as well given the permission to set-executionpolicy remotesigned
REM # execute by shortcut with [%windir%\System32\WindowsPowerShell\v1.0\powershell.exe -noexit -File "pathToScript.ps1"]
REM # or schedule using powershell.exe with arguments [-File "pathToScript.ps1"]
REM # note that an error occurs if the file already exists

REM $srcfldr = "C:\ProgramData\Vorum\Canfit-X_Access\2.0"
REM $destfldr = "\\FSA03.ads.krz.uni-heidelberg.de\add07\OUK-To3DScanner\Sicherung Canfit\"
REM $filename = "Backup_"
REM $backupdate = get-date -Format "yyyyMMdd"
REM $dest = $destfldr + $filename + $backupdate + ".zip"
REM Compress-Archive -Path $srcfldr -DestinationPath $dest

REM ############ BATCH OPTION ###################
REM execute script directly by shortcut or schedule execution
REM existing files wil be overwritten. network folders do work even if unsupported unc paths are stated

REM quotes position is intentional!
SET "srcfldr=localpath"
SET "destfldr=remotpath"

SET filename=Backup_
SET backupdate=%date:~-4%%date:~3,2%%date:~0,2%

SET dest="%destfldr%%filename%%backupdate%.zip"
ECHO(
ECHO backup will take a few minutes...
REM following warning might be useful if a program folder is to be backuped
SET /p warning=the application has to be closed. did you save your progress and closed the application (y/n)?
IF /I "%warning%"=="y" (
    tar -cf %dest% --format=zip %srcfldr%
    ECHO(
    ECHO storage of %srcfldr%
    ECHO to %dest% had been completed.
)

ECHO have a nice day!
PAUSE
EXIT