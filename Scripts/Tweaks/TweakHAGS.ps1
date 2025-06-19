Write-Host "Downloading - "
Write-Host "Enabling HAGS..."

$regPath = "HKLM:\SYSTEM\CurrentControlSet\Control\GraphicsDrivers"
Set-ItemProperty -Path $regPath -Name "HwSchMode" -Type DWord -Value 2