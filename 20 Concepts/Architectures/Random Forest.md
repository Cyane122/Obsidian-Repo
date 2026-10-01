---
type: concept
title: "Random Forest"
summary: "서로 다른 자료와 분할 후보로 학습한 결정나무들의 예측을 결합하는 앙상블이다."
maturity: developing
last_reviewed: ""
aliases:
  - "랜덤 포레스트"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

서로 다른 자료와 분할 후보로 학습한 결정나무들의 예측을 결합하는 앙상블이다.

# 왜 필요한가

여러 나무의 예측을 합쳐 단일 나무의 높은 분산을 줄일 수 있다.

# 작동 원리

각 나무는 대체로 부트스트랩 표본으로 학습하고, 분할마다 특성 일부만 후보로 본다. 분류는 투표나 확률 평균, 회귀는 수치 평균을 사용한다.

# 특징과 한계

하나의 나무보다 계산량이 많고 전체 예측을 설명하기 어렵다. 특성 중요도는 방식에 따라 편향될 수 있으며 인과효과를 뜻하지 않는다.

# 대표 변형

분류 포레스트와 회귀 포레스트가 있다. 일반적인 축 정렬 나무는 특성 스케일링이 대체로 필요하지 않다.

# 관련 개념

- [[Decision Tree]]
- [[Gradient Boosting]]
- [[Ensemble Learning]]

