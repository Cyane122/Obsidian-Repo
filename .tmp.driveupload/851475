---
type: project-concept
title: "Narragraph DSL"
aliases: [Narragraph Scene DSL, QSP-style DSL]
project: "[[Narragraph]]"
session_refs: ["codex:019f1c01", "codex:019f285e"]
tags: []
---

# 정의

`Narragraph DSL`은 Markdown형 장면 본문 안에서 이동, 상태 변화, hook, LLM slot을 저작할 수 있게 만든 간결한 문법이다. 작가가 모든 로직을 Python으로 작성하지 않고도 결정론적 장면 흐름과 생성 구간을 함께 표현하도록 설계됐다.

# 핵심 sigil

초기 M1에서 `>`, `!`, `@`, `?` 네 sigil을 중심으로 파서를 구성했다. 각각 이동·action, 상태 변경 또는 지시, hook, 조건·LLM 관련 표현을 구분한다. 실제 의미는 문맥과 구문 위치에 따라 달라질 수 있어 bracket-aware parsing이 필요했다.

# 파싱에서 어려웠던 점

`?`가 조건과 다른 역할을 겸하고, 값 안에도 bracket나 구분자가 들어갈 수 있어 단순 문자열 split으로는 안전하지 않았다. parser는 source 위치를 포함한 오류를 내고, 잘못된 target이나 존재하지 않는 scene·character를 manifest 검증 단계에서 warning 또는 error로 드러내야 했다.

# 저작과 실행의 분리

DSL은 실행 코드가 아니라 SceneIR로 변환된다. parser가 frontmatter와 body, action을 구조화하면 deterministic lane이 조건을 평가하고 GameState의 좁은 API를 호출한다. LLM에 전달되는 hint와 산문 입력은 같은 SceneIR에서 파생되지만 상태 쓰기 권한은 갖지 않는다.

# 관련 문서

- [[결정론적·LLM 이중 실행 레인]]
- [[safe_hint (Narragraph)]]
- [[GameState 단일 권위]]

# 세션 근거

- `codex:019f1c01` — M1 DSL sigil, bracket-aware parser와 snapshot 구조
- `codex:019f285e` — flag guard와 safe_hint variant가 DSL 실행에 연결된 방식
