#Requires -RunAsAdministrator


# TODO: add call to delete current profile and symlink the profile of the dotfiles repos

# Choco install
Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Oh My Posh install
winget install JanDeDobbeleer.OhMyPosh -s winget

. $PROFILE
