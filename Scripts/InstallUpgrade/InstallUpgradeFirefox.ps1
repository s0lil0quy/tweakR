Write-Host "Starting Firefox Install..." -ForegroundColor Red

$wingetCommand = "winget install --id=Mozilla.Firefox -e --source winget --accept-package-agreements"
$process = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $wingetCommand" -NoNewWindow -PassThru

$process.WaitForExit()

# Check if Firefox is installed
$firefoxInstalled = (winget list | Select-String -Pattern "Mozilla Firefox")

if ($firefoxInstalled) {
    Write-Host "Firefox Install Complete" -ForegroundColor Green
} else {
    Write-Host "Firefox Installation Failed. Please check for errors." -ForegroundColor Red -BackgroundColor Yellow
}
