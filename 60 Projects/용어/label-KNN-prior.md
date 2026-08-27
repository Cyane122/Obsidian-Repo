---
type: project-concept
title: "label-KNN-prior"
aliases: [Label KNN Prior, 날짜 근접 라벨 사전확률]
project: "[[CH2026 센서 데이터 예측]]"
session_refs: ["codex:019e5410", "codex:019e6277"]
tags: []
---

# 정의

같은 피험자의 알려진 날짜 중 예측 날짜와 가까운 라벨을 찾아 사전확률로 사용하는 CH2026 특징이다. 센서 특징만으로는 잡기 어려운 개인별 지속성과 최근 상태를 반영한다.

# 작동 원리

각 target별로 known rows에서 같은 subject의 시간 거리를 계산하고 가까운 라벨을 가중 평균한다. 거리가 멀거나 알려진 라벨이 없으면 전체·피험자 prior로 후퇴할 수 있다.

# 누출 위험

validation row의 라벨이나 미래 정보를 known set에 넣으면 점수가 즉시 과대평가된다. 이 특징은 반드시 fold별 train label만으로 만들어야 하고, interleaved holdout과 마지막 7일 holdout처럼 시간 구조가 다른 검증에서 함께 확인해야 한다.

# 확인된 결과

관련 실험 기록에는 interleaved holdout 평균 logloss 약 0.5750, 보조 interleaved 약 0.5868, 마지막 7일 미래형 약 0.6198이 남아 있다. 분할에 따라 성능 차이가 커 prior의 미래 일반화 한계를 보여준다.

# 관련 문서

- [[Subject-hole CV]]
- [[6시간 이동 생활일]]
- [[OOF와 Public LB (CH2026)]]

# 세션 근거

- `codex:019e5410` — label-KNN 실험과 세 검증 수치
- `codex:019e6277` — 최종 v4 KNN robust 블렌드 계보
