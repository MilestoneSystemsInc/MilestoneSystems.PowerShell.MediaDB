function Get-MdbSpeaker {
    [CmdletBinding()]
    [OutputType([VideoOS.Platform.Item])]
    param()

    process {
        Get-MdbItemList -Kind Speaker
    }
}
