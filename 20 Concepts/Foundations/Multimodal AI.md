---
type: concept
title: "Multimodal AI"
summary: "이미지, 텍스트, 음성, 영상, 센서 등 여러 modality를 표현하고 정렬해 결합·추론하는 AI 시스템의 접근."
maturity: developing
last_reviewed: 2026-09-09
aliases:
  - 멀티모달 AI
  - Multimodal Learning
tags:
  - domain/multimodal
  - task/representation-learning
---

# 정의

Multimodal AI는 이미지, 텍스트, 음성, 영상, 센서처럼 서로 다른 modality에서 온 정보를 처리하고, 표현하고, 연결하고, 함께 추론하는 AI 시스템의 접근이다. 여러 단일 modality 모델을 단순히 나열하는 것과 달리, modality 사이의 의미적·시간적 대응과 상호작용을 학습하는 데 초점이 있다.

# 왜 필요한가

현실의 사건은 보통 하나의 신호만으로 충분히 관찰되지 않는다. 서로 다른 modality는 같은 사건의 보완적 정보, 확인을 위한 중복 정보, 모호성을 푸는 맥락 정보를 제공한다. 반면 조명, 소음, 가림, 센서 결함처럼 하나의 입력이 실패할 가능성도 있어, 입력 품질과 결측을 고려한 결합이 필요하다.

# 작동 원리

1. 각 modality를 전용 encoder로 embedding으로 변환한다.
2. 서로 다른 embedding에서 같은 객체·사건·시점에 해당하는 요소를 Alignment한다.
3. Early, Intermediate, Late Fusion 중 과제에 맞는 방식으로 정보를 결합한다.
4. 결합된 표현을 이용해 검색, 분류, 질의응답, 감지, 제어 같은 과제를 수행한다.

Representation은 각 modality의 정보를 계산 가능한 형태로 만드는 단계이고, Alignment는 modality 사이에서 무엇이 대응하는지를 학습하는 단계이며, Fusion은 대응 관계를 바탕으로 어떤 정보를 어떻게 합칠지를 결정하는 단계다.

# 수식 / 알고리즘

Image-text retrieval 같은 과제에서는 image encoder와 text encoder가 만든 embedding의 유사도를 높이도록 학습한다. [[Contrastive Learning]]은 실제로 대응하는 image-text 쌍을 가깝게, 대응하지 않는 쌍을 멀게 두는 대표적인 Alignment 방법이다. [[Learning Transferable Visual Models From Natural Language Supervision|CLIP]]은 이 방식을 활용해 공동 표현 공간을 학습했다.

# 특징과 한계

- modality는 구조와 시간 해상도, 노이즈 특성이 달라 원시 데이터를 바로 비교할 수 없다.
- Intermediate Fusion은 modality별 특성을 보존하면서 깊은 상호작용을 만들 수 있지만, 계산 비용이 커질 수 있다.
- Late Fusion은 결측 입력에 비교적 견고하지만 세밀한 cross-modal 관계를 놓칠 수 있다.
- 잘못된 Alignment, 편향된 학습 자료, 낮은 입력 품질은 여러 modality를 결합해도 해결되지 않으며 오히려 오류를 강화할 수 있다.

# 대표 변형

- [[Learning Transferable Visual Models From Natural Language Supervision|CLIP]]: image-text 쌍을 대조 학습으로 정렬해 zero-shot 분류와 검색에 활용한다.
- [[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models|BLIP-2]]: 동결한 vision encoder와 Large Language Model 사이를 Q-Former로 연결해 생성 과제를 지원한다.

# 등장/대표 논문

- [[Learning Transferable Visual Models From Natural Language Supervision]]
- [[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models]]

# 관련 개념

- [[Word Embedding]]
- [[Contrastive Learning]]
- [[Transformer]]
- [[비전-언어 사전학습]]
