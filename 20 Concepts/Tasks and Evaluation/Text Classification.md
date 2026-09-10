---
type: concept
title: "Text Classification"
summary: "미리 정한 범주 가운데 하나 이상을 텍스트에 부여하는 supervised learning task."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 텍스트 분류
  - Document Classification
tags:
  - domain/nlp
  - task/text-classification
---

# 정의

Text Classification은 주제, 감성, 스팸 여부처럼 미리 정한 class 가운데 하나 이상을 문서에 부여하는 지도 학습 과제다.

# 왜 필요한가

대량의 문서를 빠르게 분류하고, 분류 결과를 검색, 우선순위 결정, 모니터링, 통계 분석에 활용할 수 있다.

# 작동 원리

텍스트를 전처리하고 [[Term Frequency–Inverse Document Frequency|TF-IDF]]나 [[Word Embedding]]으로 표현한 뒤, 레이블이 달린 예시로 분류 규칙이나 모델을 학습한다. 하나의 문서에 하나의 class를 주는 single-label 설정과 여러 class를 동시에 주는 multi-label 설정이 있다.

# 특징과 한계

- 정확도는 class 정의와 레이블 품질, 데이터의 대표성에 좌우된다.
- 분류 결과만으로 근거를 알기 어려울 수 있어 [[Information Extraction]]과 함께 쓰기도 한다.

# 수업 자료

- [[50 Courses/2026-2학기/DSC2021-01 - 텍스트마이닝기초/1주차|Text Mining 1주차]]

# 관련 개념

- [[Sentiment Analysis]]
- [[Text Clustering]]
