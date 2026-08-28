---
type: project-entity
title: "obsidian-paper-notes"
aliases: [Obsidian Paper Notes Skill]
project: "[[AI·NLP 학술 지식 Wiki]]"
session_refs: ["codex:019f597a", "codex:01a0277d"]
tags: []
---

# 개요

`obsidian-paper-notes`는 `D:\World`의 AI·NLP·ML 학술 Wiki를 일관된 방식으로 유지하기 위해 만든 프로젝트 전용 Agent Skill이다. 논문 PDF 편입, concept 갱신, map·comparison·synthesis 작성, 링크·태그 감사를 하나의 작업 규칙으로 묶는다.

# 만들어진 배경

초기 저장소에는 논문과 용어 노트 74개가 루트에 섞여 있었고 태그 대소문자·오탈자·구분자가 일치하지 않았다. 외부의 일반 Obsidian skill은 자체 폴더·frontmatter 체계가 강해 기존 노트와 충돌할 가능성이 있었다. 이에 저장소의 실제 문체와 구조를 기준으로 전용 skill을 만들었다.

# 핵심 동작

- 같은 대상은 새 파일을 만들지 않고 canonical note를 갱신한다.
- paper에서 재사용 가능한 지식을 concept·map으로 편입한다.
- 등록된 `domain/task/method/theme` 태그만 쓴다.
- PDF와 paper note의 basename·분야를 맞춘다.
- 사용자 메모와 불완전한 섹션을 삭제하지 않는다.
- 구조 감사는 report-only로 실행한다.

# 실제 사용

74개 root note를 12 paper, 1 map, 61 concept로 분류해 이동했고 빈 BPR·UCT 노트도 삭제하지 않았다. 2026-08-22에는 텍스트 익명화 metric survey와 CluSanT PDF를 원문 기준으로 편입하고 프라이버시 지도에 연결했다.

# 관련 문서

- [[AI·NLP 학술 지식 Wiki]]
- [[태그 일람]]
- [[audit-vault.ps1]]

# 세션 근거

- `codex:019f597a` — skill 제작과 74개 노트 마이그레이션
- `codex:01a0277d` — 실제 PDF 기반 paper 편입
