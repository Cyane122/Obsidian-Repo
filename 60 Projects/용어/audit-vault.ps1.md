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

74개 노트 마이그레이션 전후와 신규 논문 편입 뒤 실행됐다. 2026-08-27 프로젝트 Wiki 검사에서는 115개 note, canonical tag 40개, unresolved wikilink 0개, orphan 후보 0개를 보고했다. 기존 comparison note 한 건의 type/folder mismatch는 별도 오류로 남아 있다.

# 관련 문서

- [[obsidian-paper-notes]]
- [[태그 일람]]

# 세션 근거

- `codex:019f597a` — migration 검증과 audit script
- `codex:01a0277d` — 신규 paper·map 연결 검사
