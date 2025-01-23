properties {
    & dotnet tool restore
    $PSBPreference.General.ModuleVersion = (dotnet nbgv get-version -f json | ConvertFrom-Json).SimpleVersion
    $PSBPreference.Build.CompileModule = $true
    $PSBPreference.Help.DefaultLocale = 'en-US'
    $PSBPreference.Test.OutputFile = 'out/testResults.xml'

    $psake.context.tasks.stagefiles.PostAction = {
        $outputManifestPath = [io.path]::Combine($PSBPreference.Build.ModuleOutDir, "$($PSBPreference.General.ModuleName).psd1")
        Write-Verbose "Updating ModuleVersion in output manifest '$outputManifestPath' to NBGV-based version $($PSBPreference.General.ModuleVersion)"
        BuildHelpers\Update-Metadata -Path $outputManifestPath -Property ModuleVersion -Value $PSBPreference.General.ModuleVersion
        #$content = Get-Content $outputManifestPath | ForEach-Object { $_ -replace "'0.1.0'", "'$($PSBPreference.General.ModuleVersion)'" }
        #$content | Set-Content $outputManifestPath -Encoding UTF8

        Write-Verbose "Converting root module to UTF8 since PowerShellBuild generates a Unicode file on Windows PowerShell"
        Import-Module (Join-Path $env:BHProjectPath 'tests/MetaFixers.psm1')
        $rootModulePath = Join-Path -Path $env:BHBuildOutput -ChildPath "$($env:BHProjectName).psm1"
        Get-Item $rootModulePath | ConvertTo-UTF8
    }
}

task Default -depends Test

task Test -FromModule PowerShellBuild -minimumVersion '0.6.2'
