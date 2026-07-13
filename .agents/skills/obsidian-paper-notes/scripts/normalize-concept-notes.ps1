param(
    [string]$VaultRoot = (Resolve-Path (Join-Path $PSScriptRoot '..\..\..\..')).Path,
    [switch]$DryRun
)

$ErrorActionPreference = 'Stop'
$Utf8NoBom = [System.Text.UTF8Encoding]::new($false)
$Root = [System.IO.Path]::GetFullPath($VaultRoot).TrimEnd('\')
$ConceptRoot = Join-Path $Root '20 Concepts'
$Sections = @(
    '정의',
    '왜 필요한가',
    '작동 원리',
    '수식 / 알고리즘',
    '특징과 한계',
    '대표 변형',
    '등장/대표 논문',
    '관련 개념'
)

function Get-TargetSection {
    param([string]$Heading)

    $h = $Heading.Trim()
    switch -Regex ($h) {
        '^정의$|^의미$|^핵심 정보$' { return '정의' }
        '왜 필요한가|목적|설계 의도|필요성|기존 .*한계' { return '왜 필요한가' }
        '작동 원리|메커니즘|구조|동작|구성|방식$|계산 방식|적용$|입출력|세 가지 레이블|주요 아키텍처|Forward|Backward|Encoder|Decoder|gate|hidden|셀 상태|Annotation|Huffman|Masking|Value|Softmax 정규화|스케일링|유사도|입력 선형|Concatenate|Norm Clipping|Value Clipping|게이트|후보|최종|레이어' { return '작동 원리' }
        '수식|알고리즘|공식|목표 함수|노이즈 분포|\$k\$|계산 복잡도' { return '수식 / 알고리즘' }
        '특성|특징|한계|적용 사례|모델별 적용 방식|결과|영향|발생 원인|역할|해석|효과|NLP에서의 발전|컴퓨터 비전' { return '특징과 한계' }
        '대표 변형|관련 기법|옵티마이저|주요 유형|대표 학습 방법|대표 손실함수|방식별 분류|이후 발전|파생' { return '대표 변형' }
        '등장 논문|대표 논문' { return '등장/대표 논문' }
        '관련 개념' { return '관련 개념' }
        default { return '특징과 한계' }
    }
}

function Add-Block {
    param(
        [hashtable]$Buckets,
        [string]$Target,
        [string]$Heading,
        [string]$Text
    )

    $cleanText = $Text.Trim()
    if ([string]::IsNullOrWhiteSpace($cleanText)) {
        return
    }

    $block = if ($Heading -eq $Target) {
        $cleanText
    } else {
        "## $Heading`r`n`r`n$cleanText"
    }
    $Buckets[$Target].Add($block) | Out-Null
}

if (-not (Test-Path -LiteralPath $ConceptRoot)) {
    throw "Concept directory not found: $ConceptRoot"
}

$files = @(Get-ChildItem -LiteralPath $ConceptRoot -Recurse -File -Filter '*.md')
$changed = 0

foreach ($file in $files) {
    $content = [System.IO.File]::ReadAllText($file.FullName)
    $frontmatterMatch = [regex]::Match($content, '(?s)\A---\r?\n.*?\r?\n---(?:\r?\n|$)')
    if (-not $frontmatterMatch.Success) {
        throw "Missing frontmatter: $($file.FullName)"
    }

    $frontmatter = $frontmatterMatch.Value.TrimEnd()
    $body = $content.Substring($frontmatterMatch.Length).Trim()
    $buckets = @{}
    foreach ($section in $Sections) {
        $buckets[$section] = [System.Collections.Generic.List[string]]::new()
    }

    $headingMatches = @([regex]::Matches($body, '(?m)^(?<marks>#{1,3})\s+(?<heading>.+?)\s*$'))
    if ($headingMatches.Count -eq 0) {
        $buckets['정의'].Add($body) | Out-Null
    } else {
        $prefix = $body.Substring(0, $headingMatches[0].Index).Trim()
        if (-not [string]::IsNullOrWhiteSpace($prefix)) {
            $buckets['정의'].Add($prefix) | Out-Null
        }

        for ($i = 0; $i -lt $headingMatches.Count; $i++) {
            $match = $headingMatches[$i]
            $heading = $match.Groups['heading'].Value.Trim()
            $start = $match.Index + $match.Length
            $end = if ($i + 1 -lt $headingMatches.Count) { $headingMatches[$i + 1].Index } else { $body.Length }
            $text = $body.Substring($start, $end - $start)
            $target = Get-TargetSection -Heading $heading
            Add-Block -Buckets $buckets -Target $target -Heading $heading -Text $text
        }
    }

    $newBodyParts = foreach ($section in $Sections) {
        $sectionBody = ($buckets[$section] -join "`r`n`r`n").Trim()
        if ([string]::IsNullOrWhiteSpace($sectionBody)) {
            "# $section"
        } else {
            "# $section`r`n`r`n$sectionBody"
        }
    }
    $newContent = $frontmatter + "`r`n" + ($newBodyParts -join "`r`n`r`n") + "`r`n"

    if ($newContent -ne $content) {
        $changed++
        Write-Output "Normalize: $($file.FullName)"
        if (-not $DryRun) {
            [System.IO.File]::WriteAllText($file.FullName, $newContent, $Utf8NoBom)
        }
    }
}

if ($DryRun) {
    Write-Output "Dry run; $changed concept notes would change."
} else {
    Write-Output "Updated $changed concept notes."
}
