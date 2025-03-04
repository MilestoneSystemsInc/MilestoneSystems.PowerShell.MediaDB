---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Split-MdbSequence

## SYNOPSIS

Splits one or more sequences based on the provided maximum duration.

## SYNTAX

```
Split-MdbSequence [-Sequences] <SequenceInfo[]> [[-MaxDuration] <TimeSpan>] [<CommonParameters>]
```

## DESCRIPTION

The `Split-MdbSequence` command splits one or more sequences based on the provided maximum duration. This can be useful
when you are processing a large media database and need to create multiple exports of a specific duration.

When provided with a number of sequences, the duration of each sequence will be measured against the maximum duration,
and the resulting "split" sequences may bridge across multiple sequences in order to ensure each resulting sequence
contains no more than the `MaxDuration`.

## EXAMPLES

### Export all video in MKV format with a maximum duration of 5 minutes each

```powershell
Get-MdbCamera | Get-MdbSequence | Split-MdbSequence -MaxDuration (New-Timespan -Minutes 5) | ForEach-Object {
    $path = '.\{0}_{1}.mkv' -f $_.Source, $_.Start.ToString('yyyy-MM-dd_HH-mm-ss')
    $exportParams = @{
        Start  = $_.Start
        End    = $_.End
        Path   = $path
    }
    $_ | Export-MdbMkv @exportParams
}
```

This example retrieves all cameras from all open media databases, and gets all recording sequences from each camera,
then splits those sequences into new sequences with a maximum duration of 5 minutes each before exporting them to MKV
files.

## PARAMETERS

### -MaxDuration

Specifies the maximum length of the resulting sequences.

```yaml
Type: TimeSpan
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Sequences

Specifies one or more sequence to split.

```yaml
Type: SequenceInfo[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### VideoOS.Platform.Data.SequenceData[]

## OUTPUTS

### SequenceInfo

## NOTES

## RELATED LINKS
