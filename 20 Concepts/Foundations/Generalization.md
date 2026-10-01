---
type: concept
title: "Generalization"
summary: "훈련에 사용하지 않은 새로운 사례에서도 모델이 잘 작동하는 성질이다."
maturity: developing
last_reviewed: ""
aliases:
  - "일반화"
tags:
  - domain/machine-learning
  - theme/generalization
---

# 정의

훈련에 사용하지 않은 새로운 사례에서도 모델이 잘 작동하는 성질이다.

# 왜 필요한가

훈련 성능만으로 실제 사용 환경의 성능을 판단할 수 없기 때문이다.

# 작동 원리

훈련 자료로 매개변수를 학습하고 검증 자료로 모델이나 초매개변수를 선택한다. 최종 선택 뒤 별도의 시험 자료로 성능을 평가한다.

# 특징과 한계

검증 자료가 실제 사용 환경을 대표하지 못하면 일반화 추정도 빗나갈 수 있다. 과적합, 과소적합, 분포 이동을 구분해야 한다.

# 관련 개념

- [[Supervised Learning]]
- [[Overfitting]]
- [[Cross-Validation]]
