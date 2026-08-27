param(
    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,
    [switch]$StrictLinks
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

$noteDirectories = @('10 Papers', '20 Concepts', '30 Maps', '35 Comparisons', '37 Syntheses')
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
$canonicalByTarget = [System.Collections.Generic.Dictionary[string, string]]::new(
    [System.StringComparer]::OrdinalIgnoreCase
)
$incomingCounts = @{}
foreach ($file in $files) {
    [void]$targets.Add($file.BaseName)
    if (
        $canonicalByTarget.ContainsKey($file.BaseName) -and
        $canonicalByTarget[$file.BaseName] -ne $file.BaseName
    ) {
        $Errors.Add("Canonical name/alias collision '$($file.BaseName)': $($canonicalByTarget[$file.BaseName]), $($file.BaseName)")
    } else {
        $canonicalByTarget[$file.BaseName] = $file.BaseName
    }
    $incomingCounts[$file.BaseName] = 0
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
                $alias = $valueMatch.Groups['value'].Value
                [void]$targets.Add($alias)
                if (
                    $canonicalByTarget.ContainsKey($alias) -and
                    $canonicalByTarget[$alias] -ne $file.BaseName
                ) {
                    $Errors.Add("Alias collision '$alias': $($canonicalByTarget[$alias]), $($file.BaseName)")
                } else {
                    $canonicalByTarget[$alias] = $file.BaseName
                }
            }
        }
    }
}

$legacyTargets = @(
    'Attention is All You Need', 'BPR - Bayesian Personalized Ranking',
    'Singular Value Decompostion', 'Positonal Encoding',
    'bidirectional Language Model', 'bidirectional RNN', 'Recurrent Neural Networks'
)
$documentTypes = @{}

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
    if (-not $frontmatterMatch.Success) {
        continue
    }
    $yaml = $frontmatterMatch.Groups['yaml'].Value
    $body = $content.Substring($frontmatterMatch.Length)

    $expectedTypes = if ($file.FullName.StartsWith((Join-Path $Root '10 Papers') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        @('paper')
    } elseif ($file.FullName.StartsWith((Join-Path $Root '20 Concepts') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        @('concept')
    } elseif ($file.FullName.StartsWith((Join-Path $Root '30 Maps') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        @('map')
    } elseif ($file.FullName.StartsWith((Join-Path $Root '35 Comparisons') + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        @('comparison')
    } else {
        @('synthesis')
    }
    $typeMatch = [regex]::Match($yaml, '(?m)^type:\s*(\S+)\s*$')
    if (-not $typeMatch.Success -or $typeMatch.Groups[1].Value -notin $expectedTypes) {
        $Errors.Add("Type/folder mismatch: $($file.FullName)")
    }
    $documentType = if ($typeMatch.Success) { $typeMatch.Groups[1].Value } else { '' }
    $documentTypes[$file.BaseName] = $documentType
    if ($documentType -eq 'paper') {
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
    } elseif ($documentType -eq 'concept') {
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

    $yamlLinkLines = @(
        $yaml -split '\r?\n' |
            Where-Object { $_ -match '\[\[' -and $_ -notmatch '^pdf:' }
    )
    $linkSource = $body + "`n" + ($yamlLinkLines -join "`n")
    foreach ($link in [regex]::Matches($linkSource, '\[\[(?<target>[^\]|#]+)')) {
        $target = $link.Groups['target'].Value.Trim()
        if ([string]::IsNullOrWhiteSpace($target)) {
            continue
        }
        $target = [System.IO.Path]::GetFileNameWithoutExtension($target.Replace('/', '\'))
        if ($legacyTargets -ccontains $target) {
            $Errors.Add("Legacy wikilink target '$target': $($file.FullName)")
        }
        if ($targets.Contains($target)) {
            $canonical = $canonicalByTarget[$target]
            if ($canonical -ne $file.BaseName) {
                $incomingCounts[$canonical] += 1
            }
        } else {
            [void]$Unresolved.Add($target)
        }
    }
}

$Orphans = @(
    $files |
        Where-Object {
            $incomingCounts[$_.BaseName] -eq 0 -and
            $documentTypes[$_.BaseName] -ne 'map'
        } |
        Sort-Object FullName
)
$ReportedUnresolved = @(
    $Unresolved |
        Where-Object { -not [string]::IsNullOrWhiteSpace($_) } |
        Sort-Object
)

Write-Output "Notes audited: $($files.Count)"
Write-Output "Canonical tags registered: $($allowedTags.Count)"
Write-Output "Unresolved wikilink targets: $($ReportedUnresolved.Count)"
if ($ReportedUnresolved.Count -gt 0) {
    $ReportedUnresolved | ForEach-Object { Write-Output "  $_" }
}
Write-Output "Orphan note candidates: $($Orphans.Count)"
if ($Orphans.Count -gt 0) {
    $Orphans | ForEach-Object {
        Write-Output "  $($_.FullName.Substring($Root.Length + 1))"
    }
}

if ($StrictLinks) {
    foreach ($target in $ReportedUnresolved) {
        $Errors.Add("Unresolved wikilink target: $target")
    }
}

if ($Errors.Count -gt 0) {
    Write-Output "Errors: $($Errors.Count)"
    $Errors | ForEach-Object { Write-Output "  $_" }
    exit 1
}

Write-Output 'Structural audit passed.'
