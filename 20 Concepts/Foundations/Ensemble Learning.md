---
type: concept
title: "Ensemble Learning"
summary: "여러 모델의 예측을 결합해 하나의 예측을 만드는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Ensemble Method"
  - "앙상블"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

여러 모델의 예측을 결합해 하나의 예측을 만드는 방법이다.

# 왜 필요한가

서로 다른 모델의 오류가 완전히 겹치지 않으면 예측의 변동을 줄이거나 성능을 높일 수 있다.

# 작동 원리

분류에서는 투표 또는 확률 평균, 회귀에서는 수치 평균을 사용할 수 있다. 배깅은 재표본으로 학습한 모델을 결합하고, 부스팅은 현재 앙상블을 개선할 모델을 순차적으로 추가한다.

# 특징과 한계

구성 모델의 수만 늘린다고 항상 성능이 좋아지지는 않는다. 구성원의 다양성과 목표 환경에서의 유효성을 함께 확인해야 한다.

# 관련 개념

- [[Random Forest]]
- [[Gradient Boosting]]
