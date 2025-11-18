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
function Test-CommandExists {
    param($command)
    $exists = $null -ne (Get-Command $command -ErrorAction SilentlyContinue)
    return $exists
}

function touch($file) { "" | Out-File $file -Encoding ASCII }

function refreshenv
{
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")
}

# ============================
# --    System Utilities    --
# ============================
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

Set-Alias -Name puv -Value 'C:\Users\olivier.guenette\.local\bin\uv'
function lg { lazygit }
function gs { git status }
function gb { git branch -l k-vv }

function spot { spotify_player }

# =================================
# -- Install/Update nvim install --
# =================================
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
if (Get-Command zoxide -ErrorAction SilentlyContinue) {
    Invoke-Expression (& { (zoxide init --cmd cd powershell | Out-String) })
    Set-Alias -Name z -Value __zoxide_z -Option AllScope -Scope Global -Force
    Set-Alias -Name zi -Value __zoxide_zi -Option AllScope -Scope Global -Force
} else {
    Write-Error "Can't find zoxide."
}

