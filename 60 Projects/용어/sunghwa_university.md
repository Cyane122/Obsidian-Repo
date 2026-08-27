---
type: project-entity
title: "sunghwa_university"
aliases: [성화대학교 월드, Sunghwa University World]
project: "[[GraphRAG]]"
session_refs: ["claude:e133aa48"]
tags: []
---

# 개요

`sunghwa_university`는 신촌의 사립대학을 배경으로 한 [[GraphRAG]] world이며, Graph 형식에서 [[WikiRAG]] 형식으로 실제 이식된 대표 사례다.

# Wiki 이식

`wiki_v2/worlds/sunghwa_university/` 아래 50개 파일로 옮겼다. `world.md`, `prose.md`, location, character profile과 7개 scenario를 포함했다. 기존 Graph world의 설정과 cast를 Markdown canonical home으로 나눴다.

# 시나리오별 Actor와 cast

초기 Wiki loader는 world 기본 NPC와 모든 world character를 공통으로 넣어 scenario 차이를 충분히 표현하지 못했다. `scenario.md`에 다음 optional field를 추가했다.

- `npc_profile_id`: world 기본 Actor를 scenario에서 덮어쓴다.
- `characters`: world-level character allowlist다.

scenario 전용 character는 allowlist와 무관하게 포함한다. 필드 부재는 기존 동작, 빈 목록은 공통 인물 전원 제외로 정의했다.

# 검증에서 발견한 문제

초기 smoke test helper가 quoted `created_at`을 잘못 replace해 새 frontmatter를 실제로 삽입하지 못했는데도 테스트가 통과했다. helper를 고친 뒤 mutation test로 `npc_profile_id`와 empty-list 회귀가 실제로 잡히는지 확인했고 `smoke_wiki_v2`, `smoke_wiki_runtime`을 통과했다.

# 관련 문서

- [[WikiRAG]]
- [[GraphRAG]]

# 세션 근거

- `claude:e133aa48` — 50파일 이식, scenario cast 계약과 테스트 harness 수정
