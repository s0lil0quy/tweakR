Write-Host "Enabling HAGS..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Registry path
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"

# Create the key if it doesn't exist
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

Set-ItemProperty -Path $regPath -Name "HwSchMode" -Type DWord -Value 2