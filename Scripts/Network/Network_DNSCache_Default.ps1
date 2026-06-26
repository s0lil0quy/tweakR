<#
 Author: soliloquy
 Version: 1.0
 Description: Removes custom DNS cache values and restores Windows defaults.
#>

Write-Host "Network - Restoring DNS client cache defaults..."
If (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) { Start-Process PowerShell.exe -ArgumentList "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs; Exit }
$dns="HKLM:\SYSTEM\CurrentControlSet\Services\Dnscache\Parameters"
foreach($n in "MaxCacheTtl","MaxNegativeCacheTtl","NegativeSOACacheTime"){
  if(Get-ItemProperty -Path $dns -Name $n -ErrorAction SilentlyContinue){
    Remove-ItemProperty -Path $dns -Name $n -ErrorAction SilentlyContinue
    Write-Host "Removed $n"
  }
}
