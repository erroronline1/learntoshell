@ECHO OFF
REM this script is a lazy approach to not needing to remember "git remote set-url usb PATH".
REM there are presets to a remote repository called "usb" that has been initialized as bare and
REM serves as remote repository to exchange code updates from different developing environments  
REM where an online repository is not possible.
REM so currently the remote repository is stored on an usb-drive within the portable git folder.

REM set default, customize to your needs
SET defaultdir=:\git\aqms
REM read arguments
REM %0 is always scripts name, sanitize to filename 
SET self=%~n0
REM %1 is first argument
SET arg1=%1

if NOT "%arg1%"==""  (
	REM /I-switch for case-insensitive
	if /I "%arg1%" == "help" (
		ECHO this script updates a remote repository url on usb e.g. for use with portable git
		ECHO default directory for the usb remote directory is currently set to %defaultdir%, change it to your needs directy in the script
		ECHO start script with drive letter as first argument
		ECHO type .\%self% e
		ECHO without arguments you will be prompted for the drive letter
		ECHO.
		ECHO you could as well just type git remote set-url usb e%defaultdir%
		EXIT
	) else (
		SET drive=%arg1%
		GOTO :execute 
	)
)

REM input for alternative drive character, /p-switch is for promt
SET /p drive=enter drive letter for remote repository (ctrl + x to abort): 
if "%drive%"=="" (
	ECHO remote url was not set... 
	GOTO :end
)

:execute
SET /p execute=execute: git remote set-url usb %drive%%defaultdir% (y/n)? 
if /I "%execute%"=="y" (
	git remote set-url usb %drive%%defaultdir%
	ECHO remote url was set...
) else (
	ECHO remote url was not set... 
)
:end
ECHO current remote url is set to:
git config --get remote.usb.url

REM pause if called from windows ui. unfortunately i found no reliable switch
PAUSE

EXIT