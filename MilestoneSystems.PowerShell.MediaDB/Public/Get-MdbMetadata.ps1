function Get-MdbMetadata {
    [CmdletBinding()]
    [OutputType([VideoOS.Platform.Item])]
    param()

    process {
        Get-MdbItemList -Kind Metadata
    }
}
