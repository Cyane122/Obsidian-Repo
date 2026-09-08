---
type: project-entity
title: "audit-vault.ps1"
aliases: [Vault Audit Script]
project: "[[AI·NLP 학술 지식 Wiki]]"
session_refs: ["codex:019f597a", "codex:01a0277d"]
tags: []
---

# 개요

`audit-vault.ps1`은 개인 학술 Wiki의 구조와 연결 상태를 검사하는 `obsidian-paper-notes` 부속 PowerShell script다. 기본 실행은 읽기 전용이며 오류와 후보만 보고한다.

# 검사 범위

- type과 folder의 일치
- 등록되지 않은 tag
- unresolved wikilink
- duplicate basename·alias 충돌
- orphan note 후보
- paper의 PDF·reading status

# 사용 기록

74개 노트 마이그레이션 전후와 신규 논문 편입 뒤 실행됐다. 2026-08-27 프로젝트 Wiki 검사에서는 115개 note, canonical tag 40개, unresolved wikilink 0개, orphan 후보 0개를 보고했다. 당시에는 comparison note 한 건의 type/folder mismatch가 별도 오류로 남아 있었다.

2026-09-04 Vault Schema v2 정리에서 해당 comparison을 canonical home인 `35 Comparisons/`로 옮겼다. 같은 날 다시 검사한 결과는 115개 note, canonical tag 40개, unresolved wikilink 0개, orphan 후보 0개, 구조 오류 0개였다. 여러 분야를 한데 모으는 `[[논문 읽기 프로젝트]]`의 태그가 하나뿐이라는 경고 한 건만 의도적으로 유지했다.

# 관련 문서

- [[obsidian-paper-notes]]
- [[태그 일람]]

# 세션 근거

- `codex:019f597a` — migration 검증과 audit script
- `codex:01a0277d` — 신규 paper·map 연결 검사
