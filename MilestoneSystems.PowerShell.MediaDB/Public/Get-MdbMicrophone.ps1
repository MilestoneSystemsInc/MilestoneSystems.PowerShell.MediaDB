function Get-MdbMicrophone {
    [CmdletBinding()]
    [OutputType([VideoOS.Platform.Item])]
    param()

    process {
        Get-MdbItemList -Kind Microphone
    }
}
