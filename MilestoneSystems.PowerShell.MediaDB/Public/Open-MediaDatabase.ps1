function Open-MediaDatabase {
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    [Alias('Open-Mdb')]
    param(
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Path')]
        [ValidateScript({
                if ($_ -notmatch 'cache\.xml$') {
                    if (!(Test-Path -Path (Join-Path $_ 'cache.xml'))) {
                        throw "The provided media database path must be a path to a file named 'cache.xml', or a directory containing a cache.xml file."
                    }
                }
                $true
            })]
        [string]
        $Path,

        [Parameter(Mandatory, ParameterSetName = 'LiteralPath')]
        [ValidateScript({
            if ($_ -notmatch 'cache\.xml$') {
                if (!(Test-Path -LiteralPath (Join-Path $_ 'cache.xml'))) {
                    throw "The provided media database path must be a path to a file named 'cache.xml', or a directory containing a cache.xml file."
                }
            }
                $true
            })]
        [string]
        $LiteralPath,

        [Parameter()]
        [securestring]
        $Password = [securestring]::new()
    )

    $ErrorActionPreference = 'Stop'
    $DatabasePath = [string]::Empty
    if (![string]::IsNullOrWhiteSpace($Path)) {
        $DatabasePath = (Resolve-Path -Path $Path).Path
    }
    if (![string]::IsNullOrWhiteSpace($LiteralPath)) {
        $DatabasePath = (Resolve-Path -LiteralPath $LiteralPath).Path
    }
    if ($DatabasePath -notmatch 'cache\.xml$') {
        $DatabasePath = (Resolve-Path -LiteralPath (Join-Path $DatabasePath 'cache.xml')).Path
    }

    try {
        [videoos.platform.sdk.environment]::AddServer(
            $false,
            "file:\$DatabasePath",
            [system.net.networkcredential]::new('', $Password)
        )

        [videoos.platform.sdk.environment]::Login(
            "file:\$DatabasePath",
            'c4308810-f355-40c2-8a5b-8f15d177ddb1', # integration id
            'MilestoneSystems.PowerShell.MediaDB', # integration name
            '0.1', # version
            'Milestone Systems'                     # manufacturer
        )

        $null = [videoos.platform.sdk.environment]::LoadConfiguration(
            "file:\$DatabasePath"
        )
    } catch {
        # Must remove all servers - removing just the one that failed to open will throw UriFormatException
        [videoos.platform.sdk.environment]::RemoveAllServers()
        throw
    }
}
