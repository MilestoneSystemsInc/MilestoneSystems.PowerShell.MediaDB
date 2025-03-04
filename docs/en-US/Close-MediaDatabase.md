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

### Close all open media databases

```powershell
Close-MediaDatabase
```

Closes all media databases previously opened using `Open-MediaDatabase`.

### Close all open media databases using alias

```powershell
Close-Mdb
```

Closes all media databases previously opened using `Open-MediaDatabase` using the `Close-Mdb` alias.

### Close one media database by path

```powershell
Close-Mdb -Path .\MediaDatabase\cache.xml
```

Closes one media database by specifying a relative path to the `cache.xml` file used to originally open the media
database. Any other media databases opened during the same session will remain open.

### Close one media database by literal path

```powershell
Close-Mdb -Path 'C:\MediaDatabase\Storage [Long Term]\cache.xml'
```

Closes one media database by specifying an absolute, literal path to the `cache.xml` file used to originally open the
media database. Any other media databases opened during the same session will remain open.

## PARAMETERS

### -LiteralPath

Specifies the literal path to a `cache.xml` file at the root of an XProtect media database.

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

Specifies the path to a `cache.xml` file at the root of an XProtect media database.

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
