Context "Export-MdbMkv" {
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

        $mkvFile = Get-MdbCamera | Get-MdbSequence -Type RecordingSequence | ForEach-Object {
            $item = [videoos.platform.configuration]::Instance.GetItem($_.FQID)
            $path = 'TestDrive:\{0}_{1}.mkv' -f $_.Source, $_.Start.ToString('yyyy-MM-dd_HH-mm-ss')
            $exportParams = @{
                Device = $item
                Start  = $_.Start
                End    = $_.End
                Path   = $path
            }
            Export-MdbMkv @exportParams
        }
        $mkvFile | Should -Not -BeNullOrEmpty
    }
}
