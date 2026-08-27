---
type: project-concept
title: "Reader State"
aliases: [독자 상태]
project: "[[서사 생성 모델 연구 프로토타입]]"
session_refs: ["codex:019fc1f0"]
tags: []
---

# 정의

`Reader State`는 독자가 현재 무엇을 알고, 의심하고, 기대하며, 어떤 인물에게 애착을 느끼는지를 나타내는 잠재 상태다. 좋은 산문을 `세계 상태 → 텍스트`가 아니라 `ReaderState(t) → 산문 → ReaderState(t+1)`의 변화로 보려는 연구 가설에서 나왔다.

# 최소 변수 후보

- 알고 있는 사실과 숨겨진 사실
- 각 가설에 대한 의심·확신
- 다음 사건에 대한 기대
- 긴장, 공포, 애착, 안도 같은 목표 감정
- 특정 인물의 의도에 대한 해석

# 같은 사건이 달라지는 예

방 안에 살인자가 숨어 있다는 Story State가 같아도 독자에게 먼저 존재를 알려주면 서스펜스가 되고, 소리와 흔적만 주면 공포가 되며, 무의미해 보이는 단서만 심으면 반전을 준비할 수 있다. 차이는 사건이 아니라 독자에게 배분한 정보다.

# 평가와 난점

Reader State는 정답이 직접 관측되지 않는다. 독자 질문, 정보 회상, 예상 선택, 긴장도·애착도 평정으로 근사해야 한다. 모델 평가도 perplexity만이 아니라 의도한 정보 공개와 독자 상태 변화가 실제로 일어났는지를 봐야 한다.

# 관련 문서

- [[Story State]]
- [[Narrative Intent]]
- [[Narrative Director]]

# 세션 근거

- `codex:019fc1f0` — ReaderState(t)에서 ReaderState(t+1)로 보는 산문 모델 가설
