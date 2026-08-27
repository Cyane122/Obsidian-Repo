---
type: project-concept
title: "Narrative Intent"
aliases: [서사 의도]
project: "[[서사 생성 모델 연구 프로토타입]]"
session_refs: ["codex:019fc1f0"]
tags: []
---

# 정의

`Narrative Intent`는 이번 장면에서 어떤 정보를 드러내거나 숨기고, 독자의 지식·감정·기대를 어느 방향으로 바꿀지 명시하는 목표다. Story State가 현재 사실이라면 Narrative Intent는 그 사실을 독자에게 어떻게 경험시킬지에 관한 계획이다.

# 표현할 수 있는 목표

- 단서를 노출하되 중요성을 강조하지 않는다.
- 주인공은 모르지만 독자는 위험을 알게 한다.
- 특정 인물에 대한 의심을 높이되 확정하지 않는다.
- 장면 끝에서 긴장을 높이고 해소는 미룬다.
- 이전에 심은 단서를 payoff한다.

# 모델 입력에서의 위치

초기 기준선은 `<story_state>`, `<reader_state>`, `<narrative_intent>`, `<prose>` 같은 구조화된 구간을 기존 모델에 제공하는 방식이다. 효과가 확인된 뒤에야 instruction tuning이나 adapter, 별도 planning module을 검토한다.

# 평가

산문 품질만 평가하면 의도가 지켜졌는지 알 수 없다. 공개해야 할 정보의 포함·비포함, 독자 질문의 변화, clue payoff, 상태 일관성과 함께 측정해야 한다.

# 관련 문서

- [[Story State]]
- [[Reader State]]
- [[Narrative Director]]

# 세션 근거

- `codex:019fc1f0` — 장면별 정보 공개와 독자 상태 변화를 모델 입력으로 분리한 설계
