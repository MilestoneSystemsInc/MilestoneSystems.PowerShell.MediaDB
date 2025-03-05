@{
    RootModule        = 'MilestoneSystems.PowerShell.MediaDB.psm1'
    ModuleVersion     = '0.1.0'
    GUID              = '873f32e4-50a3-499b-8eab-f895986223ab'
    Author            = 'Milestone Systems'
    CompanyName       = 'Milestone Systems'
    Copyright         = '(c) 2025 Milestone Systems. All rights reserved.'
    Description       = 'Open a raw Milestone XProtect media database, get information about the contents including the available devices, recording and motion sequences, and perform exports of the available data.'
    RequiredModules   = @('MilestonePSTools')
    FunctionsToExport = '*'
    CmdletsToExport   = '*'
    VariablesToExport = '*'
    AliasesToExport   = @('Close-Mdb', 'Open-Mdb')
    PrivateData       = @{
        PSData = @{
            Tags = @('Windows', 'MilestoneSystems', 'XProtect')
            # LicenseUri = ''
            # ProjectUri = ''
            # IconUri = ''
            # ReleaseNotes = ''
        }
    }
}
