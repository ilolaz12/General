# Filename: Install-RSAT.ps1

# Set execution policy to allow script execution
Set-ExecutionPolicy Bypass -Scope Process -Force

# Install Chocolatey
Write-Output "Installing Chocolatey..."
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

# Verify Chocolatey installation
if (Get-Command choco -ErrorAction SilentlyContinue) {
    Write-Output "Chocolatey installed successfully."
} else {
    Write-Output "Chocolatey installation failed."
    Exit 1
}

# Install RSAT tools using Chocolatey
Write-Output "Installing RSAT tools..."
choco install rsat -y

# Verify RSAT installation
$rsatTools = @(
    "RSAT-AD-PowerShell",
    "RSAT-AD-AdminCenter",
    "RSAT-ADDS",
    "RSAT-DNS-Server",
    "RSAT-File-Services",
    "RSAT-FRS-Mgmt-Console",
    "RSAT-Group-Policy-Management",
    "RSAT-Hyper-V-Tools",
    "RSAT-IPAM-Client",
    "RSAT-LIS-Feature",
    "RSAT-Network-Controller",
    "RSAT-Network-Load-Balancing",
    "RSAT-RDS-Tools",
    "RSAT-Remote-Access",
    "RSAT-SMTP-Server",
    "RSAT-Storage-Mgmt",
    "RSAT-System-Insights",
    "RSAT-VM-Manager",
    "RSAT-Web-Server",
    "RSAT-Windows-Deployment-Services",
    "RSAT-Windows-Server-Backup",
    "RSAT-WindowsServer-UpdateServices"
)

$installedTools = @()

foreach ($tool in $rsatTools) {
    if (Get-WindowsFeature -Name $tool -ErrorAction SilentlyContinue) {
        $installedTools += $tool
    }
}

if ($installedTools.Count -eq $rsatTools.Count) {
    Write-Output "All RSAT tools installed successfully."
} else {
    Write-Output "Some RSAT tools failed to install."
}

# End of script
Write-Output "Installation complete."
