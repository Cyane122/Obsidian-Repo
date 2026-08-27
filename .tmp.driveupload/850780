---
type: concept
title: "Principal Component Analysis"
aliases:
  - "PCA"
  - "주성분분석"
tags:
  - domain/machine-learning
  - method/dimensionality-reduction
  - task/representation-learning
---

# 정의

Principal Component Analysis(PCA)는 데이터 분산을 가장 많이 설명하는 서로 직교한 축을 찾아 저차원으로 투영하는 선형 차원 축소 방법이다.

# 작동 원리

데이터를 중심화한 뒤 공분산 행렬의 고유벡터를 분산이 큰 순서로 선택한다. 수치적으로는 중심화한 데이터 행렬에 [[Singular Value Decomposition]]를 적용해 같은 축을 구할 수 있다.

# 특징과 한계

- 계산과 해석이 비교적 단순하고 시각화·노이즈 제거·압축에 유용하다.
- 선형 구조만 표현하며, 분산이 큰 방향이 반드시 과제에 중요한 방향은 아니다.
- 입력 스케일에 민감하므로 변수의 단위가 다르면 표준화가 필요하다.

# 등장/대표 논문

- [[Sequence to Sequence Learning with Neural Networks]]
- [[GloVe - Global Vectors for Word Representation]]

# 관련 개념

- [[Singular Value Decomposition]]
- [[Hellinger PCA]]

# 왜 필요한가

고차원 데이터의 주요 변동 방향을 적은 축으로 요약해 시각화, 압축, 노이즈 제거와 후속 모델의 계산 절감을 돕는다.

# 수식 / 알고리즘

중심화된 행렬 \(X\)의 SVD \(X=U\Sigma V^\top\)에서 앞쪽 열의 \(V\)를 주성분 축으로 사용하고 \(XV_k\)로 투영한다.

# 대표 변형

- Kernel PCA: kernel을 통해 비선형 구조를 표현한다.
- [[Hellinger PCA]]: 확률형 동시발생 벡터에 Hellinger 변환을 먼저 적용한다.
