function Get-MdbItemList {
    [CmdletBinding()]
    [OutputType([VideoOS.Platform.Item])]
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateSet('AccessControlSystem', 'AccessControlUnit', 'AlarmDefinition', 'Alert', 'Bookmark', 'Camera',
                     'Folder', 'GisMapLocation', 'Hardware', 'InputEvent', 'Layout', 'LayoutGroup', 'LprServer',
                     'Matrix', 'Metadata', 'Microphone', 'Output', 'OutputEvent', 'PlaybackController', 'Preset',
                     'RestrictedMedia', 'RestrictedMediaLive', 'Role', 'Screen', 'Server', 'SmartWall',
                     'SmartWallMonitor', 'SmartWallPreset', 'Speaker', 'TimeProfile', 'TransactSource', 'TriggerEvent',
                     'User', 'VideoWall', 'VideoWallMonitor', 'VideoWallPreset', 'View', 'ViewItemInstance', 'Webhook',
                     'Window', 'WorkSpace')]
        [string]
        $Kind
    )

    process {
        $stack = [system.collections.generic.stack[VideoOS.Platform.Item]]::new()

        $config = [videoos.platform.configuration]::Instance
        $config.GetItemsByKind([videoos.platform.kind]::$Kind, [videoos.platform.itemhierarchy]::SystemDefined) | ForEach-Object {
            if ($null -ne $_) {
                $stack.Push($_)
            }
        }

        while ($stack.Count -gt 0) {
            $item = $stack.Pop()
            if ($item.FQID.Kind -eq [videoos.platform.kind]::$Kind -and $item.FQID.FolderType -eq [videoos.platform.foldertype]::No) {
                $item
            }
            if ($item.HasChildren -ne 'No') {
                $item.GetChildren() | ForEach-Object {
                    if ($null -ne $_) {
                        $stack.Push($_)
                    }
                }
            }
        }
    }
}
