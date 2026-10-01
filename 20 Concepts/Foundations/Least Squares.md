---
type: concept
title: "Least Squares"
summary: "관측값과 선형모델 예측값 사이의 잔차 제곱합을 최소화하는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Ordinary Least Squares"
  - "최소제곱법"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

최소제곱법(Least Squares)은 $A\in\mathbb{R}^{m\times n}$와 관측 벡터 $b\in\mathbb{R}^{m}$에 대해 $\|Ax-b\|_2^2$를 최소화하는 계수 벡터 $\hat x$를 찾는다.

# 왜 필요한가

실제 관측값은 오차 때문에 하나의 선형방정식 $Ax=b$를 정확히 만족하지 않을 수 있다. 최소제곱법은 전체 오차를 기준으로 가장 잘 맞는 계수를 정하며, 일반적인 [[Linear Regression]]의 바탕이 된다.

# 작동 원리

최적해에서는 잔차 $b-A\hat x$가 $A$의 열공간에 직교한다. 따라서 정규방정식 $A^\top A\hat x=A^\top b$가 성립한다. $A$가 열 전체 계수이면 계수 벡터가 유일하다.

# 수식 / 알고리즘

$\hat x\in\arg\min_x\|Ax-b\|_2^2$. 열 전체 계수라면 $\hat x=(A^\top A)^{-1}A^\top b$다. 실제 수치 계산에서는 역행렬을 직접 구하기보다 QR 분해나 SVD를 쓰는 편이 안정적이다.

# 특징과 한계

- 큰 잔차를 제곱하므로 이상치에 민감하다.
- $A$의 열이 종속이면 계수는 여럿일 수 있지만 투영된 예측값은 유일하다.

# 대표 변형

- 가중 최소제곱법은 관측값마다 다른 가중치를 준다.
- [[Ridge Regression]]은 계수에 벌점을 추가해 해를 안정화한다.

# 관련 개념

- [[Orthogonal Projection]]
- [[Matrix Rank]]
- [[Linear Regression]]
- [[Singular Value Decomposition]]
