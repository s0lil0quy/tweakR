Write-Host "Disabling GameDVR and background recording..."

# Elevate if not running as admin
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Registry paths
$regPath1 = "HKCU:\System\GameConfigStore"
$regPath2 = "HKCU:\Software\Microsoft\Windows\CurrentVersion\GameDVR"

# Ensure keys exist
If (-not (Test-Path $regPath1)) { New-Item -Path $regPath1 -Force | Out-Null }
If (-not (Test-Path $regPath2)) { New-Item -Path $regPath2 -Force | Out-Null }

# Disable GameDVR & background recording
Set-ItemProperty -Path $regPath1 -Name "GameDVR_Enabled" -Value 0
Set-ItemProperty -Path $regPath1 -Name "GameDVR_FSEBehaviorMode" -Value 2
Set-ItemProperty -Path $regPath1 -Name "GameDVR_HonorUserFSEBehaviorMode" -Value 1
Set-ItemProperty -Path $regPath2 -Name "AppCaptureEnabled" -Value 0