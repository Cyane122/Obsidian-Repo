---
type: concept
title: "Linear Regression"
summary: "특성의 가중합으로 연속형 목표값을 예측하는 회귀 모델이다."
maturity: developing
last_reviewed: ""
aliases:
  - "선형회귀"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

특성의 가중합으로 연속형 목표값을 예측하는 회귀 모델이다.

# 왜 필요한가

연속형 값을 예측하는 기준 모델이며 특성과 예측값의 관계를 살펴보기 쉽다.

# 작동 원리

예측값을 $\hat y=w^\top x+b$로 계산한다. 보통 최소제곱법으로 훈련 자료의 잔차 제곱합을 줄여 계수를 추정한다.

# 특징과 한계

여기서 선형은 원래 입력이 아니라 계수에 대한 선형성을 뜻한다. 다항식 특성을 넣을 수 있지만, 특성 간 상관이 강하면 개별 계수가 불안정해질 수 있다. 예측 적합도가 인과관계를 증명하지는 않는다.

# 대표 변형

Ridge Regression은 L2 벌점을, Lasso Regression은 L1 벌점을 더한다.

# 관련 개념

- [[Ridge Regression]]
- [[Lasso Regression]]
- [[Regression Metrics]]
- [[Generalization]]
