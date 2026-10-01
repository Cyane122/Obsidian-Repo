---
type: concept
title: "Lasso Regression"
summary: "선형회귀 손실에 계수의 절댓값 합인 L1 벌점을 더한 모델이다."
maturity: developing
last_reviewed: ""
aliases:
  - "라쏘 회귀"
tags:
  - domain/machine-learning
  - method/regularization
---

# 정의

선형회귀 손실에 계수의 절댓값 합인 L1 벌점을 더한 모델이다.

# 왜 필요한가

계수 수축과 특성 선택을 동시에 수행해 모델을 단순화할 수 있다.

# 작동 원리

예측오차와 $\alpha\lVert w\rVert_1$을 함께 최소화한다. 벌점 때문에 일부 계수가 정확히 $0$이 되어 특성 선택 효과가 생길 수 있다.

# 특징과 한계

서로 강하게 상관된 특성 가운데 무엇이 선택되는지는 불안정할 수 있다. 스케일링과 벌점 강도는 검증 과정 안에서 결정해야 한다.

# 대표 변형

목적함수의 한 형태는 $\sum_i(y_i-\hat y_i)^2+\alpha\lVert w\rVert_1$이다. Elastic Net은 L1과 L2 벌점을 결합한다.

# 관련 개념

- [[Linear Regression]]
- [[Ridge Regression]]
- [[Feature Engineering]]
