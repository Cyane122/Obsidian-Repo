---
type: concept
title: "Text Clustering"
summary: "문서 간 유사성을 바탕으로 비슷한 텍스트를 의미 있는 그룹으로 묶는 unsupervised learning method."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 텍스트 군집화
  - Document Clustering
tags:
  - domain/nlp
  - task/representation-learning
  - task/text-mining
---

# 정의

Text Clustering은 비슷한 문서를 의미 있는 group으로 묶는 비지도 학습 방법이다. 정답 class가 주어진 [[Text Classification]]과 달리, 데이터 안의 유사성만으로 구조를 찾는다.

# 왜 필요한가

사전에 범주를 정하기 어려운 대량 문서를 탐색하고, 비슷한 자료를 묶어 새 범주나 자료의 흐름을 발견하는 데 쓴다.

# 작동 원리

문서를 [[Term Frequency–Inverse Document Frequency|TF-IDF]]나 [[Word Embedding]]으로 표현한 뒤, 거리나 유사도를 계산해 group을 만든다. K-Means는 미리 정한 $K$개의 군집으로 나누며, Hierarchical Clustering은 군집 사이의 포함 관계를 트리로 표현한다.

# 특징과 한계

- 군집은 정답이 아니라 분석자가 해석해야 하는 결과다.
- 군집 수, 거리 함수, 표현 방식이 바뀌면 결과도 달라질 수 있다.

# 관련 개념

- [[Text Classification]]
- [[Topic Modeling]]
