---
type: concept
title: "K-Nearest Neighbors"
summary: "새 입력과 가까운 $k$개 훈련 사례의 정답으로 예측하는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "KNN"
  - "k-NN"
  - "k-최근접 이웃"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

새 입력과 가까운 $k$개 훈련 사례의 정답으로 예측하는 방법이다.

# 왜 필요한가

복잡한 모형을 명시적으로 학습하지 않고도 주변 사례의 패턴으로 분류·회귀를 수행할 수 있다.

# 작동 원리

분류에서는 이웃의 다수결, 회귀에서는 평균을 사용하며 가까운 이웃에 더 큰 가중치를 줄 수도 있다. 거리 척도와 특성 스케일이 이웃의 순서를 결정한다.

# 특징과 한계

$k$가 너무 작으면 잡음에 민감하고 너무 크면 국소 패턴이 희석된다. 자료가 크면 예측 비용이 늘고 고차원에서는 거리의 구분력이 떨어질 수 있다.

# 관련 개념

- [[Feature Scaling]]
- [[Supervised Learning]]
