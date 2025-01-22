Write-Host "Starting Firefox Install..." -ForegroundColor Orange
winget install --id=Mozilla.Firefox  -e --source winget --accept-package-agreements
Write-Host "Firefox Install Complete" -ForegroundColor Green