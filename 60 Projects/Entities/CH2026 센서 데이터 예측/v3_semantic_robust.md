---
type: project-entity
title: "v3_semantic_robust"
aliases: [v3 semantic robust ensemble]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e5410", "codex:019e6277"]
tags: []
---

# 개요

`v3_semantic_robust`는 앱 사용·ambience·활동 sensor를 생활 의미 그룹으로 재구성하고 여러 tree model을 결합한 CH2026 실험 계열이다.

# 대표 semantic group

앱 사용을 social, media, communication, game, finance/shopping, routine/health, browser/search로 묶고 passive/productive 비율을 만들었다. ambience는 speech, silence, music, vehicle, outdoor, sleep_noise 등으로 집계했다.

# 모델

CatBoost, LightGBM, Extra Trees와 XGBoost 후보를 target별 OOF로 비교했다. 단독 제출보다 targetwise ensemble과 Anchor 혼합을 우선했다.

# 관련 문서

- [[CH2026 센서 데이터 예측]]
- [[Semantic–Anchor Stack]]
- [[v2_shift6_robust]]
- [[v4_knn_robust]]

# 세션 근거

- `codex:019e5410`, `codex:019e6277` — semantic feature와 robust ensemble·blend 계보
