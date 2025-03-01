BeforeAll {
    $outputManifestPath = Join-Path $env:BHBuildOutput "$env:BHProjectName.psd1"
    Import-Module $outputManifestPath -ErrorAction Stop
}

Context 'Setup' {
    It 'Module is loaded' {
        Get-Module -Name $env:BHProjectName | Should -Not -BeNullOrEmpty
    }
}
