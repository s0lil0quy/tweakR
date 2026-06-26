<#
 Author: soliloquy
 Version: 1.0
 Description: Disables Nagles algorithm on all active IPv4 interfaces to reduce packet delay.
#>

Write-Host "Network - Disabling Nagle's algorithm on active interfaces..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
function Ensure-Key($p){ if(-not(Test-Path $p)){ New-Item -Path $p -Force | Out-Null } }
function Set-DW($p,$n,$v){ Ensure-Key $p; New-ItemProperty -Path $p -Name $n -PropertyType DWord -Value $v -Force | Out-Null; Write-Host "$p\$n=$v" }
$ifRoot="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $ifRoot | ForEach-Object {
  $g=$_.PsPath
  $dhcp=(Get-ItemProperty -Path $g -ErrorAction SilentlyContinue)."DhcpIPAddress"
  $ip=(Get-ItemProperty -Path $g -ErrorAction SilentlyContinue)."IPAddress"
  if($dhcp -or $ip){ Set-DW $g "TcpAckFrequency" 1; Set-DW $g "TCPNoDelay" 1; Set-DW $g "TCPDelAckTicks" 0 }
}
Write-Host "Network - Nagle disabled. Reboot recommended."
