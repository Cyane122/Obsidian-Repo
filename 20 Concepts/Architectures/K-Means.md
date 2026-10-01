---
type: concept
title: "K-Means"
summary: "각 점을 가장 가까운 중심에 할당하고 중심을 다시 계산하는 과정을 반복하는 군집화 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "K-means Clustering"
  - "k-평균 군집화"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

각 점을 가장 가까운 중심에 할당하고 중심을 다시 계산하는 과정을 반복하는 군집화 방법이다.

# 왜 필요한가

자료를 지정한 수의 군집으로 나누고 각 군집의 대표 중심을 얻는다.

# 작동 원리

$k$개의 중심을 정한 뒤 점을 최근접 중심에 할당하고, 각 군집의 평균으로 중심을 갱신한다. 군집 내 제곱거리 합이 더 줄지 않을 때 멈춘다.

# 특징과 한계

$k$, 초기값, 특성 스케일, 이상치에 민감하다. 제곱거리 목적함수는 대체로 조밀하고 볼록한 모양의 군집에 잘 맞는다.

# 대표 변형

여러 초기값을 시도해 국소해의 영향을 줄인다. 관성(inertia)이 낮다는 사실만으로 군집이 실제로 의미 있다고 결론 내릴 수는 없다.

# 관련 개념

- [[Unsupervised Learning]]
- [[Feature Scaling]]
- [[Silhouette Score]]

