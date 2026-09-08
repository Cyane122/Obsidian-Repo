---
type: project-entity
title: "데이터·AI 데일리 브리핑"
aliases: [Daily Data and AI Briefing]
project: "[[데이터·AI 데일리·주간 브리핑]]"
session_refs: ["codex:019f7a1b", "codex:01a042ec"]
tags: []
---

# 개요

`데이터·AI 데일리 브리핑`은 한국 시간 매일 정오를 기준으로 신입·인턴 채용, 논문, 공식 AI 발표와 오픈소스·커뮤니티 신호를 조사해 `everyday-info`에 보고서를 저장하는 예약 작업이다.

# 수집 대상

데이터 분석·데이터 사이언스·ML/AI 엔지니어링·NLP·LLM·RAG·MLOps 직무와 arXiv·ACL Anthology·OpenReview 논문, AI 기업·연구기관 발표, Hugging Face·GitHub·Papers with Code, 공식 YouTube를 다룬다. Hacker News와 Reddit은 탐색 신호로만 사용한다.

# 실행 규칙

정오에 PC가 꺼져 있을 수 있어 이후 주기적 확인으로 보충 실행한다. 당일 `state.json`과 보고서가 모두 존재하면 다시 조사하지 않는다. 보고서 저장까지 끝난 뒤 성공 상태를 기록한다.

# 관련 문서

- [[데이터·AI 데일리·주간 브리핑]]
- [[데이터·AI 주간 브리핑]]

# 세션 근거

- `codex:019f7a1b` — 정오 예약과 수집 범위, 보충 실행
- `codex:01a042ec` — 당일 완료 확인 후 skip
