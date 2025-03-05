---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Get-MdbSpeaker

## SYNOPSIS

Gets speaker items found in any currently opened media database.

## SYNTAX

```
Get-MdbSpeaker [<CommonParameters>]
```

## DESCRIPTION

The `Get-MdbSpeaker` command gets speaker items found in any currently opened media database.

## EXAMPLES

### Display all speakers by Name and Id

```powershell
Get-MdbSpeaker | Select-Object Name, @{ Name = 'Id'; Expression = { $_.FQID.ObjectId }}
```

This example retrieves all speakers from all open media databases, and displays their names and ids in a table by using
`Select-Object` with a [calculated property](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties?view=powershell-5.1).

### Get all speakers with names containing the word "Parking"

```powershell
Get-MdbSpeaker | Where-Object Name -match 'Parking'
```

This example retrieves all speakers from all open media databases, and filters the results to the speakers with names
containing the word "Parking" using `Where-Object` with the `-match` operator.

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### VideoOS.Platform.Item

## NOTES

## RELATED LINKS
