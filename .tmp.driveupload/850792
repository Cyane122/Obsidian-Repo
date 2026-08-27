---
type: concept
title: "Sequence Labeling"
aliases:
  - "Sequence Tagging"
  - "시퀀스 레이블링"
tags:
  - domain/nlp
  - task/text-classification
  - theme/evaluation
---

# 정의

Sequence Labeling은 입력 토큰 열의 각 위치에 품사·개체명·구문 경계 같은 레이블을 할당하는 구조화 예측 과제다.

# 왜 필요한가

각 토큰의 정답은 주변 문맥과 인접 레이블에 의존한다. 예를 들어 [[Named Entity Recognition]]에서 한 개체를 이루는 여러 토큰은 BIO/BIOES 규칙에 맞는 일관된 태그를 가져야 한다.

# 작동 원리

입력 표현은 RNN이나 [[Transformer]]가 문맥화하고, 출력은 독립 softmax 또는 [[Conditional Random Field]]가 예측한다. subword 모델에서는 원래 토큰과 subword 레이블의 정렬 규칙을 명시해야 한다.

# 평가

토큰 정확도보다 완전한 span과 유형이 모두 맞은 개체 단위 [[Precision]], [[Recall]], [[F1 Score]]가 흔히 사용된다.

# 특징과 한계

- annotation 단위와 태그 규칙이 달라지면 같은 모델의 수치도 직접 비교하기 어렵다.
- class imbalance와 boundary error가 평균 정확도에 가려질 수 있다.

# 등장/대표 논문

- [[Korean named entity recognition based on language-specific features]]
- [[KLUE - Korean Language Understanding Evaluation]]

# 수식 / 알고리즘

독립 분류는 위치별 cross-entropy를 합산한다. 구조화 모델은 전체 태그열 점수와 가능한 모든 태그열의 log-partition 차이를 최소화한다.

# 대표 변형

- Token classification: 각 위치를 독립 예측한다.
- BiLSTM-CRF 또는 Transformer-CRF: 문맥 encoder와 [[Conditional Random Field]]를 결합한다.

# 관련 개념

- [[Named Entity Recognition]]
- [[F1 Score]]
- [[Conditional Random Field]]
