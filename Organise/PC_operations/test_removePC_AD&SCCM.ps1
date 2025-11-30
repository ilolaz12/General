<# $PCName = "HOST" #enter PC name to remove here
# Remove from AD
Remove-ADComputer -Identity $PCName | Remove-ADObject -Recursive
# Remove from SCCM
Remove-CMDevice -DeviceName $PCName  #>

# Variables
$ComputerName = "HOST" # Replace with the actual computer name

$SCCMSiteCode = "Server_code" # SCCM Site Code
$SCCMServer = "server_name # SCCM Server Name

# Load the SCCM PowerShell module if not already loaded
if (-not (Get-Module -Name 'ConfigurationManager')) {
    Import-Module "$($Env:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" -ErrorAction Stop
}

# Set the SCCM connection to the specified site code
cd "$SCCMSiteCode:" # Connect to the SCCM site

# Remove the computer from Active Directory
Write-Output "Attempting to remove $ComputerName from Active Directory..."
try {
    $ADComputer = Get-ADComputer -Identity $ComputerName -ErrorAction Stop
    Remove-ADComputer -Identity $ADComputer -Confirm:$false
    Write-Output "$ComputerName removed from Active Directory."
} catch {
    Write-Output "Failed to remove $ComputerName from Active Directory: $_"
}

# Remove the computer from SCCM
Write-Output "Attempting to remove $ComputerName from SCCM..."
try {
    $SCCMComputer = Get-CMDevice -Name $ComputerName -ErrorAction Stop
    Remove-CMDevice -InputObject $SCCMComputer -Force
    Write-Output "$ComputerName removed from SCCM."
} catch {
    Write-Output "Failed to remove $ComputerName from SCCM: $_"
}
