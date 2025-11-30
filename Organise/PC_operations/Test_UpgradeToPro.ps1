# Filename: UpgradeToPro.ps1

# Ensure the script is run as an administrator
if (!([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator"))
{
    Write-Host "Please run this script as an administrator." -ForegroundColor Red
    Exit
}

# Set the generic Windows 11 Pro product key
$productKey = "X-X-X-X-X"

# Upgrade to Windows 11 Pro
Write-Host "Upgrading to Windows 11 Pro..."
slmgr.vbs /ipk $productKey
changepk.exe /ProductKey $productKey

# Attempt to activate Windows
Write-Host "Attempting to activate Windows..."
slmgr.vbs /ato

Write-Host "Upgrade process initiated. Your system will restart to complete the upgrade." -ForegroundColor Green
