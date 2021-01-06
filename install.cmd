@echo off
rem reinstalling a system is annoying enough. i guess i'll be happy next time to not having to find out another time why the scripts won't run.

python -m pip install --upgrade pip

set pip[0]=PILLOW
set pip[1]=pypiwin32
set pip[2]=pyinstaller

set "x=0"
:pipLoop
if defined pip[%x%] (
    call echo installing %%pip[%x%]%%...
    call pip install %%pip[%x%]%%
    set /a "x+=1"
    GOTO :pipLoop
)

rem in hope for quicker disabling auf services this routine might help. if you accomodate it to your needs make sure not to make your system unstable.

set process[0]=AdobeARMservice
set process[1]=AGMService
set process[2]=AGSService
set process[3]=ClickToRunSvc
set process[4]="Killer Analytics Service"
set process[5]="Dell SupportAssist Remediation"

set "x=0"
:processLoop
if defined process[%x%] (
    call echo disabling %%process[%x%]%%...
    call sc stop %%process[%x%]%%
    call sc config %%process[%x%]%% start= disabled
    set /a "x+=1"
    GOTO :processLoop
)

pause