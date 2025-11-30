# Restart Windows Update service and related services
Write-Host "Restarting Windows Update services..."
$services = @("wuauserv", "bits", "cryptsvc", "msiserver")
foreach ($service in $services) {
    if ((Get-Service -Name $service).Status -eq 'Running') {
        Stop-Service -Name $service -Force
        Start-Sleep -Seconds 3
    }
    Start-Service -Name $service
}

# Clear SoftwareDistribution and Catroot2 folders
Write-Host "Clearing SoftwareDistribution and Catroot2 folders..."
Remove-Item -Path "C:\Windows\SoftwareDistribution\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\System32\catroot2\*" -Recurse -Force -ErrorAction SilentlyContinue

# Re-register Windows Update DLL files
Write-Host "Re-registering Windows Update DLL files..."
$wudlls = @("wuapi.dll", "wuaueng.dll", "wups.dll", "wups2.dll", "wuwebv.dll", "wucltux.dll", "wudriver.dll")
foreach ($dll in $wudlls) {
    try {
        regsvr32.exe /s "C:\Windows\System32\$dll"
    } catch {
        Write-Host "Failed to register $dll"
    }
}

# Reset Windows Update and Software Center components
Write-Host "Resetting Windows Update and Software Center components..."
Invoke-Expression -Command "C:\Windows\CCM\ccmrepair.exe"

# Restart Windows Update services to ensure they're running
Write-Host "Ensuring Windows Update services are running..."
foreach ($service in $services) {
    Start-Service -Name $service
}

# Force Software Center to check for updates
Write-Host "Forcing Software Center to check for updates..."
# Invoke-Expression -Command "C:\Windows\CCM\scclient.exe"
Start-Process -FilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Configuration Manager\Configuration Manager\Software Center.lnk"

Write-Host "Windows Update reset and Software Center update check complete."
