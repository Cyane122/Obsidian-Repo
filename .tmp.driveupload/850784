---
type: concept
title: "Matrix Factorization"
aliases:
  - "행렬분해"
tags:
  - domain/recommender-systems
  - task/recommendation
  - method/matrix-factorization
---

# 정의

추천 시스템의 Matrix Factorization은 사용자-항목 상호작용 행렬을 낮은 차원의 사용자 벡터와 항목 벡터의 곱으로 근사하는 방법이다. 예측 점수는 보통 \(\hat r_{ui}=p_u^\top q_i\)로 계산한다.

# 왜 필요한가

상호작용 행렬은 대부분 비어 있고 사용자와 항목의 수가 크다. 저차원 잠재 요인은 희소한 관측을 공유 구조로 압축해 관측하지 않은 항목의 선호를 일반화한다.

# 작동 원리

명시적 평점에서는 관측 오차를, [[Implicit Feedback]]에서는 confidence-weighted 오차나 항목 쌍의 순위 손실을 최소화한다. 정규화로 사용자·항목 벡터의 과도한 크기와 [[Overfitting]]을 제어한다.

# 특징과 한계

- 계산이 효율적이고 강한 추천 기준선이지만 사용자·항목의 부가 정보와 시간 변화를 기본형에서는 사용하지 않는다.
- 상호작용이 전혀 없는 cold-start 대상에는 잠재 벡터를 학습할 근거가 없다.
- 노출되지 않은 항목과 싫어한 항목을 구분하기 어렵다.

# 등장/대표 논문

- [[Collaborative Filtering for Implicit Feedback Datasets]]
- [[BPR - Bayesian Personalized Ranking from Implicit Feedback]]

# 관련 개념

- [[Implicit Feedback]]
- [[Singular Value Decomposition]]

# 수식 / 알고리즘

정규화된 squared loss 또는 pairwise loss를 최소화하며 사용자 벡터 \(p_u\)와 항목 벡터 \(q_i\)를 교대 또는 동시에 갱신한다.

# 대표 변형

- WR-MF: confidence-weighted implicit feedback를 ALS로 학습한다.
- BPR-MF: 항목 쌍의 상대 순위를 [[Stochastic Gradient Descent]]로 학습한다.
