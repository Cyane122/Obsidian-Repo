---
type: concept
title: "Unsupervised Learning"
summary: "정답 레이블이 없는 입력 자료에서 구조나 표현을 찾는 학습 방식이다."
maturity: developing
last_reviewed: ""
aliases:
  - "비지도학습"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

정답 레이블이 없는 입력 자료에서 구조나 표현을 찾는 학습 방식이다.

# 왜 필요한가

정답을 만들기 어렵거나 자료의 숨은 구조를 먼저 탐색해야 할 때 사용한다.

# 작동 원리

군집화는 유사한 사례를 묶고, 차원 축소는 낮은 차원의 표현을 만들며, 이상 탐지는 기준 분포에서 벗어난 사례를 찾는다.

# 특징과 한계

정답이 없으면 평가 기준도 과제에 맞게 정해야 한다. 계산된 군집이 실제 범주를 뜻한다고 단정할 수 없다.

# 관련 개념

- [[Principal Component Analysis]]
- [[t-Distributed Stochastic Neighbor Embedding|t-SNE]]
- [[K-Means]]
- [[Anomaly Detection]]
