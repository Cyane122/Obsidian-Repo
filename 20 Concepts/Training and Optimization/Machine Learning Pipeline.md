---
type: concept
title: "Machine Learning Pipeline"
summary: "학습되는 전처리 단계들과 최종 예측기를 하나의 작업 흐름으로 묶은 것이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Pipeline"
  - "ML Pipeline"
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

학습되는 전처리 단계들과 최종 예측기를 하나의 작업 흐름으로 묶은 것이다.

# 왜 필요한가

교차검증에서 스케일링이나 특성 선택을 훈련 부분마다 다시 학습해 정보 누출을 줄인다.

# 작동 원리

입력은 순서대로 변환 단계를 거쳐 최종 예측기에 전달된다. 검증할 때는 각 분할에서 전체 파이프라인을 새로 맞춘다.

# 특징과 한계

파이프라인에 들어오기 전에 이미 목표값을 이용해 만든 특성이나 잘못된 자료 분할에서 생긴 누출까지 막지는 못한다.

# 관련 개념

- [[Feature Scaling]]
- [[Feature Engineering]]
- [[Cross-Validation]]

