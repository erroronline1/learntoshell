@echo off
rem add runtime processes to the following array
rem the taskkill command with necessary parameters will iterate through the list
rem some processes will be protected unless you execute the script with administrator permissions

set process[0]=actrotray.exe
set process[1]=skypeapp.exe
set process[2]=SkypeBackgroundHost.exe
set process[3]=SkypeBridge.exe
set process[4]=integratedoffice.exe
set process[5]=Dropbox.exe
set process[6]=DbxSvc.exe
set process[7]=DropboxUpdate.exe
set process[8]=Sarmsvc.exe
set process[9]=AGSService.exe
set process[10]=AGMService.exe
set process[11]=Skype.exe
set process[12]=armsvc.exe
set process[13]=officeclicktorun.exe

set "x=0"
:processLoop
if defined process[%x%] (
    call echo closing %%process[%x%]%%...
    call taskkill /f /t /im %%process[%x%]%%
    set /a "x+=1"
    GOTO :processLoop
)

timeout 5
rem pause
