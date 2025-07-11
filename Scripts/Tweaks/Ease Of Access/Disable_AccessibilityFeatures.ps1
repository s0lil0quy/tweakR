Write-Host "Disabling general accessibility features..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

If (-not (Test-Path "HKCU:\Software\Microsoft\Ease of Access")) { New-Item -Path "HKCU:\Software\Microsoft\Ease of Access" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfvoice" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Ease of Access" -Name "selfscan" -Value 0

If (-not (Test-Path "HKCU:\Control Panel\Accessibility")) { New-Item -Path "HKCU:\Control Panel\Accessibility" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Sound on Activation" -Value 0
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility" -Name "Warning Sounds" -Value 0

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\HighContrast")) { New-Item -Path "HKCU:\Control Panel\Accessibility\HighContrast" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\HighContrast" -Name "Flags" -Value "4194"

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\SoundSentry")) { New-Item -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "Flags" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "FSTextEffect" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "TextEffect" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SoundSentry" -Name "WindowsEffect" -Value "0"

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\SlateLaunch")) { New-Item -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "ATapp" -Value ""
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\SlateLaunch" -Name "LaunchAT" -Value 0