# =================================
# OG Custom cfg
# =================================
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmypush_theme.json" | Invoke-Expression
# =================================

# =================================
# Custom Alias
# =================================
function v 
{
    $selection = Invoke-Expression -Command "fzf"
    if ( -not $selection ) { return }
    nvim $selection
}

function pushmta { mjs pushmta }

function gs { git status }

function gb { git branch -l -vv }

function rd ($dir) { cmd.exe /c "rd /s /q $dir" }
# =================================

# =================================
# Quick functions to switch current direcory
# =================================
function repos { Set-Location d:\repos }

function mlang { Set-Location d:\lang\marcotte }

function nvim_cfg { Set-Location $env:USERPROFILE\AppData\Local\nvim }

function msys ($project) { Set-Location -Path D:\Systems\All\$project }

function touch($file) { "" | Out-File $file -Encoding utf8 }
# =================================

# =================================
# Install or update nvim install
# =================================
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
    
    c:\tools\neovim\nvim-win64\bin\nvim.exe --version
}
# =================================

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

function refreshenv {
    $Env:Path = [System.Environment]::GetEnvironmentVariable("Path","Machine")      
}
