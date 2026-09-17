---
type: concept
title: "Text Summarization"
summary: "원문의 핵심 정보와 의미를 유지하면서 더 짧은 텍스트를 만드는 task."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 텍스트 요약
  - Automatic Summarization
tags:
  - domain/nlp
  - task/summarization
---

# 정의

Text Summarization은 긴 문서의 중요한 정보와 전체 의미를 유지하면서 더 짧은 형태로 만드는 작업이다.

# 왜 필요한가

뉴스, 보고서, 회의 기록처럼 빠르게 전체 내용을 파악해야 하는 긴 문서를 읽는 부담을 줄인다.

# 작동 원리

Extractive Summarization은 원문에서 중요한 문장이나 구를 골라 요약한다. Abstractive Summarization은 새로운 문장을 생성하며, [[Transformer]]와 [[Attention]]을 사용하는 sequence-to-sequence 모델이나 [[Large Language Model]]을 활용할 수 있다.

# 특징과 한계

- 추출 요약은 원문에 없는 사실을 만들 위험이 비교적 낮지만 문장이 부자연스럽게 이어질 수 있다.
- 생성 요약은 더 자연스러운 표현이 가능하지만 원문에 없는 내용을 만들어 내지 않는지 별도 검증이 필요하다.
