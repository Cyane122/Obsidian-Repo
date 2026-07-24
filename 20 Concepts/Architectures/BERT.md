---
type: concept
title: "BERT"
aliases:
  - "Bidirectional Encoder Representations from Transformers"
tags:
  - domain/nlp
  - task/language-modeling
  - method/transformer
---

# 정의

BERT(Bidirectional Encoder Representations from Transformers)는 [[Transformer]] encoder를 양방향 문맥으로 사전학습한 언어 표현 모델이다. 입력 전체를 동시에 보며 토큰과 문장의 문맥 표현을 만든 뒤 과제별 데이터로 미세조정한다.

# 왜 필요한가

왼쪽 문맥만 읽는 언어 모델은 토큰의 오른쪽 정보를 사전학습에 사용할 수 없다. BERT는 입력 일부를 가리고 복원하는 Masked Language Modeling으로 이 제약을 우회해 분류, 질문응답, [[Named Entity Recognition]]에 공통으로 쓸 수 있는 표현을 학습한다.

# 작동 원리

- `[CLS]`는 문장 수준 예측에, 각 토큰의 출력은 토큰 수준 예측에 사용한다.
- 사전학습에서는 MLM과 Next Sentence Prediction을 함께 사용했다.
- 적용 단계에서는 작은 출력층을 추가하고 전체 모델을 end-to-end로 미세조정한다.

# 특징과 한계

- 양방향 문맥과 간단한 fine-tuning 인터페이스가 강점이다.
- self-attention 비용은 입력 길이의 제곱에 비례하고, `[MASK]`는 실제 입력과 사전학습 사이의 불일치를 만든다.
- encoder-only 구조이므로 자유로운 장문 생성보다 이해·표현 학습에 적합하다.

# 등장/대표 논문

- [[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]]
- [[KLUE - Korean Language Understanding Evaluation]]

# 관련 개념

- [[Transformer]]
- [[Language Model]]
- [[GPT]]

# 수식 / 알고리즘

MLM은 선택한 위치의 원래 토큰에 대한 cross-entropy를 최소화한다. 입력 전체를 보되 정답 토큰 자체는 가려 양방향 조건부 표현을 학습한다.

# 대표 변형

- RoBERTa: NSP를 제거하고 데이터·학습량과 masking 전략을 조정한다.
- DistilBERT: 지식 증류로 BERT를 더 작고 빠르게 만든다.
