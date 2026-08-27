---
type: concept
title: "Greedy Decoding"
aliases:
  - "Greedy Search"
tags:
  - domain/nlp
  - method/encoder-decoder
  - method/sampling
---

# 정의

Greedy Decoding은 각 생성 단계에서 현재 확률이 가장 높은 토큰 하나를 즉시 선택하는 디코딩 방법이다.

# 작동 원리

각 시점 (t\)에서 \(y_t=\arg\max_y p(y\mid y_{<t},x)\)를 선택하고 종료 토큰이 나오거나 길이 제한에 도달할 때까지 반복한다.

# 특징과 한계

- 후보 하나만 유지하므로 빠르고 결정적이다.
- 초기에 내린 선택을 되돌릴 수 없어 전체 문장 확률이 더 높은 경로를 놓칠 수 있다.
- 번역처럼 출력 구조가 복잡한 과제에서는 여러 후보를 유지하는 [[Beam Search]]가 흔히 사용된다.

# 등장/대표 논문

- [[Sequence to Sequence Learning with Neural Networks]]

# 관련 개념

- [[Beam Search]]
- [[Encoder-Decoder]]

# 왜 필요한가

후보 탐색 비용을 최소화하면서 모델의 가장 선호하는 국소 선택으로 빠르게 출력 하나를 얻기 위해 사용한다.

# 수식 / 알고리즘

각 단계의 argmax 한 개만 다음 상태로 전달하므로 시간 복잡도는 출력 길이와 vocabulary scoring 비용에 비례하고 별도의 후보 메모리가 거의 필요하지 않다.

# 대표 변형

- [[Beam Search]]: 상위 \(B\)개 부분 가설을 유지한다.
- sampling: 확률 분포에서 토큰을 뽑아 다양한 출력을 만든다.
