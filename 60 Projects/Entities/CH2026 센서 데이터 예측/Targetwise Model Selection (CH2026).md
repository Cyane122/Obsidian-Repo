---
type: project-entity
title: "Targetwise Model Selection (CH2026)"
aliases: []
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e3f23", "codex:019e6277"]
tags: []
---

# 정의

여러 이진 타깃에 하나의 모델을 공통 적용하지 않고, 각 타깃의 로컬 검증 성능에 따라 서로 다른 모델이나 스택을 선택하는 전략이다.

# 확인된 효과

LSTM, GRU, RNN, Transformer를 같은 검증 틀에서 비교했을 때 평균 성능은 LSTM이 가장 좋았지만 Q1과 Q3에서는 RNN이 앞섰다. 타깃별 우승 모델을 선택하자 평균 logloss가 약 `0.636879`에서 `0.634041`로 개선됐다.

# 주의점

- 타깃별 선택 기준은 동일한 fold와 metric에서 계산한다.
- 후보 수가 늘수록 검증 점수에 과적합할 수 있으므로 선택 규칙을 먼저 고정한다.
- Public LB만으로 타깃별 모델을 다시 고르지 않는다.

# 관련 문서

- [[CH2026 센서 데이터 예측]]
- [[OOF와 Public LB (CH2026)]]
- [[Semantic–Anchor Stack]]

