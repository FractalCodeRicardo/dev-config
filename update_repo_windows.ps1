$nvimRepo = "."
$nvimConfig = "$env:USERPROFILE\AppData\Local\nvim"

Copy-Item -Recurse -Force $nvimConfig $nvimRepo

Write-Output "Ok!"
