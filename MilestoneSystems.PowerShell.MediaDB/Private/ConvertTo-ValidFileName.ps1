function ConvertTo-ValidFileName {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $Name
    )

    [io.path]::GetInvalidFileNameChars() | ForEach-Object {
        $Name = $Name -replace [regex]::Escape($_), '-'
    }
    $Name
}
