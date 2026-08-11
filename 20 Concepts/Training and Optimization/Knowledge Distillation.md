---
type: concept
title: "Knowledge Distillation"
aliases:
  - "KD"
  - "지식 증류"
tags:
  - domain/machine-learning
  - method/neural-network
  - theme/computational-efficiency
  - theme/generalization
---

# 정의

Knowledge Distillation(KD)은 크고 성능이 높은 teacher model의 예측 분포·생성 결과·중간 표현을 더 작은 student model에 supervision으로 전달하는 model compression 및 transfer 방법이다. 정답 label만 학습하는 대신 teacher가 표현하는 class/token 사이의 상대적 가능성, 즉 soft targets를 활용하는 것이 고전적 핵심이다.

# 왜 필요한가

- 큰 모델의 latency, memory, energy cost를 낮추면서 utility를 유지한다.
- Label 하나가 담지 못하는 teacher의 uncertainty와 대안 간 구조를 student에 전달한다.
- 같은 크기의 독립 학습보다 generalization을 개선하는 regularizer로 작동할 수 있다.
- Teacher logit에 접근할 수 없는 환경에서는 teacher-generated sequence를 학습 데이터로 사용할 수 있다.

# 작동 원리

## Soft 또는 logit-level distillation

Teacher와 student의 temperature-scaled output distribution을 맞춘다. Teacher distribution을 기준으로 한 forward [[KL Divergence|KL]]가 대표적이다.

$$
\mathcal L_{KD}=T^2D_{KL}\left(p_T^{(T)}\,\|\,p_S^{(T)}\right)
$$

Temperature $T>1$은 distribution을 평평하게 만들어 정답 이외 token의 상대적 확률을 드러낸다. 실제 학습에서는 hard-label [[Cross-Entropy]]와 KD loss를 가중합하기도 한다.

## Hard 또는 sequence-level distillation

Teacher가 생성한 sequence를 one-hot target으로 보고 student를 cross-entropy로 학습한다. Logit을 받을 수 없는 API 환경에 적용하기 쉽지만 teacher uncertainty를 잃고 teacher-specific output을 그대로 고정할 수 있다.

## Intermediate-feature distillation

Output뿐 아니라 hidden state, attention map, representation을 맞춘다. Teacher와 student의 layer 수·차원이 다르면 projection이나 layer mapping이 필요하다.

# 수식 / 알고리즘

1. Teacher를 고정한다.
2. Distillation input $x$에 대해 teacher distribution $p_T(y\mid x)$ 또는 teacher-generated target을 얻는다.
3. Student distribution $p_S(y\mid x)$를 계산한다.
4. KL, reverse KL, Jensen–Shannon, cross-entropy, representation matching 중 선택한 objective를 최소화한다.
5. 같은 크기의 non-distilled baseline과 utility·calibration·memorization·cost를 함께 비교한다.

Forward KL은 teacher가 확률을 둔 여러 mode를 폭넓게 cover하도록 압력을 주고, reverse KL은 student가 teacher의 높은-probability mode에 집중하는 경향이 있다. Autoregressive generation에서는 teacher forcing과 student-generated context 사이의 distribution shift 때문에 on-policy KD가 사용되기도 한다.

# 특징과 한계

- Student capacity가 너무 작으면 teacher distribution을 충분히 근사하지 못한다.
- Teacher의 bias, 오류, private information, unsafe behavior도 전달될 수 있다.
- High temperature는 richer soft target을 주지만 지나치면 signal이 약해질 수 있다.
- Hard KD는 간단하지만 teacher uncertainty와 calibration 정보를 버린다.
- 서로 다른 tokenizer나 vocabulary를 쓰면 token-level logit matching이 어렵다.
- KD 자체는 [[Differential Privacy]] guarantee가 아니다. Empirical memorization 감소와 formal privacy를 구분해야 한다.

[[Memorization Dynamics in Knowledge Distillation for Language Models]]은 soft KD가 동일 크기의 표준 fine-tuning baseline보다 exact training-data memorization을 크게 줄일 수 있음을 보인다. 다만 hard KD는 총 memorization rate가 같아도 teacher-specific example inheritance가 더 많을 수 있다.

# 대표 변형

- Soft/logit distillation: full teacher distribution을 직접 맞춘다.
- Sequence-level KD: teacher-generated sequence를 hard target으로 학습한다.
- Reverse-KL distillation: mode-seeking 성질로 student의 teacher distribution 과잉 근사를 줄인다.
- On-policy distillation: student가 생성한 context에서 teacher feedback을 받아 exposure bias를 줄인다.
- Rationale distillation: final answer와 함께 chain-of-thought 또는 explanation을 전달한다.
- Feature distillation: hidden representation이나 attention을 맞춘다.

# 등장/대표 논문

- Hinton et al. (2015), *Distilling the Knowledge in a Neural Network*: temperature-scaled soft target을 정립한 대표 논문
- Kim and Rush (2016), *Sequence-Level Knowledge Distillation*: sequence generation을 위한 hard KD
- [[Memorization Dynamics in Knowledge Distillation for Language Models]]: LLM KD의 memorization·privacy dynamics 분석

# 관련 개념

- [[KL Divergence]]
- [[Cross-Entropy]]
- [[Softmax]]
- [[Perplexity]]
- [[Overfitting]]
- [[Large Language Model]]
- [[Differential Privacy]]

