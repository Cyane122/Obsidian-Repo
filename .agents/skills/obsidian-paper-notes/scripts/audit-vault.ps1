param(
    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path
)

$ErrorActionPreference = 'Stop'
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')
$Errors = [System.Collections.Generic.List[string]]::new()
$Unresolved = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
$AllowedStatuses = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]@('to-read', 'reading', 'read', 'review-needed'),
    [System.StringComparer]::Ordinal
)
$ConceptSections = @(
    '정의', '왜 필요한가', '작동 원리', '수식 / 알고리즘',
    '특징과 한계', '대표 변형', '등장/대표 논문', '관련 개념'
)

$taxonomyPath = Join-Path $Root '90 Meta\태그 일람.md'
if (-not (Test-Path -LiteralPath $taxonomyPath)) {
    throw "Tag taxonomy not found: $taxonomyPath"
}
$taxonomy = [System.IO.File]::ReadAllText($taxonomyPath)
$allowedTags = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::Ordinal)
foreach ($match in [regex]::Matches($taxonomy, '#((?:domain|task|method|theme)/[a-z0-9-]+)')) {
    [void]$allowedTags.Add($match.Groups[1].Value)
}

$noteDirectories = @('10 Papers', '20 Concepts', '30 Maps')
$files = @()
foreach ($directory in $noteDirectories) {
    $path = Join-Path $Root $directory
    if (-not (Test-Path -LiteralPath $path)) {
        $Errors.Add("Missing note directory: $directory")
        continue
    }
    $files += Get-ChildItem -LiteralPath $path -Recurse -File -Filter '*.md'
}

$duplicateNames = @($files | Group-Object BaseName | Where-Object Count -gt 1)
foreach ($group in $duplicateNames) {
    $Errors.Add("Duplicate basename: $($group.Name)")
}

$targets = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)
foreach ($file in $files) {
    [void]$targets.Add($file.BaseName)
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
    if (-not $frontmatterMatch.Success) {
        $Errors.Add("Missing or malformed frontmatter: $($file.FullName)")
        continue
    }
    $yaml = $frontmatterMatch.Groups['yaml'].Value
    $aliasMatch = [regex]::Match($yaml, '(?ms)^aliases:(?: \[\])?\r?\n?(?<block>(?:  - .+\r?\n?)*)')
    if ($aliasMatch.Success) {
        foreach ($aliasLine in $aliasMatch.Groups['block'].Value -split '\r?\n') {
            $valueMatch = [regex]::Match($aliasLine, '^  - "(?<value>.*)"$')
            if ($valueMatch.Success) {
                [void]$targets.Add($valueMatch.Groups['value'].Value)
            }
        }
    }
}

$legacyTargets = @(
    'Attention is All You Need', 'BPR - Bayesian Personalized Ranking',
    'Singular Value Decompostion', 'Positonal Encoding',
    'bidirectional Language Model', 'bidirectional RNN', 'Recurrent Neural Networks'
)

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
    if (-not $frontmatterMatch.Success) {
        continue
    }
    $yaml = $frontmatterMatch.Groups['yaml'].Value
    $body = $content.Substring($frontmatterMatch.Length)

    $expectedType = if ($file.FullName.StartsWith((Join-Path $Root '10 Papers') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        'paper'
    } elseif ($file.FullName.StartsWith((Join-Path $Root '20 Concepts') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        'concept'
    } else {
        'map'
    }
    $typeMatch = [regex]::Match($yaml, '(?m)^type:\s*(\S+)\s*$')
    if (-not $typeMatch.Success -or $typeMatch.Groups[1].Value -ne $expectedType) {
        $Errors.Add("Type/folder mismatch: $($file.FullName)")
    }
    if ($expectedType -eq 'paper') {
        $pdfMatch = [regex]::Match($yaml, '(?m)^pdf:\s*"(?<value>.*)"\s*$')
        if (-not $pdfMatch.Success) {
            $Errors.Add("Missing pdf property: $($file.FullName)")
        } elseif (-not [string]::IsNullOrWhiteSpace($pdfMatch.Groups['value'].Value)) {
            $pdfTarget = $pdfMatch.Groups['value'].Value -replace '^\[\[|\]\]$', ''
            $pdfTarget = ($pdfTarget -split '#page=')[0]
            $pdfPath = Join-Path $Root $pdfTarget
            if (-not (Test-Path -LiteralPath $pdfPath)) {
                $Errors.Add("PDF target does not exist '$pdfTarget': $($file.FullName)")
            }
        }

        $statusMatch = [regex]::Match($yaml, '(?m)^status:\s*(?<value>[a-z-]+)\s*$')
        if (-not $statusMatch.Success) {
            $Errors.Add("Missing status property: $($file.FullName)")
        } elseif (-not $AllowedStatuses.Contains($statusMatch.Groups['value'].Value)) {
            $Errors.Add("Invalid status '$($statusMatch.Groups['value'].Value)': $($file.FullName)")
        }

        $readDateMatch = [regex]::Match($yaml, '(?m)^read_date:\s*"(?<value>.*)"\s*$')
        if (-not $readDateMatch.Success) {
            $Errors.Add("Missing read_date property: $($file.FullName)")
        } elseif (
            -not [string]::IsNullOrWhiteSpace($readDateMatch.Groups['value'].Value) -and
            -not [regex]::IsMatch($readDateMatch.Groups['value'].Value, '^\d{4}-\d{2}-\d{2}$')
        ) {
            $Errors.Add("Invalid read_date '$($readDateMatch.Groups['value'].Value)': $($file.FullName)")
        }
    } elseif ($expectedType -eq 'concept') {
        $headings = @([regex]::Matches($body, '(?m)^#\s+(.+?)\s*$') | ForEach-Object { $_.Groups[1].Value })
        foreach ($section in $ConceptSections) {
            if ($section -notin $headings) {
                $Errors.Add("Missing concept section '$section': $($file.FullName)")
            }
        }
    }

    $tagBlock = [regex]::Match($yaml, '(?ms)^tags:\r?\n(?<block>(?:  - [a-z0-9/-]+\r?\n?)*)')
    if (-not $tagBlock.Success) {
        $Errors.Add("Missing tags block: $($file.FullName)")
    } else {
        $tags = @([regex]::Matches($tagBlock.Groups['block'].Value, '(?m)^  - ([a-z0-9/-]+)$') | ForEach-Object { $_.Groups[1].Value })
        if ($tags.Count -lt 1 -or $tags.Count -gt 4) {
            $Errors.Add("Invalid tag count ($($tags.Count)): $($file.FullName)")
        }
        foreach ($tag in $tags) {
            if (-not $allowedTags.Contains($tag)) {
                $Errors.Add("Unregistered tag '$tag': $($file.FullName)")
            }
        }
    }

    if ([regex]::IsMatch($body, '(?m)^\s*-\s*tags:\s*#|^\s*(?:#[A-Za-z][A-Za-z0-9_-]*\s*,?\s*)+$')) {
        $Errors.Add("Legacy inline tags remain: $($file.FullName)")
    }

    foreach ($link in [regex]::Matches($body, '\[\[(?<target>[^\]|#]+)')) {
        $target = $link.Groups['target'].Value.Trim()
        $target = [System.IO.Path]::GetFileNameWithoutExtension($target.Replace('/', '\'))
        if ($legacyTargets -ccontains $target) {
            $Errors.Add("Legacy wikilink target '$target': $($file.FullName)")
        }
        if (-not $targets.Contains($target)) {
            [void]$Unresolved.Add($target)
        }
    }
}

Write-Output "Notes audited: $($files.Count)"
Write-Output "Canonical tags registered: $($allowedTags.Count)"
Write-Output "Unresolved wikilink targets: $($Unresolved.Count)"
if ($Unresolved.Count -gt 0) {
    $Unresolved | Sort-Object | ForEach-Object { Write-Output "  $_" }
}

if ($Errors.Count -gt 0) {
    Write-Output "Errors: $($Errors.Count)"
    $Errors | ForEach-Object { Write-Output "  $_" }
    exit 1
}

Write-Output 'Structural audit passed.'
