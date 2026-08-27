---
type: concept
title: "RMSProp"
aliases:
  - "RMSprop"
tags:
  - domain/machine-learning
  - method/optimization
  - theme/training-stability
---

# 정의

RMSProp은 최근 기울기 제곱의 지수 이동 평균으로 각 파라미터의 갱신량을 정규화하는 적응형 최적화 방법이다.

# 왜 필요한가

[[AdaGrad]]는 과거의 모든 기울기 제곱을 누적해 학습률이 단조롭게 감소한다. RMSProp은 오래된 기울기의 영향을 지수적으로 줄여 비정상적 목적함수에서도 학습을 계속할 수 있게 한다.

# 작동 원리

\(v_t=\rho v_{t-1}+(1-\rho)g_t^2\)를 유지하고 \(\theta_t=\theta_{t-1}-\alpha g_t/(\sqrt{v_t}+\epsilon)\)로 갱신한다.

# 특징과 한계

- RNN처럼 곡률과 기울기 크기가 크게 달라지는 학습에서 유용하다.
- 전역 학습률과 감쇠율 선택에 여전히 민감하다.
- momentum과 결합할 수 있으며, 1차 모멘트까지 함께 추적한 [[Adam]]과 밀접하다.

# 관련 개념

- [[AdaGrad]]
- [[AdaDelta]]
- [[Adam]]

# 수식 / 알고리즘

분모에 \(\sqrt{v_t}+\epsilon\)을 사용해 최근에 큰 기울기를 보인 파라미터의 step을 줄이고 작은 기울기의 step은 상대적으로 유지한다.

# 대표 변형

- Centered RMSProp: 기울기 평균까지 추적해 분산으로 정규화한다.
- RMSProp with momentum: 평활화된 갱신 방향을 함께 사용한다.

# 등장/대표 논문

- recurrent neural network 학습에서 널리 알려졌고 [[Adam]]의 2차 모멘트 구성과 직접 연결된다.
