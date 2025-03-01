# Only dot-source files at development time. At build time, all classes and functions are embedded in the PSM1 file.
if (Get-ChildItem $PSScriptRoot\Classes\*.ps1 -ErrorAction SilentlyContinue) {
    [object[]]$classes = Get-ChildItem $PSScriptRoot\Classes\*.ps1
    [object[]]$private = Get-ChildItem $PSScriptRoot\Private\*.ps1
    [object[]]$public = Get-ChildItem $PSScriptRoot\Public\*.ps1
    $classes, $private, $public | ForEach-Object {
        $_ | ForEach-Object {
            $file = $_
            try {
                . $file
            } catch {
                Write-Warning "Failed to dot-source $($file.FullName): $_"
                throw
            }
        }
    }
    Export-ModuleMember -Function $public.BaseName
}
