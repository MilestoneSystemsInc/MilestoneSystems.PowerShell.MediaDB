function Split-MdbSequence {
    [CmdletBinding()]
    [OutputType([SequenceInfo])]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [SequenceInfo[]]
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
            $sequence = $Sequences[$i]

            if ($null -eq $t1) {
                $t1 = $sequence.Start
            }

            do {
                if ($sequence.Start.Add($remainingDuration) -le $sequence.End) {
                    [sequenceinfo]@{
                        Source = $sequence.Source
                        Start  = $t1
                        End    = $sequence.Start.Add($remainingDuration)
                        Type   = $sequence.Type
                        Id     = $sequence.Id
                        FQID   = $sequence.FQID
                    }
                    $t1 = $sequence.Start = $sequence.Start.Add($remainingDuration).AddTicks(1)
                    $remainingDuration = $MaxDuration
                } else {
                    $remainingDuration = $remainingDuration - ($sequence.End - $sequence.Start)
                }
            } while ($remainingDuration -eq $MaxDuration)
            if ($t1 -ge $sequence.End) {
                $t1 = $null
            }
        }
        if ($remainingDuration -gt [timespan]::Zero) {
            [sequenceinfo]@{
                Source = $sequence.Source
                Start  = $t1
                End    = $Sequences[-1].End
                Type   = $Sequences[-1].Type
                Id     = $Sequences[-1].Id
                FQID   = $Sequences[-1].FQID
            }
        }
    }
}
