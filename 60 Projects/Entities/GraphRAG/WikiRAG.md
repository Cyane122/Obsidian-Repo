---
type: project-entity
title: "WikiRAG"
aliases: [GraphRAG Wiki Mode]
project: "[[GraphRAG]]"
session_refs: ["claude:697838f0", "claude:e133aa48"]
tags: []
---

# 개요

`WikiRAG`는 [[GraphRAG]]의 세계·인물·시나리오·스레드 상태를 Kuzu graph 대신 Markdown Wiki로 표현하는 실행 모드다. 사람이 직접 읽고 고칠 수 있는 authored canon과 runtime 문서를 Actor prompt 및 상태 갱신의 기반으로 사용한다.

# 주요 구성

- `world.md`, `prose.md`: 세계 공통 설정과 문체
- `characters/*.md`: 인물별 profile
- `scenarios/<id>/scenario.md`: 시나리오 설정
- `opening_scene.md`: 플레이어에게 보이는 시작 산문
- thread document: event, memory, goal, item, secret 등 진행 중 상태
- `commit.md`: revision-safe 변경 계획

# Actor에게 보이는 문서

본문은 다른 파일을 런타임에 따라가야 이해되는 문서가 아니라 독립적인 prompt module이어야 한다. 내부 경로, revision, thread metadata, 비공개 Secret, inactive variant는 제거한다. factual canon과 prompt-bearing heading은 영어를 기본으로 하고, 한국어는 고유명사·호칭·대화·플레이어용 산문에 제한하는 규칙이 있다.

# GraphRAG와의 관계

별도 제품이 아니라 같은 accepted-turn 계약의 Wiki 저장 구현이다. 공개 진입점은 `Updater` 하나를 공유하고, Wiki 결과는 section patch와 document creation을 담은 JSON으로 생성한 뒤 `commit_planner.py`가 검증한다.

# 이식 사례

`sunghwa_university` Graph 월드를 50개 Wiki 파일로 옮겼다. 이후 `scenario.md`에 `npc_profile_id`와 `characters` allowlist를 추가해 시나리오별 Actor와 cast를 원본과 맞췄다.

# 관련 문서

- [[GraphRAG]]
- [[Updater (GraphRAG)]]
- [[PromptBuilder (GraphRAG)]]
- [[sunghwa_university]]

# 세션 근거

- `claude:697838f0` — WikiRAG 패리티와 단일 Updater 계약
- `claude:e133aa48` — 실제 Graph world의 WikiRAG 이식
