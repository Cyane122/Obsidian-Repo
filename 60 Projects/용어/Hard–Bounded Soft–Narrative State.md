---
type: project-concept
title: "Hard–Bounded Soft–Narrative State"
aliases: [Narragraph 3-tier State, Hard State, Bounded Soft State, Narrative State]
project: "[[Narragraph]]"
session_refs: ["codex:019f1d00", "codex:019f1d50"]
tags: []
---

# 정의

[[Narragraph]]는 LLM이 상태에 미칠 수 있는 권한을 `Hard`, `Bounded Soft`, `Narrative`의 세 단계로 나눈다. 상태 이름의 차이보다 누가 값을 결정하고 어떤 검증을 거치는지가 핵심이다.

# 세 단계

## Hard State

위치, 시간, 재화, inventory, 핵심 flag처럼 게임 규칙과 분기에 직접 영향을 주는 값이다. authored action과 deterministic handler만 변경한다. LLM은 `proposed_hard_*`를 출력할 권한이 없다.

## Bounded Soft State

관계 수치, mood, 일부 기억처럼 서사에 영향을 받지만 허용 범위와 적용 조건을 검증할 수 있는 값이다. LLM은 변경을 제안할 수 있으나 validator가 범위·대상·현재 상태를 확인한 뒤에만 GameState API로 반영한다.

## Narrative State

당장 규칙 분기를 바꾸지 않는 서술·묘사·해석이다. LLM이 자유롭게 생성할 수 있지만, 그것만으로 위치·상처·소유권 같은 Hard State가 생기지는 않는다.

# 필요한 이유

LLM에게 상태 쓰기를 전혀 허용하지 않으면 관계와 감정 변화가 authored script에만 갇힌다. 반대로 모든 문장에서 상태를 추출하면 비유와 과장이 게임 규칙으로 굳는다. 세 단계는 서사 유연성과 결정성을 동시에 유지하는 절충이다.

# Adult FSM 검토에서 드러난 경계

결정론적 exit delta까지 LLM proposal validator를 통과시키면 authored 규칙의 권위가 약해진다. exit delta는 좁은 GameState API로 직접 적용하고, scheduler decay는 시간 구동 규칙으로 처리하는 편이 맞다고 판단했다.

# 관련 문서

- [[GameState 단일 권위]]
- [[결정론적·LLM 이중 실행 레인]]
- [[Adult Scene FSM (Narragraph)]]

# 세션 근거

- `codex:019f1d00` — M4 LLM lane과 proposed soft/narrative 계약
- `codex:019f1d50` — adult FSM의 결정론적 delta와 validator 경계 검토
