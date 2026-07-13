---
type: concept
title: "ROUGE"
aliases: []
tags:
  - domain/nlp
  - task/summarization
  - theme/evaluation
---
# 정의

생성된 텍스트와 하나 이상의 참조(reference) 텍스트 사이의 n-gram, 단어 시퀀스 중첩 정도를 측정하는 자동 평가 지표 모음. 주로 텍스트 요약, 텍스트 생성 태스크의 평가에 사용된다.

# 왜 필요한가

# 작동 원리

## 계산 방식

ROUGE-N은 기본적으로 [[Recall]] 중심 지표로 시작되었으나, 현재는 [[Precision]]과 함께 계산한 [[F1 Score]] 형태로 보고하는 경우가 많다.
$$\text{Recall} = \dfrac{\text{일치하는 n-gram 수}}{\text{참조 텍스트의 전체 n-gram 수}}$$
$$\text{Precision} = \dfrac{\text{일치하는 n-gram 수}}{\text{생성 텍스트의 전체 n-gram 수}}$$

# 수식 / 알고리즘

# 특징과 한계

## 주요 변형

- ROUGE-N: 생성 텍스트와 참조 텍스트 사이 n-gram 중첩을 측정.
	e.g. ROUGE-1: unigram / ROUGE-2: bigram
- ROUGE-L: 생성 텍스트와 참조 텍스트 간 최장 공통 부분수열(Longest Common Subsequence)을 기반으로 측정. 어순을 고려하나 연속일 필요는 없음
- ROUGE-LSUM: ROUGE-L의 변형으로, 긴 텍스트(여러 문장으로 구성된 요약 등)를 문장 단위로 나누어 LCS를 계산한 뒤 합산. 긴 텍스트 평가에 더 적합하다.

## 한계

- 표면적 어휘 중첩만 측정하므로 의미는 같지만 단어 선택이 다른 문장(paraphrase)를 낮게 평가하는 경향이 있음
- 문법적 정합성이나 사실적 정확성을 직접 측정하지 못함
- 참조 텍스트의 품질과 다양성에 평가 결과가 크게 좌우됨

# 대표 변형

## 대표 변형 / 관련 기법

- [[BLEU Score]]: 기계번역 평가에서 주로 쓰이는 precision 중심 n-gram 지표. ROUGE와 자매격.
- METEOr: 동의어, 어간 매칭까지 고려해 ROUGE/BLEU의 한계를 일부 보완한 지표
- BERTScore: 사전 학습된 언어모델의 임베딩 기반 유사도로 표면적 어휘 중첩의 한계를 극복하려는 지표.
- MAUVE: 생성 텍스트 분포와 참조 텍스트 분포 자체를 비교하는 최신 평가 지표.

# 등장/대표 논문

# 관련 개념
