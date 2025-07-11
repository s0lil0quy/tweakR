Write-Host "Prioritising Gaming Tasks..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Registry path
$regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"

# Create the key if it doesn't exist
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

New-Item -Path $regPath -Force | Out-Null
Set-ItemProperty -Path $regPath -Name "GPU Priority" -Value 8 -Type DWord
Set-ItemProperty -Path $regPath -Name "Priority" -Value 6 -Type DWord
Set-ItemProperty -Path $regPath -Name "Clock Rate" -Value 10000 -Type DWord
Set-ItemProperty -Path $regPath -Name "Scheduling Category" -Value "High"
Set-ItemProperty -Path $regPath -Name "SFIO Priority" -Value "High"
Set-ItemProperty -Path $regPath -Name "Background Only" -Value "False"
Set-ItemProperty -Path $regPath -Name "Affinity" -Value 0