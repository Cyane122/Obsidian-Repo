---
type: project-entity
title: "OOF와 Public LB (CH2026)"
aliases: []
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e5410", "codex:019e6277"]
tags: []
---

# 정의

CH2026에서 OOF는 재현 가능한 로컬 모델 선택 근거이고, Public Leaderboard는 공개된 일부 평가 구간에서 얻은 외부 신호다. 두 점수는 평가 대상과 누출 위험이 다르므로 같은 순위표처럼 해석하지 않는다.

# 판단 원칙

- 모델과 특징 선택은 피험자 단위 분할을 포함한 로컬 OOF를 우선한다.
- Public LB 개선은 블렌드 후보를 좁히는 보조 신호로 사용한다.
- 공개 점수에 맞춰 비중을 반복 조정한 결과는 과적합 가능성을 별도로 기록한다.
- 최종 제출과 로컬 최고 모델이 다르면 타깃별 기여를 분리해 설명한다.

# 관련 문서

- [[CH2026 센서 데이터 예측]]
- [[Subject-hole CV]]
- [[Targetwise Model Selection (CH2026)]]

