---
type: concept
title: "DBSCAN"
summary: "밀도가 높은 영역을 연결해 군집을 만들고, 희박한 점은 잡음으로 표시하는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Density-Based Spatial Clustering of Applications with Noise"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

밀도가 높은 영역을 연결해 군집을 만들고, 희박한 점은 잡음으로 표시하는 방법이다.

# 왜 필요한가

군집 수를 미리 정하기 어렵거나 불규칙한 형태의 군집과 잡음을 함께 구분하고 싶을 때 유용하다.

# 작동 원리

반경 $\varepsilon$와 최소 점 개수로 핵심점을 정한다. 핵심점과 밀도로 연결된 점들을 같은 군집으로 확장한다.

# 특징과 한계

특성 스케일과 두 매개변수에 민감하다. 밀도가 크게 다른 군집을 하나의 설정으로 함께 찾기 어렵고, 기본 알고리즘에는 새 점의 군집을 바로 예측하는 규칙이 없다.

# 대표 변형

핵심점은 $\varepsilon$ 이웃에 충분한 점이 있는 점, 경계점은 핵심점에 가깝지만 자신은 핵심점이 아닌 점이다. 나머지는 잡음점이다.

# 관련 개념

- [[K-Means]]
- [[Agglomerative Clustering]]
- [[Feature Scaling]]

