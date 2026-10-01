---
type: concept
title: "Linear Transformation"
summary: "벡터의 덧셈과 스칼라배를 보존하며, 기저를 정하면 행렬곱으로 표현되는 변환이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Linear Map"
  - "선형변환"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

선형변환(Linear Transformation) $T:V\to W$는 모든 $u,v\in V$와 스칼라 $c$에 대해 $T(u+v)=T(u)+T(v)$, $T(cu)=cT(u)$를 만족하는 함수다.

# 왜 필요한가

행렬곱, 투영, 많은 특성 변환을 같은 수학적 틀에서 다룰 수 있다. 변환이 선형인지 알면 계수나 고유값 같은 도구를 적용할 수 있다.

# 작동 원리

유한차원 공간에서 기저를 선택하면 선형변환은 행렬 $A$로 표현된다. 표준기저를 쓸 때 $A$의 각 열은 해당 기저 벡터가 변환된 결과다. 선형변환을 합성하면 행렬을 곱하게 된다.

# 수식 / 알고리즘

$T(x)=Ax$, $A=[T(e_1)\ \cdots\ T(e_n)]$.

# 특징과 한계

$b\neq0$인 $x\mapsto Ax+b$는 선형변환이 아니라 아핀변환이다. 신경망 층은 흔히 아핀변환과 비선형 활성화 함수를 결합한다.

# 대표 변형

- 직교변환은 내적과 길이를 보존하며, 행렬 $Q$가 $Q^\top Q=I$를 만족한다.

# 관련 개념

- [[Vector Space]]
- [[Matrix Rank]]
- [[Eigenvalues and Eigenvectors]]
- [[Orthogonal Projection]]
