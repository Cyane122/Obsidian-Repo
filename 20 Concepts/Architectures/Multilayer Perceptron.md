---
type: concept
title: "Multilayer Perceptron"
summary: "여러 은닉층에서 아핀변환과 비선형 활성화를 합성하는 순전파 신경망이다."
maturity: developing
last_reviewed: ""
aliases:
  - "MLP"
  - "다층 퍼셉트론"
tags:
  - domain/machine-learning
  - method/neural-network
---

# 정의

여러 은닉층에서 아핀변환과 비선형 활성화를 합성하는 순전파 신경망이다.

# 왜 필요한가

여러 층과 비선형 함수를 합쳐 선형모델로는 표현하기 어려운 관계를 학습한다.

# 작동 원리

입력이 은닉층을 통과하며 $h^{(l)}=\phi(W^{(l)}h^{(l-1)}+b^{(l)})$로 변환된다. 출력층은 과제에 맞춰 회귀값 또는 분류 점수를 만든다.

# 특징과 한계

비선형 활성이 없다면 여러 선형층은 하나의 선형변환으로 합쳐진다. 폭과 깊이를 늘리면 표현력과 함께 계산비용 및 과적합 위험도 커진다.

# 대표 변형

출력층은 일반 회귀에 선형 출력, 이진분류에 Sigmoid, 다중분류에 Softmax를 사용할 수 있다.

# 관련 개념

- [[Deep Neural Networks]]
- [[ReLU]]
- [[Cross-Entropy]]

