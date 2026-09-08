---
type: project-entity
title: "Manager (GraphRAG)"
aliases: [GraphRAG Manager]
project: "[[GraphRAG]]"
session_refs: ["codex:019f93f9", "claude:de1f5d3a"]
tags: []
---

# 개요

`Manager`는 [[Actor (GraphRAG)]] 호출 전에 현재 턴에 필요한 정보와 효과를 준비하는 [[GraphRAG]]의 조정 계층이다. 사용자 입력, thread 상태와 scene type을 해석해 [[PromptBuilder (GraphRAG)]]에 전달할 컨텍스트를 만든다.

# 주요 책임

- scene type 분류
- 현재 world·scenario·thread 확인
- 필요한 상태 시스템 선택과 조회
- Actor profile과 관계·기억·needs 조립
- Fixed·Genre·Dynamic prompt 구성에 필요한 입력 제공
- Actor 응답 이후 반영할 수 있는 효과의 준비

# Graph와 Wiki

Graph에서는 planner가 keyword를 이용해 조회할 시스템을 고르고 Kuzu query를 병렬 실행한다. [[WikiRAG]]에서는 visibility, owner/knower, 제목 일치와 최근성을 기준으로 문서를 골라 token budget 안에 넣는다.

# 권한 경계

Manager의 turn preparation은 가능한 한 부수 효과가 없어야 한다. scene type을 분류하거나 context를 계산할 수 있지만 응답 수락 전에 세계 시간을 진행하거나 영구 상태를 바꾸지 않는다.

# 관련 문서

- [[Actor (GraphRAG)]]
- [[Updater (GraphRAG)]]
- [[PromptBuilder (GraphRAG)]]
- [[Kuzu (GraphRAG)]]

# 세션 근거

- `codex:019f93f9` — Manager의 턴 준비와 side-effect 경계
- `claude:de1f5d3a` — Graph planner와 Wiki recall 비교
