function Open-MediaDatabase {
    [CmdletBinding(DefaultParameterSetName = 'Path')]
    [Alias('Open-Mdb')]
    param(
        [Parameter(Mandatory, Position = 0, ParameterSetName = 'Path')]
        [ValidateScript({
                if ($_ -notmatch 'cache\.xml$') {
                    throw "The provided media database path must be a path to a file named 'cache.xml'"
                }
                $true
            })]
        [string]
        $Path,

        [Parameter(Mandatory, ParameterSetName = 'LiteralPath')]
        [ValidateScript({
                if ($_ -notmatch 'cache\.xml$') {
                    throw "The provided media database path must be a path to a file named 'cache.xml'"
                }
                $true
            })]
        [string]
        $LiteralPath,

        [Parameter()]
        [securestring]
        $Password = [securestring]::new()
    )

    $DatabasePath = [string]::Empty
    if (![string]::IsNullOrWhiteSpace($Path)) {
        $DatabasePath = (Resolve-Path -Path $Path).Path
    }
    if (![string]::IsNullOrWhiteSpace($LiteralPath)) {
        $DatabasePath = (Resolve-Path -LiteralPath $LiteralPath).Path
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
        Close-MediaDatabase -LiteralPath $DatabasePath
        throw
    }
}
