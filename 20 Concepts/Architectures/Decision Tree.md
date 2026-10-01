---
type: concept
title: "Decision Tree"
summary: "특성에 대한 조건으로 데이터를 반복 분할하고 말단 노드에서 예측하는 모델이다."
maturity: developing
last_reviewed: ""
aliases:
  - "의사결정나무"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

특성에 대한 조건으로 데이터를 반복 분할하고 말단 노드에서 예측하는 모델이다.

# 왜 필요한가

사람이 따라갈 수 있는 규칙으로 분류와 회귀 예측을 만들 수 있다.

# 작동 원리

각 내부 노드에서 분할 조건을 고르고 데이터를 자식 노드로 보낸다. 분류에서는 지니 불순도나 엔트로피를, 회귀에서는 제곱오차를 줄이는 분할이 흔하다.

# 특징과 한계

나무가 깊어지면 훈련 데이터에 과적합하기 쉽다. 깊이와 잎의 최소 표본 수 등을 제한할 수 있지만, 탐욕적으로 고른 분할은 전체 최적 나무를 보장하지 않는다.

# 대표 변형

분류 나무는 범주를, 회귀 나무는 수치를 예측한다.

# 관련 개념

- [[Random Forest]]
- [[Gradient Boosting]]
- [[Overfitting]]

