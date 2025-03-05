---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Export-MdbMkv

## SYNOPSIS

Export media in MKV format.

## SYNTAX

### Item (Default)
```
Export-MdbMkv -Device <Item> -Start <DateTime> -End <DateTime> -Path <String> [<CommonParameters>]
```

### FQID
```
Export-MdbMkv -FQID <FQID> -Start <DateTime> -End <DateTime> -Path <String> [<CommonParameters>]
```

## DESCRIPTION

The `Export-MdbMkv` command exports media in MKV format.

## EXAMPLES

### Find and export all recording sequences from all cameras

```powershell
$password = Read-Host -Prompt 'Database Password' -AsSecureString
Open-MediaDatabase -Path .\encrypted-database\cache.xml -Password $password
Get-MdbCamera | Get-MdbSequence -Type RecordingSequence | ForEach-Object {
    $path = '.\{0}_{1}.mkv' -f $_.Source, $_.Start.ToString('yyyy-MM-dd_HH-mm-ss')
    $exportParams = @{
        Start  = $_.Start
        End    = $_.End
        Path   = $path
    }
    $_ | Export-MdbMkv @exportParams
}
```

This example will prompt for a password to open an encrypted media database. If your database is not encrypted, you can
omit the `-Password $password` property when calling `Open-MediaDatabase`. Each recording sequence for each camera found
in the opened media database(s) will be exported to a file named after the camera name and a timestamp matching the
start of the recording sequence.

## PARAMETERS

### -Device

Specifies one or more camera items as returned by `Get-MdbCamera`.

```yaml
Type: Item
Parameter Sets: Item
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -End

A timestamp representing the end of the time range to be exported.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FQID

An FQID object representing the fully-qualified identifer for XProtect devices in one of the currently opened
databases. It is easiest to pipe one devices to the export command as the FQID property can be passed by
property name, and all XProtect devices have an FQID property.

```yaml
Type: FQID
Parameter Sets: FQID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Path

Specifies a path to a file where the export should be saved to disk.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Start

A timestamp representing the start of the time range to be exported.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### VideoOS.Platform.Item

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
