$nvim_repo = "nvim"
$nvim_config = "$HOME\AppData\Local\nvim"

$wezterm_repo = "wezterm"
$wezterm_config = "$HOME\.config\wezterm"

function ReplaceFolder {
    param (
        [string]$SourceDir,
        [string]$TargetDir
    )

    
    if (Test-Path $TargetDir) {
        Write-Host "Removing $TargetDir"
        Remove-Item $TargetDir -Recurse -Force
    }

    New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null
    
    Write-Host "--Copying--"
    Write-Host "From $SourceDir"
    Write-Host "To $TargetDir"
    Write-Host "---------"

    Copy-Item "$SourceDir\*" -Destination $TargetDir -Recurse -Force
}

if ($args.Count -eq 0) {
    Write-Host "Usage: update.ps1 (config | repo)"
    exit 1
}

Write-Host $args[0]
if ($args[0] -eq "config") {
    ReplaceFolder $nvim_repo $nvim_config
    ReplaceFolder $wezterm_repo $wezterm_config
}

if ($args[0] -eq "repo") {
    ReplaceFolder $nvim_config $nvim_repo
    ReplaceFolder $wezterm_config $wezterm_repo
}

Write-Host "Ok!"
