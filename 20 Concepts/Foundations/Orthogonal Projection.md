---
type: concept
title: "Orthogonal Projection"
summary: "주어진 벡터와 가장 가까운 부분공간의 벡터를 구하는 변환이다."
maturity: developing
last_reviewed: ""
aliases:
  - "직교투영"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

벡터 $x$의 부분공간 $W$로의 직교투영(Orthogonal Projection)은 $x-p$가 $W$의 모든 벡터와 직교하도록 하는 $p\in W$다. 이는 $W$에서 $x$에 가장 가까운 벡터이기도 하다.

# 왜 필요한가

최소제곱법은 관측 벡터를 모델의 열공간으로 투영하는 문제로 해석된다. [[Principal Component Analysis]]도 데이터를 선택한 저차원 부분공간으로 투영한다.

# 작동 원리

$W$의 정규직교기저를 열로 갖는 행렬 $Q$가 있으면 각 기저 방향의 성분을 모아 $QQ^\top x$를 구한다. 남은 오차는 $W$에 직교한다.

# 수식 / 알고리즘

$\operatorname{proj}_{u}(x)=\dfrac{u^\top x}{u^\top u}u$ ($u\neq0$). 정규직교기저 행렬 $Q$에 대해서는 $P=QQ^\top$, $P^2=P$이다.

# 특징과 한계

가장 가까운 벡터라는 설명은 선택한 내적이 정하는 거리에서 성립한다. 다른 내적을 쓰면 투영 결과도 달라질 수 있다.

# 대표 변형

- 직선으로의 투영은 1차원 사례이고, 여러 기저 벡터로의 투영은 고차원 부분공간으로 확장한 사례다.

# 관련 개념

- [[Vector Space]]
- [[Least Squares]]
- [[Principal Component Analysis]]
