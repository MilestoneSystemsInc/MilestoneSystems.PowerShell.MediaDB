---
external help file: MilestoneSystems.PowerShell.MediaDB-help.xml
Module Name: MilestoneSystems.PowerShell.MediaDB
online version:
schema: 2.0.0
---

# Export-Mdb

## SYNOPSIS
{{ Fill in the Synopsis }}

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
{{ Fill in the Description }}

## EXAMPLES

### Example 1
```powershell
PS C:\> {{ Add example code here }}
```

{{ Add example description here }}

## PARAMETERS

### -Device
{{ Fill Device Description }}

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
{{ Fill Encrypt Description }}

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
{{ Fill EncryptionStrength Description }}

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
{{ Fill End Description }}

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
{{ Fill FQID Description }}

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
{{ Fill NoReExport Description }}

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
{{ Fill Password Description }}

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
{{ Fill Path Description }}

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
{{ Fill Sign Description }}

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
{{ Fill Start Description }}

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
