---
type: concept
title: "t-Distributed Stochastic Neighbor Embedding"
summary: "고차원 자료의 가까운 이웃 관계를 낮은 차원에 표현하는 비선형 시각화 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "t-SNE"
tags:
  - domain/machine-learning
  - method/dimensionality-reduction
---

# 정의

고차원 자료의 가까운 이웃 관계를 낮은 차원에 표현하는 비선형 시각화 방법이다.

# 왜 필요한가

고차원 자료의 국소적인 이웃 구조를 2차원이나 3차원 그림으로 살펴볼 수 있다.

# 작동 원리

원래 공간과 그림 공간에서 점 쌍의 유사도를 확률분포로 만들고, 두 분포의 KL 발산을 줄이도록 좌표를 조정한다.

# 특징과 한계

그림에서 멀리 떨어진 군집 사이 거리, 군집 크기, 축 값은 일반적으로 해석하기 어렵다. 퍼플렉서티, 초기값, 스케일, 난수 상태에 따라 모양이 달라질 수 있다.

# 관련 개념

- [[Principal Component Analysis]]
- [[KL Divergence]]

