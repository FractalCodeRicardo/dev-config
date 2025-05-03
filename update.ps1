$nvim_repo = "nvim"
$nvim_config = "$HOME\.config\nvim"

$wezterm_repo = "wezterm"
$wezterm_config = "$HOME\.config\wezterm"

function ReplaceFolder {
    param (
        [string]$SourceDir,
        [string]$TargetDir
    )

    Write-Host "Updating $TargetDir"
    
    if (Test-Path $TargetDir) {
        Remove-Item $TargetDir -Recurse -Force
    }

    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null

    Copy-Item "$SourceDir\*" -Destination $TargetDir -Recurse -Force
}

if ($args.Count -eq 0) {
    Write-Host "Usage: update.ps1 (config | repo)"
    exit 1
}

if ($args[0] -eq "config") {
    ReplaceFolder $nvim_repo $nvim_config
    ReplaceFolder $wezterm_repo $wezterm_config
}

if ($args[0] -eq "repo") {
    ReplaceFolder $nvim_config $nvim_repo
    ReplaceFolder $wezterm_config $wezterm_repo
}

Write-Host "Ok!"
