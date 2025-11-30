# Ideally just check manually

# dell updates
#dcu-cli.exe /applyUpdates /silent /reboot=enable
#invoke-dcu -updateType driver -scan
Start-Process -FilePath "C:\Program Files\Dell\CommandUpdate\dcu-cli.exe" -ArgumentList "/UpdateServiceStart", "/StartScan", "/Quiet" -Wait
 
# Check for available updates and install them
$Updates = Get-WmiObject -Namespace "root\ccm\clientSDK" -Class CCM_SoftwareUpdate
foreach ($update in $Updates) {
    if ($update.InstallState -ne 3) { # 3 = Already Installed
        $update.InvokeMethod("Install", $null)
    }
}


# Open Software Center
# Start-Process -FilePath "C:\Windows\CCM\SCClient.exe"
Start-Process -FilePath "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Microsoft Configuration Manager\Configuration Manager\Software Center.lnk"

#Open Dell Command
Start-Process -FilePath "C:\Program Files\WindowsApps\DellInc.DellCommandUpdate_5.4.22.0_x86__htrsf667h5kn2\DCU\DellCommandUpdate.exe"