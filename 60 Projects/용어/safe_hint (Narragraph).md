---
type: project-concept
title: "safe_hint (Narragraph)"
aliases: [safe_hint, Resolved Hint]
project: "[[Narragraph]]"
session_refs: ["codex:019f285e", "codex:019f2875"]
tags: []
---

# 정의

`safe_hint`는 [[Narragraph]]가 LLM에 장면 방향을 알려줄 때 사용하는 저작자 제공 힌트다. guard와 flag에 따른 여러 variant가 있더라도 LLM에는 조건식이나 전체 후보가 아니라, 현재 상태에서 해석된 최종 hint 하나만 전달한다.

# 필요한 이유

작가는 같은 장면에서도 관계·flag에 따라 다른 어조와 정보를 요구할 수 있다. LLM에 모든 variant와 내부 조건을 보여주면 현재 상태에 맞지 않는 지시를 섞거나 숨겨야 할 분기를 노출할 수 있다. 엔진이 조건을 먼저 해결하면 LLM은 선택이 아니라 표현에 집중한다.

# 해석 규칙

- 현재 flag가 특정 variant의 guard를 만족하면 그 hint를 쓴다.
- 일치하는 variant가 없거나 flag가 없으면 base `safe_hint`로 돌아간다.
- 해석된 hint만 `build_fsm_request`와 UI/LLM 요청 경로에 들어간다.
- 원본 guard 목록과 실패한 variant는 LLM에 전달하지 않는다.

# 검증

구현 후 UI 경로와 `build_fsm_request`가 같은 resolver를 사용하는지 확인했다. 145개 기존 테스트와 추가 5개 테스트가 통과했고, missing flag가 base hint로 돌아가는 회귀도 고정했다.

# 관련 문서

- [[Narragraph DSL]]
- [[결정론적·LLM 이중 실행 레인]]
- [[Adult Scene FSM (Narragraph)]]

# 세션 근거

- `codex:019f285e` — flag guard와 fallback 설계
- `codex:019f2875` — 두 호출 경로의 resolver 통합과 150개 테스트
