---
type: concept
title: "Grid Search"
summary: "미리 지정한 초매개변수 값의 모든 조합을 평가하는 탐색 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Grid Search CV"
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

미리 지정한 초매개변수 값의 모든 조합을 평가하는 탐색 방법이다.

# 왜 필요한가

검토할 후보 범위가 작고 명확할 때 빠짐없이 비교할 수 있다.

# 작동 원리

각 조합을 교차검증으로 평가하고 평균 검증 점수가 좋은 조합을 선택한다. 선택된 작업 흐름은 독립된 시험 자료에서 다시 평가한다.

# 특징과 한계

지정하지 않은 값은 탐색하지 못한다. 계산량은 각 초매개변수의 후보 수를 곱한 만큼 증가하며, 전처리는 매 검증 분할 안에서 학습해야 한다.

# 관련 개념

- [[Cross-Validation]]
- [[Machine Learning Pipeline]]
- [[Automated Machine Learning]]

