Write-Host "Starting OperaGX Install..." -ForegroundColor Red

$wingetCommand = "winget install --id=Opera.OperaGX -e --source winget --accept-package-agreements"
$process = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $wingetCommand" -NoNewWindow -PassThru

$process.WaitForExit()

# Check if OperaGX is installed
$operaGXInstalled = (winget list | Select-String -Pattern "OperaGX")

if ($operaGXInstalled) {
    Write-Host "OperaGX Install Complete" -ForegroundColor Green
} else {
    Write-Host "OperaGX Install Failed. Please check for errors." -ForegroundColor Red -BackgroundColor Yellow
}
