Write-Host "Disabling Narrator features..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

If (-not (Test-Path "HKCU:\Software\Microsoft\Narrator")) { New-Item -Path "HKCU:\Software\Microsoft\Narrator" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator" -Name "NarratorCursorHighlight" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator" -Name "CoupleNarratorCursorKeyboard" -Value 0

If (-not (Test-Path "HKCU:\Software\Microsoft\Narrator\NoRoam")) { New-Item -Path "HKCU:\Software\Microsoft\Narrator\NoRoam" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator\NoRoam" -Name "DuckAudio" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator\NoRoam" -Name "WinEnterLaunchEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator\NoRoam" -Name "ScriptingEnabled" -Value 0
Set-ItemProperty -Path "HKCU:\Software\Microsoft\Narrator\NoRoam" -Name "OnlineServicesEnabled" -Value 0