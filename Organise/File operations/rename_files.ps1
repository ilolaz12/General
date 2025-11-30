#
#
### DO NOT use file on its own adjust first!!!

## Rename files based on name attribute
# Get-ChildItem -Path "C:\Photos" -Filter *.jpg | ForEach-Object {
#     $date = (Get-Date $_.CreationTime).ToString("yyyy-MM-dd_HH-mm-ss")
    # Rename-Item $_ -NewName "$date.jpg"
# }

# Function
Function Rename-FilesByAttribute {
    param (
        [string]$Path,
        [ValidateSet("CreationTime", "LastWriteTime", "Name", "Extension")]
        [string]$Attribute = "CreationTime",
        [string]$Format = "yyyy-MM-dd_HH-mm-ss"
    )

    Get-ChildItem -Path $Path -File | ForEach-Object {
        $value = $_.$Attribute
        if ($value -is [datetime]) {
            $formatted = $value.ToString($Format)
        } else {
            $formatted = $value
        }

        $newName = "$formatted$($_.Extension)"
        Rename-Item -Path $_.FullName -NewName $newName -WhatIf
    }
}
