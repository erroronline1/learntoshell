@ECHO off

SET available_python=0
SET /p available_drive=[?] type accessible drive letter:

SET env[0].name="D:/qm/aqms/assistant/"
SET env[0].location="%available_drive%:\qm\aqms\assistant"
SET env[1].name="T:/ext03/OUK-TO-QM/code/aqms/assistant/"
SET env[1].location="t:\ext03\OUK-TO-QM\code\aqms\assistant"

CD /D %env[0].location:"=%
IF %errorlevel% GTR 0 (
	SET available_drive=0
	ECHO [X] drive not available or %env[0].name:"=% already reached
) ELSE (
	ECHO [!] %cd% is prepared
	START cmd /k %available_drive%:\vsc\code %env[1].location%
)

CD /D %env[1].location:"=%
IF %errorlevel% GTR 0 (
	ECHO [X] drive not available or %env[1].name:"=% already reached
) ELSE (
	ECHO [!] %cd% is prepared
	IF EXIST "C:\Program Files\Python38" (
		SET available_python=1
		CALL %env[1].location:"=%\.venv\Scripts\activate
		ECHO [!] virtual environment for python activated
	) ELSE (
		SET available_python=0
		ECHO [X] python not available
	)
	
	IF %available_python% GTR 0 (
		SET /P py=[?] start assistant? [p for python, e for exe]
	) ELSE (
		SET /P py=[?] start assistant? [e for exe]
	)
	IF /I "%py%"=="p" (
		IF %available_python% GTR 0 (
			START py "%env[1].location:"=%\assistant.py" --webfolder: %env[1].name% --browser edge
		) ELSE (
			ECHO [X] python STILL not available
		)
	)
	If /I "%py%"=="e" (
		START "%env[1].location%:"=\assistant" --webfolder: %env[1].name% --browser edge
	)
)

IF NOT %available_drive%==0 (
	ECHO [!] activating git portable...
	CALL %available_drive%:\git\git-cmd.exe
) ELSE (
	ECHO [X] git not available
	CMD /K
	PAUSE
)
EXIT /B 0