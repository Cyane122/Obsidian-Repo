---
type: project-entity
title: "v4_knn_robust"
aliases: [v4 KNN robust ensemble]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e5410", "codex:019e6277"]
tags: []
---

# 개요

`v4_knn_robust`는 같은 피험자의 가까운 날짜 라벨을 prior로 쓰는 [[label-KNN-prior]]를 robust ensemble에 결합한 CH2026 실험 계열이다.

# 검증 차이

interleaved holdout에서는 평균 logloss 약 0.5750, 보조 interleaved에서는 0.5868, 마지막 7일 미래형 holdout에서는 0.6198이 기록됐다. 시간상 가까운 label을 이용하는 만큼 검증 방식에 민감했다.

# 최종 blend에서의 비중

사용자가 확인한 Public 최고 제출에서 `v4_knn_robust`는 43.75%로 가장 큰 성분이었다. 이는 Public 결과일 뿐 Private 일반화가 확정됐다는 뜻은 아니다.

# 관련 문서

- [[CH2026 센서 데이터 예측]]
- [[label-KNN-prior]]
- [[v2_shift6_robust]]
- [[v3_semantic_robust]]
- [[blend_friend25_v3robust3125_v4knnrobust4375_submission.csv]]

# 세션 근거

- `codex:019e5410` — Label KNN 실험
- `codex:019e6277` — 최종 blend의 v4 계열
