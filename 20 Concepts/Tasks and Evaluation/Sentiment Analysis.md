---
type: concept
title: "Sentiment Analysis"
summary: "텍스트에 드러난 긍정, 중립, 부정 또는 세부 감정과 태도를 판별하는 Text Classification task."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 감성 분석
  - Opinion Mining
tags:
  - domain/nlp
  - task/text-classification
---

# 정의

Sentiment Analysis는 문서, 문장, 또는 특정 속성에 대해 긍정·중립·부정의 극성이나 감정을 판단하는 작업이다. 평가 점수처럼 연속값으로 표현하는 경우도 있다.

# 왜 필요한가

고객 후기, 소셜 미디어 반응, 설문 서술 응답처럼 대량의 의견을 빠르게 요약하고, 어떤 대상이나 속성에서 반응이 달라지는지 살필 수 있다.

# 작동 원리

감성 사전에서 긍정·부정 단어를 찾아 규칙으로 판단할 수 있다. 또는 감성 레이블이 달린 예시 데이터로 분류 모델을 학습할 수 있다. 제품 전체에 대한 반응을 보는 문서 수준 분석과 배터리·배송처럼 특정 속성을 따로 보는 aspect 수준 분석이 있다.

# 특징과 한계

- 부정 표현, 반어, 문맥, 도메인별 어휘 때문에 단순 단어 목록만으로는 판단이 어렵다.
- 감성의 대상과 근거를 함께 밝혀야 해석이 가능하다.

# 수업 자료

- [[50 Courses/2026-2학기/DSC2021-01 - 텍스트마이닝기초/1주차|Text Mining 1주차]]

# 관련 개념

- [[Text Classification]]
- [[Text Mining]]
