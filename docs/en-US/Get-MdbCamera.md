---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Get-MdbCamera

## SYNOPSIS

Gets camera items found in any currently opened media database.

## SYNTAX

```
Get-MdbCamera [<CommonParameters>]
```

## DESCRIPTION

The `Get-MdbCamera` command gets camera items found in any currently opened media database.

## EXAMPLES

### Display all cameras by Name and Id

```powershell
Get-MdbCamera | Select-Object Name, @{ Name = 'Id'; Expression = { $_.FQID.ObjectId }}
```

This example retrieves all cameras from all open media databases, and displays their names and ids in a table by using
`Select-Object` with a [calculated property](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_calculated_properties?view=powershell-5.1).

### Get all cameras with names containing the word "Parking"

```powershell
Get-MdbCamera | Where-Object Name -match 'Parking'
```

This example retrieves all cameras from all open media databases, and filters the results to the cameras with names
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
