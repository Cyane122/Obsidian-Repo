param(
    [string]$VaultRoot = 'D:\World',
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')
$ProjectRoot = Join-Path $Root '60 Projects'
$EntityRoot = Join-Path $ProjectRoot 'Entities'
$Changes = [System.Collections.Generic.List[string]]::new()

$StatusByTitle = @{
    '개인 지출 기록 자동화' = 'milestone-complete'
    '개인 프로젝트' = 'active'
    '데이터·AI 데일리·주간 브리핑' = 'active'
    '로스트아크 기상술사 딜 최적화기' = 'active'
    '서사 생성 모델 연구 프로토타입' = 'prototype'
    '아크 그리드 코어 기록장' = 'deployed-unverified'
    'AI·NLP 학술 지식 Wiki' = 'active'
    'CH2026 센서 데이터 예측' = 'complete'
    'GraphRAG' = 'active'
    'Narragraph' = 'prototype'
    'Two-stage 추천 시스템' = 'complete'
}

function Get-Scalar {
    param([string]$Yaml, [string]$Name)
    $match = [regex]::Match($Yaml, '(?m)^' + [regex]::Escape($Name) + ':\s*["'']?(?<value>[^"''\r\n]*)["'']?\s*$')
    if ($match.Success) { return $match.Groups['value'].Value.Trim() }
    return ''
}

function Add-ScalarAfter {
    param([string]$Yaml, [string]$After, [string]$Name, [string]$Value)
    if ([regex]::IsMatch($Yaml, '(?m)^' + [regex]::Escape($Name) + ':')) { return $Yaml }
    $anchor = [regex]::Match($Yaml, '(?m)^' + [regex]::Escape($After) + ':[^\r\n]*(?<newline>\r?\n)')
    if (-not $anchor.Success) { throw "Cannot insert '$Name'; anchor '$After' is missing." }
    $escaped = $Value.Replace('\', '\\').Replace('"', '\"')
    $line = "$Name`: `"$escaped`"$($anchor.Groups['newline'].Value)"
    return $Yaml.Insert($anchor.Index + $anchor.Length, $line)
}

function Get-ProjectSummary {
    param([string]$Body, [string]$Title)
    foreach ($heading in @('프로젝트 정의', '이 문서의 범위', '한 줄 요약')) {
        $section = [regex]::Match(
            $Body,
            '(?ms)^#\s+' + [regex]::Escape($heading) + '\s*\r?\n(?<value>.*?)(?=^#\s+|\z)'
        )
        if (-not $section.Success) { continue }
        $paragraph = @($section.Groups['value'].Value -split '(?:\r?\n){2,}')[0].Trim()
        if ([string]::IsNullOrWhiteSpace($paragraph)) { continue }
        $paragraph = [regex]::Replace($paragraph, '\[\[[^\]|]+\|(?<label>[^\]]+)\]\]', '${label}')
        $paragraph = [regex]::Replace($paragraph, '\[\[(?<target>[^\]#|]+)(?:#[^\]]+)?\]\]', '${target}')
        $paragraph = $paragraph -replace '[*_`]', ''
        $paragraph = [regex]::Replace($paragraph, '\s+', ' ').Trim()
        $sentences = @([regex]::Matches($paragraph, '[^.!?]+[.!?](?=\s|$)') | ForEach-Object { $_.Value.Trim() })
        $summary = if ($sentences.Count -gt 0) { $sentences[0] } else { $paragraph }
        if ($summary.Length -le 200) { return $summary }
        return $summary.Substring(0, 197).TrimEnd() + '…'
    }
    return "$Title 프로젝트의 목표, 결정과 확인된 상태를 기록한 문서다."
}

$projectFiles = Get-ChildItem -LiteralPath $ProjectRoot -File -Filter '*.md'
foreach ($file in $projectFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatter = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?<tail>\r?\n|$)')
    if (-not $frontmatter.Success) { throw "Malformed frontmatter: $($file.FullName)" }
    $yaml = $frontmatter.Groups['yaml'].Value
    $updatedYaml = $yaml
    $body = $content.Substring($frontmatter.Length)
    $type = Get-Scalar $yaml 'type'
    $title = Get-Scalar $yaml 'title'
    $fields = [System.Collections.Generic.List[string]]::new()

    if ($type -eq 'project-map') {
        $updatedYaml = [regex]::Replace($updatedYaml, '(?m)^type:\s*project-map\s*$', 'type: project')
        $fields.Add('type=project')
    }
    if (-not [regex]::IsMatch($updatedYaml, '(?m)^summary:')) {
        $summary = Get-ProjectSummary $body $title
        $updatedYaml = Add-ScalarAfter $updatedYaml 'title' 'summary' $summary
        $fields.Add("summary=$summary")
    }
    if (-not [regex]::IsMatch($updatedYaml, '(?m)^status:')) {
        $status = [string]$StatusByTitle[$title]
        if ([string]::IsNullOrWhiteSpace($status)) { $status = 'unknown' }
        $updatedYaml = Add-ScalarAfter $updatedYaml 'summary' 'status' $status
        $fields.Add("status=$status")
    }
    if (-not [regex]::IsMatch($updatedYaml, '(?m)^state_source:')) {
        $updatedYaml = Add-ScalarAfter $updatedYaml 'status' 'state_source' 'session-history'
        $fields.Add('state_source=session-history')
    }
    if (-not [regex]::IsMatch($updatedYaml, '(?m)^last_verified:')) {
        $verified = Get-Scalar $yaml 'last_session_date'
        if ([string]::IsNullOrWhiteSpace($verified)) { $verified = Get-Scalar $yaml 'last_reviewed' }
        $updatedYaml = Add-ScalarAfter $updatedYaml 'state_source' 'last_verified' $verified
        $fields.Add("last_verified=$verified")
    }

    if ($updatedYaml -eq $yaml) { continue }
    $Changes.Add("metadata | $($file.Name) | $($fields -join ', ')")
    if (-not $DryRun) {
        $newContent = "---$($frontmatter.Groups['tail'].Value)$updatedYaml$($frontmatter.Groups['tail'].Value)---$($frontmatter.Groups['tail'].Value)$body"
        [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new($false))
    }
}

$termRoot = Join-Path $ProjectRoot '용어'
$termFiles = if (Test-Path -LiteralPath $termRoot) {
    @(Get-ChildItem -LiteralPath $termRoot -File -Filter '*.md')
} else {
    @()
}
foreach ($file in $termFiles) {
    if ($file.Name -eq '태그 일람.md') { continue }
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatter = [regex]::Match($content, '(?s)\A---\r?\n(?<yaml>.*?)\r?\n---(?<tail>\r?\n|$)')
    if (-not $frontmatter.Success) { throw "Malformed frontmatter: $($file.FullName)" }
    $yaml = $frontmatter.Groups['yaml'].Value
    $updatedYaml = [regex]::Replace($yaml, '(?m)^type:\s*project-concept\s*$', 'type: project-entity')
    $projectLink = Get-Scalar $updatedYaml 'project'
    $projectName = ($projectLink -replace '^\[\[|\]\]$', '').Trim()
    if ([string]::IsNullOrWhiteSpace($projectName)) { throw "Missing project link: $($file.FullName)" }
    if (-not (Test-Path -LiteralPath (Join-Path $ProjectRoot ($projectName + '.md')))) {
        throw "Project note does not exist for '$projectName': $($file.FullName)"
    }
    $destinationDirectory = [System.IO.Path]::GetFullPath((Join-Path $EntityRoot $projectName))
    $destination = [System.IO.Path]::GetFullPath((Join-Path $destinationDirectory $file.Name))
    if (-not $destination.StartsWith([System.IO.Path]::GetFullPath($EntityRoot) + '\', [System.StringComparison]::OrdinalIgnoreCase)) {
        throw "Destination outside entity root: $destination"
    }
    if (Test-Path -LiteralPath $destination) { throw "Destination already exists: $destination" }
    $typeChanged = $updatedYaml -ne $yaml
    $Changes.Add("move | $($file.Name) -> Entities\$projectName\$($file.Name) | type-normalized=$typeChanged")

    if (-not $DryRun) {
        if ($typeChanged) {
            $newContent = "---$($frontmatter.Groups['tail'].Value)$updatedYaml$($frontmatter.Groups['tail'].Value)---$($frontmatter.Groups['tail'].Value)$($content.Substring($frontmatter.Length))"
            [System.IO.File]::WriteAllText($file.FullName, $newContent, [System.Text.UTF8Encoding]::new($false))
        }
        if (-not (Test-Path -LiteralPath $destinationDirectory)) {
            [void](New-Item -ItemType Directory -Path $destinationDirectory)
        }
        Move-Item -LiteralPath $file.FullName -Destination $destination
    }
}

$mode = if ($DryRun) { 'DRY RUN' } else { 'APPLIED' }
Write-Output "$mode`: $($Changes.Count) project change(s)"
$Changes | ForEach-Object { Write-Output "  $_" }
