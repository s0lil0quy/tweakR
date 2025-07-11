Write-Host "Adjusting Network Throttling Index..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Registry path
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"

# Ensure the path exists
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Apply network performance tweaks
Set-ItemProperty -Path $regPath -Name "NetworkThrottlingIndex" -Value 0xFFFFFFFF
Set-ItemProperty -Path $regPath -Name "SystemResponsiveness" -Value 0