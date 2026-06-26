<#
 Author: soliloquy
 Version: 1.0
 Description: Restores NIC power management features to Windows defaults.
#>

Write-Host "Network - Restoring NIC power features to defaults..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$adapters = Get-NetAdapter -Physical | Where-Object {$_.Status -eq "Up"}
foreach($nic in $adapters){
  try{
    Set-NetAdapterPowerManagement -Name $nic.Name -NoOSPM Off -ArpOffload Enabled -NSOffload Enabled -PacketCoalescing Enabled -ErrorAction Stop
    Write-Host "Restored: $($nic.Name)"
  } catch { Write-Host "Skipped $($nic.Name): $($_.Exception.Message)" }
}
