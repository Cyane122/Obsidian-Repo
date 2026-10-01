---
type: concept
title: "Automated Machine Learning"
summary: "전처리·모델·초매개변수 후보를 자동 탐색하는 절차다."
maturity: developing
last_reviewed: ""
aliases:
  - "AutoML"
tags:
  - domain/machine-learning
  - method/optimization
---

# 정의

전처리·모델·초매개변수 후보를 자동 탐색하는 절차다.

# 왜 필요한가

여러 모델링 조합을 제한된 시간과 자원 안에서 체계적으로 비교할 수 있다.

# 작동 원리

탐색 공간, 후보를 고르는 전략, 검증 지표를 정한 뒤 각 조합을 평가한다. 탐색 결과에서 선택한 전체 작업 흐름을 별도 자료로 최종 평가한다.

# 특징과 한계

자동화가 목표 변수, 자료의 출처, 허용 가능한 오류를 대신 정해 주지는 않는다. 정보 누출이나 잘못된 지표가 있으면 탐색 자체가 잘못된 흐름을 선택할 수 있다.

# 관련 개념

- [[Grid Search]]
- [[Machine Learning Pipeline]]

