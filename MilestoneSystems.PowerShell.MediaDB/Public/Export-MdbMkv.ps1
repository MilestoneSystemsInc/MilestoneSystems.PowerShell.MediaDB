function Export-MdbMkv {
    [CmdletBinding(DefaultParameterSetName = 'Item')]
    [OutputType([System.IO.FileInfo])]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Item')]
        [VideoOS.Platform.Item]
        $Device,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'FQID')]
        [VideoOS.Platform.FQID]
        $FQID,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [DateTime]
        $Start,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [DateTime]
        $End,

        [Parameter(Mandatory)]
        [string]
        $Path
    )

    process {
        if ($null -eq $Device) {
            $Device = [videoos.platform.configuration]::Instance.GetItem($FQID)
        }

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
        if (!(Test-Path -Path $fileInfo.DirectoryName)) {
            Write-Verbose "Creating directory '$($fileInfo.DirectoryName)'"
            $null = New-Item -Path $fileInfo.DirectoryName -ItemType Directory -Force
        }

        $pathIsFolder = $false
        if (Test-Path $fileInfo.FullName -PathType Container) {
            $pathIsFolder = $true
        }

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

            $exporter.Filename = if ($pathIsFolder) { '{0}_{1}.mkv' -f (ConvertTo-ValidFileName $Device.Name), $Start.ToString('yyyy-MM-dd_HH-mm-ss') } else { $fileInfo.Name }
            $exporter.Path = if ($pathIsFolder) { $fileInfo.FullName } else { $fileInfo.DirectoryName }
            $exporter.Init()
            if (!$exporter.StartExport($Start, $End)) {
                Write-Error "MKVExporter could not begin the export process. Error code $($exporter.LastError): $($exporter.LastErrorString)" -TargetObject $exporter
            }

            while ($exporter.Progress -lt 100 -and $exporter.LastError -eq 0) {
                $progress.PercentComplete = $exporter.Progress
                Write-Progress @progress
                Start-Sleep -Milliseconds 250
            }
            if ($exporter.LastError) {
                Write-Error "MKVExporter returned error code $($exporter.LastError): $($exporter.LastErrorString)" -TargetObject $exporter
                return
            }
            Get-Item -LiteralPath (Join-Path $exporter.Path $exporter.Filename)
        } catch {
            Write-Error -Message $_.Exception.Message
        } finally {
            $exporter.Close()
            $progress.Completed = $true
            Write-Progress @progress
        }
    }
}
