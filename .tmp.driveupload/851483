---
type: project-concept
title: "Adult Scene FSM (Narragraph)"
aliases: [Narragraph Adult FSM, 성인 장면 상태기계]
project: "[[Narragraph]]"
session_refs: ["codex:019f1d50", "codex:019f1d76", "codex:019f285e"]
tags: []
---

# 정의

`Adult Scene FSM`은 [[Narragraph]]에서 성인 장면의 단계, 진입·전환·종료 조건과 상태 변화를 authored finite-state machine으로 관리하는 시스템이다. 장면의 실제 진행 단계는 LLM 산문이 아니라 FSM과 GameState가 결정한다.

# 설계 경계

- 진입 조건과 phase 전환은 authored guard가 결정한다.
- exit delta는 LLM proposal이 아니라 GameState의 좁은 API로 적용한다.
- 시간 경과에 따른 decay는 Scheduler가 처리한다.
- LLM은 현재 phase와 해석된 `safe_hint`를 받아 산문을 만든다.

# raw_tag 노출 문제

내부 FSM tag를 그대로 prompt-visible mood나 memory에 넣으면 작성용 식별자가 산문에 새어 나갈 수 있다. 검토에서는 prompt-view adapter 또는 sanitize 계층으로 내부 표현과 Actor에게 보이는 표현을 분리해야 한다고 지적했다.

# guard와 hint

flag별 `safe_hint` variant를 지원하되, 현재 상태에서 선택된 최종 hint만 LLM에 넘긴다. missing flag는 base hint로 돌아간다. 이 규칙은 장면 조건과 표현 지시가 서로 다른 권한을 가진다는 점을 명확히 한다.

# 관련 문서

- [[Hard–Bounded Soft–Narrative State]]
- [[safe_hint (Narragraph)]]
- [[행동 비용 기반 시간 진행]]

# 세션 근거

- `codex:019f1d50` — FSM 설계 검토, exit delta·decay·raw_tag 문제
- `codex:019f1d76` — Stage 2 invariant review
- `codex:019f285e` — guard별 hint 해석
