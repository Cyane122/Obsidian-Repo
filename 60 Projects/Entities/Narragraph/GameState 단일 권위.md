---
type: project-entity
title: "GameState 단일 권위"
aliases: []
project: "[[Narragraph]]"
session_refs: ["codex:019f2875"]
tags: []
---

# 정의

Narragraph 런타임에서는 인메모리 `GameState`만 현재 상태의 권위로 삼는다. NetworkX 그래프, Kuzu, 벡터 인덱스와 렌더 결과는 필요할 때 다시 만드는 파생 projection이다.

# 책임 경계

- 위치, 시간, 자원, 플래그와 서사 상태의 현재값은 `GameState`가 소유한다.
- snapshot에는 복구에 필요한 권위 상태와 버전만 저장한다.
- 그래프와 인덱스가 런타임 진행을 막거나 서로 다른 현재 상태를 주장하지 못하게 한다.
- LLM은 상태 변경안을 제안할 수 있지만 검증된 API를 거치지 않고 Hard State를 직접 바꾸지 않는다.

# 관련 문서

- [[Narragraph]]
- [[GameState (Narragraph)]]
- [[Hard–Bounded Soft–Narrative State]]

