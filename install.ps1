$source = "https://raw.githubusercontent.com/L8X/Roblox-Client-Optimizer/main/ClientAppSettings.json"
$versionsFolder = Join-Path $env:LOCALAPPDATA "Roblox\Versions"
$latestVersionFolder = Get-ChildItem $versionsFolder | Where-Object { (Join-Path $_.FullName "RobloxPlayerBeta.exe") | Test-Path } | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($null -eq $latestVersionFolder) {
    Write-Output "[Error] Could not locate the Roblox installation folder."
}
else {
    $clientSettingsFolder = Join-Path $latestVersionFolder.FullName "ClientSettings"
    if (!(Test-Path $clientSettingsFolder)) {
        New-Item -ItemType Directory -Path $clientSettingsFolder | Out-Null
    }
    $destination = Join-Path $clientSettingsFolder "ClientAppSettings.json"
    Write-Output "Installing tweaks to: $destination"
    Invoke-WebRequest -Uri $source -OutFile $destination
    if ($?) {
        Write-Output "[Success] RCO installed."
    }
    else {
        Write-Output "[Error] RCO installation failed."
    }
}

Write-Output "Press any key to exit..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
