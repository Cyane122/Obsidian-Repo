---
type: concept
title: "Feature Engineering"
summary: "모델이 사용할 입력 특성을 만들거나 변환하는 과정이다."
maturity: developing
last_reviewed: ""
aliases:
  - "특성 공학"
tags:
  - domain/machine-learning
  - task/representation-learning
---

# 정의

모델이 사용할 입력 특성을 만들거나 변환하는 과정이다.

# 왜 필요한가

같은 모델이라도 입력 표현에 따라 학습할 수 있는 관계가 달라지기 때문이다.

# 작동 원리

범주형 값을 인코딩하고, 수치형 값을 구간화하거나, 다항식·상호작용 특성을 만들 수 있다. 기존 특성을 고르는 특성 선택과 새 표현을 만드는 특성 추출도 포함된다.

# 특징과 한계

자료에서 학습하는 전처리는 검증 단계의 각 훈련 부분에서만 맞춰야 정보 누출을 피할 수 있다. 새 특성의 효과는 실제 검증으로 확인해야 한다.

# 관련 개념

- [[One-hot Encoding]]
- [[Principal Component Analysis]]
- [[Feature Selection]]
- [[Machine Learning Pipeline]]
