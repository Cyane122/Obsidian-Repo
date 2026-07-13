param(
    [Parameter(Mandatory = $true)]
    [string]$PdfPath,

    [string]$PaperNote = "",

    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,

    [switch]$DryRun,

    [switch]$Overwrite
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

function Resolve-PaperNote {
    param([string]$Value, [System.IO.FileInfo[]]$Candidates)

    if (-not [string]::IsNullOrWhiteSpace($Value)) {
        $pathsToTry = @()
        $pathsToTry += $Value
        $pathsToTry += (Join-Path $Root $Value)
        if (-not $Value.EndsWith('.md', [System.StringComparison]::OrdinalIgnoreCase)) {
            $pathsToTry += (Join-Path $Root ($Value + '.md'))
        }

        foreach ($path in $pathsToTry) {
            if (Test-Path -LiteralPath $path) {
                $resolved = Get-Item -LiteralPath $path
                if ($resolved.Extension -ne '.md') {
                    throw "Paper note is not a Markdown file: $($resolved.FullName)"
                }
                return $resolved
            }
        }

        $matches = @($Candidates | Where-Object {
            $_.BaseName -ieq $Value -or $_.Name -ieq $Value -or $_.Name -ieq ($Value + '.md')
        })
        if ($matches.Count -eq 1) {
            return $matches[0]
        }
        if ($matches.Count -gt 1) {
            throw "Paper note is ambiguous: $Value"
        }

        throw "Paper note not found: $Value"
    }

    return $null
}

$sourcePdf = Get-Item -LiteralPath $PdfPath
if ($sourcePdf.Extension -ine '.pdf') {
    throw "Source is not a PDF: $($sourcePdf.FullName)"
}

$paperRoot = Assert-WithinRoot (Join-Path $Root '10 Papers')
$sourceRoot = Assert-WithinRoot (Join-Path $Root '40 Sources\Papers')
$paperNotes = @(Get-ChildItem -LiteralPath $paperRoot -Recurse -File -Filter '*.md')
$note = Resolve-PaperNote -Value $PaperNote -Candidates $paperNotes

if (-not $note) {
    $matches = @($paperNotes | Where-Object { $_.BaseName -ieq $sourcePdf.BaseName })
    if ($matches.Count -eq 1) {
        $note = $matches[0]
    } elseif ($matches.Count -eq 0) {
        throw "No matching paper note for PDF basename '$($sourcePdf.BaseName)'. Pass -PaperNote."
    } else {
        throw "PDF basename '$($sourcePdf.BaseName)' matches multiple notes. Pass -PaperNote."
    }
}

$noteFullName = Assert-WithinRoot $note.FullName
if (-not $noteFullName.StartsWith($paperRoot + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
    throw "Paper note must be under 10 Papers: $noteFullName"
}

$relativeNoteDirectory = [System.IO.Path]::GetRelativePath($paperRoot, $note.DirectoryName)
$destinationDirectory = if ($relativeNoteDirectory -eq '.') {
    $sourceRoot
} else {
    Join-Path $sourceRoot $relativeNoteDirectory
}
$destinationDirectory = Assert-WithinRoot $destinationDirectory
$destinationPdf = Assert-WithinRoot (Join-Path $destinationDirectory ($note.BaseName + '.pdf'))
$vaultRelativePdf = [System.IO.Path]::GetRelativePath($Root, $destinationPdf).Replace('\', '/')
$pdfLink = "[[$vaultRelativePdf]]"

Write-Output "Paper note: $noteFullName"
Write-Output "PDF target: $destinationPdf"
Write-Output "PDF link: $pdfLink"

if ($DryRun) {
    Write-Output "Dry run; no files changed."
    exit 0
}

if (-not (Test-Path -LiteralPath $destinationDirectory)) {
    New-Item -ItemType Directory -Path $destinationDirectory -Force | Out-Null
}

if ($sourcePdf.FullName -ne $destinationPdf) {
    if ((Test-Path -LiteralPath $destinationPdf) -and -not $Overwrite) {
        Write-Output "Target PDF already exists; linking existing file."
    } else {
        Copy-Item -LiteralPath $sourcePdf.FullName -Destination $destinationPdf -Force:$Overwrite
        Write-Output "Copied PDF."
    }
}

$content = [System.IO.File]::ReadAllText($noteFullName)
$frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
if (-not $frontmatterMatch.Success) {
    throw "Missing frontmatter: $noteFullName"
}

$yaml = $frontmatterMatch.Groups['yaml'].Value
$updatedYaml = if ([regex]::IsMatch($yaml, '(?m)^pdf:\s*".*"\s*$')) {
    [regex]::Replace($yaml, '(?m)^pdf:\s*".*"\s*$', 'pdf: "' + $pdfLink + '"')
} elseif ([regex]::IsMatch($yaml, '(?m)^url:.*$')) {
    [regex]::Replace($yaml, '(?m)^url:.*$', '$0' + "`r`n" + 'pdf: "' + $pdfLink + '"')
} else {
    $yaml + "`r`n" + 'pdf: "' + $pdfLink + '"'
}

$updatedContent = "---`r`n$updatedYaml`r`n---`r`n" + $content.Substring($frontmatterMatch.Length)
[System.IO.File]::WriteAllText($noteFullName, $updatedContent, $Utf8NoBom)
Write-Output "Updated paper note."
