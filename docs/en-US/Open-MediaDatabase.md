---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Open-MediaDatabase

## SYNOPSIS

Opens an XProtect media database from a recording server, or an export.

## SYNTAX

### Path (Default)

```
Open-MediaDatabase [-Path] <String> [-Password <SecureString>] [<CommonParameters>]
```

### LiteralPath

```
Open-MediaDatabase -LiteralPath <String> [-Password <SecureString>] [<CommonParameters>]
```

## DESCRIPTION

The `Open-MediaDatabase` command opens a raw XProtect media database originating from a recording server, or from an
export in XProtect format.

It is required that the media database include a valid `cache.xml` file. If this file is missing, it indicates that the
recording server is/was running at the time the media database was opened or copied, or it means the recording server
did not stop gracefully since this file is only created during recording server shutdown.

More than one media database can be opened at one time. When more than one media database is open, calls to commands
like get `Get-MdbCamera` will return records from all open media databases.

## EXAMPLES

### Open an unencrypted media database and list all recording sequences

```powershell
Open-MediaDatabase -Path .\unencrypted-database\cache.xml
Get-MdbCamera | Get-MdbSequence | Select-Object Source, Start, End
```

This example will open an unencrypted media database and then list all recording sequences for all cameras.

### Open an encrypted media database and list all recording sequences

```powershell
$password = Read-Host -Prompt 'Database password' -AsSecureString
Open-MediaDatabase -Path .\encrypted-database\cache.xml -Password $password
Get-MdbCamera | Get-MdbSequence | Select-Object Source, Start, End
```

This example will open an encrypted media database and then list all recording sequences for all cameras.

## PARAMETERS

### -LiteralPath

Specifies the literal file path to a `cache.xml` file at the root of a media database folder.

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

### -Password

Specifies an encrypted database password as a secure string.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Path

Specifies the file path to a `cache.xml` file at the root of a media database folder.

```yaml
Type: String
Parameter Sets: Path
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters

This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### None

## OUTPUTS

### System.Object

## NOTES

## RELATED LINKS
