---
type: concept
title: "Agglomerative Clustering"
summary: "가까운 군집을 반복해서 합치는 계층적 군집화 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Hierarchical Clustering"
  - "계층적 군집화"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

가까운 군집을 반복해서 합치는 계층적 군집화 방법이다.

# 왜 필요한가

군집 수를 미리 단정하지 않고 데이터가 합쳐지는 여러 수준을 살펴볼 수 있다.

# 작동 원리

처음에는 각 데이터가 하나의 군집이다. 연결 기준(linkage)에 따라 가장 가까운 두 군집을 합치고, 원하는 군집 수나 높이에 도달할 때 멈춘다.

# 특징과 한계

한번 합친 군집은 되돌리지 않는다. 거리 척도, 특성 스케일, 연결 기준에 따라 결과가 달라지며 덴드로그램 자체가 군집의 실제 의미를 보증하지 않는다.

# 대표 변형

단일 연결은 두 군집의 가장 가까운 점, 완전 연결은 가장 먼 점, 평균 연결은 점 쌍 거리의 평균을 사용한다. Ward 연결은 군집 내 분산 증가를 최소화한다.

# 관련 개념

- [[K-Means]]
- [[DBSCAN]]
- [[Feature Scaling]]

