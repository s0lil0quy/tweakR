<#
 Author: soliloquy
 Version: 1.0
 Description: Disables NIC power-savers (NS/ARP offload, packet coalescing) to keep the adapter fully responsive.
#>

Write-Host "Network - Optimizing NIC power features..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$adapters = Get-NetAdapter -Physical | Where-Object {$_.Status -eq "Up"}
foreach($nic in $adapters){
  try{
    Set-NetAdapterPowerManagement -Name $nic.Name -NoOSPM On -ArpOffload Disabled -NSOffload Disabled -PacketCoalescing Disabled -ErrorAction Stop
    Write-Host "Adjusted: $($nic.Name)"
  } catch { Write-Host "Skipped $($nic.Name): $($_.Exception.Message)" }
}
