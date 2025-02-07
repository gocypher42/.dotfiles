#opt-out of telemetry before doing anything, only if PowerShell is run as admin
if ([bool]([System.Security.Principal.WindowsIdentity]::GetCurrent()).IsSystem) {
    [System.Environment]::SetEnvironmentVariable('POWERSHELL_TELEMETRY_OPTOUT', 'true', [System.EnvironmentVariableTarget]::Machine)
}

# Import Modules and External Profiles
# Ensure Terminal-Icons module is installed before importing
if (-not (Get-Module -ListAvailable -Name Terminal-Icons)) {
    Install-Module -Name Terminal-Icons -Scope CurrentUser -Force -SkipPublisherCheck
}
Import-Module -Name Terminal-Icons
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
    Import-Module "$ChocolateyProfile"
}

# Utility Functions
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

function touch($file) { "" | Out-File $file -Encoding ASCII }

# System Utilitie
function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}

if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
} else {
    Write-Host "zoxide command not found. Attempting to install via winget..."
    try {
        winget install -e --id ajeetdsouza.zoxide
        Write-Host "zoxide installed successfully. Initializing..."
        Invoke-Expression (& { (zoxide init powershell | Out-String) })
    } catch {
        Write-Error "Failed to install zoxide. Error: $_"
    }
}

Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force

function v
{
    $cmd = "rg --files '.' -g '!*.git\*' -g '!*.gif' -g '!*.ico' -g '!*.d.*' -g '!*.png' | fzf"
    $selection = Invoke-Expression -Command $cmd
    if ( $selection )
    {
        nvim $selection
    }
}

function lg { lazygit }
function gs { git status }
function gb { git branch -l -vv }

# === Install/Update nvim install ===
function update_nvim
{
    $module = "nvim-win64"
    $archive = "$module.zip"
    $nvim_download_link = "https://github.com/neovim/neovim/releases/download/stable/$archive"
    $tools_path = "c:\tools\neovim\$module"
    $zip_file_path = "$Env:Temp\$archive"

    Invoke-WebRequest -Uri $nvim_download_link -OutFile $zip_file_path
    Expand-Archive -Path $zip_file_path -DestinationPath $ENV:Temp -Force
    Remove-Item -Path $tools_path -Recurse -Force
    Move-Item -Path "$Env:Temp\$module" -Destination $tools_path
    Remove-Item -Path $zip_file_path -Recurse -Force

    Invoke-Expression -Command "c:\tools\neovim\nvim-win64\bin\nvim.exe --version"
}

function refreshenv
{
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmyposh_config.json" | Invoke-Expression
