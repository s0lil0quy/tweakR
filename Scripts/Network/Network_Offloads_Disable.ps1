<#
 Author: soliloquy
 Version: 1.0
 Description: Disables LSO/Checksum/RSC offloads to favor latency (higher CPU usage).
#>

Write-Host "Network - Disabling NIC offloads (where supported)..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$props=@(
 "Large Send Offload V2 (IPv4)","Large Send Offload V2 (IPv6)",
 "IPv4 Checksum Offload","IPv6 Checksum Offload",
 "TCP Checksum Offload (IPv4)","TCP Checksum Offload (IPv6)",
 "UDP Checksum Offload (IPv4)","UDP Checksum Offload (IPv6)",
 "Receive Side Coalescing"
)
Get-NetAdapter -Physical | Where-Object {$_.Status -eq "Up"} | ForEach-Object {
  $n=$_.Name
  foreach($p in $props){ try{ Set-NetAdapterAdvancedProperty -Name $n -DisplayName $p -DisplayValue "Disabled" -NoRestart -ErrorAction Stop; Write-Host "Disabled $p on $n" } catch{} }
}
Write-Host "Network - Offloads disabled. Reboot recommended."