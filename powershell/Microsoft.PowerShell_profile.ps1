# ==================================
# OG Custom Powershell Config
# ==================================

# ==== oh-my-posh ==================
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmypush_config.json" | Invoke-Expression

# ==== Custom Alias ================
function v
{
    $cmd = "rg --files '.' -g '!*.git\*' -g '!*.gif' -g '!*.ico' -g '!*.d.*' -g '!*.png' | fzf"
    $selection = Invoke-Expression -Command $cmd
    if ( $selection )
    {
        nvim $selection
    }
}

function jf 
{
    $paths = "(Get-ChildItem -Path `"d:\repos`", `"d:\systems\all`", `"d:\dev`" -Directory).FullName"
    $cmd = "$paths | fzf"
    $selection = Invoke-Expression -Command $cmd
    if ( $selection ) { 
        Set-Location $selection
    }
}

function vjf 
{
    jf
    v
}

function pushmta { mjs pushmta }
function rd ($dir) { cmd.exe /c "rd /s /q $dir" }
function rf ($pattern) { rg --files | rg "$pattern" -i}

# === Git Alias =====================
function lg { lazygit }

function gs { git status }
function gb { git branch -l -vv }
function gr { git restore . }
function cb {
    param (
        [Parameter(Mandatory=$true)]
        [string] $WI_number,
        [Parameter(Mandatory=$false)]
        [string] $source_branch = "master"
    )

    git switch -c "users/oggy/WI$WI_number" "$source_branch"
}

# === CMake Alias ===================
function cstage { cmake -B build }
function cdeb { cmake --build build }
function crel { cmake --build build --config Release }

# === Function for marcotte repos ===
function repos { Set-Location d:\repos }
function mlang { Set-Location d:\lang\marcotte }
function nvim_cfg { Set-Location $env:USERPROFILE\AppData\Local\nvim }
function msys ($project) { Set-Location -Path D:\Systems\All\$project }
function touch ($file) 
{ 
    if (!(Test-Path $file)) {
        "" | Out-File $file -Encoding utf8 
    }
}

function start-cds
{
    $frontend = "frontend"
    $backend = "backend"

    $current_app = Split-Path -Path (Get-Location) -Leaf

    $frontend_pane_title = "$current_app :: $frontend"
    $frontend_path = "./$frontend"
    $frontend_cmd = "npm i --legacy-peer-deps && npm start && pause"

    $backend_pane_title = "$current_app :: $backend"
    $backend_path = "./$backend"
    $backend_cmd = "npm i && npm run develop-watch && pause"

    wt --title $frontend_pane_title --suppressApplicationTitle -d $frontend_path cmd /c $frontend_cmd `; sp --title $backend_pane_title --suppressApplicationTitle -d $backend_path cmd /c $backend_cmd
}

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

# === Super User ====================
function admin 
{
    if ($args.Count -gt 0) 
    {   
        $argList = "& '" + $args + "'"
        Start-Process "wt.exe" -Verb runAs -ArgumentList $argList
        return
    }
    Start-Process "wt.exe" -Verb runAs
}

# === Utils Functions ===============
function refreshenv 
{
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")      
}

# === Zoxide config ===============
Invoke-Expression (& { (zoxide init powershell | Out-String) })
function cd { z }
