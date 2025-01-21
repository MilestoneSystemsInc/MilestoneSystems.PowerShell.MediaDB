function Split-MdbSequence {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [VideoOS.Platform.Data.SequenceData[]]
        $Sequences,

        [Parameter()]
        [timespan]
        $MaxDuration = [timespan]::FromHours(1)
    )

    begin {
        $t1 = $null
        $remainingDuration = $MaxDuration
    }

    process {
        for ($i = 0; $i -lt $Sequences.Count; $i++) {
            Write-Verbose "Processing sequence $i"
            $sequence = $Sequences[$i].EventSequence

            if ($null -eq $t1) {
                $t1 = $sequence.StartDateTime
            }

            do {
                if ($sequence.StartDateTime.Add($remainingDuration) -le $sequence.EndDateTime) {
                    [pscustomobject]@{
                        Start = $t1
                        End   = $sequence.StartDateTime.Add($remainingDuration)
                    }
                    $t1 = $sequence.StartDateTime = $sequence.StartDateTime.Add($remainingDuration).AddTicks(1)
                    $remainingDuration = $MaxDuration
                } else {
                    $remainingDuration = $remainingDuration - ($sequence.EndDateTime - $sequence.StartDateTime)
                }
            } while ($remainingDuration -eq $MaxDuration)
            if ($t1 -ge $sequence.EndDateTime) {
                $t1 = $null
            }
        }
        if ($remainingDuration -gt [timespan]::Zero) {
            [pscustomobject]@{
                Start = $t1
                End   = $Sequences[-1].EventSequence.EndDateTime
            }
        }
    }
}
