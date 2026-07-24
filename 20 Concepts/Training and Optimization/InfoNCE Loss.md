---
type: concept
title: "InfoNCE Loss"
aliases:
  - "InfoNCE"
tags:
  - domain/machine-learning
  - method/contrastive-learning
  - method/information-theory
---

# 정의

InfoNCE Loss는 하나의 positive pair를 여러 negative 후보와 구분하도록 학습하는 대조 손실이다. 표현 간 유사도를 temperature로 나눈 뒤 softmax 분류 문제로 만든다.

# 수식 / 알고리즘

anchor (i\)의 positive가 (j\)일 때 손실은 보통 다음과 같다.

$$
-\log\frac{\exp(\operatorname{sim}(z_i,z_j)/\tau)}{\sum_k\exp(\operatorname{sim}(z_i,z_k)/\tau)}
$$

배치의 다른 샘플을 negative로 재사용하면 별도 음성 데이터 없이 효율적으로 학습할 수 있다.

# 특징과 한계

- positive는 가깝게, negative는 멀게 만들어 검색 가능한 표현 공간을 학습한다.
- 큰 batch나 좋은 negative가 성능에 중요하며 false negative는 의미가 비슷한 샘플을 잘못 밀어낸다.
- temperature는 분포의 날카로움과 기울기 크기를 함께 바꾼다.

# 등장/대표 논문

- [[Learning Transferable Visual Models From Natural Language Supervision]]

# 관련 개념

- [[Contrastive Learning]]
- [[Cosine Similarity]]
- [[Noise Contrastive Estimation]]

# 왜 필요한가

레이블이 적은 상황에서도 augmentation이나 paired modality에서 positive 관계를 이용해 구분 가능한 표현을 학습하기 위해 사용한다.

# 작동 원리

유사도 점수를 logits로 보고 올바른 positive의 class index를 맞히는 cross-entropy로 계산한다. 양방향 짝이 있는 경우 두 방향 loss를 평균한다.

# 대표 변형

- NT-Xent: 정규화된 표현과 temperature를 사용하는 대칭적 contrastive loss다.
- Supervised contrastive loss: 같은 클래스의 여러 표본을 positive로 둔다.
