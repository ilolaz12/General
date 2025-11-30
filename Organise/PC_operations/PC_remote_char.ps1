# Define the remote computer name
$ComputerName = "RemotePCName"  # Replace with the actual remote PC name or IP address

# Collect information
Invoke-Command -ComputerName $ComputerName -ScriptBlock {
    # General System Information
    $SystemInfo = Get-CimInstance -ClassName Win32_ComputerSystem |
        Select-Object Name, Manufacturer, Model, TotalPhysicalMemory

    # Operating System Information
    $OSInfo = Get-CimInstance -ClassName Win32_OperatingSystem |
        Select-Object Caption, OSArchitecture, Version, InstallDate, LastBootUpTime

    # Processor Information
    $CPUInfo = Get-CimInstance -ClassName Win32_Processor |
        Select-Object Name, Manufacturer, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors

    # Installed RAM Information
    $RAMInfo = Get-CimInstance -ClassName Win32_PhysicalMemory |
        Select-Object Manufacturer, Capacity, Speed, PartNumber

    # Disk Drives Information
    $DiskInfo = Get-CimInstance -ClassName Win32_LogicalDisk |
        Select-Object DeviceID, VolumeName, Size, FreeSpace, FileSystem

    # GPU (Video Controller) Information
    $GPUInfo = Get-CimInstance -ClassName Win32_VideoController |
        Select-Object Name, AdapterRAM, DriverVersion

    # BIOS Information
    $BIOSInfo = Get-CimInstance -ClassName Win32_BIOS |
        Select-Object Manufacturer, Version, ReleaseDate

    # Network Adapter Information
    $NetworkInfo = Get-CimInstance -ClassName Win32_NetworkAdapterConfiguration |
        Where-Object { $_.IPEnabled -eq $true } |
        Select-Object Description, MACAddress, IPAddress, DefaultIPGateway

    # Installed Software
    $SoftwareInfo = Get-ItemProperty 'HKLM:\Software\Microsoft\Windows\CurrentVersion\Uninstall\*',
                                     'HKLM:\Software\Wow6432Node\Microsoft\Windows\CurrentVersion\Uninstall\*' |
        Select-Object DisplayName, DisplayVersion, Publisher, InstallDate

    # Combine all information into a single object
    $PCInfo = [PSCustomObject]@{
        SystemInfo    = $SystemInfo
        OSInfo        = $OSInfo
        CPUInfo       = $CPUInfo
        RAMInfo       = $RAMInfo
        DiskInfo      = $DiskInfo
        GPUInfo       = $GPUInfo
        BIOSInfo      = $BIOSInfo
        NetworkInfo   = $NetworkInfo
        SoftwareInfo  = $SoftwareInfo
    }

    # Return the combined object
    $PCInfo
} | Export-Csv -Path "C:\RemotePC_Details.csv" -NoTypeInformation -Force
