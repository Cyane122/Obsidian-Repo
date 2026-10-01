---
type: concept
title: "One-hot Encoding"
summary: "범주마다 한 위치만 1인 벡터로 표현하는 방식으로, 범주형 특성과 단어 인코딩에 사용된다."
maturity: "developing"
last_reviewed: ""
aliases: []
tags:
  - domain/machine-learning
  - task/representation-learning
---
# 정의

원-핫 인코딩(One-hot Encoding)은 범주마다 지시 변수 하나를 두고, 관측된 범주에 해당하는 위치만 1로 표시한다. 표 형식 자료의 범주형 특성과 어휘의 단어 모두에 적용할 수 있다.

단어를 어휘 크기 $|V|$의 벡터로 표현하되, 해당 단어의 인덱스에만 1, 나머지는 모두 0으로 표현하는 방식.
예를 들어 어휘가 `V = {cat, dog, bird}`일 때,
- `cat = [1, 0, 0]`
- `dog = [0, 1, 0]`
- `bird = [0, 0, 1]`

# 왜 필요한가

# 작동 원리

# 수식 / 알고리즘

# 특징과 한계

## 핵심 특징

- 희소성(Sparse): 벡터의 단 하나의 차원만 활성화됨
- 고차원성: 어휘 크기 $|V|$만큼의 차원이 필요함 (보통 수만~수십만)
- 의미 부재: 두 벡터 사이의 내적이 항상 0이므로, 단어 사이의 유사도를 표현할 수 없음
- 독립성 가정: 모든 단어를 서로 무관한 원자 단위로 취급

## 한계

- 어휘가 커질수록 벡터 차원이 선형으로 증가한다.
- 단어 사이의 의미 관계를 전혀 포착하지 못한다.
- [[Distributed Representation]]으로 대체되는 주요 동기가 됨

# 대표 변형

# 등장/대표 논문

## 등장 논문

- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - one-hot의 한계를 극복하기 위한 동기로 언급

# 관련 개념

- [[Distributed Representation]]
- [[Word Embedding]]
