---
type: synthesis
title: "NLP 표현은 어떻게 문맥화되었는가"
scope: "Word2Vec·GloVe의 정적 단어 표현에서 ELMo와 BERT의 문맥적 사전학습으로 이어지는 변화"
sources:
  - "[[Efficient Estimation of Word Representations in Vector Space]]"
  - "[[Distributed Representations of Words and Phrases and their Compositionality]]"
  - "[[GloVe - Global Vectors for Word Representation]]"
  - "[[Deep Contextualized Word Representations]]"
  - "[[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]]"
tags:
  - domain/nlp
  - task/representation-learning
  - theme/generalization
aliases: []
---

# 핵심 결론

표현 학습의 핵심 변화는 통계의 범위를 local에서 global로 넓힌 것보다, 표현의 단위를 “단어 유형”에서 “문장 속 토큰 사용”으로 바꾼 데 있다. Word2Vec와 GloVe는 효율적인 정적 벡터를 만들었고, ELMo는 깊은 양방향 언어 모델의 층별 문맥을 feature로 제공했으며, BERT는 같은 사전학습 encoder 전체를 다양한 과제에 미세조정하는 방식을 정착시켰다.

# 합의되는 내용

- [[Efficient Estimation of Word Representations in Vector Space]]와 [[Distributed Representations of Words and Phrases and their Compositionality]]는 단순한 예측 목표와 샘플링으로 대규모 말뭉치의 의미·구문 규칙성을 효율적으로 학습할 수 있음을 보였다.
- [[GloVe - Global Vectors for Word Representation]]는 전역 동시발생 비율에도 선형 의미 관계를 만드는 정보가 있음을 명시했다.
- [[Deep Contextualized Word Representations]]와 [[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]]는 같은 단어도 문맥에 따라 다른 표현이 필요하다는 방향을 공통으로 지지한다.

# 조건에 따른 차이

ELMo는 biLSTM의 여러 층을 과제별 가중합으로 사용해 기존 모델의 입력 feature를 강화한다. BERT는 [[Transformer]] encoder 전체를 fine-tuning해 과제별 구조를 단순화한다. 정적 표현은 계산·저장 비용이 낮고 해석·검색이 단순하므로 제한된 환경에서는 여전히 실용적이다.

# 충돌과 근거의 한계

각 논문의 말뭉치 크기, 파라미터 수, 평가 과제가 달라 모델 방식만의 효과를 수치로 분리하기 어렵다. 문맥적 모델의 성능 향상에는 구조뿐 아니라 훨씬 큰 사전학습 데이터와 계산량도 함께 기여한다.

# 미해결 질문

- 필요한 문맥 길이와 모델 크기를 과제별로 어떻게 결정할 것인가?
- 정적 표현의 효율과 문맥적 표현의 적응성을 결합할 수 있는가?
- 사전학습 데이터의 편향과 암기가 downstream 표현에 어떻게 남는가?

# 다음 읽기 경로

- [[NLP 표현 학습의 흐름]]: 논문별 변화 순서를 따라간다.
- [[정적 단어 표현과 문맥적 표현 비교]]: 선택 기준을 표로 확인한다.
