---
type: project-entity
title: "결정론적·LLM 이중 실행 레인"
aliases: []
project: "[[Narragraph]]"
session_refs: ["codex:019f2875"]
tags: []
---

# 정의

anchor의 sigil로 규칙 기반 행동과 LLM 생성 슬롯을 실행 전에 분리하는 Narragraph의 라우팅 원칙이다.

| sigil | 역할 | 실행 경로 |
|---|---|---|
| `>` | 위치 이동 | 결정론적 레인 |
| `!` | 사건·행동 | 결정론적 레인 |
| `?` | 조사 | 결정론적 레인 |
| `@` | 대화·산문 생성 | LLM 레인 |

# 불변식

- 지원하지 않는 LLM 레인을 결정론적 사건으로 대신 실행하지 않는다.
- href의 첫 글자를 sigil로 분리한 뒤 나머지 query를 해석한다.
- 두 레인은 같은 turn result 계약을 사용하되 상태 변경 권한은 분리한다.

# 관련 문서

- [[Narragraph]]
- [[Narragraph DSL]]
- [[safe_hint (Narragraph)]]
- [[GameState 단일 권위]]

