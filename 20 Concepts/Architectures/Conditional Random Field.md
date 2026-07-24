---
type: concept
title: "Conditional Random Field"
aliases:
  - "CRF"
  - "조건부 무작위장"
tags:
  - domain/nlp
  - task/text-classification
  - method/optimization
---

# 정의

Conditional Random Field(CRF)는 관측 입력이 주어졌을 때 구조화된 출력 전체의 조건부 확률을 모델링하는 판별 모델이다. NLP에서는 인접 태그 사이의 의존성을 반영하는 linear-chain CRF가 [[Sequence Labeling]]에 널리 쓰인다.

# 왜 필요한가

토큰을 각각 독립 분류하면 `I-PER`가 `B-PER` 없이 나타나는 것처럼 불가능하거나 어색한 태그열을 만들 수 있다. CRF는 방출 점수와 태그 전이 점수를 함께 최적화해 문장 전체에서 일관된 출력을 고른다.

# 수식 / 알고리즘

입력 (x\)와 태그열 (y\)의 점수 \(s(x,y)\)를 정의하고 \(p(y\mid x)=\exp s(x,y)/\sum_{y'}\exp s(x,y')\)로 정규화한다. 학습은 로그우도를 최대화하고, 추론은 Viterbi 알고리즘으로 최고 점수 태그열을 찾는다.

# 특징과 한계

- 출력 제약과 국소 의존성을 명시적으로 반영한다.
- 가능한 태그 쌍이 늘면 계산량이 커지고, linear-chain 구조는 장거리 출력 의존성을 제한적으로 표현한다.

# 등장/대표 논문

- [[GloVe - Global Vectors for Word Representation]]
- [[Korean named entity recognition based on language-specific features]]

# 관련 개념

- [[Named Entity Recognition]]
- [[Sequence Labeling]]

# 작동 원리

encoder가 만든 위치별 방출 점수에 이전 태그에서 현재 태그로 이동하는 전이 점수를 더한다. forward algorithm으로 모든 태그열의 정규화 상수를 계산하고, 추론에서는 동적 계획법으로 최고 점수 경로를 복원한다.

# 대표 변형

- Linear-chain CRF: 인접 태그 의존성을 모델링하는 표준 형태다.
- Neural CRF: 방출 점수를 BiLSTM이나 [[Transformer]]가 계산한다.
