function Get-MdbSequence {
    [CmdletBinding()]
    [OutputType([SequenceInfo])]
    param(
        [Parameter(Mandatory, ValueFromPipeline)]
        [VideoOS.Platform.Item]
        $Device,

        [Parameter()]
        [DateTime]
        $Start = [datetime]::MinValue,

        [Parameter()]
        [DateTime]
        $End = [datetime]::MaxValue,

        [Parameter()]
        [ValidateSet('MotionSequence', 'RecordingSequence', 'RecordingWithTriggerSequence', 'TimelineMotionDetected', 'TimelineRecording')]
        [string]
        $Type = 'RecordingSequence',

        [Parameter()]
        [switch]
        $Crop,

        [Parameter()]
        [int]
        $PageSize = 1000
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

        try {
            $sds = [videoos.platform.data.sequencedatasource]::new($Device)
            $sds.Init()
            $position = $Start
            do {
                $sequences = $sds.GetData(
                    $position,
                    [timespan]::Zero,
                    0,
                    $End - $position,
                    $PageSize,
                    [videoos.platform.data.datatype+sequencetypeguids]::$Type
                )
                $count = 0
                $lastSequence = $null
                foreach ($sequence in $sequences) {
                    if ($Crop -and $sequence.EventSequence.StartDateTime -lt $Start) {
                        $sequence.EventSequence.StartDateTime = $Start
                    }
                    if ($Crop -and $sequence.EventSequence.EndDateTime -gt $End) {
                        $sequence.EventSequence.EndDateTime = $End
                    }
                    $lastSequence = $sequence
                    [sequenceinfo]::new($sequence, $Type)
                    $count++
                }

                if ($count -lt $PageSize) {
                    break
                }
                $position = $lastSequence.EventSequence.EndDateTime.AddTicks(1)
                if ($null -eq $position) {
                    $position = $End
                }

            } while ($position -le $End)
        } finally {
            $sds.Close()
        }
    }
}
