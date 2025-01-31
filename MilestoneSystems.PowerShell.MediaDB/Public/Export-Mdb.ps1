function Export-Mdb {
    [CmdletBinding(DefaultParameterSetName = 'Item')]
    [OutputType([System.IO.directoryinfo])]
    param(
        [Parameter(Mandatory, ValueFromPipeline, ParameterSetName = 'Item')]
        [VideoOS.Platform.Item[]]
        $Device,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'FQID')]
        [VideoOS.Platform.FQID[]]
        $Fqid,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [DateTime]
        $Start,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [DateTime]
        $End,

        [Parameter(Mandatory)]
        [string]
        $Path,

        [Parameter()]
        [switch]
        $Sign,

        [Parameter()]
        [switch]
        $Encrypt,

        [Parameter()]
        [securestring]
        $Password,

        [Parameter()]
        [VideoOS.Platform.Data.EncryptionStrength]
        $EncryptionStrength = [VideoOS.Platform.Data.EncryptionStrength]::AES256,

        [Parameter()]
        [switch]
        $NoReExport
    )

    begin {
        $devices = [system.collections.generic.list[videoos.platform.item]]::new()
    }

    process {
        if ($Device.Count) {
            foreach ($item in $Device) {
                $devices.Add($item)
            }
        } else {
            foreach ($itemFqid in $Fqid) {
                $devices.Add([videoos.platform.configuration]::Instance.GetItem($itemFqid))
            }
        }
    }

    end {
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
        $dirInfo = [io.directoryinfo]::new($Path)
        if ($dirInfo.Name -eq $dirInfo.FullName) {
            Write-Error "Path cannot be the root of a drive."
            return
        }

        if (!(Test-Path -LiteralPath $dirInfo.Parent.FullName)) {
            $null = New-Item -Path $dirInfo.Parent.FullName -ItemType Directory -Force
        }

        if (Test-Path -Path $Path -PathType Container) {
            Write-Error "Directory already exists: '$Path'"
            return
        }

        try {
            Write-Verbose "Exporting $($Device.Name) from $($Start.ToLocalTime().ToString('o')) to $($End.ToLocalTime().ToString('o'))"
            $progress = @{
                Id              = 10
                Activity        = 'Exporting to MKV'
                Status          = 'In progress'
                PercentComplete = 0
            }

            $exporter = [VideoOS.Platform.Data.DBExporter]::new()
            $devices | ForEach-Object {
                $item = $_
                switch ($item.FQID.Kind) {
                    ([videoos.platform.kind]::Camera) {
                        $exporter.CameraList.Add($item)
                    }

                    ([videoos.platform.kind]::Microphone) {
                        $exporter.AudioList.Add($item)
                    }

                    ([videoos.platform.kind]::Speaker) {
                        $exporter.AudioList.Add($item)
                    }

                    ([videoos.platform.kind]::Metadata) {
                        $exporter.MetadataList.Add($item)
                    }

                    default {
                        Write-Verbose "Ignoring '$($item.Name)' of type '$([videoos.platform.kind]::DefaultTypeToNameTable[$item.FQID.Kind])'."
                    }
                }
            }
            $exporter.Path = $dirInfo.FullName
            $exporter.PreventReExport = $NoReExport.ToBool()
            $exporter.Encryption = $Encrypt.ToBool()
            $exporter.EncryptionStrength = $EncryptionStrength
            $exporter.SignExport = $Sign.ToBool()
            if ($PSCmdlet.MyInvocation.BoundParameters.ContainsKey('Password')) {
                $exporter.Password = [net.networkcredential]::new('', $Password).Password
            }
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
