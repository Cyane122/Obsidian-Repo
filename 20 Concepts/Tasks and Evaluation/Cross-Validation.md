---
type: concept
title: "Cross-Validation"
summary: "여러 훈련·검증 분할에서 모델을 반복 학습하고 평가하는 절차다."
maturity: developing
last_reviewed: ""
aliases:
  - "CV"
  - "교차검증"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

여러 훈련·검증 분할에서 모델을 반복 학습하고 평가하는 절차다.

# 왜 필요한가

한 번의 분할에만 의존하지 않고 모델 선택과 성능 추정의 변동을 살펴볼 수 있다.

# 작동 원리

$k$겹 교차검증에서는 자료를 $k$개 부분으로 나누고 각 부분을 한 번씩 검증에 사용한다. 계층화 방식은 분류 비율을 비슷하게 유지한다.

# 특징과 한계

전처리와 특성 선택도 매 반복의 훈련 부분 안에서만 맞춰야 한다. 교차검증 자체가 학습된 모델을 개선하는 것은 아니며 최종 시험 자료가 별도로 필요할 수 있다.

# 관련 개념

- [[Generalization]]
- [[Machine Learning Pipeline]]
- [[Grid Search]]

