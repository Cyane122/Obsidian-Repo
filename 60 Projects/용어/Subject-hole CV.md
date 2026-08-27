---
type: project-concept
title: "Subject-hole CV"
aliases: [Subject-hole Validation, 피험자 구간 홀드아웃]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e3f23", "codex:019e5410", "codex:019e6277"]
tags: []
---

# 정의

한 피험자의 시간축을 교대로 비운 구간으로 나눠 validation으로 사용하는 [[CH2026 센서 데이터 예측]]의 교차검증 방식이다. 동일 인물의 다른 시점으로 예측하되 가까운 행의 직접 누출을 줄이려는 목적이 있다.

# 비교한 검증축

- subject-hole 5-fold와 7-fold
- 피험자별 최신 구간을 비우는 last-block/temporal split
- 전체 피험자를 빼는 leave-subject-out
- interleaved holdout과 마지막 7일 미래형 holdout

# 해석

실제 test가 기존 subject의 미래 구간이라면 leave-subject-out만을 최종 기준으로 삼는 것도 문제다. 반대로 같은 피험자의 인접 날짜를 train과 validation에 섞으면 label prior가 과대평가될 수 있다. 그래서 한 점수보다 여러 분할에서 target별 안정성을 봤다.

# 관련 문서

- [[label-KNN-prior]]
- [[OOF와 Public LB (CH2026)]]
- [[Targetwise Model Selection (CH2026)]]

# 세션 근거

- `codex:019e3f23` — temporal·leave-subject-out 비교
- `codex:019e5410`, `codex:019e6277` — subject-hole과 미래형 holdout의 차이
