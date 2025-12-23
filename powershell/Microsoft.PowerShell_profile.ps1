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

# ============================
# --      Load Files        --
# ============================
$files = @(
    "$HOME\.dotfiles\powershell\command_alkon.ps1"
    "$HOME\.dotfiles\powershell\deps.ps1"
)

foreach ($file in $files) {
    if (Test-Path $file) { . $file }
}

# ============================
# --   Utility Functions    --
# ============================
function touch($file) { "" | Out-File $file -Encoding ASCII }

function refreshenv
{
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
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

Set-Alias -Name puv -Value 'C:\Users\OGuenette\AppData\Local\Microsoft\WinGet\Links\uv.exe'
function lg { lazygit }
function gs { git status }
function gb { git branch -l -vv }

function Enter-MSVC {
    $vswhere = "${env:ProgramFiles(x86)}\Microsoft Visual Studio\Installer\vswhere.exe"

    if (-not (Test-Path $vswhere)) {
        Write-Error "vswhere.exe not found. Is Visual Studio or Build Tools installed?"
        return
    }

    $vsInstallPath = & $vswhere `
        -latest `
        -products * `
        -requires Microsoft.VisualStudio.Component.VC.Tools.x86.x64 `
        -property installationPath

    if (-not $vsInstallPath) {
        Write-Error "No Visual Studio installation with C++ tools found."
        return
    }

    $vcvars = Join-Path $vsInstallPath "VC\Auxiliary\Build\vcvarsall.bat"

    if (-not (Test-Path $vcvars)) {
        Write-Error "vcvarsall.bat not found at $vcvars"
        return
    }

    cmd /c "`"$vcvars`" x64 && set" |
        ForEach-Object {
            if ($_ -match '^(.*?)=(.*)$') {
                Set-Item -Path Env:$($matches[1]) -Value $matches[2]
            }
        }

    Write-Host "MSVC environment loaded from:" -ForegroundColor Green
    Write-Host "  $vsInstallPath"
}

# ============================
# --          yazi          --
# ============================
function y {
    $tmp = (New-TemporaryFile).FullName
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
    }
    Remove-Item -Path $tmp
}

# ============================
# -- Jujutsu VCS Completion --
# ============================
Invoke-Expression (& { (jj util completion power-shell | Out-String) })

# ============================
# --       Oh-My-Posh       --
# ============================
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmyposh_config.json" | Invoke-Expression

# ============================
# --         Zoxide         --
# ============================
# --- !!! Must be last section
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
    Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
    Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
} else {
    Write-Error "Can't find zoxide."
}

