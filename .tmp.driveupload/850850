---
type: concept
title: "Adam"
aliases:
  - "Adaptive Moment Estimation"
tags:
  - domain/machine-learning
  - method/optimization
  - theme/training-stability
---

# 정의

Adam(Adaptive Moment Estimation)은 기울기의 1차 모멘트와 제곱 기울기의 2차 비중심 모멘트를 지수 이동 평균으로 추정해 파라미터마다 학습률을 조절하는 최적화 방법이다.

# 수식 / 알고리즘

\(m_t=\beta_1m_{t-1}+(1-\beta_1)g_t\), \(v_t=\beta_2v_{t-1}+(1-\beta_2)g_t^2\)를 계산하고 초기 0 편향을 보정한 뒤 \(\theta_t=\theta_{t-1}-\alpha\hat m_t/(\sqrt{\hat v_t}+\epsilon)\)로 갱신한다.

# 특징과 한계

- 희소하거나 스케일이 다른 기울기에서 안정적으로 시작하기 쉽다.
- 기본 하이퍼파라미터가 여러 과제에서 잘 작동하지만 최적은 아니다.
- 일반화 성능이 SGD보다 낮을 수 있고, weight decay를 올바르게 분리한 AdamW가 자주 사용된다.

# 관련 개념

- [[Stochastic Gradient Descent]]
- [[RMSProp]]
- [[AdaGrad]]

# 왜 필요한가

momentum의 안정적인 방향 추정과 RMSProp의 파라미터별 스케일 조정을 결합해 noisy·sparse gradient에서도 빠르게 학습하기 위해 사용한다.

# 작동 원리

1차 모멘트는 기울기의 방향을 평활화하고, 2차 모멘트는 큰 기울기의 갱신량을 줄인다. 초기 추정치가 0에 치우치는 문제는 bias correction으로 보정한다.

# 대표 변형

- AdamW: weight decay를 gradient regularization에서 분리한다.
- AMSGrad: 2차 모멘트의 최대값을 유지해 일부 수렴 문제를 보완한다.

# 등장/대표 논문

- Transformer와 [[Large Language Model]] 학습에서 AdamW 계열이 널리 사용된다.
