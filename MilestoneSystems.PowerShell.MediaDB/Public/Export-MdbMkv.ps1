function Export-MdbMkv {
    [CmdletBinding()]
    [OutputType([System.IO.FileInfo])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [VideoOS.Platform.Item]
        $Device,

        [Parameter(Mandatory)]
        [DateTime]
        $Start,

        [Parameter(Mandatory)]
        [DateTime]
        $End,

        [Parameter(Mandatory)]
        [string]
        $Path
    )

    process {
        $epoch = [datetime]::SpecifyKind([datetimeoffset]::FromUnixTimeSeconds(0).DateTime, [datetimekind]::utc)
        $Start = $Start.ToUniversalTime()
        if ($Start -lt $epoch) {
            $Start = $epoch
        }
        $End = $End.ToUniversalTime()
        if ($End -gt [datetime]::UtcNow) {
            $End = [datetime]::UtcNow
        }

        $Path = $ExecutionContext.SessionState.Path.GetUnresolvedProviderPathFromPSPath($Path)
        $fileInfo = [io.fileinfo]::new($Path)
        $null = New-Item -Path $fileInfo.DirectoryName -ItemType Directory -Force

        try {
            Write-Verbose "Exporting $($Device.Name) from $($Start.ToLocalTime().ToString('o')) to $($End.ToLocalTime().ToString('o'))"
            $progress = @{
                Id              = 10
                Activity        = 'Exporting to MKV'
                Status          = 'In progress'
                PercentComplete = 0
            }

            $exporter = [videoos.platform.data.mkvexporter]::new()
            $exporter.CameraList.Add($Device)

            $exporter.Filename = $fileInfo.Name
            $exporter.Path = $fileInfo.DirectoryName
            $exporter.Init()
            $exporter.StartExport($Start, $End)
            while ($exporter.Progress -lt 100) {
                $progress.PercentComplete = $exporter.Progress
                Write-Progress @progress
                Start-Sleep -Milliseconds 250
            }
            if ($exporter.LastError) {
                Write-Error "MKVExporter returned error code $($exporter.LastError): $($exporter.LastErrorString)" -TargetObject $exporter
                return
            }
            Get-Item -LiteralPath $Path
        } catch {
            Write-Error -Message $_.Exception.Message
        } finally {
            $exporter.Close()
            $progress.Completed = $true
            Write-Progress @progress
        }
    }
}
