# Note templates

## Paper note

```markdown
---
type: paper
title: "Official Paper Title"
authors:
  - "First Author"
year: 2026
venue: ""
url: ""
pdf: ""
status: reading
read_date: ""
tags:
  - domain/nlp
  - task/language-modeling
  - method/transformer
aliases: []
---

# 한 줄 요약

이 논문이 무엇을 왜 바꾸었는지 한 문장으로 기술한다.

# Abstract

논문의 실제 섹션 순서에 맞춰 계속 작성한다.

# 핵심 기여

1. 기여와 그 근거를 함께 쓴다.
2. 기여와 그 근거를 함께 쓴다.

# 한계와 후속 질문

- 저자가 명시한 한계와 노트 작성자의 해석을 구분한다.
```

### Paper metadata rules

- `title`은 공식 제목과 정확히 일치시킨다.
- `authors`는 확인 가능한 저자 목록을 사용한다. 저자가 매우 많으면 본문 표시만 `First Author et al.`로 줄일 수 있지만 frontmatter에는 가능한 전체 목록을 둔다.
- `status`는 `to-read`, `reading`, `read`, `review-needed` 중 하나를 사용한다.
- `read_date`는 `read`로 바꿀 때 `YYYY-MM-DD` 형식으로 채운다. 아직 다 읽지 않았으면 빈 문자열로 둔다.
- `venue`, `url`을 확인하지 못하면 빈 문자열로 두고 추측하지 않는다.
- `pdf`는 `40 Sources/Papers/<분야>/`에 실제 파일이 있을 때만 vault-relative wikilink로 채운다.

## Generic concept note

```markdown
---
type: concept
title: "Full English Name"
aliases: []
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

독립적인 핵심 정의와 필요한 수식을 쓴다.

# 왜 필요한가

이 개념이 해결하는 문제와 필요한 이유를 쓴다.

# 작동 원리

단계별 동작뿐 아니라 각 설계가 필요한 이유를 설명한다.

# 수식 / 알고리즘

핵심 수식, 알고리즘, 계산 절차가 있으면 쓴다.

# 특징과 한계

- 장점, 한계, 대안의 맥락을 함께 쓴다.

# 대표 변형

- [[Related Concept]]: 관계를 한 문장으로 설명한다.

# 등장/대표 논문

- [[Representative Paper]]

# 관련 개념

- [[Related Concept]]
```

## Paper-origin concept note

```markdown
---
type: concept
title: "Full English Name"
aliases: []
tags:
  - domain/nlp
  - method/attention
---

# 정의

개념의 핵심 정의를 쓴다.

# 왜 필요한가

이 개념이 등장한 문제와 기존 접근의 한계를 쓴다.

# 작동 원리

구성 요소와 설계 이유를 설명한다.

# 수식 / 알고리즘

핵심 수식, 알고리즘, 계산 절차가 있으면 쓴다.

# 특징과 한계

- 비교 대상과 조건을 명시한다.

# 대표 변형

- [[Related Concept]]: 관계를 한 문장으로 설명한다.

# 등장/대표 논문

- [[Official Paper Title]]

# 관련 개념

- [[Related Concept]]
```

## Topic map

```markdown
---
type: map
title: "Topic Name"
tags:
  - domain/nlp
aliases: []
---

# 흐름 요약

분야의 변화 방향을 2~3문장으로 압축한다.

# 연구 흐름

1. [[Paper A]] (연도)
   - 해결한 문제:
   - 남긴 한계:
2. [[Paper B]] (연도)
   - 이전 연구에서 바꾼 점:
   - 남긴 한계:

# 핵심 개념

- [[Concept A]]
- [[Concept B]]
```

## Comparison note

```markdown
---
type: comparison
title: "Comparison Question or Subject"
subjects:
  - "[[Paper or Concept A]]"
  - "[[Paper or Concept B]]"
sources:
  - "[[Paper A]]"
  - "[[Paper B]]"
tags:
  - domain/nlp
  - theme/evaluation
aliases: []
---

# 비교 목적

무엇을 어떤 조건에서 판단하기 위한 비교인지 쓴다.

# 비교 축

| 축 | 대상 A | 대상 B |
|---|---|---|
| 문제 정의 |  |  |
| 핵심 가정 |  |  |
| 방법 |  |  |
| 데이터·평가 |  |  |
| 결과 |  |  |
| 한계 |  |  |

# 핵심 차이

비교표를 반복하지 말고 선택에 영향을 주는 차이를 설명한다.

# 비교 가능성의 한계

데이터셋, split, metric, 모델 규모, 학습 조건이 달라 직접 비교할 수 없는 부분을 쓴다.

# 관련 문서

- [[Related Map or Synthesis]]
```

## Synthesis note

```markdown
---
type: synthesis
title: "Reusable Synthesis Question"
scope: "다루는 범위와 제외 범위"
sources:
  - "[[Paper A]]"
  - "[[Paper B]]"
tags:
  - domain/nlp
  - theme/evaluation
aliases: []
---

# 핵심 결론

여러 출처를 함께 보아야 얻을 수 있는 결론을 2~4문장으로 쓴다.

# 합의되는 내용

서로 독립적인 출처가 공통으로 지지하는 내용을 근거와 함께 쓴다.

# 조건에 따른 차이

방법, 데이터, 가정, 평가 조건에 따라 달라지는 결론을 구분한다.

# 충돌과 근거의 한계

출처 간 모순, 불확실성, 직접 비교 불가능성을 숨기지 않는다.

# 미해결 질문

- 다음 자료나 실험으로 확인해야 할 질문

# 다음 읽기 경로

- [[Related Paper or Concept]]: 왜 다음에 읽어야 하는지 설명한다.
```

### Comparison and synthesis rules

- `subjects`는 직접 비교하는 대상만, `sources`는 판단 근거로 실제 사용한 문서만 넣는다.
- 출처 하나를 요약하는 문서는 synthesis가 아니라 paper 또는 concept로 둔다.
- 비교표의 빈칸을 추측으로 채우지 않는다. 확인하지 못한 값은 `확인되지 않음`으로 표시한다.
- synthesis 제목은 자료 이름의 나열보다 반복해서 물을 수 있는 주제나 질문을 사용한다.

## Formatting rules

- 본문은 한국어 문어체로 작성하되 기술 용어와 canonical wikilink는 English-first로 쓴다.
- 최상위 논문 섹션은 `#`, 그 안의 충분히 긴 하위 주제는 `##`를 사용한다.
- 한두 문장뿐인 하위 주제에는 제목을 만들지 말고 bullet을 사용한다.
- callout 제목과 내용은 반드시 서로 다른 줄에 둔다.
- 쉼표로 나열한 inline tag 줄을 만들지 말고 YAML `tags` 목록을 사용한다.
- comparison과 synthesis의 주요 주장에는 관련 `[[paper]]` 또는 `[[concept]]`가 추적 가능하게 연결되어야 한다.
