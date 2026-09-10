---
type: concept
title: "Term Frequency–Inverse Document Frequency"
summary: "문서 안의 빈도와 말뭉치 전체의 희소성을 결합해 단어의 문서별 중요도를 나타내는 가중치."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - TF-IDF
  - TFIDF
  - 용어 빈도-역문서 빈도
tags:
  - domain/nlp
  - task/representation-learning
  - task/text-mining
---

# 정의

Term Frequency–Inverse Document Frequency(TF-IDF)는 특정 문서에서 자주 등장하지만 전체 말뭉치에서는 드문 단어에 높은 가중치를 주는 텍스트 표현 방법이다.

# 왜 필요한가

the처럼 거의 모든 문서에 나오는 단어는 문서를 구별하는 데 도움이 되지 않는다. TF-IDF는 이런 공통 단어의 비중을 낮추고 특정 문서의 주제를 드러내는 단어를 강조한다.

# 수식 / 알고리즘

전체 문서 수를 $N$, 단어 $t$가 등장한 문서 수를 $df(t)$라고 하면, 한 가지 표준 정의는 다음과 같다.

$$TF(t,d)=\frac{count(t,d)}{|d|}, \qquad IDF(t)=\log\frac{N}{df(t)}, \qquad TF\text{-}IDF(t,d)=TF(t,d)\times IDF(t)$$

$df(t)=N$이면 $IDF(t)=0$이므로 모든 문서에 등장하는 단어의 TF-IDF도 0이 된다. 실제 라이브러리는 로그의 밑, 정규화, smoothing을 다르게 적용할 수 있다.

# 특징과 한계

- 희소 벡터 기반의 간단하고 해석하기 쉬운 표현이다.
- 단어 순서와 문맥, 동의어 관계를 직접 반영하지 못한다.
- 문맥과 의미 관계가 중요한 경우에는 [[Word Embedding]]이나 문맥화된 표현을 함께 고려한다.

# 수업 자료

- [[50 Courses/2026-2학기/DSC2021-01 - 텍스트마이닝기초/1주차|Text Mining 1주차]]
