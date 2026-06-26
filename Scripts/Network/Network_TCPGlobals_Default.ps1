<#
 Author: soliloquy
 Version: 1.0
 Description: Tunes TCP/IP globals (RSS on, RSC off, ECN off, timestamps off) for responsiveness and stability.
#>

Write-Host "Network - Applying TCP Global settings..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
"netsh int tcp set global rss=enabled"            | Invoke-Expression
"netsh int tcp set global rsc=disabled"           | Invoke-Expression
"netsh int tcp set global autotuninglevel=normal" | Invoke-Expression
"netsh int tcp set global ecncapability=disabled" | Invoke-Expression
"netsh int tcp set global chimney=disabled"       | Invoke-Expression
"netsh int tcp set global timestamps=disabled"    | Invoke-Expression
"netsh int tcp show global"                       | Invoke-Expression
Write-Host "Network - TCP globals configured. Reboot recommended."