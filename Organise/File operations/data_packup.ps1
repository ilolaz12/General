#
#
### DO NOT use file on its own adjust first!!!


# $source = "$env:USERPROFILE\Documents"
# $dest = "D:\Backups\Documents_$(Get-Date -Format 'yyyyMMdd')"
# Copy-Item -Path $source -Destination $dest -Recurse

# $Source ='H:\My Drive\Books'
# $Destination = "I:\GDrive\Books"

$Source ='G:\My Drive\Study'
$Destination = "I:\GDrive\Study"

Function Merge-Backup {
    param (
        [string]$Source,
        [string]$Destination
    )

    Get-ChildItem -Path $Source -Recurse -File | ForEach-Object {
        $relPath = $_.FullName.Substring($Source.Length)
        $destPath = Join-Path $Destination $relPath

        if (!(Test-Path $destPath)) {
            New-Item -ItemType Directory -Path (Split-Path $destPath) -Force | Out-Null
            Copy-Item -Path $_.FullName -Destination $destPath
        } else {
            $sourceHash = Get-FileHash $_.FullName
            $destHash = Get-FileHash $destPath

            if ($sourceHash.Hash -ne $destHash.Hash) {
                Rename-Item -Path $destPath -NewName ($destPath + ".old")
                Copy-Item -Path $_.FullName -Destination $destPath
            }
        }
    }
}
