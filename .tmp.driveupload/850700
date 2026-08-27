---
type: concept
title: "Cosine Similarity"
aliases:
  - "코사인 유사도"
tags:
  - domain/machine-learning
  - task/representation-learning
  - method/information-theory
---

# 정의

Cosine Similarity는 두 벡터의 방향이 얼마나 가까운지를 측정한다.

$$
\operatorname{cos}(a,b)=\frac{a^\top b}{\lVert a\rVert_2\lVert b\rVert_2}
$$

# 왜 필요한가

벡터의 크기보다 방향이 의미를 나타내는 [[Word Embedding]]과 멀티모달 표현에서 문서·단어·이미지-텍스트 사이의 유사도를 비교하기 좋다.

# 특징과 한계

- 양수 스케일 변화에 불변이며 정규화된 벡터에서는 내적과 같다.
- 벡터의 크기에 담긴 정보는 무시한다.
- 고차원 표현의 분포가 비등방적이면 서로 무관한 벡터도 높은 유사도를 보일 수 있다.

# 등장/대표 논문

- [[Learning Transferable Visual Models From Natural Language Supervision]]
- [[GloVe - Global Vectors for Word Representation]]

# 관련 개념

- [[Contrastive Learning]]
- [[Word Embedding]]

# 작동 원리

두 벡터를 L2 정규화한 뒤 내적한다. 같은 방향이면 1, 직교하면 0, 반대 방향이면 -1에 가깝다.

# 수식 / 알고리즘

0 벡터에서는 분모가 0이 되므로 구현에서 epsilon을 더하거나 별도로 처리한다. 대규모 검색은 정규화된 벡터의 maximum inner-product search로 바꿀 수 있다.

# 대표 변형

- Cosine distance: 보통 \(1-\operatorname{cos}(a,b)\)로 정의한다.
- Temperature-scaled cosine similarity: [[InfoNCE Loss]]에서 logit 크기를 조절한다.
