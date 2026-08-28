---
type: project-entity
title: "v2_shift6_robust"
aliases: [v2 shift6 robust ensemble]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e5410", "codex:019e6277"]
tags: []
---

# 개요

`v2_shift6_robust`는 친구 브랜치에서 전달된 CH2026 실험 계열이다. 오전 6시 이전 센서 event를 전날에 귀속하는 shifted day, 수면 창, 피험자별 z-score와 subject-hole 검증을 결합했다.

# 특징

- 06:00 경계 생활일
- absolute·calendar feature
- subject z-score
- sleep-window와 semantic sensor 집계
- alternating held-out block 기반 Subject-hole CV
- 여러 model 예측의 robust ensemble

# 프로젝트에서의 위치

잘린 코드 조각과 제출 파일명에서 구조를 복원해 별도 script·report·submission 계열로 정리했다. 이후 `v3_semantic_robust`, `v4_knn_robust`와 Public LB blend를 만드는 한 성분으로 사용됐다.

# 관련 문서

- [[CH2026 센서 데이터 예측]]
- [[Subject-hole CV]]
- [[v3_semantic_robust]]
- [[v4_knn_robust]]

# 세션 근거

- `codex:019e5410` — 잘린 `v2_shift6_robust` 코드 복원
- `codex:019e6277` — 최종 실험 계보
