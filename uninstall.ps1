$versionsFolder = Join-Path $env:LOCALAPPDATA "Roblox\Versions"
$latestVersionFolder = Get-ChildItem $versionsFolder | Where-Object { (Join-Path $_.FullName "RobloxPlayerBeta.exe") | Test-Path } | Sort-Object LastWriteTime -Descending | Select-Object -First 1

if ($null -eq $latestVersionFolder) {
    Write-Output "[Error] Could not locate the Roblox installation folder."
}
else {
    $clientSettingsFolder = Join-Path $latestVersionFolder.FullName "ClientSettings"
    if (Test-Path $clientSettingsFolder) {
        Write-Output "Uninstalling tweaks from: $clientSettingsFolder"
        Remove-Item -Recurse -Force $clientSettingsFolder
        Write-Output "[Success] RCO uninstalled."
    }
    else {
        Write-Output "[Error] RCO is not installed."
    }
}

Write-Output "Press any key to exit..."
$null = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")