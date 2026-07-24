---
type: paper
title: "BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding"
authors:
  - "Jacob Devlin"
  - "Ming-Wei Chang"
  - "Kenton Lee"
  - "Kristina Toutanova"
year: 2019
venue: "NAACL-HLT 2019"
url: "https://aclanthology.org/N19-1423/"
pdf: ""
status: to-read
read_date: ""
tags:
  - domain/nlp
  - task/language-modeling
  - method/transformer
  - theme/generalization
aliases:
  - "BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding"
---

# 한 줄 요약

BERT는 Transformer encoder를 Masked Language Modeling과 Next Sentence Prediction으로 사전학습하고, 작은 출력층만 더해 다양한 언어 이해 과제에 미세조정하는 방식을 확립했다.

# 핵심 문제

당시 사전학습 언어 모델은 왼쪽에서 오른쪽으로 읽는 단방향 구조가 많았다. 이 제약은 질문응답이나 개체명 인식처럼 토큰의 양쪽 문맥이 중요한 과제에서 표현력을 제한한다.

# Method

## Bidirectional Transformer encoder

[[Transformer]]의 encoder만 쌓아 모든 토큰이 양방향 문맥을 함께 보게 한다. BERT Base는 12개 층과 768차원 hidden state, BERT Large는 24개 층과 1024차원 hidden state를 사용한다.

## Pre-training objectives

- Masked Language Modeling: 입력 토큰 일부를 가리고 원래 토큰을 맞힌다. 양방향 문맥을 누출 없이 학습하기 위한 장치다.
- Next Sentence Prediction: 두 문장이 원문에서 연속하는지 구분해 문장 쌍 관계를 학습한다.

## Fine-tuning

사전학습된 모든 파라미터와 과제별 출력층을 함께 미세조정한다. 문장 분류는 `[CLS]` 표현을, 토큰 분류는 각 토큰 표현을 사용한다.

# 핵심 기여

1. 깊은 양방향 사전학습 표현을 단일 구조로 여러 NLP 과제에 전이했다.
2. 복잡한 과제별 아키텍처 대신 최소한의 출력층과 미세조정만으로 강한 성능을 보였다.
3. GLUE, MultiNLI, SQuAD 등 11개 과제에서 당시 최고 성능을 갱신했다.

# 한계와 후속 질문

- MLM은 실제 미세조정 입력에는 없는 `[MASK]` 토큰을 사용해 사전학습과 적용 사이 불일치를 만든다.
- 고정 길이 입력과 self-attention 비용 때문에 긴 문서 처리가 비싸다.
- 이후 연구는 NSP의 필요성, 더 효율적인 마스킹, 데이터·모델 규모의 효과를 재검토했다.

# 위키 연결

- 선행: [[Attention Is All You Need]], [[Deep Contextualized Word Representations]]
- 적용: [[KLUE - Korean Language Understanding Evaluation]], [[Korean named entity recognition based on language-specific features]]
- 핵심 개념: [[BERT]], [[Language Model]], [[Transformer]]
