---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Close-MediaDatabase

## SYNOPSIS

Closes the media database opened with the `Open-MediaDatabase` command.

## SYNTAX

### Path (Default)
```
Close-MediaDatabase [-Path <String>] [<CommonParameters>]
```

### LiteralPath
```
Close-MediaDatabase -LiteralPath <String> [<CommonParameters>]
```

## DESCRIPTION

The `Close-MediaDatabase` command closes the media database opened with the `Open-MediaDatabase` command.

## EXAMPLES

### Example 1

```powershell
Close-MediaDatabase
```

Closes all media databases previously opened using `Open-MediaDatabase`.

### Example 2

```powershell
Close-Mdb
```

Closes all media databases previously opened using `Open-MediaDatabase` using the `Close-Mdb` alias.

## PARAMETERS

### -LiteralPath
{{ Fill LiteralPath Description }}

```yaml
Type: String
Parameter Sets: LiteralPath
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path
{{ Fill Path Description }}

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### None

## NOTES

## RELATED LINKS
