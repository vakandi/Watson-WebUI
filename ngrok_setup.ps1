$api_android = "k-1deb4a7ba1f3"
$hostName = $env:COMPUTERNAME
$dateTime = Get-Date -Format "yyyy_MM_dd_HH:mm"
$port = 7860
$ngrokPath = "C:\Users\vakandi\ngrok.exe"
$ip = (Invoke-RestMethod -Uri "http://checkip.dyndns.org").Content -replace '.*Current IP Address: |<.*$'

if (-not $link) {
    Write-Host "Ngrok Server Not Started.."
    Start-Process -FilePath "cmd.exe" -ArgumentList "/c start $ngrokPath http $port"
    Start-Sleep -Seconds 1.5

    $tunnelInfo = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels" | Select-Object -ExpandProperty tunnels
    $link = $tunnelInfo[0].public_url
    $link | Out-File "$env:USERPROFILE\.link_watson"

    $url = "http://xdroid.net/api/message?k=$api_android&t=Watson+Active&c=IP:$ip+$hostName+$dateTime&u=$link"
    Invoke-RestMethod -Uri $url
} else {
    Write-Host "Ngrok Server Already Started.."
    Stop-Process -Name ngrok -Force
    Start-Sleep -Seconds 1

    Start-Process -FilePath "cmd.exe" -ArgumentList "/c start $ngrokPath http $port"
    Start-Sleep -Seconds 1.5

    $tunnelInfo = Invoke-RestMethod -Uri "http://localhost:4040/api/tunnels" | Select-Object -ExpandProperty tunnels
    $link = $tunnelInfo[0].public_url
    $link | Out-File "$env:USERPROFILE\.link_watson"

    $url = "http://xdroid.net/api/message?k=$api_android&t=Watson+Active&c=IP:$ip+$hostName+$dateTime&u=$link"
    Invoke-RestMethod -Uri $url
}
