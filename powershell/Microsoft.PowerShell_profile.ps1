# ==================================
# OG Custom Powershell Config
# ==================================

# ==== oh-my-posh ==================
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmypush_theme.json" | Invoke-Expression

# ==== Custom Alias ================
function v 
{
    $cmd = "rg --files '.' -g '!*.git\*' | fzf"
    $selection = Invoke-Expression -Command $cmd
    if ( $selection ) { nvim $selection }
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
function gs { git status }
function gb { git branch -l -vv }
function gr { git restore . }
function lg { lazygit }

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

# === Install/Update nvim install ===
function update_nvim {
    $nvim_download_link = "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip"
    $module = "nvim-win64"
    $archive_path = "c:\temp"
    $tools_path = "c:\tools\neovim\$module"    
    $zip_file_path = "$archive_path\$module.zip"
    
    New-Item -Path "c:\" -Name "temp" -ItemType "directory" -Force
    Invoke-WebRequest -Uri $nvim_download_link -OutFile $zip_file_path
    Expand-Archive -Path $zip_file_path -DestinationPath $archive_path -Force
    Remove-Item -Path $tools_path -Recurse -Force
    Move-Item -Path "$archive_path\$module" -Destination $tools_path
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
