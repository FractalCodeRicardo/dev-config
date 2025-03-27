
# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

#function prompt {
#    Write-Host "["(Get-Date -Format "HH:mm:ss")"]" -ForegroundColor Black -BackgroundColor Green -NoNewline 
#    Write-Host $(Get-Location | Split-Path -Leaf) -ForegroundColor Black -BackgroundColor Green -NoNewline
#    return ""
#}

Set-Location "C:\Users\Ricardo\Desktop\Proyectos"

function prompt {
    # Time with green background
    Write-Host "[" -ForegroundColor Green -NoNewline
    Write-Host (Get-Date -Format "HH:mm:ss") -ForegroundColor Black -BackgroundColor Green -NoNewline
    Write-Host "] " -ForegroundColor Green -NoNewline

    # Current directory with blue background
    Write-Host "[" -ForegroundColor Blue -NoNewline
    Write-Host $(Get-Location | Split-Path -Leaf) -ForegroundColor Black -BackgroundColor Blue -NoNewline
    Write-Host "]" -ForegroundColor Blue -NoNewline

    # Space before input
    return " "
}

