---
type: concept
title: "Local Outlier Factor"
summary: "한 점의 국소 밀도를 이웃 점들의 국소 밀도와 비교하는 이상 점수다."
maturity: developing
last_reviewed: ""
aliases:
  - "LOF"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

한 점의 국소 밀도를 이웃 점들의 국소 밀도와 비교하는 이상 점수다.

# 왜 필요한가

전체 밀도보다 주변 이웃의 밀도를 기준으로 국소적인 이상치를 찾는다.

# 작동 원리

가까운 이웃과의 도달 가능 거리를 이용해 국소 도달 가능 밀도를 구한다. 이웃보다 상대적으로 밀도가 낮은 점에 큰 이상 계수를 부여한다.

# 특징과 한계

이웃 수, 거리 척도, 특성 스케일에 민감하다. 새 데이터에 점수를 매기는 방식은 학습 데이터 자체를 평가하는 방식과 구분해야 한다.

# 대표 변형

LOF가 약 $1$이면 주변과 비슷한 밀도이고 값이 클수록 주변보다 희박한 편이다.

# 관련 개념

- [[Anomaly Detection]]
- [[K-Nearest Neighbors]]

