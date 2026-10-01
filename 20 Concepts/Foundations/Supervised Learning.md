---
type: concept
title: "Supervised Learning"
summary: "입력과 정답이 짝지어진 자료로 예측 함수를 학습하는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "지도학습"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

입력과 정답이 짝지어진 자료로 예측 함수를 학습하는 방법이다.

# 왜 필요한가

새로운 입력의 범주나 수치를 예측하는 문제를 체계적으로 다룰 수 있다.

# 작동 원리

사례 $(x_i,y_i)$에서 입력 특성 $x_i$와 목표값 $y_i$의 관계를 학습한다. 범주를 예측하면 분류, 연속형 수치를 예측하면 회귀다.

# 특징과 한계

훈련 사례를 외우는 것만으로는 일반화가 되지 않는다. 학습 자료, 모델 선택용 검증 자료, 최종 평가용 시험 자료의 역할을 구분해야 한다.

# 관련 개념

- [[Generalization]]
- [[Cross-Validation]]
- [[Logistic Regression]]
- [[Multilayer Perceptron]]
