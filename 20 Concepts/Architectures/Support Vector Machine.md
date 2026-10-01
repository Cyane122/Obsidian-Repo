---
type: concept
title: "Support Vector Machine"
summary: "분류 경계의 여백을 고려해 학습하는 모델로, 커널을 이용하면 비선형 경계도 만들 수 있다."
maturity: developing
last_reviewed: ""
aliases:
  - "SVM"
  - "서포트 벡터 머신"
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

분류 경계의 여백을 고려해 학습하는 모델로, 커널을 이용하면 비선형 경계도 만들 수 있다.

# 왜 필요한가

여백을 기준으로 분류 경계를 정하고 커널을 통해 비선형 관계도 다룰 수 있다.

# 작동 원리

소프트 마진 분류에서는 여백 폭과 훈련 위반 사이의 균형을 $C$로 조절한다. 커널은 특징 공간의 내적을 직접 좌표로 계산하지 않고 평가한다.

# 특징과 한계

커널 선택과 특성 스케일에 민감하며, 커널 SVM은 표본 수가 많아지면 계산비용이 커질 수 있다. 큰 여백만으로 확률 보정이나 배포 성능이 보장되지는 않는다.

# 대표 변형

서포트 벡터 회귀(SVR)는 예측값 주위의 $\varepsilon$ 무감각 구간을 사용하는 회귀 변형이다.

# 관련 개념

- [[Feature Scaling]]
- [[Generalization]]

