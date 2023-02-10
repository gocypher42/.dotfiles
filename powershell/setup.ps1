#Requires -RunAsAdministrator

# Force setup $Profile
Copy-Item .\Microsoft.PowerShell_profile.ps1 $PROFILE -Force
. $PROFILE

# Choco install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Oh My Posh install
winget install JanDeDobbeleer.OhMyPosh -s winget
