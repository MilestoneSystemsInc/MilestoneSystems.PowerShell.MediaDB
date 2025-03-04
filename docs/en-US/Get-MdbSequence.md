---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Get-MdbSequence

## SYNOPSIS

Gets recording or motion sequences for the specified device and time range.

## SYNTAX

```
Get-MdbSequence [-Device] <Item> [[-Start] <DateTime>] [[-End] <DateTime>] [[-Type] <String>] [-Crop]
 [[-PageSize] <Int32>] [<CommonParameters>]
```

## DESCRIPTION

The `Get-MdbSequence` command gets recording or motion sequences for the specified device and time range.

## EXAMPLES

### List all recording sequences from all cameras

```powershell
Get-MdbCamera | Get-MdbSequence | Select-Object Source, Start, End
```

This example will get all cameras from all open media databases, and for each camera, get all recording sequences,
listing the source name (camera name), and start/end timestamps.

## PARAMETERS

### -Crop

If the start or end time falls within a sequence, the entire sequence is returned. Use the Crop parameter to trim the
first and last sequences to the provided Start and End times.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Device

Specifies a device returned by `Get-MdbCamera` or `Get-MdbMicrophone` for example.

```yaml
Type: Item
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -End

Specifies the end of the time period from which to search for matching sequences.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -PageSize

Specifies how many matching sequences to return at a time. This is not normally something you will need to adjust.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start

Specifies the start of the time period from which to search for matching sequences.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Type

Specifies the type of sequence to return. The default is RecordingSequence, and normally you will only encounter
sequences of type MotionSequence or RecordingSequence.

```yaml
Type: String
Parameter Sets: (All)
Aliases:
Accepted values: MotionSequence, RecordingSequence, RecordingWithTriggerSequence, TimelineMotionDetected, TimelineRecording

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### VideoOS.Platform.Item

## OUTPUTS

### SequenceInfo

## NOTES

## RELATED LINKS
