---
type: project-entity
title: "Kuzu (GraphRAG)"
aliases: [GraphRAG Kuzu]
project: "[[GraphRAG]]"
session_refs: ["codex:019f93f9", "codex:01a00da4"]
tags: []
---

# 개요

`Kuzu`는 [[GraphRAG]]의 Graph 실행 모드가 세계 상태를 저장·조회하는 in-process graph database다. character, location, relationship, event, memory와 여러 시스템 상태를 node·relationship table로 표현한다.

# 격리

world와 thread마다 graph 경로를 분리해 서로 다른 플레이의 상태가 섞이지 않게 한다. world-specific schema와 초기 데이터는 해당 world package가 소유하고, 공통 node·relationship table은 base schema가 만든다.

# Transaction 규칙

여러 write 또는 read-modify-write는 `async with async_driver.transaction() as tx:` 안에서 실행한다. Kuzu driver lock은 non-reentrant이므로 transaction 내부에서 새 session을 열거나 transaction-owning helper를 호출하면 안 된다. embedding 등 느린 작업은 transaction 전에 끝낸다.

# Actor와의 거리

Actor가 Kuzu query를 직접 실행하지 않는다. [[Manager (GraphRAG)]]의 planner와 subsystem fetcher가 필요한 상태를 가져와 [[PromptBuilder (GraphRAG)]]에 제공한다. write는 [[Updater (GraphRAG)]]의 validation·audit 경로를 거친다.

# 관련 문서

- [[GraphRAG]]
- [[Manager (GraphRAG)]]
- [[Updater (GraphRAG)]]
- [[WikiRAG]]

# 세션 근거

- `codex:019f93f9`, `codex:01a00da4` — Kuzu transaction·isolation과 Graph state 규칙
