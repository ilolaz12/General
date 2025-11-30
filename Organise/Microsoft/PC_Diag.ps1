#
#
### DO NOT use file on its own adjust first!!!

# # Monitor CPU Usage Every 5 Seconds
# while ($true) {
#     Get-Counter '\Processor(_Total)\% Processor Time'
#     Start-Sleep -Seconds 5
# }

Function Save-PCDiagnostics {
    param (
        [string]$OutputPath = "$env:USERPROFILE\Desktop\PC-Diagnostics.txt"
    )

    $info = @()
    $info += "=== OS Info ==="
    $info += (Get-ComputerInfo | Out-String)

    $info += "=== Disk Usage ==="
    $info += (Get-PSDrive -PSProvider 'FileSystem' | Out-String)

    $info += "=== Network Configuration ==="
    $info += (Get-NetIPConfiguration | Out-String)

    $info += "=== Running Services ==="
    $info += (Get-Service | Where-Object {$_.Status -eq "Running"} | Out-String)

    $info | Set-Content -Path $OutputPath
}
