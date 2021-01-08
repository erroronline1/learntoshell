@echo off
rem reinstalling a system is annoying enough. i guess i'll be happy next time to not having to find out another time why the scripts won't run.
rem also in hope for quicker disabling auf services this routine might help. if you accomodate it to your needs make sure not to make your system unstable.
rem make sure to run this in administrator mode

rem ####################################################
rem set up variables

set pip[0]=PILLOW
set pip[1]=pypiwin32
set pip[2]=pyinstaller

set process[0]=AdobeARMservice
set process[1]=AGMService
set process[2]=AGSService
set process[3]=AcroTray
set process[4]="Killer Analytics Service"
set process[5]="Dell SupportAssist Remediation"

rem ####################################################
rem upgrade pip and install libraries

python -m pip install --upgrade pip
set "x=0"
:pipLoop
if defined pip[%x%] (
    call echo installing %%pip[%x%]%%...
    call pip install %%pip[%x%]%%
    set /a "x+=1"
    GOTO :pipLoop
)

rem ####################################################
rem view or disable services

echo if you are unsure which services currently are in effect and what their names are you can view a recent list.
echo the list will be created in the current directory and instantaneously deleted. you can save it elsewhere though and complete the variable on top if this batch-file
set /p action=(v)iew list or (c)ontinue disabling (ctrl + x to abort): 

if /I "%action%"=="v" (
    call sc query >> service_processes_overview.txt
    call service_processes_overview.txt
    call del service_processes_overview.txt
)
if /I "%action%"=="c" (
    set "x=0"
    :processLoop
    if defined process[%x%] (
        call echo disabling %%process[%x%]%%...
        call sc stop %%process[%x%]%%
        call sc config %%process[%x%]%% start= disabled
        set /a "x+=1"
        GOTO :processLoop
    )
)

pause