$nvimRepo = "nvim"
$nvimConfig = "$env:USERPROFILE\AppData\Local"

Copy-Item -Recurse -Force $nvimRepo $nvimConfig

Write-Output "Ok!"
