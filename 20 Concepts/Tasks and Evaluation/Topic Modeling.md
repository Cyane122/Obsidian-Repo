---
type: concept
title: "Topic Modeling"
summary: "대량 문서에서 단어의 공출현 패턴을 이용해 잠재적인 주제 구조를 찾는 unsupervised learning method."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 토픽 모델링
  - Topic Model
tags:
  - domain/nlp
  - task/representation-learning
  - task/text-mining
---

# 정의

Topic Modeling은 대량 문서에서 단어가 함께 나타나는 패턴을 바탕으로 잠재적인 주제 구조를 찾는 비지도 학습 방법이다. 문서가 어떤 주제를 얼마나 담는지와, 주제가 어떤 단어로 드러나는지를 함께 추정한다.

# 왜 필요한가

미리 정한 범주가 없는 문서 집합을 탐색하고, 시간에 따른 주제 변화나 문서 집단의 관심사를 살피는 데 유용하다.

# 작동 원리

Latent Dirichlet Allocation(LDA)은 문서 하나를 여러 topic의 혼합으로, topic 하나를 여러 단어의 분포로 본다. 결과로 document-topic matrix와 topic-word matrix를 얻는다.

# 특징과 한계

- topic의 이름과 의미는 사람이 상위 단어와 문서를 보고 해석해야 한다.
- topic 수와 전처리, 말뭉치의 구성에 따라 결과가 달라진다.
- 문서의 유사한 group을 찾는 [[Text Clustering]]과 목표가 겹치지만, Topic Modeling은 단어 분포를 통해 주제 자체를 설명하려는 데 더 초점을 둔다.

# 관련 개념

- [[Text Clustering]]
- [[Text Mining]]
