---
type: project-concept
title: "Narrative Director"
aliases: [서사 디렉터]
project: "[[서사 생성 모델 연구 프로토타입]]"
session_refs: ["codex:019fc1f0"]
tags: []
---

# 정의

`Narrative Director`는 인물 시뮬레이션의 결과를 그대로 문장으로 옮기지 않고, 무엇을 보여주고 숨길지, 누구의 시점으로 어떤 순서와 거리에서 전달할지를 선택하는 중간 계층이다.

# 제안된 전체 구조

```text
Character Genome + 기억 회수 + 현재 상황
→ 내적 반응과 행동 후보
→ Narrative Director
→ Prose Realizer
→ 독자의 지식·감정·예상 변화
```

# 필요한 이유

인물 상태와 사건이 정확해도 모델은 모든 감정과 복선을 직접 설명해 버릴 수 있다. Narrative Director가 없으면 ‘무슨 일이 일어나는가’와 ‘독자가 어떻게 알게 되는가’가 한 단계에 섞여 산문이 해설조로 굳는다.

# 첫 실험에서의 처리

처음부터 별도 neural module로 만들지 않는다. [[Narrative Intent]]를 구조화된 입력으로 넣어 director의 기능을 프롬프트 수준에서 흉내 내고, Reader State 변화에 실제 효과가 있는지 확인한다. 기준선이 유효할 때만 planning head나 fine-tuning을 검토한다.

# 관련 문서

- [[Story State]]
- [[Reader State]]
- [[Narrative Intent]]

# 세션 근거

- `codex:019fc1f0` — Character simulator와 Prose Realizer 사이의 비어 있던 선택 층을 Narrative Director로 제안
