param(
    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,
    [switch]$StrictLinks,
    [switch]$ShowAllIssues
)

$ErrorActionPreference = 'Stop'
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')
$Errors = [System.Collections.Generic.List[string]]::new()
$Warnings = [System.Collections.Generic.List[string]]::new()
$Infos = [System.Collections.Generic.List[string]]::new()
$Unresolved = [System.Collections.Generic.HashSet[string]]::new([System.StringComparer]::OrdinalIgnoreCase)

function Add-Issue {
    param(
        [ValidateSet('error', 'warning', 'info')]
        [string]$Severity,
        [string]$Rule,
        [string]$Message
    )
    $formatted = "[$Rule] $Message"
    if ($Severity -eq 'error') { $Errors.Add($formatted); return }
    if ($Severity -eq 'warning') { $Warnings.Add($formatted); return }
    $Infos.Add($formatted)
}

function Write-IssueCollection {
    param(
        [string]$Label,
        [System.Collections.Generic.List[string]]$Items
    )
    if ($Items.Count -eq 0) { return }

    Write-Output "$Label`: $($Items.Count)"
    $Items |
        ForEach-Object {
            if ($_ -match '^\[(?<rule>[^]]+)\]') { $Matches['rule'] } else { 'unclassified' }
        } |
        Group-Object |
        Sort-Object Name |
        ForEach-Object { Write-Output "  $($_.Name): $($_.Count)" }

    $shown = if ($ShowAllIssues) { @($Items) } else { @($Items | Select-Object -First 20) }
    $shown | ForEach-Object { Write-Output "  $_" }
    if (-not $ShowAllIssues -and $Items.Count -gt $shown.Count) {
        Write-Output "  ... $($Items.Count - $shown.Count) more; rerun with -ShowAllIssues for every item"
    }
}

$schemaPath = Join-Path $Root '90 Meta\Vault Schema.md'
if (-not (Test-Path -LiteralPath $schemaPath)) {
    throw "Vault schema not found: $schemaPath"
}
$schemaText = [System.IO.File]::ReadAllText($schemaPath)
$schemaMatch = [regex]::Match(
    $schemaText,
    '(?s)<!-- vault-schema:start -->\s*```json\s*(?<json>.*?)\s*```\s*<!-- vault-schema:end -->'
)
if (-not $schemaMatch.Success) {
    throw "Machine-readable schema block not found: $schemaPath"
}
$Schema = $schemaMatch.Groups['json'].Value | ConvertFrom-Json
$AllowedStatuses = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]$Schema.paper_status,
    [System.StringComparer]::Ordinal
)
$AllowedMaturities = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]$Schema.concept_maturity,
    [System.StringComparer]::Ordinal
)
$ConceptSections = @($Schema.concept_sections)
$AdoptionWarningFields = [System.Collections.Generic.HashSet[string]]::new(
    [string[]]$Schema.adoption_warning_fields,
    [System.StringComparer]::Ordinal
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

$noteDirectories = @($Schema.academic_roots.PSObject.Properties.Name)
$files = @()
foreach ($directory in $noteDirectories) {
    $path = Join-Path $Root $directory
    if (-not (Test-Path -LiteralPath $path)) {
        Add-Issue error 'structure/missing-root' "Missing note directory: $directory"
        continue
    }
    $files += Get-ChildItem -LiteralPath $path -Recurse -File -Filter '*.md'
}

$duplicateNames = @($files | Group-Object BaseName | Where-Object Count -gt 1)
foreach ($group in $duplicateNames) {
    Add-Issue error 'identity/duplicate-basename' "Duplicate basename: $($group.Name)"
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
        Add-Issue error 'identity/alias-collision' "Canonical name/alias collision '$($file.BaseName)': $($canonicalByTarget[$file.BaseName]), $($file.BaseName)"
    } else {
        $canonicalByTarget[$file.BaseName] = $file.BaseName
    }
    $incomingCounts[$file.BaseName] = 0
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?:\r?\n|$)')
    if (-not $frontmatterMatch.Success) {
        Add-Issue error 'metadata/frontmatter' "Missing or malformed frontmatter: $($file.FullName)"
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
                    Add-Issue error 'identity/alias-collision' "Alias collision '$alias': $($canonicalByTarget[$alias]), $($file.BaseName)"
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

    $relativePath = $file.FullName.Substring($Root.Length + 1).Replace('\', '/')
    $legacyType = $null
    foreach ($legacyProperty in $Schema.legacy_locations.PSObject.Properties) {
        if ($relativePath.StartsWith($legacyProperty.Name + '/', [System.StringComparison]::OrdinalIgnoreCase)) {
            $legacyType = [string]$legacyProperty.Value
            Add-Issue warning 'structure/legacy-location' "Legacy $legacyType location: $relativePath"
            break
        }
    }
    if ($null -ne $legacyType) {
        $expectedTypes = @($legacyType)
    } else {
        $rootName = ($relativePath -split '/')[0]
        $rootProperty = $Schema.academic_roots.PSObject.Properties | Where-Object Name -eq $rootName | Select-Object -First 1
        $expectedTypes = @([string]$rootProperty.Value)
    }
    $typeMatch = [regex]::Match($yaml, '(?m)^type:\s*(\S+)\s*$')
    if (-not $typeMatch.Success -or $typeMatch.Groups[1].Value -notin $expectedTypes) {
        Add-Issue error 'structure/type-path' "Type/folder mismatch: $relativePath"
    }
    $documentType = if ($typeMatch.Success) { $typeMatch.Groups[1].Value } else { '' }
    $documentTypes[$file.BaseName] = $documentType

    $requiredProperty = $Schema.required_fields.PSObject.Properties | Where-Object Name -eq $documentType | Select-Object -First 1
    if ($null -ne $requiredProperty) {
        foreach ($field in @($requiredProperty.Value)) {
            if (-not [regex]::IsMatch($yaml, '(?m)^' + [regex]::Escape([string]$field) + ':')) {
                if ($AdoptionWarningFields.Contains([string]$field)) {
                    Add-Issue warning 'metadata/v2-adoption' "Missing v2 field '$field': $relativePath"
                } else {
                    Add-Issue error 'metadata/required' "Missing required field '$field': $relativePath"
                }
            }
        }
    }

    $summaryMatch = [regex]::Match($yaml, '(?m)^summary:\s*(?<value>.*)\s*$')
    if ($summaryMatch.Success) {
        $summary = $summaryMatch.Groups['value'].Value.Trim().Trim('"').Trim("'")
        if ($summary.Length -gt 200 -or $summary -match '\[\[|[*_]') {
            Add-Issue warning 'metadata/summary' "Summary is over 200 characters or contains markup: $relativePath"
        }
    }

    $reviewedMatch = [regex]::Match($yaml, '(?m)^last_reviewed:\s*["'']?(?<value>[^"''\r\n]*)["'']?\s*$')
    if (
        $reviewedMatch.Success -and
        -not [string]::IsNullOrWhiteSpace($reviewedMatch.Groups['value'].Value) -and
        -not [regex]::IsMatch($reviewedMatch.Groups['value'].Value, '^\d{4}-\d{2}-\d{2}$')
    ) {
        Add-Issue error 'metadata/date' "Invalid last_reviewed '$($reviewedMatch.Groups['value'].Value)': $relativePath"
    }

    if ($documentType -eq 'paper') {
        $pdfMatch = [regex]::Match($yaml, '(?m)^pdf:\s*"(?<value>.*)"\s*$')
        if (-not $pdfMatch.Success) {
            Add-Issue error 'metadata/required' "Missing pdf property: $relativePath"
        } elseif (-not [string]::IsNullOrWhiteSpace($pdfMatch.Groups['value'].Value)) {
            $pdfTarget = $pdfMatch.Groups['value'].Value -replace '^\[\[|\]\]$', ''
            $pdfTarget = ($pdfTarget -split '#page=')[0]
            $pdfPath = Join-Path $Root $pdfTarget
            if (-not (Test-Path -LiteralPath $pdfPath)) {
                Add-Issue error 'file/missing-pdf' "PDF target does not exist '$pdfTarget': $relativePath"
            }
        }

        $statusMatch = [regex]::Match($yaml, '(?m)^status:\s*(?<value>[a-z-]+)\s*$')
        if (-not $statusMatch.Success) {
            Add-Issue error 'metadata/required' "Missing status property: $relativePath"
        } elseif (-not $AllowedStatuses.Contains($statusMatch.Groups['value'].Value)) {
            Add-Issue error 'metadata/enum' "Invalid status '$($statusMatch.Groups['value'].Value)': $relativePath"
        }

        $readDateMatch = [regex]::Match($yaml, '(?m)^read_date:\s*"(?<value>.*)"\s*$')
        if (-not $readDateMatch.Success) {
            Add-Issue error 'metadata/required' "Missing read_date property: $relativePath"
        } elseif (
            -not [string]::IsNullOrWhiteSpace($readDateMatch.Groups['value'].Value) -and
            -not [regex]::IsMatch($readDateMatch.Groups['value'].Value, '^\d{4}-\d{2}-\d{2}$')
        ) {
            Add-Issue error 'metadata/date' "Invalid read_date '$($readDateMatch.Groups['value'].Value)': $relativePath"
        }
    } elseif ($documentType -eq 'concept') {
        $maturityMatch = [regex]::Match($yaml, '(?m)^maturity:\s*(?<value>[a-z-]+)\s*$')
        if ($maturityMatch.Success) {
            $maturity = $maturityMatch.Groups['value'].Value
            if (-not $AllowedMaturities.Contains($maturity)) {
                Add-Issue error 'metadata/enum' "Invalid maturity '$maturity': $relativePath"
            } elseif ($maturity -eq 'stub') {
                Add-Issue info 'quality/stub' "Concept is a stub: $relativePath"
            } elseif ($maturity -eq 'reviewed' -and (
                -not $reviewedMatch.Success -or
                [string]::IsNullOrWhiteSpace($reviewedMatch.Groups['value'].Value)
            )) {
                Add-Issue error 'metadata/date' "Reviewed concept has no last_reviewed date: $relativePath"
            }
        }
        $headings = @([regex]::Matches($body, '(?m)^#\s+(.+?)\s*$') | ForEach-Object { $_.Groups[1].Value })
        foreach ($section in $ConceptSections) {
            if ($section -notin $headings) {
                Add-Issue error 'metadata/required' "Missing concept section '$section': $relativePath"
            }
        }
    }

    $tagBlock = [regex]::Match($yaml, '(?ms)^tags:\r?\n(?<block>(?:  - [a-z0-9/-]+\r?\n?)*)')
    if (-not $tagBlock.Success) {
        Add-Issue error 'metadata/required' "Missing tags block: $relativePath"
    } else {
        $tags = @([regex]::Matches($tagBlock.Groups['block'].Value, '(?m)^  - ([a-z0-9/-]+)\r?$') | ForEach-Object { $_.Groups[1].Value })
        if ($tags.Count -lt 2 -or $tags.Count -gt 4) {
            Add-Issue warning 'tag/count' "Tag count is $($tags.Count), expected 2-4: $relativePath"
        }
        foreach ($tag in $tags) {
            if (-not $allowedTags.Contains($tag)) {
                Add-Issue error 'tag/unregistered' "Unregistered tag '$tag': $relativePath"
            }
        }
    }

    if ([regex]::IsMatch($body, '(?m)^\s*-\s*tags:\s*#|^\s*(?:#[A-Za-z][A-Za-z0-9_-]*\s*,?\s*)+$')) {
        Add-Issue error 'tag/unregistered' "Legacy inline tags remain: $relativePath"
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
            Add-Issue warning 'link/unresolved' "Legacy wikilink target '$target': $relativePath"
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
    $ReportedUnresolved | ForEach-Object {
        if ($StrictLinks) {
            Add-Issue error 'link/unresolved' "Unresolved wikilink target: $_"
        } else {
            Add-Issue warning 'link/unresolved' "Unresolved wikilink target: $_"
        }
    }
}
Write-Output "Orphan note candidates: $($Orphans.Count)"
if ($Orphans.Count -gt 0) {
    $Orphans | ForEach-Object {
        Add-Issue info 'graph/orphan' $($_.FullName.Substring($Root.Length + 1))
    }
}

Write-IssueCollection 'Warnings' $Warnings
Write-IssueCollection 'Info' $Infos

if ($Errors.Count -gt 0) {
    Write-IssueCollection 'Errors' $Errors
    exit 1
}

Write-Output 'Structural audit passed with no errors.'
