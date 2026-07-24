---
type: concept
title: "ReLU"
aliases:
  - "Rectified Linear Unit"
tags:
  - domain/machine-learning
  - method/activation-function
  - method/neural-network
---

# 정의

ReLU(Rectified Linear Unit)는 \(f(x)=\max(0,x)\)로 정의되는 활성화 함수다.

# 왜 필요한가

[[Sigmoid]]와 [[Tanh]]는 입력 절댓값이 크면 기울기가 거의 0이 되어 깊은 신경망에서 [[Vanishing Gradient]]를 악화시킨다. ReLU의 양수 구간 기울기는 1이라 이 문제를 완화하고 계산도 단순하다.

# 특징과 한계

- 양수 영역에서 포화하지 않고 음수 출력을 0으로 만들어 희소 활성화를 만든다.
- 음수 영역에 오래 머문 뉴런은 기울기가 0이 되어 회복하지 못하는 dying ReLU 문제가 있다.
- Leaky ReLU, ELU, GELU 등은 음수 구간이나 부드러움을 조정한 변형이다.

# 관련 개념

- [[Sigmoid]]
- [[Tanh]]
- [[Hard Sigmoid]]

# 작동 원리

선형 변환의 음수 출력을 0으로 잘라 비선형성과 희소성을 만들고, 양수 출력은 그대로 다음 층에 전달한다.

# 수식 / 알고리즘

\(f(x)=\max(0,x)\)이며 도함수는 음수에서 0, 양수에서 1이다. \(x=0\)의 미분은 구현에서 관례적으로 한 값을 정한다.

# 대표 변형

- Leaky ReLU: 음수 구간에 작은 기울기를 둔다.
- GELU: 입력 크기에 따라 부드럽게 gate한다.

# 등장/대표 논문

- 깊은 feed-forward·convolutional network의 기본 활성화 함수로 널리 사용된다.
