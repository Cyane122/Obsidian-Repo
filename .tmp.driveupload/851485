---
type: project-concept
title: "Story State"
aliases: [서사 상태]
project: "[[서사 생성 모델 연구 프로토타입]]"
session_refs: ["codex:019fc1f0"]
tags: []
---

# 정의

`Story State`는 서사 세계에서 실제로 무엇이 참인지, 인물들이 무엇을 알고·믿고·기억하는지, 관계와 갈등이 어디까지 진행됐는지를 구조화한 상태다. 단순 줄거리 요약보다 다음 장면 생성에 필요한 인과적 제약을 담는다.

# 구성 예

- 세계의 객관적 사실과 현재 사건
- 인물별 지식·믿음·오해·기억
- 관계와 갈등의 현재 단계
- 아직 회수되지 않은 단서와 약속
- 장면에서 바꿀 수 있는 상태와 유지해야 할 상태

# 역할

기존 decoder-only 모델에 구조화된 텍스트나 special token 형태로 제공해, 장문 생성 중 인물·사건 일관성을 높이는 기준선으로 사용한다. 처음부터 새 Transformer를 학습하기보다 이 상태 표현 자체가 효과가 있는지 먼저 검증한다.

# 한계

Story State만 정확해도 산문은 사건 보고서처럼 될 수 있다. 무엇을 독자에게 보여줄지, 숨길지, 어떤 순서로 알려줄지는 [[Reader State]]와 [[Narrative Intent]]가 담당한다.

# 관련 문서

- [[Reader State]]
- [[Narrative Intent]]
- [[Narrative Director]]

# 세션 근거

- `codex:019fc1f0` — 세계·인물 상태와 산문 선택 층을 분리한 초기 연구 구상
