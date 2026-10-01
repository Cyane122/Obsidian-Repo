---
type: concept
title: "Feature Selection"
summary: "기존 입력 특성 가운데 일부를 골라 모델에 사용하는 과정이다."
maturity: developing
last_reviewed: ""
aliases:
  - "특성 선택"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

기존 입력 특성 가운데 일부를 골라 모델에 사용하는 과정이다.

# 왜 필요한가

불필요하거나 중복된 특성을 줄여 계산과 해석을 단순하게 만들 수 있다.

# 작동 원리

필터 방식은 모델 밖의 통계 기준으로 고르고, 래퍼 방식은 특성 집합의 검증 성능을 비교하며, 내장 방식은 모델 학습 과정에서 선택한다.

# 특징과 한계

선택을 전체 자료에 먼저 수행하면 검증 정보가 새어 성능을 과대평가한다. 반드시 교차검증의 각 훈련 부분 안에서 선택해야 한다.

# 관련 개념

- [[Feature Engineering]]
- [[Lasso Regression]]
- [[Machine Learning Pipeline]]
