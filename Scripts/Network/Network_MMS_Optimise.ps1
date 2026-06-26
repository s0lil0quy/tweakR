<#
 Author: soliloquy
 Version: 1.0
 Description: Disables multimedia network throttling and lowers system responsiveness for low latency.
#>

Write-Host "Network - Disabling Multimedia Throttling & SystemResponsiveness..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
function Ensure-Key($p){ if(-not(Test-Path $p)){ New-Item -Path $p -Force | Out-Null } }
function Set-DW($p,$n,$v){ Ensure-Key $p; New-ItemProperty -Path $p -Name $n -PropertyType DWord -Value $v -Force | Out-Null; Write-Host "$p\$n=$v" }
$reg="HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile"
Set-DW $reg "NetworkThrottlingIndex" 0xFFFFFFFF
Set-DW $reg "SystemResponsiveness" 0