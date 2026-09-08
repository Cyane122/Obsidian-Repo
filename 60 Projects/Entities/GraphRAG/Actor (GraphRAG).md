---
type: project-entity
title: "Actor (GraphRAG)"
aliases: [GraphRAG Actor]
project: "[[GraphRAG]]"
session_refs: ["codex:019f93f9", "claude:de1f5d3a", "codex:387dd133"]
tags: []
---

# 개요

`Actor`는 [[GraphRAG]]에서 NPC와 세계의 반응을 플레이어에게 보일 산문으로 생성하는 LLM 역할이다. 세계 상태를 직접 수정하지 않고 [[Manager (GraphRAG)]]가 조립한 prompt를 받아 응답을 만든다.

# 입력

- Fixed·Genre·Dynamic prompt
- 현재 Actor profile과 scene 지시
- 검색된 관계·기억·needs·사건
- 현재 세계·시나리오·thread에 허용된 정보

# 출력과 권한

Actor 출력은 사용자에게 보일 후보 응답이다. 응답이 수락되기 전까지 이 산문에서 파생된 상태 변경은 폐기할 수 있어야 한다. private Secret이나 Wiki frontmatter, 내부 runtime mechanics를 보지 못하며 DB·Markdown을 직접 쓰지 않는다.

# Provider 구현

Claude와 DeepSeek 등 여러 provider를 지원했다. 2026-08-27 코드 품질 검토에서는 `actor.py`의 provider별 streaming·retry·usage handling이 복제돼 있고, `client.py`의 provider abstraction이 절반만 이행됐다는 문제가 지적됐다. 특히 retryable 429와 provider fallback 대상 403을 구분해야 했다.

# Agent loop 논의

Actor가 직접 Graph/Wiki 검색 tool을 반복 호출하는 방식도 검토됐다. 하지만 latency·비용·재현성·비공개 정보 통제가 나빠져, 현재의 prefetch/push 구조를 유지하는 결론이 나왔다.

# 관련 문서

- [[Manager (GraphRAG)]]
- [[Updater (GraphRAG)]]
- [[PromptBuilder (GraphRAG)]]

# 세션 근거

- `codex:019f93f9` — Actor의 턴 위치와 Deferred Commit
- `claude:de1f5d3a` — agent loop 검토
- `codex:387dd133` — provider 중복과 fallback 기술부채
