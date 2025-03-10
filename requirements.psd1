@{
    PSDepend = @{
        Version = '0.3.8'
    }
    PSDependOptions = @{
        Target = 'CurrentUser'
        Parameters = @{
            Scope = 'CurrentUser'
        }
    }
    'Pester' = @{
        RequiredVersion = '5.7.1'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'platyPS' = @{
        RequiredVersion = '0.14.2'
        Parameters = @{
            SkipPublisherCheck = $true
        }
    }
    'psake' = @{
        Version = '4.9.1'
    }
    'BuildHelpers' = @{
        Version = '2.0.16'
    }
    'PowerShellBuild' = @{
        Version = '0.6.2'
    }
    'PSScriptAnalyzer' = @{
        Version = '1.23.0'
    }
    'MilestonePSTools' = @{
        Version = '24.2.18'
    }
}
