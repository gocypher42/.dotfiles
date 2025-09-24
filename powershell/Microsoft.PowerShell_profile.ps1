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

# System Utilities
function admin {
    if ($args.Count -gt 0) {
        $argList = $args -join ' '
        Start-Process wt -Verb runAs -ArgumentList "pwsh.exe -NoExit -Command $argList"
    } else {
        Start-Process wt -Verb runAs
    }
}


function v
{
    $cmd = "rg --files '.' -g '!node_modules' -g '!*.gif' -g '!*.ico' -g '!*.d.*' -g '!*.png' | fzf"
    $selection = Invoke-Expression -Command $cmd
    if ( $selection )
    {
        nvim $selection
    }
}

function lg { lazygit }
function gs { git status }
function gb { git branch -l k-vv }

function spot { spotify_player }

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

# === Command Alkon Specific Functions ===
function start-cds
{
    param(
        [string]$AppPath = (Get-Location),
        [string]$FrontendDir = "frontend",
        [string]$BackendDir  = "backend",
        [switch]$NoPause
    )

    if (-Not (Test-Path -Path $AppPath)) {
        Write-Output "Can't local $AppPath. Please try again..."
    }

    $AppPath = (Resolve-Path -Path $AppPath).Path
    $current_app = Split-Path -Path $AppPath -Leaf

    function Get-PaneSpec{
        param(
            [string]$Role,
            [string]$Path,
            [string]$InstallCmd,
            [string]$RunCmd
        )

        $full_path = Join-Path -Path $AppPath -ChildPath $Path
        $title = "$current_app :: $Role"

        if (Test-Path -Path $full_path) {
            $cmd = "$InstallCmd && $RunCmd"
        } else{
            $cmd = "echo ==^> no $Path directory found."
            $full_path = $AppPath
        }

        if (-not $NoPause) {
            $cmd += " && pause"
        }

        return @{
            Title = $title
            Path = $full_path
            Cmd = $cmd
        }
    }

    $frontendspec = Get-PaneSpec -Role "frontend" -Path $FrontendDir `
        -InstallCmd "npm i --legacy-peer-deps" `
        -RunCmd "npm start"

    $backendSpec = Get-PaneSpec -Role "backend" -Path $BackendDir `
        -InstallCmd "npm i" `
        -RunCmd "npm run develop-watch"

    wt --title $frontendSpec.Title --suppressApplicationTitle -d $frontendSpec.Path cmd /c $frontendSpec.Cmd `
        `; sp --title $backendSpec.Title --suppressApplicationTitle -d $backendSpec.Path cmd /c $backendSpec.Cmd
}

function pull-all-cds {
    foreach ($dir in (Get-ChildItem -Directory).Name) {
        $fullPath = (Resolve-Path -Path $dir).Path
        Write-Output "==> $fullPath"
        Set-Location -Path $fullPath
        if (Test-Path -Path ".jj") {
            jj git fetch
        } elseif (Test-Path -Path ".git") {
            git pull
        }
        Write-Output "----"
        cd -
    }
}

function show-all-status-cds {
    foreach ($dir in (Get-ChildItem -Directory).Name) {
        $fullPath = (Resolve-Path -Path $dir).Path
        Write-Output "==> $fullPath"
        Set-Location -Path $fullPath
        if (Test-Path -Path ".jj") {
            jj
        } elseif (Test-Path -Path ".git") {
            git status
        }
        Write-Output "----"
        cd -
    }
}

# === Package installation ===
$packages = @(
    @{ Name = "zoxide"; WingetPackage = "ajeetdsouza.zoxide" },
    @{ Name = "oh-my-posh"; WingetPackage = "JanDeDobbeleer.OhMyPosh" }
)

foreach ($pkg in $packages) {
    if (-Not (Get-Command $pkg.Name -ErrorAction SilentlyContinue)) {
        Write-Host "$($pkg.Name) command not found. Attempting to install via winget..."
        try {
            winget install -e --id $pkg.WingetPackage
        } catch {
            Write-Error "Failed to install $($pkg.Name). Error: $_"
        }
    }
}

# === Jujutsu VCS Completion ===
Invoke-Expression (& { (jj util completion power-shell | Out-String) })

# === Oh-My-Posh ===
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmyposh_config.json" | Invoke-Expression

# === Zoxide ===
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
    Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
    Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
} else {
    Write-Error "Can't find zoxide."
}

