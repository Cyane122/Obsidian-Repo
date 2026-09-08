---
type: project-entity
title: "GameState (Narragraph)"
aliases: [Narragraph GameState]
project: "[[Narragraph]]"
session_refs: ["codex:019f1c01", "codex:019f1d00", "codex:019f1d50"]
tags: []
---

# 개요

`GameState`는 [[Narragraph]]에서 진행 중인 세계의 현재값을 소유하는 단일 상태 객체다. 장소, 시간, 인물 상태, 플래그와 자원처럼 게임 규칙에 영향을 주는 값은 이 객체를 거치며, 화면이나 LLM 출력이 별도의 진실을 만들지 못하게 한다.

# 맡는 일

- DSL 명령이 요구한 이동·시간 경과·플래그 변경을 적용한다.
- 조건식이 읽을 현재 상태를 제공한다.
- 저장·불러오기용 snapshot을 만든다.
- 성인 장면 종료처럼 여러 값을 함께 바꾸는 전이를 정해진 API로 처리한다.
- 화면에 렌더링할 값과 LLM에 전달할 soft context의 근거가 된다.

# 권한 경계

LLM lane은 `GameState`를 직접 수정하지 않는다. LLM은 서술과 허용된 `proposed_soft_deltas`만 반환하고, 실제 반영 여부는 엔진이 검증한다. 이동 가능 여부, 시간 비용, 자원 소비와 authored flag는 결정론적 규칙이 정한다.

# 관련 문서

- [[Narragraph DSL]]
- [[Hard–Bounded Soft–Narrative State]]
- [[Adult Scene FSM (Narragraph)]]

# 세션 근거

- `codex:019f1c01` — 단일 in-memory `GameState`, DSL 실행과 snapshot
- `codex:019f1d00` — LLM lane의 상태 쓰기 제한
- `codex:019f1d50` — Adult FSM 종료 전이를 `GameState` API로 적용

