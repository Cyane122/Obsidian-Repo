---
type: concept
title: "Large Language Model"
aliases:
  - "LLM"
  - "대규모 언어 모델"
tags:
  - domain/nlp
  - task/language-modeling
  - method/large-language-model
---

# 정의

Large Language Model(LLM)은 대규모 텍스트와 많은 파라미터로 일반적인 언어 패턴과 지식을 사전학습한 [[Language Model]]이다. 크기만으로 경계를 정하기보다, 하나의 기반 모델이 다양한 과제에 전이되는 운용 방식까지 포함해 이해하는 편이 유용하다.

# 왜 필요한가

과제별 레이블과 모델을 매번 새로 만드는 비용을 줄이고, 자연어 지시만으로 생성·분류·추론·도구 사용을 통합하기 위해 사용한다.

# 작동 원리

대부분 [[Transformer]]를 기반으로 다음 토큰 예측 또는 마스킹 복원으로 사전학습한다. 이후 instruction tuning, preference optimization, retrieval, tool use 등을 더해 사용자 의도와 외부 정보에 맞춘다.

# 특징과 한계

- zero-shot과 few-shot 전이가 가능하지만 능력은 모델·데이터·프롬프트에 따라 크게 달라진다.
- 생성 확률은 사실의 참·거짓과 같지 않아 환각과 과신이 발생한다.
- 학습 데이터의 편향, 저작권, 개인정보와 높은 계산·에너지 비용을 함께 검토해야 한다.

# 등장/대표 논문

- [[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]]
- [[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models]]
- [[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization]]

# 관련 개념

- [[GPT]]
- [[Prompt Engineering]]
- [[Perplexity]]

# 수식 / 알고리즘

자동회귀 모델은 말뭉치의 \(-\sum_t\log p(x_t\mid x_{<t})\)를 최소화한다. 실제 시스템은 tokenization, pre-training, alignment, inference decoding의 연속된 파이프라인으로 운용된다.

# 대표 변형

- [[GPT]]: decoder-only 생성 모델 계열이다.
- [[BERT]]: encoder-only 문맥 표현 모델 계열이다.
- encoder-decoder LLM: 입력 이해와 조건부 생성을 분리한다.
