$SourceDirectory = "C:/Projects/.ranni/dotfiles"
$DestinationDirectory = $PWD

$Items = [ordered]@{
    ".clang-format"                       = $null
    ".editorconfig.win"                   = ".editorconfig"
    ".prettierrc.json"                    = $null
    "Directory.Build.props"               = $null
    "Directory.Build.AfterCppProps.props" = $null
    ".pre-commit-config.yaml"             = $null
}

foreach ($Item in $Items.GetEnumerator()) {
    $SourceFileName = $Item.Key
    $SourceFilePath = Join-Path $SourceDirectory $SourceFileName

    $DestinationFileName = if ($null -ne $Item.Value) { $Item.Value } else { $SourceFileName }
    $DestinationFilePath = Join-Path $DestinationDirectory $DestinationFileName

    if (Test-Path $SourceFilePath) {
        if (Test-Path $DestinationFilePath) {
            Remove-Item $DestinationFilePath -Force
        }
        try {
            New-Item -Path $DestinationFilePath -Target $SourceFilePath -ItemType HardLink -ErrorAction Stop | Out-Null
            $LinkCount = (fsutil hardlink list $DestinationFilePath | Measure-Object).Count
            "(V) {0,-40} => {1} [HardLinks: {2}]" -f $SourceFileName, $DestinationFileName, $LinkCount | Write-Host -ForegroundColor Green
        }
        catch {
            Write-Host "(X) $SourceFileName" -ForegroundColor Red
        }
    }
    else {
        Write-Host "(?) $SourceFileName" -ForegroundColor Yellow
    }
}
