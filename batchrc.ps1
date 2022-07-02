# python versions

Set-Alias -Name py36 -Value "C:\Program Files\Python36\python.exe"
Set-Alias -Name py38 -Value "C:\Program Files\Python38\python.exe"


#dirs

Function code {Set-Location -Path $env:USERPROFILE\Documents\code}
Function stick {Set-Location -Path $env:USERPROFILE\Documents\arbeit\stick}


#shortcuts

Function eject{
Param(
[Parameter(Mandatory=$true,Position=0)] [String]$Drive
)
powershell (New-Object -comObject Shell.Application).Namespace(17).ParseName($Drive+":\").InvokeVerb("Eject")
}