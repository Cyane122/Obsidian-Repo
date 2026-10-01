---
type: concept
title: "Matrix Rank"
summary: "행렬의 열공간 차원으로, 행렬이 보존하는 독립적인 방향의 수를 나타낸다."
maturity: developing
last_reviewed: ""
aliases:
  - "Rank"
  - "행렬의 계수"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

행렬 계수(Matrix Rank)는 행렬 열공간의 차원이다. 행공간의 차원 및 선형독립인 열 또는 행의 최대 개수와도 같다.

# 왜 필요한가

계수는 선형방정식의 해가 유일한지, 특성에 선형 중복이 있는지, 최소제곱 해의 계수가 유일한지를 판단하는 기준이다.

# 작동 원리

$A\in\mathbb{R}^{m\times n}$이 영벡터가 아닌 입력을 $0$으로 보내면 영공간이 존재하고 열이 선형종속이다. 계수-퇴화차수 정리는 입력 차원을 열공간과 영공간의 차원으로 나눈다.

# 수식 / 알고리즘

$\operatorname{rank}(A)+\dim\ker(A)=n$, $0\leq\operatorname{rank}(A)\leq\min(m,n)$.

# 특징과 한계

정확한 계수는 대수적 성질이다. 실수 계산에서 특이값이 $0$에 가까우면 어떤 허용 오차를 쓰는지에 따라 수치적 계수가 달라진다.

# 대표 변형

- 수치적 계수(Numerical Rank)는 정해진 허용 오차보다 큰 특이값의 수로 판단한다.

# 관련 개념

- [[Linear Independence and Basis]]
- [[Linear Transformation]]
- [[Least Squares]]
- [[Singular Value Decomposition]]
