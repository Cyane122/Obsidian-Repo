param(
    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')
$AcademicRoots = @('10 Papers', '20 Concepts', '30 Maps', '35 Comparisons', '37 Syntheses')
$Changes = [System.Collections.Generic.List[string]]::new()

function Get-Scalar {
    param([string]$Yaml, [string]$Name)
    $match = [regex]::Match($Yaml, '(?m)^' + [regex]::Escape($Name) + ':\s*["'']?(?<value>[^"''\r\n]*)["'']?\s*$')
    if ($match.Success) { return $match.Groups['value'].Value.Trim() }
    return ''
}

function Add-ScalarAfter {
    param(
        [string]$Yaml,
        [string]$After,
        [string]$Name,
        [string]$Value
    )
    if ([regex]::IsMatch($Yaml, '(?m)^' + [regex]::Escape($Name) + ':')) { return $Yaml }
    $anchor = [regex]::Match($Yaml, '(?m)^' + [regex]::Escape($After) + ':[^\r\n]*(?<newline>\r?\n)')
    if (-not $anchor.Success) { throw "Cannot insert '$Name'; anchor '$After' is missing." }
    $escaped = $Value.Replace('\', '\\').Replace('"', '\"')
    $line = "$Name`: `"$escaped`"$($anchor.Groups['newline'].Value)"
    return $Yaml.Insert($anchor.Index + $anchor.Length, $line)
}

function Get-Section {
    param([string]$Body, [string[]]$Headings)
    foreach ($heading in $Headings) {
        $match = [regex]::Match(
            $Body,
            '(?ms)^#\s+' + [regex]::Escape($heading) + '\s*\r?\n(?<section>.*?)(?=^#\s+|\z)'
        )
        if ($match.Success -and -not [string]::IsNullOrWhiteSpace($match.Groups['section'].Value)) {
            return $match.Groups['section'].Value
        }
    }
    return ''
}

function ConvertTo-Summary {
    param([string]$Text)
    if ([string]::IsNullOrWhiteSpace($Text)) { return '' }
    $clean = [regex]::Replace($Text, '(?s)```.*?```', ' ')
    $clean = [regex]::Replace($clean, '(?s)\$\$.*?\$\$', ' ')
    $clean = [regex]::Replace($clean, '(?s)\\\[(?<math>.*?)\\\]', ' ${math} ')
    $clean = [regex]::Replace($clean, '(?s)\\\((?<math>.*?)\\\)', ' ${math} ')
    $clean = [regex]::Replace($clean, '\$(?!\$)(?<math>.*?)\$', '${math}')
    $lines = [System.Collections.Generic.List[string]]::new()
    foreach ($line in ($clean -split '\r?\n')) {
        $value = $line.Trim()
        if ([string]::IsNullOrWhiteSpace($value)) {
            if ($lines.Count -gt 0) { break }
            continue
        }
        if ($value -match '^#|^\|(?:.*\|)+$|^!\[|^>\s*\[!|^---+$') { continue }
        $value = $value -replace '^[-*+]\s+', '' -replace '^\d+[.)]\s+', '' -replace '^>\s*', ''
        $lines.Add($value)
    }
    $summary = ($lines -join ' ')
    $summary = [regex]::Replace($summary, '\[\[[^\]|]+\|(?<label>[^\]]+)\]\]', '${label}')
    $summary = [regex]::Replace($summary, '\[\[(?<target>[^\]#|]+)(?:#[^\]]+)?\]\]', '${target}')
    $summary = [regex]::Replace($summary, '\[(?<label>[^\]]+)\]\([^)]+\)', '${label}')
    $summary = $summary -replace '[*_`]', '' -replace '<[^>]+>', ' '
    $summary = $summary -replace '\\cdots', '…' -replace '\\(?:bf|mathbf|mathrm|text)\s*', ''
    $summary = $summary -replace '\\(?<symbol>theta|sigma|mu|eta|gamma|beta|epsilon)', '${symbol}'
    $summary = $summary -replace '[{}\\]', ''
    $summary = [regex]::Replace($summary, '\s+', ' ').Trim()
    $sentences = @([regex]::Matches($summary, '[^.!?]+[.!?](?=\s|$)') | ForEach-Object { $_.Value.Trim() })
    if ($sentences.Count -gt 0) {
        $candidate = ($sentences | Select-Object -First 2) -join ' '
        if ($candidate.Length -le 200) { return $candidate }
        if ($sentences[0].Length -le 200) { return $sentences[0] }
    }
    if ($summary.Length -le 200) { return $summary }
    $cut = $summary.Substring(0, 197)
    $lastSentence = [Math]::Max($cut.LastIndexOf('.'), [Math]::Max($cut.LastIndexOf('!'), $cut.LastIndexOf('?')))
    if ($lastSentence -gt 80) { return $cut.Substring(0, $lastSentence + 1).Trim() }
    $lastSpace = $cut.LastIndexOf(' ')
    if ($lastSpace -gt 120) { $cut = $cut.Substring(0, $lastSpace) }
    return $cut.TrimEnd() + '…'
}

function Get-Summary {
    param([string]$Type, [string]$Title, [string]$Body)
    $headings = switch ($Type) {
        'paper' { @('한 줄 요약', '핵심 기여', 'Abstract') }
        'concept' { @('정의') }
        'map' { @('흐름 요약') }
        'comparison' { @('비교 목적', '핵심 차이') }
        'synthesis' { @('핵심 결론') }
        default { @() }
    }
    $summary = ConvertTo-Summary (Get-Section $Body $headings)
    if ($Type -eq 'concept' -and $summary -match '^(?<first>.*?[.!?])(?:\s|$)') {
        $summary = $Matches['first'].Trim()
    }
    if (-not [string]::IsNullOrWhiteSpace($summary)) { return $summary }
    if ($Type -eq 'concept') { return "내용 보강이 필요한 $Title 개념 문서다." }
    if ($Type -eq 'paper') { return "$Title 논문의 서지 정보와 읽기 상태를 추적하는 노트다." }
    if ($Type -eq 'map' -and $Title -eq '논문 읽기 프로젝트') {
        return '논문 읽기 원칙과 분야별 학술 자료의 탐색 경로를 모은 지도다.'
    }
    if ($Type -eq 'map') { return "$Title 주제의 연구 흐름과 읽기 경로를 정리한 지도다." }
    if ($Type -eq 'comparison') { return "$Title의 공통 기준과 차이를 정리한 비교 문서다." }
    return "$Title에 관한 여러 출처의 결론과 근거를 종합한 문서다."
}

function Get-DomainTag {
    param([string]$RelativePath, [string]$Title)
    $path = $RelativePath.Replace('\', '/')
    if ($path.StartsWith('10 Papers/NLP/')) { return 'domain/nlp' }
    if ($path.StartsWith('10 Papers/Multimodal/')) { return 'domain/multimodal' }
    if ($path.StartsWith('10 Papers/Recommender Systems/')) { return 'domain/recommender-systems' }
    if ($path.StartsWith('10 Papers/')) { return 'domain/machine-learning' }
    if ($path.StartsWith('20 Concepts/Recommender Systems/')) { return 'domain/recommender-systems' }
    if ($path.StartsWith('20 Concepts/Representations/')) { return 'domain/nlp' }
    if ($path.StartsWith('20 Concepts/Foundations/')) { return 'domain/machine-learning' }
    if ($path.StartsWith('20 Concepts/Training and Optimization/')) { return 'domain/machine-learning' }
    if ($path.StartsWith('20 Concepts/Privacy and Safety/')) { return 'domain/privacy-and-safety' }
    if ($path.StartsWith('20 Concepts/Architectures/')) {
        if ($Title -match 'Deep Neural Networks|Residual Connection') { return 'domain/machine-learning' }
        return 'domain/nlp'
    }
    if ($path.StartsWith('20 Concepts/Tasks and Evaluation/')) {
        if ($Title -match 'Language|Named Entity|BLEU|ROUGE|Zero-Shot') { return 'domain/nlp' }
        return 'domain/machine-learning'
    }
    # This cross-domain reading index intentionally keeps its single broad domain tag.
    if ($path -eq '30 Maps/논문 읽기 프로젝트.md') { return '' }
    return ''
}

function Add-DomainTag {
    param([string]$Yaml, [string]$Tag)
    if ([string]::IsNullOrWhiteSpace($Tag)) { return $Yaml }
    if ([regex]::IsMatch($Yaml, '(?m)^  - ' + [regex]::Escape($Tag) + '\r?$')) { return $Yaml }
    $tagHeader = [regex]::Match($Yaml, '(?m)^tags:(?<newline>\r?\n)')
    if (-not $tagHeader.Success) { throw 'Cannot add domain tag; tags block is missing.' }
    return $Yaml.Insert(
        $tagHeader.Index + $tagHeader.Length,
        "  - $Tag$($tagHeader.Groups['newline'].Value)"
    )
}

$files = foreach ($directory in $AcademicRoots) {
    Get-ChildItem -LiteralPath (Join-Path $Root $directory) -Recurse -File -Filter '*.md'
}

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatter = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?<tail>\r?\n|$)')
    if (-not $frontmatter.Success) { throw "Malformed frontmatter: $($file.FullName)" }

    $yaml = $frontmatter.Groups['yaml'].Value
    $updatedYaml = $yaml
    $body = $content.Substring($frontmatter.Length)
    $type = Get-Scalar $yaml 'type'
    $title = Get-Scalar $yaml 'title'
    $relativePath = $file.FullName.Substring($Root.Length + 1)
    $changedFields = [System.Collections.Generic.List[string]]::new()

    if (-not [regex]::IsMatch($updatedYaml, '(?m)^summary:')) {
        $summary = Get-Summary $type $title $body
        $updatedYaml = Add-ScalarAfter $updatedYaml 'title' 'summary' $summary
        $changedFields.Add("summary=$summary")
    }

    if ($type -eq 'concept') {
        if (-not [regex]::IsMatch($updatedYaml, '(?m)^maturity:')) {
            $plainBody = ($body -replace '(?m)^#+\s+.*$', '' -replace '\s+', ' ').Trim()
            $maturity = if ($plainBody.Length -lt 120) { 'stub' } else { 'developing' }
            $updatedYaml = Add-ScalarAfter $updatedYaml 'summary' 'maturity' $maturity
            $changedFields.Add("maturity=$maturity")
        }
        if (-not [regex]::IsMatch($updatedYaml, '(?m)^last_reviewed:')) {
            $updatedYaml = Add-ScalarAfter $updatedYaml 'maturity' 'last_reviewed' ''
            $changedFields.Add('last_reviewed')
        }
    } elseif ($type -in @('map', 'comparison', 'synthesis')) {
        if (-not [regex]::IsMatch($updatedYaml, '(?m)^last_reviewed:')) {
            $updatedYaml = Add-ScalarAfter $updatedYaml 'summary' 'last_reviewed' ''
            $changedFields.Add('last_reviewed')
        }
    }

    $tagBlock = [regex]::Match($updatedYaml, '(?ms)^tags:\r?\n(?<block>(?:  - [a-z0-9/-]+\r?\n?)*)')
    $tags = @(
        [regex]::Matches($tagBlock.Groups['block'].Value, '(?m)^  - ([a-z0-9/-]+)\r?$') |
            ForEach-Object { $_.Groups[1].Value }
    )
    if ($tags.Count -lt 2) {
        $domainTag = Get-DomainTag $relativePath $title
        if (-not [string]::IsNullOrWhiteSpace($domainTag)) {
            $updatedYaml = Add-DomainTag $updatedYaml $domainTag
            $changedFields.Add("tag=$domainTag")
        }
    }

    if ($updatedYaml -eq $yaml) { continue }
    $Changes.Add("$relativePath | $($changedFields -join ', ')")
    if (-not $DryRun) {
        $newContent = "---$($frontmatter.Groups['tail'].Value)$updatedYaml$($frontmatter.Groups['tail'].Value)---$($frontmatter.Groups['tail'].Value)$body"
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new($false))
    }
}

$mode = if ($DryRun) { 'DRY RUN' } else { 'APPLIED' }
Write-Output "$mode`: $($Changes.Count) note(s)"
$Changes | ForEach-Object { Write-Output "  $_" }
