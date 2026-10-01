---
type: concept
title: "Isolation Forest"
summary: "무작위 분할 나무에서 데이터가 얼마나 빨리 고립되는지로 이상 정도를 평가하는 방법이다."
maturity: developing
last_reviewed: ""
aliases:
  - "iForest"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

무작위 분할 나무에서 데이터가 얼마나 빨리 고립되는지로 이상 정도를 평가하는 방법이다.

# 왜 필요한가

정상 자료와 뚜렷하게 다른 관측치를 라벨 없이 탐색할 수 있다.

# 작동 원리

부분표본으로 여러 나무를 만들고 특성과 분할값을 무작위로 선택한다. 평균 경로 길이가 짧은 점일수록 다른 점과 쉽게 분리되므로 이상 점수는 높아진다.

# 특징과 한계

특성 표현, 부분표본 크기, 판정 임계값에 따라 결과가 달라진다. 높은 이상 점수는 특이함을 뜻할 뿐 실제 오류나 중요한 사건임을 증명하지 않는다.

# 대표 변형

분할 나무의 평균 경로 길이를 점수로 바꾼 뒤 임계값을 적용해 이상 여부를 판정한다.

# 관련 개념

- [[Anomaly Detection]]
- [[Decision Tree]]

