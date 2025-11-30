# Check if the script is running as Administrator - out of the box PC's dont know policy where new group allows bypass that by running this script PC should have rebuild few times and know it


If (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Relaunch the script as Administrator
    $scriptPath = $MyInvocation.MyCommand.Path
    Start-Process powershell.exe -ArgumentList "-File `"$scriptPath`"" -Verb RunAs
    exit
}

# Run script 2 to hide BIOS 
Start-Process -FilePath "\\scmg45\source$\Applications\_Packages\Tier 0\Dell Command Update XML Config Import\Settings_Excluding_BIOS.bat" -Wait

# Wait for 20 Seconds
Start-Sleep -Seconds 20

# Run script 2 to hide BIOS 
Start-Process -FilePath "\\scmg45\source$\Applications\_Packages\Tier 0\Dell Command Update XML Config Import\Settings_Excluding_BIOS.bat" -Wait