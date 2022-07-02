@echo off
:: from https://stackoverflow.com/questions/20530996/aliases-in-windows-command-prompt


:: python versions

doskey py36="C:\Program Files\Python36\python.exe" $*
doskey py38="C:\Program Files\Python38\python.exe" $*


:: dirs

doskey code=cd %USERPROFILE%\Documents\code
doskey stick=cd %USERPROFILE%\Documents\arbeit\stick


:: shortcuts

doskey eject=powershell (New-Object -comObject Shell.Application).Namespace(17).ParseName(""""$1:\\"""").InvokeVerb(""""Eject"""")