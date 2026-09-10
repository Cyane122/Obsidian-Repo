---
type: concept
title: "Information Extraction"
summary: "비정형 또는 반구조화 텍스트에서 개체, 속성, 관계, 사실을 찾아 구조화된 정보로 바꾸는 작업."
maturity: developing
last_reviewed: 2026-09-08
aliases:
  - 정보 추출
  - IE
tags:
  - domain/nlp
  - task/text-mining
---

# 정의

Information Extraction은 텍스트에서 개체와 속성, 개체 사이의 관계를 찾아 구조화된 형태로 만드는 작업이다. 문서를 그대로 반환하는 Information Retrieval과 달리, 문서 안의 사실을 추출하는 데 초점을 둔다.

# 왜 필요한가

뉴스와 보고서, 웹페이지처럼 형식이 일정하지 않은 자료를 데이터베이스나 분석용 표로 바꿔 검색, 집계, 후속 모델링에 활용할 수 있다.

# 작동 원리

어휘·구문 전처리 뒤 숫자와 개체를 찾고, 대명사와 지시 표현의 대상을 해소한 뒤, 관계와 사실을 추출한다. [[Named Entity Recognition]]은 인명, 지명, 기관명 같은 개체를 식별하는 대표 하위 과제다.

# 특징과 한계

- 같은 표기가 서로 다른 대상을 뜻할 수 있어 개체명 모호성 해소가 필요하다.
- 정확도는 문서 형식, 도메인 용어, 관계 정의의 범위에 크게 좌우된다.

# 수업 자료

- [[50 Courses/2026-2학기/DSC2021-01 - 텍스트마이닝기초/1주차|Text Mining 1주차]]

# 관련 개념

- [[Named Entity Recognition]]
- [[Text Mining]]
