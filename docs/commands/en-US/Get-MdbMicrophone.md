---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Get-MdbMicrophone

## SYNOPSIS

Gets microphone items found in any currently opened media database.

## SYNTAX

```
Get-MdbMicrophone [<CommonParameters>]
```

## DESCRIPTION

The `Get-MdbMicrophone` command gets microphone items found in any currently opened media database.

## EXAMPLES

### Display all microphones by Name and Id

```powershell
Get-MdbMicrophone | Select-Object Name, @{ Name = 'Id'; Expression = { $_.FQID.ObjectId }}
```

This example retrieves all microphones from all open media databases, and displays their names and ids in a table by using
`Select-Object` with a [calculated property](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties?view=powershell-5.1).

### Get all microphones with names containing the word "Parking"

```powershell
Get-MdbMicrophone | Where-Object Name -match 'Parking'
```

This example retrieves all microphones from all open media databases, and filters the results to the microphones with names
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
