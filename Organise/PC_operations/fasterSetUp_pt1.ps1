# Check if the script is running as Administrator - out of the box PC's dont know policy where new group allows bypass that
If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    # Relaunch the script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -Verb RunAs
    exit
}

Write-Host "Running Settings_Including_BIOS.bat"
# Run script 1 (BIOS info)
Start-Process -FilePath "\\scmg45\source$\Applications\_Packages\Tier 0\Dell Command Update XML Config Import\Settings_Including_BIOS.bat" -Wait
 
# Dell updates - you will need to re-launch dell update software, but this decreases download time
#dcu-cli.exe /applyUpdates /silent /reboot=enable
#invoke-dcu -updateType driver -scan
Write-Host "Running Dell Update Service"
Set-Location -Path "C:\Program Files\Dell\CommandUpdate\"
Start-Process "dcu-cli.exe" -ArgumentList "/applyUpdateServiceStart", "/Quiet" -Wait 
Start-Process "dcu-cli.exe" -ArgumentList "/UpdateServiceStart", "/StartScan", "/Quiet" -Wait
 
# Check for available updates in SOftware Center and install them - this works well so far, but i always open software center just in case
Write-Host "Running SCCM Update Service"
$Updates = Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate
foreach ($update in $Updates) {
    if ($update.InstallState -ne 3) { # 3 = Already Installed
        $update.InvokeMethod("Install", $null)
    }
}

# Wait for 20 Seconds
Start-Sleep -Seconds 20

# Open Software Center
# Start-Process -FilePath "C:\Windows\CCM\SCClient.exe"
Write-Host "Opening SCCM App"
Start-Process -FilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Configuration Manager\Configuration Manager\Software Center.lnk"

# Wait for 2 Seconds
Start-Sleep -Seconds 2

#Open Dell Command
Write-Host "Opening Dell App"
Start-Process -FilePath "C:\Program Files\WindowsApps\DellInc.DellCommandUpdate_5.4.22.0_x86__htrsf667h5kn2\DCU\DellCommandUpdate.exe"