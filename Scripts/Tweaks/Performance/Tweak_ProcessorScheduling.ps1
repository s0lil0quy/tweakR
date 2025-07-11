Write-Host "Enabling Processor Scheduling..."

# Requires administrator privileges
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    Exit
}

# Registry path
$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\PriorityControl"

# Create the key if it doesn't exist
If (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set Win32PrioritySeparation to 0x38 (maximum boost, variable quantum)
Set-ItemProperty -Path $regPath -Name "Win32PrioritySeparation" -Type DWord -Value 0x38