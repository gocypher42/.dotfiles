# ============================
# --  Package installation  --
# ============================

$stateFile = "$HOME\.config\pwsh\packages_installed.flag"

$packages = @(
    @{ Name = "zoxide"; WingetPackage = "ajeetdsouza.zoxide" },
    @{ Name = "oh-my-posh"; WingetPackage = "JanDeDobbeleer.OhMyPosh" }
    @{ Name = "fzf"; WingetPackage = "junegunn.fzf" }
    @{ Name = "yazi"; WingetPackage = "sxyazi.yazi" }
    @{ Name = "nvim"; WingetPackage = "Neovim.Neovim" }
    @{ Name = "git"; WingetPackage = "Git.Git" }
    @{ Name = "jj"; WingetPackage = "jj-vcs.jj" }
)

if (-not (Test-Path $stateFile)) {
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

    New-Item -ItemType File -Path $stateFile -Force | Out-Null
}

