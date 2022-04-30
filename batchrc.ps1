# python versions

Set-Alias -Name py36 -Value "C:\Program Files\Python36\python.exe"
Set-Alias -Name py38 -Value "C:\Program Files\Python38\python.exe"

#dirs

Function CDCODE {Set-Location -Path $env:USERPROFILE\Documents\code}
Function CDSTICK {Set-Location -Path $env:USERPROFILE\Documents\arbeit\stick}

Set-Alias -Name code -Value CDCODE
Set-Alias -Name stick -Value CDSTICK