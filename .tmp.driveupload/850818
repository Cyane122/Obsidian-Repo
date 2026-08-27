---
type: concept
title: "Natural Language Inference"
aliases: []
tags:
  - domain/nlp
  - task/natural-language-inference
---
# 정의

전제와 가설 문장이 주어졌을 때, 전제가 가설을 의미적으로 함의(entail)하는지, 모순(contradict)되는지, 무관(neutral)한지를 분류하는 태스크.

# 왜 필요한가

# 작동 원리

## 세 가지 레이블

- Entailment: 전제가 참이면 가설도 반드시 참
- Contradiction: 전제가 참이면 가설은 반드시 거짓
- Neutral: 전제만으로는 가설의 참/거짓을 판단할 수 없음

## 입출력 형태

- 입력: 문장 쌍 (premise, hypothesis)
- 출력: 3-class 분류 결과 (entailment / contradiction / neutral)
- 일반적으로 사전 학습된 언어 모델을 NLI 데이터셋으로 fine-tuning하여 구성한다.

# 수식 / 알고리즘

# 특징과 한계

# 대표 변형

## 대표 변형 / 관련 기법

- MNLI (Multi-Genre NLI): 다양한 장르의 텍스트로 구성된 대표적 NLI 학습 코퍼스
- SNLI (Stanford NLI): 이미지 캡션 기반의 초기 대형 NLI 데이터셋
- Zero-shot classification으로의 응용: NLI 모델을 `이 텍스트는 [레이블]에 관한 것이다`라는 가설과의 entailment 관계로 변환해, 별도 fine-tuning 없이 임의의 분류 태스크에 활용하는 기법
- Cross-lingual NLI (XNLI): 다국어로 확장된 NLI 벤치마크

# 등장/대표 논문

# 관련 개념
