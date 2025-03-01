Context "Export-Mdb" {
    BeforeAll {
        $script:EncryptedDbPath = [io.path]::Combine($PSScriptRoot, 'data', 'EncryptedExport', 'cache.xml')
        $script:UnencryptedDbPath = [io.path]::Combine($PSScriptRoot, 'data', 'UnencryptedExport', 'cache.xml')
    }

    AfterEach {
        Close-MediaDatabase
    }

    It "Can export from encrypted database" {
        $password = 'rzxW&s3Ftw' | ConvertTo-SecureString -AsPlainText -Force
        Open-MediaDatabase -Path $script:EncryptedDbPath -Password $password

        $folder = Get-MdbCamera | Get-MdbSequence -Type RecordingSequence | ForEach-Object {
            $item = [videoos.platform.configuration]::Instance.GetItem($_.FQID)
            $path = 'TestDrive:\{0}_{1}_Database' -f $_.Source, $_.Start.ToString('yyyy-MM-dd_HH-mm-ss')
            $exportParams = @{
                Device = $item
                Start  = $_.Start
                End    = $_.End
                Path   = $path
            }
            Export-Mdb @exportParams
        }
        $folder | Should -Not -BeNullOrEmpty
        (Test-Path $folder -PathType Container) | Should -Be $true
    }
}
