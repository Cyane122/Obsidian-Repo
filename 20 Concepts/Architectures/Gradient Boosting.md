---
type: concept
title: "Gradient Boosting"
summary: "이전 모델의 예측을 보완하는 약한 학습기를 순차적으로 더하는 앙상블 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Gradient Boosting Machine"
  - "GBM"
  - "그래디언트 부스팅"
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

이전 모델의 예측을 보완하는 약한 학습기를 순차적으로 더하는 앙상블 방법이다.

# 왜 필요한가

여러 단순 모델의 약점을 순차적으로 보완해 복잡한 예측 관계를 학습한다.

# 작동 원리

현재 예측에 대한 손실의 음의 기울기 방향을 새 학습기가 근사한다. 얕은 결정나무를 자주 사용하며 학습률로 각 추가분의 크기를 조절한다.

# 특징과 한계

학습기 수, 학습률, 나무 복잡도가 함께 성능과 과적합에 영향을 준다. 검증 데이터에 따른 조기 종료가 유용하다.

# 대표 변형

제곱오차 회귀에서는 새 학습기가 근사하는 목표가 잔차와 비례한다. XGBoost, LightGBM, CatBoost는 추가 설계가 다른 구현 계열이다.

# 관련 개념

- [[Decision Tree]]
- [[Random Forest]]
- [[Cross-Validation]]

