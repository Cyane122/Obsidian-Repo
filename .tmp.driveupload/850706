---
type: concept
title: "Hard Sigmoid"
aliases: []
tags:
  - domain/machine-learning
  - method/activation-function
  - theme/computational-efficiency
---

# 정의

Hard Sigmoid는 [[Sigmoid]]를 구간별 선형 함수로 근사한 활성화 함수다. 구현마다 기울기와 절편은 다르지만, 중앙에서는 선형이고 양끝에서는 0과 1로 잘린다는 구조는 같다.

# 왜 필요한가

지수함수 계산을 없애 저전력·모바일 환경에서 sigmoid형 gate를 더 싸게 계산하기 위해 사용한다.

# 특징과 한계

- 계산이 빠르고 양자화하기 쉽다.
- 꺾이는 지점에서 미분이 매끄럽지 않고, 포화 구간의 기울기 소실은 남는다.
- 정확도와 하드웨어 효율 사이의 선택이므로 일반적인 은닉층에는 [[ReLU]] 계열이 더 흔하다.

# 관련 개념

- [[Sigmoid]]
- [[ReLU]]

# 작동 원리

중앙 구간에서는 입력의 선형 변환을 사용하고, 하한보다 작으면 0, 상한보다 크면 1로 clipping한다.

# 수식 / 알고리즘

대표 예시는 \(\operatorname{clip}(0.2x+0.5,0,1)\)이지만 프레임워크마다 계수가 다르므로 구현 정의를 확인해야 한다.

# 대표 변형

- Hard Swish: 입력에 hard sigmoid gate를 곱한다.
- [[Sigmoid]]: 부드러운 원래 함수다.

# 등장/대표 논문

- 모바일 신경망과 recurrent gate의 저비용 근사에서 사용된다.
