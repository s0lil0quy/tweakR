Write-Host "Starting Brave Install..." -ForegroundColor Red

$wingetCommand = "winget install --id=Brave.Brave -e --source winget --accept-package-agreements"
$process = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $wingetCommand" -NoNewWindow -PassThru

$process.WaitForExit()

# Check if Brave is installed
$braveInstalled = (winget list | Select-String -Pattern "Brave")

if ($braveInstalled) {
    Write-Host "Brave Install Complete" -ForegroundColor Green
} else {
    Write-Host "Brave Install Failed. Please check for errors." -ForegroundColor Red -BackgroundColor Yellow
}
