---
type: project-entity
title: "Updater (GraphRAG)"
aliases: [GraphRAG Updater, update_accepted_turn]
project: "[[GraphRAG]]"
session_refs: ["claude:697838f0", "codex:019f93f9"]
tags: []
---

# 개요

`Updater`는 수락된 Actor 응답에서 세계 상태 변화를 만들고 검증·반영하는 [[GraphRAG]]의 공개 상태 갱신 진입점이다. `src.simulation.state.updater.update_accepted_turn` 하나가 Graph와 Wiki 모드를 함께 처리한다.

# 모드별 실행

```text
update_accepted_turn
├─ Graph → graph_apply.py → Kuzu transaction
└─ Wiki  → commit_planner.py → Markdown commit plan
```

# Wiki 결과

Wiki에서는 section `patches`와 새 event·memory 등 `creations`를 하나의 구조화 JSON으로 반환한다. Goal·Item·Secret 패리티도 새 Updater를 추가하지 않고 이 schema와 prompt·validator를 확장하는 방향으로 설계됐다.

# JSON mode의 한계

`response_mime_type: application/json`은 문법적으로 JSON인 출력을 유도하지만 토큰 상한에서 잘린 JSON을 완결된 객체로 만들지는 못한다. `max_output_tokens` 상한 확대와 schema 크기, truncation 검출은 별개 문제다.

# 상태 해석 규칙

비유를 실제 상처나 위치로 바꾸지 않고, routine kindness를 큰 관계 milestone로 기록하지 않으며, Event는 지속적인 서사 변화에만 만든다. Memory는 인물의 주관적 기록이므로 객관적 Event와 같은 방식으로 ‘정정’하지 않는다.

# 관련 문서

- [[Actor (GraphRAG)]]
- [[Manager (GraphRAG)]]
- [[WikiRAG]]

# 세션 근거

- `claude:697838f0` — 단일 Updater, Wiki JSON과 Goal·Item·Secret 확장
- `codex:019f93f9` — 저장소의 accepted-turn 진입점과 상태 규칙
