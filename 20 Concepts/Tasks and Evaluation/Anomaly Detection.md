---
type: concept
title: "Anomaly Detection"
summary: "기준이 되는 자료 패턴에서 벗어난 사례에 점수를 매기거나 이를 찾아내는 과제다."
maturity: developing
last_reviewed: ""
aliases:
  - "Outlier Detection"
  - "이상 탐지"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

기준이 되는 자료 패턴에서 벗어난 사례에 점수를 매기거나 이를 찾아내는 과제다.

# 왜 필요한가

오류, 사기, 고장 등 드물지만 중요한 사례를 탐색할 수 있다.

# 작동 원리

밀도, 거리, 경계, 고립 경로 길이, 재구성 오차 등을 이상 점수로 사용한다. 점수에 임계값을 적용해야 실제 판정이 된다.

# 특징과 한계

특이한 점이 반드시 오류나 중요한 사건은 아니다. 기존 자료 속 이상점을 찾는 외란 탐지와 정상 자료로 학습한 뒤 새 사례를 평가하는 신규성 탐지를 구분해야 한다.

# 관련 개념

- [[Isolation Forest]]
- [[Local Outlier Factor]]

