function Close-MediaDatabase {
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    [Alias('Close-Mdb')]
    param(
        [Parameter(ParameterSetName = 'Path')]
        [string]
        $Path,

        [Parameter(Mandatory, ParameterSetName = 'LiteralPath')]
        [string]
        $LiteralPath
    )

    try {
        $ErrorActionPreference = 'Stop'
        $DatabasePath = [string]::Empty
        if (![string]::IsNullOrWhiteSpace($Path)) {
            $DatabasePath = (Resolve-Path -Path $Path).Path
        }
        if (![string]::IsNullOrWhiteSpace($LiteralPath)) {
            $DatabasePath = (Resolve-Path -LiteralPath $LiteralPath).Path
        }
        if (![string]::IsNullOrWhiteSpace($DatabasePath) -and $DatabasePath -notmatch 'cache\.xml$') {
            $DatabasePath = (Resolve-Path -LiteralPath (Join-Path $DatabasePath 'cache.xml')).Path
        }

        if ([string]::IsNullOrWhiteSpace($DatabasePath)) {
            [videoos.platform.sdk.environment]::Logout()
            [videoos.platform.sdk.environment]::RemoveAllServers()
        } else {
            [videoos.platform.sdk.environment]::Logout("file:\$DatabasePath")
            [videoos.platform.sdk.environment]::RemoveServer("file:\$DatabasePath")
        }
    } catch {
        throw
    }
}
