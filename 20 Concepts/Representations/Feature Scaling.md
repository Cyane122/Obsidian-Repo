---
type: concept
title: "Feature Scaling"
summary: "수치 특성의 범위나 단위를 조정하는 전처리다."
maturity: developing
last_reviewed: ""
aliases:
  - "특성 스케일링"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

수치 특성의 범위나 단위를 조정하는 전처리다.

# 왜 필요한가

거리나 기울기에 민감한 모델에서 큰 단위의 특성이 계산을 과도하게 지배하지 않도록 한다.

# 작동 원리

표준화는 훈련 평균을 빼고 표준편차로 나눈다. 최소-최대 변환은 훈련 범위를 지정 구간에 맞추고, 강건한 변환은 중앙값과 사분위 범위를 사용한다.

# 특징과 한계

변환에 필요한 통계량은 훈련 자료에서만 구해 검증·시험 자료에 동일하게 적용한다. 일반적인 나무 분할 모델에는 대체로 필수적이지 않다.

# 관련 개념

- [[K-Nearest Neighbors]]
- [[Machine Learning Pipeline]]
