---
type: concept
title: "Determinant"
summary: "정사각행렬의 부호 있는 부피 확대율로, 행렬의 가역성도 판별한다."
maturity: developing
last_reviewed: ""
aliases:
  - "행렬식"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

행렬식(Determinant) $\det(A)$는 정사각행렬 $A$가 나타내는 선형변환의 부호 있는 부피 확대율이다. 값이 $0$이면 영이 아닌 방향 하나 이상이 붕괴된다.

# 왜 필요한가

정사각행렬의 역행렬 존재 여부를 판단하고, 변수변환 공식이나 다변량 확률밀도 계산에 사용한다.

# 작동 원리

두 행을 맞바꾸면 부호가 바뀌고, 한 행에 다른 행의 배수를 더해도 값은 변하지 않는다. 삼각행렬에서는 대각성분을 곱해 구할 수 있다.

# 수식 / 알고리즘

$A=\begin{pmatrix}a&b\\c&d\end{pmatrix}$이면 $\det(A)=ad-bc$다. 또한 $\det(AB)=\det(A)\det(B)$이며, $A$가 가역일 필요충분조건은 $\det(A)\neq0$이다.

# 특징과 한계

정사각행렬에만 정의된다. 크기가 작은 행렬식이라는 사실만으로 수치적 조건이 나쁘다고 판단할 수는 없다. 행렬의 전체 스케일도 함께 고려해야 한다.

# 대표 변형

- 양의 정부호 행렬에서는 로그행렬식(Log-determinant)을 계산해 확률모형의 계산을 안정화하는 경우가 많다.

# 관련 개념

- [[Linear Transformation]]
- [[Matrix Rank]]
- [[Eigenvalues and Eigenvectors]]
