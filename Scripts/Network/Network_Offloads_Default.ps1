<#
 Author: soliloquy
 Version: 1.0
 Description: Re-enables LSO/Checksum/RSC offloads for maximum throughput and lower CPU.
#>

Write-Host "Network - Enabling NIC offloads (where supported)..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$vals=@{
 "Large Send Offload V2 (IPv4)"="Enabled"; "Large Send Offload V2 (IPv6)"="Enabled";
 "IPv4 Checksum Offload"="Rx & Tx Enabled"; "IPv6 Checksum Offload"="Rx & Tx Enabled";
 "TCP Checksum Offload (IPv4)"="Rx & Tx Enabled"; "TCP Checksum Offload (IPv6)"="Rx & Tx Enabled";
 "UDP Checksum Offload (IPv4)"="Rx & Tx Enabled"; "UDP Checksum Offload (IPv6)"="Rx & Tx Enabled";
 "Receive Side Coalescing"="Enabled"
}
Get-NetAdapter -Physical | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
  $n=$_.Name
  foreach($k in $vals.Keys){ try{ Set-NetAdapterAdvancedProperty -Name $n -DisplayName $k -DisplayValue $vals[$k] -NoRestart -ErrorAction Stop; Write-Host "Set $k on $n -> $($vals[$k])" } catch{} }
}
Write-Host "Network - Offloads enabled. Reboot recommended."
