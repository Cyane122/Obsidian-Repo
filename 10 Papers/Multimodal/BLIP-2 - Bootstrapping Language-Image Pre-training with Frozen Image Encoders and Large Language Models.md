---
type: paper
title: "BLIP-2: Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models"
authors:
  - "Junnan Li"
  - "Dongxu Li"
  - "Silvio Savarese"
  - "Steven Hoi"
year: 2023
venue: "ICML 2023"
url: "https://proceedings.mlr.press/v202/li23q.html"
pdf: ""
status: to-read
read_date: ""
tags:
  - domain/multimodal
  - method/transformer
  - method/large-language-model
  - theme/computational-efficiency
aliases:
  - "BLIP-2"
  - "Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models"
---

# 한 줄 요약

BLIP-2는 동결된 이미지 인코더와 동결된 대규모 언어 모델 사이에 가벼운 Q-Former만 학습해, 적은 학습 파라미터로 시각-언어 이해와 생성을 연결했다.

# 핵심 문제

대규모 비전-언어 모델을 처음부터 end-to-end로 학습하면 데이터와 계산 비용이 크다. 이미 강력한 단일 모달 모델이 존재하므로, 두 모델을 다시 학습하기보다 모달리티 사이의 간극만 효율적으로 연결하는 것이 목표다.

# Method

## Q-Former

학습 가능한 query token이 동결된 이미지 인코더의 시각 특징에서 필요한 정보만 추출한다. Q-Former는 두 단계에서 서로 다른 목적을 학습한다.

1. 표현 학습 단계: image-text contrastive learning, image-grounded text generation, image-text matching으로 시각 특징과 텍스트를 정렬한다.
2. 생성 연결 단계: Q-Former 출력을 동결된 [[Large Language Model]]의 입력 공간에 투영해 이미지 조건부 텍스트 생성을 학습한다.

# 핵심 결과

- 다양한 비전-언어 과제에서 당시 최고 수준의 성능을 보이면서 학습해야 하는 파라미터 수를 크게 줄였다.
- zero-shot VQAv2에서 Flamingo-80B보다 높은 성능을 54배 적은 학습 파라미터로 보고했다.
- 자연어 지시를 따르는 이미지-텍스트 생성 능력을 보였다.

# 한계와 후속 질문

- 동결된 이미지 인코더와 언어 모델의 편향·지식 오류를 그대로 물려받는다.
- 이미지와 텍스트의 정렬이 틀리면 그럴듯하지만 근거 없는 생성이 나타날 수 있다.
- Q-Former의 제한된 query가 세밀한 시각 정보나 복잡한 공간 관계를 충분히 보존하는지는 과제별 검증이 필요하다.

# 위키 연결

- 선행: [[Learning Transferable Visual Models From Natural Language Supervision|CLIP]], [[Contrastive Learning]]
- 핵심 개념: [[Large Language Model]], [[Transformer]], [[Zero-Shot Transfer]]
- 비교 문서: [[CLIP과 BLIP-2 비교]]
