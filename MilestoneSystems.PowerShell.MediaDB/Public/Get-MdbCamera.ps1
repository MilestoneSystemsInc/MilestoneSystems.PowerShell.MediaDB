function Get-MdbCamera {
    [CmdletBinding()]
    [OutputType([VideoOS.Platform.Item])]
    param()

    process {
        Get-MdbItemList -Kind Camera
    }
}
