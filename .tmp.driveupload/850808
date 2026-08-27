---
type: concept
title: "Perplexity"
aliases:
  - "PPL"
  - "퍼플렉서티"
tags:
  - domain/nlp
  - task/language-modeling
  - theme/evaluation
---

# 정의

Perplexity(PPL)는 언어 모델이 정답 토큰 열에 부여한 평균 음의 로그우도를 지수화한 값이다.

$$
\operatorname{PPL}(x_{1:T})=\exp\left(-\frac{1}{T}\sum_{t=1}^T\log p(x_t\mid x_{<t})\right)
$$

값이 낮을수록 평가 텍스트를 덜 놀랍게 여긴다는 뜻이다.

# 왜 필요한가

생성 결과를 매번 샘플링하지 않고도 [[Language Model]]의 확률 예측 품질을 계산할 수 있다. 텍스트 재작성에서는 문법적 자연스러움의 자동 대리 지표로도 사용된다.

# 특징과 한계

- tokenizer, vocabulary, 데이터 전처리가 다르면 모델 간 수치를 직접 비교할 수 없다.
- 낮은 perplexity가 사실성, 의미 보존, 다양성, 인간 선호를 보장하지 않는다.
- bidirectional masked LM에는 같은 정의를 바로 적용할 수 없어 pseudo-perplexity 같은 변형이 필요하다.

# 등장/대표 논문

- [[Zero-Shot Privacy-Aware Text Rewriting via Iterative Tree Search]]

# 관련 개념

- [[Cross-Entropy]]
- [[Large Language Model]]

# 작동 원리

정답 토큰마다 모델이 준 조건부 확률을 모아 token 평균 cross-entropy를 계산하고 지수화한다. 문장 길이가 달라도 토큰당 난이도로 비교하기 위한 정규화다.

# 수식 / 알고리즘

긴 문서는 모델의 context window에 맞춰 sliding window로 평가하되, 중복 토큰의 조건과 loss 집계 방식을 명시해야 한다.

# 대표 변형

- Bits per character/byte: tokenizer 차이를 줄이기 위한 문자·바이트 단위 지표다.
- Pseudo-perplexity: masked LM에서 토큰을 하나씩 가려 근사한다.
