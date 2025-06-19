$hostappname = "MobaXterm"
$wingetName = "Mobatek.MobaXterm"

Write-Host "Starting $hostappname Install..." -ForegroundColor Red

$wingetCommand = "winget install --id=$wingetName -e --source winget --accept-package-agreements"
$process = Start-Process -FilePath "powershell.exe" -ArgumentList "-Command $wingetCommand" -NoNewWindow -PassThru

$process.WaitForExit()

$appInstalled = (winget list | Select-String -Pattern $hostappname)

if ($appInstalled) {
    Write-Host "$hostappname Install Complete" -ForegroundColor Green
} else {
    Write-Host "$hostappname Install Failed. Please check for errors." -ForegroundColor Red -BackgroundColor Yellow

}