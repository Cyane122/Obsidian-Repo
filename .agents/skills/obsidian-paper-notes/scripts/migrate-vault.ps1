param(
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

function Quote-Yaml {
    param([string]$Value)

    return '"' + $Value.Replace('\', '\\').Replace('"', '\"') + '"'
}

$AllowedTags = @(
    'domain/machine-learning', 'domain/nlp', 'domain/multimodal',
    'domain/recommender-systems', 'domain/privacy-and-safety',
    'task/language-modeling', 'task/machine-translation', 'task/text-rewriting',
    'task/text-classification', 'task/natural-language-inference', 'task/summarization',
    'task/recommendation', 'task/representation-learning', 'task/zero-shot-transfer',
    'method/attention', 'method/activation-function', 'method/neural-network',
    'method/transformer', 'method/recurrent-neural-network', 'method/encoder-decoder',
    'method/word-embedding', 'method/contrastive-learning', 'method/collaborative-filtering',
    'method/pairwise-ranking', 'method/tree-search', 'method/differential-privacy',
    'method/optimization', 'method/normalization', 'method/regularization',
    'method/sampling', 'method/matrix-factorization', 'method/dimensionality-reduction',
    'method/information-theory', 'method/large-language-model',
    'theme/privacy-preservation', 'theme/training-stability',
    'theme/computational-efficiency', 'theme/evaluation', 'theme/generalization',
    'theme/alignment'
)

$Rows = @(
    @('논문 읽기 프로젝트', 'map', '30 Maps', @('domain/machine-learning')),

    @('Attention is All You Need', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/machine-translation', 'method/attention', 'method/transformer')),
    @('Deep Contextualized Word Representations', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/representation-learning', 'method/recurrent-neural-network', 'theme/generalization')),
    @('Distributed Representations of Words and Phrases and their Compositionality', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/representation-learning', 'method/word-embedding', 'method/sampling')),
    @('Efficient Estimation of Word Representations in Vector Space', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/representation-learning', 'method/word-embedding', 'theme/computational-efficiency')),
    @('GloVe - Global Vectors for Word Representation', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/representation-learning', 'method/word-embedding', 'method/matrix-factorization')),
    @('NAP² - A Benchmark for Naturalness and Privacy-Preserving Text Rewriting by Learning from Human', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/text-rewriting', 'theme/privacy-preservation', 'theme/evaluation')),
    @('Neural Machine Translation by Jointly Learning to Align and Translate', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/machine-translation', 'method/attention', 'method/encoder-decoder')),
    @('Sequence to Sequence Learning with Neural Networks', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/machine-translation', 'method/recurrent-neural-network', 'method/encoder-decoder')),
    @('Zero-Shot Privacy-Aware Text Rewriting via Iterative Tree Search', 'paper', '10 Papers\NLP', @('domain/nlp', 'task/text-rewriting', 'method/tree-search', 'theme/privacy-preservation')),
    @('Collaborative Filtering for Implicit Feedback Datasets', 'paper', '10 Papers\Recommender Systems', @('domain/recommender-systems', 'task/recommendation', 'method/collaborative-filtering', 'method/matrix-factorization')),
    @('BPR - Bayesian Personalized Ranking', 'paper', '10 Papers\Recommender Systems', @('domain/recommender-systems', 'task/recommendation', 'method/pairwise-ranking')),
    @('Learning Transferable Visual Models From Natural Language Supervision', 'paper', '10 Papers\Multimodal', @('domain/multimodal', 'task/zero-shot-transfer', 'method/contrastive-learning', 'theme/generalization')),

    @('KL Divergence', 'concept', '20 Concepts\Foundations', @('domain/machine-learning', 'method/information-theory')),
    @('Pointwise Mutual Information', 'concept', '20 Concepts\Foundations', @('domain/nlp', 'task/representation-learning', 'method/information-theory')),
    @('Positive Pointwise Mutual Information', 'concept', '20 Concepts\Foundations', @('domain/nlp', 'task/representation-learning', 'method/information-theory')),
    @('Sigmoid', 'concept', '20 Concepts\Foundations', @('domain/machine-learning', 'method/activation-function')),
    @('Softmax', 'concept', '20 Concepts\Foundations', @('domain/machine-learning', 'method/activation-function', 'method/normalization')),
    @('Tanh', 'concept', '20 Concepts\Foundations', @('domain/machine-learning', 'method/activation-function')),
    @('Upper Confidence Bound for Trees', 'concept', '20 Concepts\Foundations', @('domain/machine-learning', 'method/tree-search')),

    @('Co-occurrence Matrix', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning')),
    @('Continuous Bag-of-Words', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning', 'method/word-embedding')),
    @('Distributed Representation', 'concept', '20 Concepts\Representations', @('domain/machine-learning', 'task/representation-learning')),
    @('Hellinger PCA', 'concept', '20 Concepts\Representations', @('domain/machine-learning', 'task/representation-learning', 'method/dimensionality-reduction')),
    @('Latent Semantic Analysis', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning', 'method/dimensionality-reduction')),
    @('One-hot Encoding', 'concept', '20 Concepts\Representations', @('domain/machine-learning', 'task/representation-learning')),
    @('Singular Value Decompostion', 'concept', '20 Concepts\Representations', @('domain/machine-learning', 'task/representation-learning', 'method/dimensionality-reduction', 'method/matrix-factorization')),
    @('Skip-gram', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning', 'method/word-embedding')),
    @('Word2Vec', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning', 'method/word-embedding')),
    @('Word Embedding', 'concept', '20 Concepts\Representations', @('domain/nlp', 'task/representation-learning', 'method/word-embedding')),

    @('Attention', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/attention', 'method/encoder-decoder', 'theme/alignment')),
    @('Beam Search', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'task/language-modeling', 'method/encoder-decoder', 'theme/computational-efficiency')),
    @('bidirectional Language Model', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'task/language-modeling', 'method/recurrent-neural-network')),
    @('bidirectional RNN', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/recurrent-neural-network')),
    @('Deep Neural Networks', 'concept', '20 Concepts\Architectures', @('domain/machine-learning', 'method/neural-network')),
    @('Encoder-Decoder', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/encoder-decoder')),
    @('Gated Recurrent Unit', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/recurrent-neural-network')),
    @('LSTM', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/recurrent-neural-network')),
    @('Multi-Head Attention', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/attention', 'method/transformer')),
    @('Neural Network Language Model', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'task/language-modeling', 'method/neural-network')),
    @('Positonal Encoding', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/transformer', 'method/attention')),
    @('Recurrent Neural Networks', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/recurrent-neural-network', 'method/neural-network')),
    @('Residual Connection', 'concept', '20 Concepts\Architectures', @('domain/machine-learning', 'method/neural-network', 'theme/training-stability')),
    @('Scaled Dot-Product Attention', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/attention', 'method/transformer')),
    @('Self-Attention', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/attention', 'method/transformer')),
    @('Transformer', 'concept', '20 Concepts\Architectures', @('domain/nlp', 'method/transformer', 'method/attention')),

    @('AdaGrad', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'theme/training-stability')),
    @('Backpropagation', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'theme/training-stability')),
    @('Batch Normalization', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/normalization', 'theme/training-stability')),
    @('Contrastive Learning', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'task/representation-learning', 'method/contrastive-learning')),
    @('Cross-Entropy', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'method/information-theory')),
    @('Dropout', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/regularization', 'theme/training-stability')),
    @('Exploding Gradient', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'theme/training-stability')),
    @('Gradient Clipping', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'theme/training-stability')),
    @('Hierarchical Softmax', 'concept', '20 Concepts\Training and Optimization', @('domain/nlp', 'task/language-modeling', 'theme/computational-efficiency')),
    @('Layer Normalization', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/normalization', 'theme/training-stability', 'method/transformer')),
    @('Negative Sampling', 'concept', '20 Concepts\Training and Optimization', @('domain/nlp', 'task/representation-learning', 'method/sampling', 'theme/computational-efficiency')),
    @('Noise Contrastive Estimation', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/sampling', 'theme/computational-efficiency')),
    @('Stochastic Gradient Descent', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization')),
    @('Subsampling of Frequent Words', 'concept', '20 Concepts\Training and Optimization', @('domain/nlp', 'task/representation-learning', 'method/sampling', 'theme/computational-efficiency')),
    @('Vanishing Gradient', 'concept', '20 Concepts\Training and Optimization', @('domain/machine-learning', 'method/optimization', 'theme/training-stability')),

    @('Accuracy', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'theme/evaluation')),
    @('BLEU Score', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/nlp', 'task/machine-translation', 'theme/evaluation')),
    @('Confusion Matrix', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'task/text-classification', 'theme/evaluation')),
    @('F1 Score', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'theme/evaluation')),
    @('Language Model', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/nlp', 'task/language-modeling')),
    @('Named Entity Recognition', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/nlp', 'task/text-classification')),
    @('Natural Language Inference', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/nlp', 'task/natural-language-inference')),
    @('Precision', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'theme/evaluation')),
    @('Recall', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'theme/evaluation')),
    @('ROUGE', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/nlp', 'task/summarization', 'theme/evaluation')),
    @('Zero-Shot Transfer', 'concept', '20 Concepts\Tasks and Evaluation', @('domain/machine-learning', 'task/zero-shot-transfer', 'theme/generalization')),

    @('Differential Privacy', 'concept', '20 Concepts\Privacy and Safety', @('domain/privacy-and-safety', 'method/differential-privacy', 'theme/privacy-preservation')),
    @('Implicit Feedback', 'concept', '20 Concepts\Recommender Systems', @('domain/recommender-systems', 'task/recommendation'))
)

$Overrides = @{
    'Attention is All You Need' = @{ NewName = 'Attention Is All You Need'; Title = 'Attention Is All You Need' }
    'BPR - Bayesian Personalized Ranking' = @{
        NewName = 'BPR - Bayesian Personalized Ranking from Implicit Feedback'
        Title = 'BPR: Bayesian Personalized Ranking from Implicit Feedback'
        Year = 2009
        Authors = @('Steffen Rendle et al.')
    }
    'GloVe - Global Vectors for Word Representation' = @{ Title = 'GloVe: Global Vectors for Word Representation' }
    'NAP² - A Benchmark for Naturalness and Privacy-Preserving Text Rewriting by Learning from Human' = @{ Title = 'NAP²: A Benchmark for Naturalness and Privacy-Preserving Text Rewriting by Learning from Human' }
    'Singular Value Decompostion' = @{ NewName = 'Singular Value Decomposition'; Title = 'Singular Value Decomposition' }
    'Positonal Encoding' = @{ NewName = 'Positional Encoding'; Title = 'Positional Encoding' }
    'bidirectional Language Model' = @{ NewName = 'Bidirectional Language Model'; Title = 'Bidirectional Language Model' }
    'bidirectional RNN' = @{ NewName = 'Bidirectional Recurrent Neural Network'; Title = 'Bidirectional Recurrent Neural Network' }
    'Recurrent Neural Networks' = @{ NewName = 'Recurrent Neural Network'; Title = 'Recurrent Neural Network' }
}

$Entries = foreach ($row in $Rows) {
    $name = [string]$row[0]
    $override = $Overrides[$name]
    $newName = if ($override -and $override.NewName) { [string]$override.NewName } else { $name }
    $title = if ($override -and $override.Title) { [string]$override.Title } else { $newName }
    [pscustomobject]@{
        Name = $name
        NewName = $newName
        Title = $title
        Type = [string]$row[1]
        Folder = [string]$row[2]
        Tags = [string[]]$row[3]
        Year = if ($override -and $override.Year) { [int]$override.Year } else { $null }
        Authors = if ($override -and $override.Authors) { [string[]]$override.Authors } else { @() }
    }
}

$rootFiles = @(Get-ChildItem -LiteralPath $Root -File -Filter '*.md')
$manifestNames = @($Entries | ForEach-Object { $_.Name + '.md' })
$unmapped = @($rootFiles.Name | Where-Object { $_ -notin $manifestNames })
$missing = @($manifestNames | Where-Object { $_ -notin $rootFiles.Name })
if ($unmapped.Count -gt 0) {
    throw "Unmapped root Markdown files: $($unmapped -join ', ')"
}
if ($missing.Count -gt 0) {
    throw "Manifest entries missing from root: $($missing -join ', ')"
}
if ($Entries.Count -ne 74) {
    throw "Expected 74 migration entries, got $($Entries.Count)"
}

$targetPaths = @()
foreach ($entry in $Entries) {
    foreach ($tag in $entry.Tags) {
        if ($tag -notin $AllowedTags) {
            throw "Unregistered tag '$tag' for $($entry.Name)"
        }
    }
    if ($entry.Tags.Count -lt 1 -or $entry.Tags.Count -gt 4) {
        throw "Invalid tag count for $($entry.Name): $($entry.Tags.Count)"
    }

    $source = Assert-WithinRoot (Join-Path $Root ($entry.Name + '.md'))
    $targetDirectory = Assert-WithinRoot (Join-Path $Root $entry.Folder)
    $target = Assert-WithinRoot (Join-Path $targetDirectory ($entry.NewName + '.md'))
    if (Test-Path -LiteralPath $target) {
        throw "Target already exists: $target"
    }
    $targetPaths += $target
}

$duplicateTargets = @($targetPaths | Group-Object | Where-Object Count -gt 1)
if ($duplicateTargets.Count -gt 0) {
    throw "Duplicate migration targets: $($duplicateTargets.Name -join ', ')"
}

if ($DryRun) {
    $Entries | Group-Object Folder | Sort-Object Name | ForEach-Object {
        Write-Output ("{0}: {1}" -f $_.Name, $_.Count)
    }
    Write-Output "Validated $($Entries.Count) files; no changes written."
    exit 0
}

$finalPaths = @()
foreach ($entry in $Entries) {
    $source = Assert-WithinRoot (Join-Path $Root ($entry.Name + '.md'))
    $targetDirectory = Assert-WithinRoot (Join-Path $Root $entry.Folder)
    $target = Assert-WithinRoot (Join-Path $targetDirectory ($entry.NewName + '.md'))

    if (-not (Test-Path -LiteralPath $targetDirectory)) {
        New-Item -ItemType Directory -Path $targetDirectory -Force | Out-Null
    }

    $body = [System.IO.File]::ReadAllText($source)
    $body = $body.TrimStart([char]0xFEFF)

    $yearMatch = [regex]::Match($body, '(?m)^-\s*발표 연도:\s*(\d{4})년\s*$')
    $authorMatch = [regex]::Match($body, '(?m)^-\s*저자:\s*(.+?)\s*$')
    $year = if ($entry.Year) { $entry.Year } elseif ($yearMatch.Success) { [int]$yearMatch.Groups[1].Value } else { $null }
    $authors = if ($entry.Authors.Count -gt 0) { $entry.Authors } elseif ($authorMatch.Success) { @($authorMatch.Groups[1].Value.Trim()) } else { @() }

    $body = [regex]::Replace($body, '(?s)\A---\r?\n.*?\r?\n---\r?\n', '')
    $body = [regex]::Replace($body, '(?s)\A##?\s+주요 정보\s*\r?\n.*?(?:\r?\n-?\s*---\s*(?:\r?\n|$))', '')
    $body = [regex]::Replace($body, '(?m)^\s*-\s*tags:\s*#.*(?:\r?\n|$)', '')
    $body = [regex]::Replace($body, '(?m)^\s*(?:#[A-Za-z][A-Za-z0-9_-]*\s*,?\s*)+(?:\r?\n|$)', '')
    $body = $body.Trim()

    $aliases = @()
    if ($entry.NewName -ne $entry.Name) {
        $aliases += $entry.Name
    }

    $frontmatter = @('---', "type: $($entry.Type)", "title: $(Quote-Yaml $entry.Title)")
    if ($entry.Type -eq 'paper') {
        if (-not $year) {
            throw "Paper year missing: $($entry.Name)"
        }
        if ($authors.Count -eq 0) {
            throw "Paper authors missing: $($entry.Name)"
        }
        $frontmatter += 'authors:'
        foreach ($author in $authors) {
            $frontmatter += "  - $(Quote-Yaml $author)"
        }
        $frontmatter += "year: $year"
        $frontmatter += 'venue: ""'
        $frontmatter += 'url: ""'
        $frontmatter += 'pdf: ""'
        $status = if ([string]::IsNullOrWhiteSpace($body)) { 'to-read' } else { 'reading' }
        $frontmatter += "status: $status"
        $frontmatter += 'read_date: ""'
    }
    if ($aliases.Count -eq 0) {
        $frontmatter += 'aliases: []'
    } else {
        $frontmatter += 'aliases:'
        foreach ($alias in $aliases) {
            $frontmatter += "  - $(Quote-Yaml $alias)"
        }
    }
    $frontmatter += 'tags:'
    foreach ($tag in $entry.Tags) {
        $frontmatter += "  - $tag"
    }
    $frontmatter += @('---', '')

    $content = ($frontmatter -join [Environment]::NewLine)
    if (-not [string]::IsNullOrWhiteSpace($body)) {
        $content += $body + [Environment]::NewLine
    }
    [System.IO.File]::WriteAllText($source, $content, $Utf8NoBom)
    Move-Item -LiteralPath $source -Destination $target
    $finalPaths += $target
}

$LinkRenames = [ordered]@{
    'Attention is All You Need' = 'Attention Is All You Need'
    'BPR - Bayesian Personalized Ranking' = 'BPR - Bayesian Personalized Ranking from Implicit Feedback'
    'Singular Value Decompostion' = 'Singular Value Decomposition'
    'Positonal Encoding' = 'Positional Encoding'
    'bidirectional Language Model' = 'Bidirectional Language Model'
    'bidirectional RNN' = 'Bidirectional Recurrent Neural Network'
    'Recurrent Neural Networks' = 'Recurrent Neural Network'
}

foreach ($path in $finalPaths) {
    $content = [System.IO.File]::ReadAllText($path)
    $updated = $content
    foreach ($pair in $LinkRenames.GetEnumerator()) {
        $updated = $updated.Replace('[[' + $pair.Key, '[[' + $pair.Value)
    }
    if ($updated -cne $content) {
        [System.IO.File]::WriteAllText($path, $updated, $Utf8NoBom)
    }
}

Write-Output "Migrated $($Entries.Count) files."
$Entries | Group-Object Folder | Sort-Object Name | ForEach-Object {
    Write-Output ("{0}: {1}" -f $_.Name, $_.Count)
}
