Write-Host "Starting Google Chrome Install..." -ForegroundColor Red

$wingetCommand = "winget install --id=Google.Chrome -e --source winget --accept-package-agreements"
$process = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $wingetCommand" -NoNewWindow -PassThru

$process.WaitForExit()

# Check if Chrome is installed
$chromeInstalled = (winget list | Select-String -Pattern "Google Chrome")

if ($chromeInstalled) {
    Write-Host "Google Chrome Install Complete" -ForegroundColor Green
} else {
    Write-Host "Google Chrome Failed. Please check for errors." -ForegroundColor Red -BackgroundColor Yellow
}
