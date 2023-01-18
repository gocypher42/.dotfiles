# =================================
# OG Custom cfg
# =================================
oh-my-posh init pwsh --config "~/.dotfiles/powershell/ohmypush_theme.json" | Invoke-Expression
# =================================

# =================================
# Custom Alias
# =================================
function v ($file = ".") { nvim $file }

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

function touch($file) { "" | Out-File $file -Encoding ascii }
# =================================

# =================================
# Install or update nvim install
# =================================
function update_nvim {
    $nvim_download_link = "https://github.com/neovim/neovim/releases/download/nightly/nvim-win64.zip"
    $archive_path = "c:\tmp\nvim-win64.zip"
    $tools_path = "c:\tools\neovim\nvim-win64"

    New-Item -Path "c:\" -Name "tmp" -ItemType "directory" -Force
    Invoke-WebRequest -Uri $nvim_download_link -OutFile $archive_path
    Expand-Archive -Path $archive_path -DestinationPath "c:\tmp" -Force
    Remove-Item -Path $tools_path -Recurse -Force
    Move-Item -Path "C:\tmp\nvim-win64" -Destination $tools_path
    c:\tools\neovim\nvim-win64\bin\nvim.exe --version
}
# =================================

# =================================
# Format PS Scripts
# =================================
function ps_format {
    # Code inspired from 
    # http://xahlee.info/powershell/powershell_format_script.html
    Param(
        [Parameter(Mandatory = $true, Position = 0)]
        [string]
        $path
    )

    if ( Test-Path $path -PathType leaf ) {
        $fileText = [IO.File]::ReadAllText($path);
        $formattedOutput = Invoke-Formatter -ScriptDefinition $fileText;
        Set-Content $path $formattedOutput -NoNewline;
        Write-Host "Fromat done!";
        return
    }
    Write-Error "file not exist";
}
# =================================

function admin {
    if ($args.Count -gt 0) {   
        $argList = "& '" + $args + "'"
        Start-Process "wt.exe" -Verb runAs -ArgumentList $argList
    } else {
        Start-Process "wt.exe" -Verb runAs
    }
}
