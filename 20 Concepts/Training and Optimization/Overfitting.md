---
type: concept
title: "Overfitting"
aliases:
  - "과적합"
tags:
  - domain/machine-learning
  - method/regularization
  - theme/generalization
---

# 정의

Overfitting은 모델이 학습 데이터의 일반적 패턴뿐 아니라 우연한 잡음까지 학습해, 학습 성능은 높지만 새로운 데이터 성능이 나빠지는 상태다.

# 원인과 진단

모델 용량에 비해 데이터가 적거나, 데이터 누수·분포 편향·지나친 반복 학습이 있을 때 발생하기 쉽다. 학습 손실은 계속 줄지만 검증 손실이 증가하는 간극이 대표 신호다.

# 완화 방법

- 독립된 validation/test split과 교차검증으로 일반화 오차를 추정한다.
- [[Dropout]], weight decay, data augmentation, early stopping으로 유효 용량을 제어한다.
- 더 많은 대표 데이터와 단순한 모델을 사용하고, 하이퍼파라미터 선택에 test set을 쓰지 않는다.

# 특징과 한계

과적합은 단순히 모델이 큰 상태가 아니라 목표 분포에서 일반화하지 못하는 관계적 현상이다. 분포 이동이 있으면 validation 성능이 좋아도 실제 배포에서 실패할 수 있다.

# 관련 개념

- [[Dropout]]
- generalization
- [[Matrix Factorization]]

# 왜 필요한가

학습 점수만으로 모델을 선택하면 새 데이터에서 실패할 수 있으므로, 일반화 오차와 데이터 누수를 명시적으로 관리해야 한다.

# 작동 원리

모델 용량이 데이터의 안정적 신호보다 커지면 경험 위험을 낮추면서 표본 특유의 변동까지 흡수한다. regularization과 독립 검증은 이 자유도를 제한하거나 실패를 조기에 감지한다.

# 수식 / 알고리즘

일반화 간극은 대략 training risk와 validation/test risk의 차이로 관찰한다. 단일 split의 우연성을 줄이려면 교차검증과 신뢰구간을 함께 사용한다.

# 대표 변형

- Data overfitting: 데이터셋 특유의 artifact에 맞춘다.
- Hyperparameter overfitting: validation set을 반복 사용해 그 split에 맞춘다.

# 등장/대표 논문

- [[Dropout]]은 representation co-adaptation을 줄이는 대표 regularization 방법이다.
