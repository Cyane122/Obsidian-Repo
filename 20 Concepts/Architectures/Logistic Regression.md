---
type: concept
title: "Logistic Regression"
summary: "특성의 선형 점수를 확률로 변환하는 분류 모델이다."
maturity: developing
last_reviewed: ""
aliases:
  - "로지스틱 회귀"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

특성의 선형 점수를 확률로 변환하는 분류 모델이다.

# 왜 필요한가

분류 점수를 확률 형태로 표현하고 임계값에 따라 최종 결정을 조절할 수 있다.

# 작동 원리

이진분류에서는 $z=w^\top x+b$를 계산한 뒤 시그모이드 함수로 $P(y=1\mid x)$를 구한다. 보통 이진 교차엔트로피를 줄여 학습한다.

# 특징과 한계

이름과 달리 회귀가 아닌 분류에 사용한다. 임계값을 바꾸면 정밀도와 재현율이 달라진다. 출력 확률의 보정 상태는 별도로 확인해야 한다.

# 대표 변형

다중분류에는 일대다 분류기나 Softmax를 쓰는 다항 로지스틱 회귀가 있다.

# 관련 개념

- [[Sigmoid]]
- [[Softmax]]
- [[Confusion Matrix]]
