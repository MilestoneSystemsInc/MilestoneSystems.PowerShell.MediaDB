---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Export-Mdb

## SYNOPSIS

Export media from one or more devices in the XProtect media database format.

## SYNTAX

### Item (Default)
```
Export-Mdb -Device <Item[]> -Start <DateTime> -End <DateTime> -Path <String> [-Sign] [-Encrypt]
 [-Password <SecureString>] [-EncryptionStrength <EncryptionStrength>] [-NoReExport] [<CommonParameters>]
```

### FQID
```
Export-Mdb -Fqid <FQID[]> -Start <DateTime> -End <DateTime> -Path <String> [-Sign] [-Encrypt]
 [-Password <SecureString>] [-EncryptionStrength <EncryptionStrength>] [-NoReExport] [<CommonParameters>]
```

## DESCRIPTION

The `Export-Mdb` command exports media from one or more devices in the XProtect media database format.

## EXAMPLES

### Export video from "Parking" cameras in an encrypted database

```powershell
Open-MediaDatabaseOpen-MediaDatabase -Path .\encrypted-database\cache.xml -Password (Read-Host -AsSecureString)
$cameras = Get-MdbCamera | Where-Object Name -match 'Parking'
$exportParams = @{
    Start  = '2025-02-28 1:00:00PM'
    End    = '2025-02-29 8:00:00AM'
    Path   = '.\SampleExport'
}
$cameras | Export-Mdb @exportParams
```

This example will prompt for a password to open the media database at the relative path `.\encrypted-database`, find all
cameras in the database with "Parking" in the name, then export a period of 19 hours to a subfolder of the current
directory named 'SampleExport'.

## PARAMETERS

### -Device

Specifies one or more devices as returned by `Get-MdbCamera`, `Get-MdbMicrophone`, and similar commands.

```yaml
Type: Item[]
Parameter Sets: Item
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByValue)
Accept wildcard characters: False
```

### -Encrypt

Specifies whether the export should be encrypted. If this parameter is used, the `Password` parameter is mandatory.

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

### -EncryptionStrength

Specifies the encryption algorithm, and thus the strength of the encryption used to protect the export. The default
value is "AES256".

```yaml
Type: EncryptionStrength
Parameter Sets: (All)
Aliases:
Accepted values: DES56, AES128, AES192, AES256

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -Fqid

One or more FQID objects representing the fully-qualified identifer for XProtect devices in one of the currently opened
databases. It is easiest to pipe one or more devices to the export command as the FQID property can be passed by
property name, and all XProtect devices have an FQID property.

```yaml
Type: FQID[]
Parameter Sets: FQID
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NoReExport

No additional exports can be created from the resulting export.

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

### -Password

The password to use to encrypt the export.

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

Specifies a path to a folder where the export should be saved to disk.

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

### -Sign

Specifies that the export should be signed. A signed export is more difficult to tamper with as doing so would
invalidate the signature.

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

### VideoOS.Platform.Item[]

### VideoOS.Platform.FQID

### System.DateTime

## OUTPUTS

### System.IO.FileInfo

## NOTES

## RELATED LINKS
