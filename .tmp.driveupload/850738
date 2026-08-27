---
type: concept
title: "GPT"
aliases:
  - "Generative Pre-trained Transformer"
tags:
  - domain/nlp
  - task/language-modeling
  - method/large-language-model
---

# 정의

GPT(Generative Pre-trained Transformer)는 다음 토큰 예측으로 사전학습하는 decoder-only [[Transformer]] 계열이다. 이전 토큰만 볼 수 있는 causal attention으로 텍스트 확률 분포를 학습하고, 프롬프트에 이어질 텍스트를 자동회귀적으로 생성한다.

# 왜 필요한가

과제마다 별도 모델을 설계하는 대신 대규모 일반 텍스트에서 언어 지식을 먼저 학습한 뒤, fine-tuning이나 prompt만으로 여러 과제에 재사용하기 위해 등장했다.

# 작동 원리

토큰 열 (x_1,\ldots,x_T\)에 대해 \(\sum_t \log p(x_t\mid x_{<t})\)를 최대화한다. 추론 시에는 생성한 토큰을 다시 입력에 붙여 다음 토큰을 반복 예측한다.

# 특징과 한계

- 동일한 인터페이스로 생성, 요약, 질의응답, in-context learning을 수행할 수 있다.
- 출력은 학습 데이터와 프롬프트에 민감하며 사실성을 보장하지 않는다.
- 규모 확대는 능력을 높이지만 계산 비용, 데이터 출처, 편향, 개인정보 문제도 키운다.

# 대표 변형

- [[BERT]]: 양방향 encoder 중심의 이해 모델이다.
- [[Large Language Model]]: GPT를 포함하는 더 넓은 범주의 대규모 언어 모델이다.

# 관련 개념

- [[Prompt Engineering]]
- [[Zero-Shot Transfer]]
- [[Few-Shot Learning]]

# 수식 / 알고리즘

causal mask를 사용한 self-attention으로 미래 토큰을 보지 못하게 한다. 출력 logits에 softmax를 적용하고 [[Greedy Decoding]], sampling, [[Beam Search]] 중 하나로 다음 토큰을 선택한다.

# 등장/대표 논문

- GPT 계열은 decoder-only Transformer의 사전학습-전이 패러다임을 확장했다.
- [[Attention Is All You Need]]는 기반 Transformer 구조를 제시했다.
