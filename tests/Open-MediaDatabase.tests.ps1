Context "Open-MediaDatabase" {
    BeforeAll {
        $script:EncryptedDbPath = [io.path]::Combine($PSScriptRoot, 'data', 'EncryptedExport', 'cache.xml')
        $script:UnencryptedDbPath = [io.path]::Combine($PSScriptRoot, 'data', 'UnencryptedExport', 'cache.xml')
    }

    AfterEach {
        Close-MediaDatabase
    }

    It "Can open encrypted database" {
        $password = 'rzxW&s3Ftw' | ConvertTo-SecureString -AsPlainText -Force
        Open-MediaDatabase -Path $script:EncryptedDbPath -Password $password
        $cameras = Get-MdbCamera
        $cameras.Count | Should -BeExactly 2
    }

    It "Can open unencrypted database" {
        Open-MediaDatabase -Path $script:UnencryptedDbPath
        $cameras = Get-MdbCamera
        $cameras.Count | Should -BeExactly 2
    }

    It "Throws expected error with incorrect password" {
        try {
            $password = 'wrong-password' | ConvertTo-SecureString -AsPlainText -Force
            Open-MediaDatabase -Path $script:EncryptedDbPath -Password $password
        } catch {
            $exception = $_.Exception.InnerException
        }
        $exception | Should -BeOfType ([VideoOS.Platform.NotAuthorizedMIPException])
    }
}
