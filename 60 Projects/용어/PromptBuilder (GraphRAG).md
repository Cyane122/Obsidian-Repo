---
type: project-entity
title: "PromptBuilder (GraphRAG)"
aliases: [GraphRAG PromptBuilder]
project: "[[GraphRAG]]"
session_refs: ["codex:019f93f9", "claude:de1f5d3a"]
tags: []
---

# 개요

`PromptBuilder`는 [[Actor (GraphRAG)]]에게 전달할 prompt를 `Fixed`, `Genre`, `Dynamic` 세 구간으로 조립하는 구성 요소다. 정보의 역할과 변화 주기를 분리해 캐시와 권한 경계를 유지한다.

# Fixed

Actor 역할, 응답 형식과 오래 유지되는 공통 규칙을 담는다. 현재 위치·최근 기억처럼 턴마다 바뀌는 상태는 넣지 않는다.

# Genre

현재 scene type에 맞는 장르·문체 지시를 담는다. authored `prose.md`, scenario 지시와 공통 prompt가 서로 중복되거나 충돌하지 않도록 canonical home을 정해야 한다.

# Dynamic

현재 인물·위치·관계·기억·needs·최근 사건과 retrieval 결과를 담는다. Graph에서는 Kuzu fetch 결과, Wiki에서는 visibility를 통과한 Markdown 문서가 들어간다.

# Wiki Prompt Bundle

`build_wiki_prompt_bundle`도 기존 PromptBuilder의 세 구간을 만들어 Actor 호출 형식을 맞춘다. Actor-visible Wiki body는 다른 문서 이름이나 runtime mechanics를 언급하지 않고 혼자 읽혀야 한다.

# 관련 문서

- [[Actor (GraphRAG)]]
- [[Manager (GraphRAG)]]
- [[WikiRAG]]

# 세션 근거

- `codex:019f93f9` — Fixed/Genre/Dynamic을 사용하는 턴 구조
- `claude:de1f5d3a` — Wiki prompt bundle과 retrieval 분석
