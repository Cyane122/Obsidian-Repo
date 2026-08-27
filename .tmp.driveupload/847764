---
type: comparison
title: "CLIP과 BLIP-2 비교"
subjects:
  - "[[Learning Transferable Visual Models From Natural Language Supervision]]"
  - "[[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models]]"
sources:
  - "[[Learning Transferable Visual Models From Natural Language Supervision]]"
  - "[[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models]]"
tags:
  - domain/multimodal
  - task/representation-learning
  - theme/computational-efficiency
aliases: []
---

# 비교 목적

이미지와 언어를 연결하는 두 대표 접근을 학습 목표, 재사용하는 사전학습 모델, 지원 과제와 계산 효율 관점에서 비교한다.

# 비교 축

| 축 | CLIP | BLIP-2 |
|---|---|---|
| 핵심 목표 | 이미지-텍스트 공동 표현 학습 | 동결 vision encoder와 동결 LLM 연결 |
| 구조 | 이미지·텍스트 이중 인코더 | image encoder + Q-Former + LLM |
| 주요 학습 신호 | 대칭적 contrastive objective | 표현 정렬 3개 목표 + image-conditioned generation |
| 주된 출력 | 유사도, 검색, zero-shot 분류 | 생성, 질의응답, instruction-following |
| 사전학습 모델 활용 | 인코더를 대규모 데이터에서 직접 학습 | 강한 단일 모달 모델을 동결해 재사용 |
| 효율의 의미 | 임베딩 사전 계산과 빠른 유사도 검색 | 학습 가능한 파라미터 수 절감 |
| 한계 | prompt와 웹 데이터 분포에 민감 | 동결 모델의 편향·환각과 연결 병목을 상속 |

# 핵심 차이

CLIP은 같은 공간에서 가까운지를 학습하는 판별적 표현 모델이고, BLIP-2는 시각 정보를 LLM이 소비할 수 있는 토큰으로 바꾸는 생성적 연결 모델이다. 따라서 둘은 완전한 대체재가 아니다. 대규모 검색·분류에는 CLIP형 dual encoder가 효율적이고, 이미지에 관한 자연어 응답에는 BLIP-2형 연결이 적합하다.

# 비교 가능성의 한계

두 연구의 데이터, backbone, 모델 규모와 평가 과제가 크게 다르다. BLIP-2의 “적은 파라미터”는 전체 추론 모델이 작다는 뜻이 아니라 동결된 거대 모델 중 학습되는 부분이 적다는 뜻이다.

# 관련 문서

- [[비전-언어 사전학습]]
