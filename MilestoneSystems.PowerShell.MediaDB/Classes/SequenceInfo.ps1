enum SequenceType {
    MotionSequence
    RecordingSequence
    RecordingWithTriggerSequence
    TimelineMotionDetected
    TimelineRecording
}

class SequenceInfo {
    [string]$Source
    [DateTime]$Start
    [DateTime]$End
    [SequenceType]$Type
    [guid]$Id
    [VideoOS.Platform.FQID]$FQID

    SequenceInfo() {}

    SequenceInfo([VideoOS.Platform.Data.SequenceData]$sequence, [string]$sequenceType) {
        $this.Source = $sequence.EventHeader.Name
        $this.Start = $sequence.EventSequence.StartDateTime
        $this.End = $sequence.EventSequence.EndDateTime
        $this.Type = [SequenceType]::$sequenceType
        $this.Id = $sequence.EventHeader.Source.FQID.ObjectId
        $this.FQID = $sequence.EventHeader.Source.FQID
    }
}
