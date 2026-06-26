<#
 Author: soliloquy
 Version: 1.0
 Description: Expands DNS cache size and trims negative-cache durations for quicker repeat lookups.
#>

Write-Host "Network - Optimizing DNS client cache..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
function Ensure-Key($p){ if(-not(Test-Path $p)){ New-Item -Path $p -Force | Out-Null } }
function Set-DW($p,$n,$v){ Ensure-Key $p; New-ItemProperty -Path $p -Name $n -PropertyType DWord -Value $v -Force | Out-Null; Write-Host "$p\$n=$v" }
$dns="HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
Set-DW $dns "MaxCacheTtl" 0x000093A8
Set-DW $dns "MaxNegativeCacheTtl" 0x00000032
Set-DW $dns "NegativeSOACacheTime" 0x0000002D