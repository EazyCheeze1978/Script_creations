param (
    [string]$RootPath = (Get-Location),
    [string]$ArchiveFormat = "zip"
)

# Ensure 7-Zip is in your PATH, or provide the full path to 7z.exe here
$SevenZip = "7z.exe"

Write-Host "Scanning recursively under: $RootPath"
$allFiles = Get-ChildItem -Path $RootPath -Recurse -Include *.dsk, *.m3u | Where-Object { -not $_.PSIsContainer }

# Build groupings
$grouped = @{}

foreach ($file in $allFiles) {
    $baseName = $file.BaseName -replace '\s*\(.*$', ''  # Remove everything from first ( onward
    $key = "$($file.Directory.FullName)\$baseName"

    if (-not $grouped.ContainsKey($key)) {
        $grouped[$key] = @()
    }
    $grouped[$key] += $file
}

# Grouped archives
foreach ($group in $grouped.GetEnumerator()) {
    $zipName = "$($group.Key).$ArchiveFormat"
    $filesToAdd = $group.Value

    $fileList = $filesToAdd | ForEach-Object { "`"$($_.FullName)`"" } | Join-String " "
    Write-Host "Creating group archive: $zipName"
    
    & $SevenZip a "`"$zipName`"" $fileList | Out-Null
}

# Individual file archives
foreach ($file in $allFiles) {
    $baseName = $file.BaseName
    $zipPath = "$($file.Directory.FullName)\$baseName.$ArchiveFormat"

    if (-not (Test-Path $zipPath)) {
        Write-Host "Creating individual archive: $zipPath"
        & $SevenZip a "`"$zipPath`"" "`"$($file.FullName)`"" | Out-Null
    }
}
Write-Host "Compression complete."