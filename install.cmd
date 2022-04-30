@echo off
rem reinstalling a system is annoying enough. i guess i'll be happy next time to not having to find out another time why the scripts won't run.
rem also in hope for quicker disabling auf services this routine might help. if you accomodate it to your needs make sure not to make your system unstable.
rem make sure to run this in administrator mode
rem note to self: loop variables are allowed with one character only

rem ####################################################
rem set up variables

set python="C:\Program Files\Python36\python.exe" "C:\Program Files\Python38\python.exe"

set pip=cchardet colorama eel kivy opencv-python-headless PILLOW psutil pyinstaller pypiwin32 pyzbar requests win10toast XslxWriter
rem set pip=%pip%;buildozer
rem remember kivy might run in a virtual environment only, so some modules might have to be reinstalled there as well
rem same goes for wsl

set process=AdobeARMservice AGMService AGSService AcroTray "Killer Analytics Service" "Dell SupportAssist Remediation"

rem ####################################################
rem upgrade pip and install libraries for all python versions

for %%p in (%python%) do (
    call %%p -m pip install --upgrade pip
    for %%i in (%pip%) do (
        echo installing %%i for %%p...
        call %%p%% -m pip install --upgrade %i
    )
)
rem ####################################################
rem view or disable services

echo if you are unsure which services currently are in effect and what their names are you can view a recent list.
echo the list will be created in the current directory and instantaneously deleted. you can save it elsewhere though and complete the variable on top if this batch-file
set /p action=(v)iew list, (c)ontinue disabling or (s)kip disabling: 

if /I "%action%"=="v" (
    call sc query >> service_processes_overview.txt
    call service_processes_overview.txt
    call del service_processes_overview.txt
)
if /I "%action%"=="c" (
    for %%p in (%process%) do (
        call echo disabling %%p...
        call sc stop %%p
        call sc config %%p start= disabled
    )
)

pause