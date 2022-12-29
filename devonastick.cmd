@ECHO OFF

:: possible issues: folders with whitespaces. i'm not getting starting and calling with quotes to work properly

:: runtime vars
SET available_success=0
SET /P available_drive=[?] type accessible drive letter: 

:: setup vars
SET stick_name="D:/qm/aqms/assistant/"
SET stick_location="%available_drive%:\qm\aqms\assistant"
SET network_name="T:/ext03/OUK-TO-QM/code/aqms/assistant/"
SET network_location="T:\ext03\OUK-TO-QM\code\aqms\assistant"
SET vsc_name="vsc portable"
SET vsc_location="%available_drive%:\vsc\Code.exe"
SET python_name="python"
SET python_location="C:\Program Files\Python38"
SET git_name="git portable"
SET git_location="%available_drive%:\git\git-cmd.exe"

:: change to 1st environment and launch a portable app
CD %stick_location:~1,2% >> NUL
IF NOT %cd%==%stick_location:"=% (
	CD /D %stick_location:"=%
)
IF %errorlevel% GTR 0 (
	ECHO [X] drive [%available_drive%] not available
	ECHO [x] %vsc_name:"=% could not be started
) ELSE (
	ECHO [!] %cd% is prepared
	SET available_success=1
	START CMD /K %vsc_location:"=% %network_location:"=%
)

:: change to 2nd environment, launch .venv, occasionally start project
CD %network_location:~1,2% >> NUL
IF NOT %cd%==%network_location:"=% (
	CD /D %network_location:"=%
)
IF %errorlevel% GTR 0 (
	ECHO [X] drive [%network_location:~1,2%] not available
) ELSE (
	ECHO [!] %cd% is prepared
	IF EXIST %python_location% (
		CALL %network_location:"=%\.venv\Scripts\activate
		ECHO [!] virtual environment for python activated
		START py "%network_location:"=%\assistant.py" --webfolder %network_name% --browser edge
	) ELSE (
		ECHO [X] %python_name:"=% not available
		START %network_location:"=%\assistant --webfolder %network_name:"=% --browser edge
	)
)

:: launch git portable if available
IF NOT %available_success%==0 (
	:: git keeps terminal open
	ECHO [!] activating %git_name:"=%...
	CALL %git_location%
) ELSE (
	:: if started from gui the terminal will close afterwards
	ECHO [X] %git_name:"=% not available due to missing drive [%available_drive%]
	PAUSE
)
EXIT /B 0