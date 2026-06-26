<#
 Author: soliloquy
 Version: 1.0
 Description: Restores default Nagle behavior for normal throughput characteristics.
#>

Write-Host "Network - Restoring Nagle's algorithm to defaults..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$ifRoot="HKLM:\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces"
Get-ChildItem $ifRoot | ForEach-Object {
  $g=$_.PsPath
  foreach($n in "TcpAckFrequency","TCPNoDelay","TCPDelAckTicks"){
    if(Get-ItemProperty -Path $g -Name $n -ErrorAction SilentlyContinue){
      Remove-ItemProperty -Path $g -Name $n -ErrorAction SilentlyContinue
      Write-Host "Removed $n on $g"
    }
  }
}
Write-Host "Network - Nagle restored. Reboot recommended."
