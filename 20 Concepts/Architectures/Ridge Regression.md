---
type: concept
title: "Ridge Regression"
summary: "선형회귀 손실에 계수 제곱합인 L2 벌점을 더한 모델이다."
maturity: developing
last_reviewed: ""
aliases:
  - "릿지 회귀"
tags:
  - domain/machine-learning
  - method/regularization
---

# 정의

선형회귀 손실에 계수 제곱합인 L2 벌점을 더한 모델이다.

# 왜 필요한가

계수를 수축시켜 상관된 특성이 많을 때 예측을 안정화할 수 있다.

# 작동 원리

예측오차와 $\alpha\lVert w\rVert_2^2$을 함께 최소화해 계수를 수축한다. 절편은 보통 벌점에서 제외한다.

# 특징과 한계

Lasso와 달리 보통 계수를 정확히 $0$으로 만들지는 않는다. 벌점이 지나치게 크면 필요한 신호까지 줄어들 수 있으므로 검증으로 정해야 한다.

# 대표 변형

목적함수의 한 형태는 $\sum_i(y_i-\hat y_i)^2+\alpha\lVert w\rVert_2^2$이다.

# 관련 개념

- [[Linear Regression]]
- [[Lasso Regression]]
- [[Overfitting]]
