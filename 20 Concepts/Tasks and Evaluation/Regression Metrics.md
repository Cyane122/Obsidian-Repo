---
type: concept
title: "Regression Metrics"
summary: "연속형 예측값과 실제값의 차이를 평가하는 지표들의 모음이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Regression Evaluation Metrics"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

연속형 예측값과 실제값의 차이를 평가하는 지표들의 모음이다.

# 왜 필요한가

어떤 종류의 예측오차가 중요한지에 맞춰 회귀모델을 비교하기 위해 사용한다.

# 작동 원리

MAE는 절댓값 오차 평균, MSE는 제곱오차 평균, RMSE는 MSE의 제곱근이다. MAPE는 상대오차를, $R^2$는 평균만 예측하는 기준과 비교한 제곱오차 감소를 나타낸다.

# 특징과 한계

MSE와 RMSE는 큰 오차에 민감하다. MAPE는 실제값이 $0$이거나 이에 가까우면 정의되지 않거나 불안정하다. 시험 자료의 $R^2$는 음수가 될 수 있다.

# 관련 개념

- [[Linear Regression]]
- [[Cross-Validation]]
