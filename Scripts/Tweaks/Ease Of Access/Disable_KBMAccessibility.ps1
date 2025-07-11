Write-Host "Disabling keyboard and mouse accessibility features..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\StickyKeys")) { New-Item -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "2"

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\ToggleKeys")) { New-Item -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\ToggleKeys" -Name "Flags" -Value "34"

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\MouseKeys")) { New-Item -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "Flags" -Value "130"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "MaximumSpeed" -Value "39"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\MouseKeys" -Name "TimeToMaximumSpeed" -Value "3000"

If (-not (Test-Path "HKCU:\Control Panel\Accessibility\Keyboard Response")) { New-Item -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Force | Out-Null }
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "Flags" -Value "2"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatRate" -Value "0"
Set-ItemProperty -Path "HKCU:\Control Panel\Accessibility\Keyboard Response" -Name "AutoRepeatDelay" -Value "0"