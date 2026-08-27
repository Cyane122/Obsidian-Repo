---
type: map
title: "NLP 표현 학습의 흐름"
tags:
  - domain/nlp
  - task/representation-learning
  - theme/generalization
aliases: []
---

# 흐름 요약

NLP 표현 학습은 단어마다 하나의 벡터를 학습하는 정적 표현에서, 문장 안의 사용 맥락에 따라 표현을 바꾸는 문맥적 사전학습으로 이동했다. 계산 효율과 전역 통계 활용을 둘러싼 Word2Vec·GloVe의 선택은 ELMo의 깊은 양방향 언어 모델을 거쳐 BERT의 범용 fine-tuning 방식으로 이어졌다.

# 연구 흐름

1. [[Efficient Estimation of Word Representations in Vector Space]] (2013)
   - CBOW와 Skip-gram으로 대규모 말뭉치에서 효율적인 [[Word Embedding]] 학습을 제시했다.
   - 단어마다 문맥과 무관한 하나의 벡터만 가진다.
2. [[Distributed Representations of Words and Phrases and their Compositionality]] (2013)
   - [[Negative Sampling]], 빈도 높은 단어의 subsampling, phrase 학습으로 Skip-gram을 확장했다.
   - local context window에 의존한다.
3. [[GloVe - Global Vectors for Word Representation]] (2014)
   - 전역 동시발생 비율을 weighted least squares로 학습해 local prediction과 matrix method를 연결했다.
   - 여전히 polysemy를 하나의 벡터에 섞는다.
4. [[Deep Contextualized Word Representations]] (2018)
   - 깊은 bidirectional LM의 여러 층을 과제별로 조합하는 ELMo를 제시했다.
   - downstream 모델에 feature로 붙이는 방식이라 과제별 구조가 남는다.
5. [[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]] (2019)
   - 양방향 Transformer encoder를 사전학습하고 전체 모델을 미세조정하는 공통 인터페이스를 확립했다.

# 핵심 비교

- [[정적 단어 표현과 문맥적 표현 비교]]
- [[NLP 표현은 어떻게 문맥화되었는가]]

# 핵심 개념

- [[Word2Vec]]
- [[GloVe - Global Vectors for Word Representation|GloVe]]
- [[Bidirectional Language Model]]
- [[BERT]]
- [[Transformer]]
