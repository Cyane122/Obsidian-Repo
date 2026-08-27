---
type: project-concept
title: "Semantic–Anchor Stack"
aliases: [Semantic Stack, Anchor Stack]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e3f8a", "codex:019e5410", "codex:019e6277"]
tags: []
---

# 정의

센서 열을 의미 있는 생활 신호로 묶은 Semantic 특징과 안정적인 기존 예측을 기준점으로 삼는 Anchor 계열을 여러 트리 모델과 targetwise ensemble로 결합한 CH2026의 로컬 OOF 주력 축이다.

# Semantic 특징

앱 사용을 social, media, communication, game, finance/shopping, routine/health, browser/search 등으로 묶고 passive/productive 비율을 만들었다. ambience는 speech, silence, music, vehicle, outdoor, sleep_noise 같은 의미 그룹으로 집계했다.

# Anchor의 역할

새 모델의 OOF가 좋아도 Public 구간에서 크게 흔들릴 수 있어, 안정적인 기존 예측과 소량 혼합하는 후보를 만들었다. `anchor 90% + semantic 10%`, `anchor 85% + semantic 15%`처럼 보수적인 비율을 별도 제출로 유지했다.

# 확인된 수치

- `model_targetwise`: 약 0.5612
- `anchor_targetwise_selected`: 약 0.5654
- sensor-adjusted kernel: 약 0.6030 → 0.5846

이 값은 로컬 OOF 맥락이며 Public LB와 직접 비교하지 않는다.

# 관련 문서

- [[6시간 이동 생활일]]
- [[Targetwise Model Selection (CH2026)]]
- [[OOF와 Public LB (CH2026)]]

# 세션 근거

- `codex:019e3f8a` — semantic targetwise와 anchor blend 후보
- `codex:019e5410`, `codex:019e6277` — 특징군·OOF·제출 계보
