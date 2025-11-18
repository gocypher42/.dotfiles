# ======================================
# -- Command Alkon Specific Functions --
# ======================================

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
        return;
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
            jj git fetch && jj rebase -d develop@origin
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
