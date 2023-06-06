$source = "https://raw.githubusercontent.com/L8X/Roblox-Client-Optimizer/main/ClientAppSettings.json"
$versionsFolder = Join-Path $env:LOCALAPPDATA "Roblox\Versions"
$latestVersionFolder = Get-ChildItem $versionsFolder | Where-Object { (Join-Path $_.FullName "RobloxPlayerBeta.exe") | Test-Path } | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($null -eq $latestVersionFolder) {
    Write-Output "Error: Could not find a version folder containing a RobloxPlayerBeta.exe file."
}
else {
    $clientSettingsFolder = Join-Path $latestVersionFolder.FullName "ClientSettings"
    if (!(Test-Path $clientSettingsFolder)) {
        New-Item -ItemType Directory -Path $clientSettingsFolder | Out-Null
    }
    $destination = Join-Path $clientSettingsFolder "ClientAppSettings.json"
    Write-Verbose "Copying file to destination: $destination"
    Invoke-WebRequest -Uri $source -OutFile $destination
    if ($?) {
        Write-Output "File copied successfully."
    }
    else {
        Write-Output "Error: Failed to copy file."
    }
}

Write-Output "Press any key to exit..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
