function Start-MdbBulkMkvExport {
    [CmdletBinding()]
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
        $Path,

        [Parameter(Mandatory)]
        [timespan]
        $MaxDuration
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

        $sequences = $Device | Get-MdbSequence -Start $Start -End $End -Type RecordingSequence
        $exportJobs = [collections.generic.list[pscustomobject]]::new()
        $t1 = $null

        $remainingDuration = $MaxDuration
        for ($i = 0; $i -lt $sequences.Count; $i++) {
            Write-Verbose "Processing sequence $i"
            $sequence = $sequences[$i].EventSequence
            if ($sequence.EndDateTime -le $Start) {
                Write-Verbose "Sequence skipped because the EndDateTime was less than or equal to the export start time."
                continue
            }
            if ($sequence.StartDateTime -lt $Start) {
                Write-Verbose "Sequence $i starts at $($sequence.StartDateTime) but the export will be cropped to $Start"
                $sequence.StartDateTime = $Start
            }
            if ($null -eq $t1) {
                Write-Verbose "Setting `$t1 to sequence $i StartDateTime: $($sequence.StartDateTime)"
                $t1 = $sequence.StartDateTime
            }

            do {
                if ($sequence.StartDateTime.Add($remainingDuration) -le $sequence.EndDateTime) {
                    Write-Verbose "Creating export job with duration $($sequence.StartDateTime.Add($remainingDuration) - $t1)"
                    $exportJobs.Add(
                        [pscustomobject]@{
                            Start = $t1
                            End   = $sequence.StartDateTime.Add($remainingDuration)
                        }
                    )
                    $t1 = $sequence.StartDateTime = $sequence.StartDateTime.Add($remainingDuration).AddTicks(1)
                    $remainingDuration = $MaxDuration
                } else {
                    $remainingDuration = $remainingDuration - ($sequence.EndDateTime - $sequence.StartDateTime)
                    Write-Verbose "There is not enough time in this sequence to fill the remaining $remainingDuration"
                }
            } while ($remainingDuration -eq $MaxDuration)
            if ($t1 -ge $sequence.EndDateTime) {
                $t1 = $null
            }
        }
        if ($remainingDuration -gt [timespan]::Zero) {
            $exportJobs.Add(
                [pscustomobject]@{
                    Start = $t1
                    End   = $sequences[-1].EventSequence.EndDateTime
                }
            )
        }
        $exportJobs
    }
}
