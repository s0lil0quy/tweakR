Write-Host "Starting Firefox Install..." -ForegroundColor Blue
winget install --id=Mozilla.Firefox  -e --source winget --accept-package-agreements --silent
Write-Host "Starting Firefox Complete" -ForegroundColor Green