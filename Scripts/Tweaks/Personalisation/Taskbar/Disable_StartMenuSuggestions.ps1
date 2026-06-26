Write-Host "Disabling Start Menu Suggestions..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\ContentDeliveryManager"

If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

Set-ItemProperty -Path $regPath -Name "SubscribedContent-338388Enabled" -Value 0
Set-ItemProperty -Path $regPath -Name "SubscribedContent-310093Enabled" -Value 0
Set-ItemProperty -Path $regPath -Name "SubscribedContent-338389Enabled" -Value 0
Set-ItemProperty -Path $regPath -Name "SubscribedContent-353698Enabled" -Value 0