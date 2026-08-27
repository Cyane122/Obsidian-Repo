param(
    [Parameter(Mandatory = $true)]
    [string]$PaperNote,

    [Parameter(Mandatory = $true)]
    [ValidateSet('to-read', 'reading', 'read', 'review-needed')]
    [string]$Status,

    [string]$ReadDate = "",

    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,

    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')

function Assert-WithinRoot {
    param([string]$Path)

    $full = [System.IO.Path]::GetFullPath($Path)
    $prefix = $Root + '\'
    if ($full -ne $Root -and -not $full.StartsWith($prefix, [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Path escapes vault root: $full"
    }
    return $full
}

$paperRoot = Assert-WithinRoot (Join-Path $Root '10 Papers')
$paperNotes = @(Get-ChildItem -LiteralPath $paperRoot -Recurse -File -Filter '*.md')
$note = $null

$pathsToTry = @($PaperNote, (Join-Path $Root $PaperNote))
if (-not $PaperNote.EndsWith('.md', [System.StringComparison]::OrdinalIgnoreCase)) {
    $pathsToTry += (Join-Path $Root ($PaperNote + '.md'))
}

foreach ($path in $pathsToTry) {
    if (Test-Path -LiteralPath $path) {
        $note = Get-Item -LiteralPath $path
        break
    }
}

if (-not $note) {
    $matches = @($paperNotes | Where-Object {
        $_.BaseName -ieq $PaperNote -or $_.Name -ieq $PaperNote -or $_.Name -ieq ($PaperNote + '.md')
    })
    if ($matches.Count -eq 1) {
        $note = $matches[0]
    } elseif ($matches.Count -eq 0) {
        throw "Paper note not found: $PaperNote"
    } else {
        throw "Paper note is ambiguous: $PaperNote"
    }
}

$noteFullName = Assert-WithinRoot $note.FullName
if (-not $noteFullName.StartsWith($paperRoot + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Paper note must be under 10 Papers: $noteFullName"
}

if ($Status -eq 'read' -and [string]::IsNullOrWhiteSpace($ReadDate)) {
    $ReadDate = (Get-Date).ToString('yyyy-MM-dd')
}
if (-not [string]::IsNullOrWhiteSpace($ReadDate) -and -not [regex]::IsMatch($ReadDate, '^\d{4}-\d{2}-\d{2}$')) {
    throw "ReadDate must use YYYY-MM-DD: $ReadDate"
}

$content = [System.IO.File]::ReadAllText($noteFullName)
$frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
if (-not $frontmatterMatch.Success) {
    throw "Missing frontmatter: $noteFullName"
}

$yaml = $frontmatterMatch.Groups['yaml'].Value
$updatedYaml = if ([regex]::IsMatch($yaml, '(?m)^status:\s*[a-z-]+\s*$')) {
    [regex]::Replace($yaml, '(?m)^status:\s*[a-z-]+\s*$', "status: $Status")
} else {
    $yaml + "`r`n" + "status: $Status"
}

$readDateLine = 'read_date: "' + $ReadDate + '"'
if ([regex]::IsMatch($updatedYaml, '(?m)^read_date:\s*".*"\s*$')) {
    $updatedYaml = [regex]::Replace($updatedYaml, '(?m)^read_date:\s*".*"\s*$', $readDateLine)
} else {
    $updatedYaml = [regex]::Replace($updatedYaml, '(?m)^status:\s*[a-z-]+\s*$', '$0' + "`r`n" + $readDateLine)
}

Write-Output "Paper note: $noteFullName"
Write-Output "Status: $Status"
Write-Output "Read date: $ReadDate"

if ($DryRun) {
    Write-Output "Dry run; no files changed."
    exit 0
}

$updatedContent = "---`r`n$updatedYaml`r`n---`r`n" + $content.Substring($frontmatterMatch.Length)
[System.IO.File]::WriteAllText($noteFullName, $updatedContent, $Utf8NoBom)
Write-Output "Updated paper status."
