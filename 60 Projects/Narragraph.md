---
type: project
title: "Narragraph"
aliases:
  - narragraph
category: ai-data-knowledge
session_period: "2026-07-01 ~ 2026-07-03"
last_session_date: 2026-07-03
session_refs:
  - "codex:019f2875"
tags:
  - domain/nlp
  - method/large-language-model
---

# 프로젝트 정의

Narragraph는 손으로 작성한 장면과 규칙을 중심에 두고, LLM은 정해진 슬롯에서만 산문을 생성하도록 제한한 QSP 스타일 인터랙티브 픽션 엔진이다. GraphRAG가 자유 대화와 그래프 상태 갱신을 중심으로 발전한 반면, Narragraph는 하이퍼링크·선택지·상시 상태 패널을 통해 플레이어가 세계 구조를 직접 탐색하게 한다.

이 프로젝트가 풀려던 문제는 “그래프에 상태가 많아도 자유 대화형 챗봇 UI에서는 그 구조가 잘 보이지 않는다”는 것이었다. Degrees of Lewdity와 Twine 계열 게임처럼 본문과 선택지가 진행을 통제하면, 위치·사건·조건·스탯 변화가 플레이어에게 더 명확하게 드러난다. 대신 모든 장면을 작성해야 하는 콘텐츠 비용이 늘어나므로, LLM은 작가가 비워 둔 생성 구간만 맡는다.

# 핵심 불변식

## 단일 런타임 권위

인메모리 `GameState`가 유일한 런타임 권위다. NetworkX 그래프는 위치와 연결 관계를 표현하지만, Kuzu와 벡터 인덱스는 필요할 때 파생하는 projection일 뿐이다. 게임 루프가 외부 임베디드 DB에 막히지 않으며, snapshot은 권위 상태만 저장한다.

## 두 개의 실행 lane

클릭한 anchor의 sigil이 실행 경로를 결정한다.

| sigil | 의미 | 실행 경로 |
|---|---|---|
| `>` | 위치 이동 | 결정론적 lane |
| `!` | 사건·행동 실행 | 결정론적 lane |
| `?` | 조사 | 결정론적 lane |
| `@` | 대화·생성 슬롯 | LLM lane |

M1 설계 단계에서 `@`를 아직 구현하지 않았더라도 결정론적 이벤트로 잘못 처리하지 않고, 명시적으로 지원 전 상태를 반환해야 한다고 정리했다.

## 세 단계 상태

- Hard State: 위치, 시간, 돈, 인벤토리, 퀘스트, 잠금 플래그, 에너지·스트레스·집중, 동의·콘텐츠 게이트
- Bounded Soft State: 호감, 신뢰, 기분, 평판
- Narrative State: 기억, 인상, 소문

LLM은 Hard State를 직접 바꿀 수 없다. Soft State에는 상한과 정책 검증이 적용되고, Narrative State 변경에는 원인이 된 사건 `reason_event`가 반드시 붙는다. LLM이 내는 것은 어디까지나 proposed delta이며, 엔진이 검증한 뒤에만 반영한다.

# 게임 팩과 엔진의 분리

엔진에는 구체적인 세계와 인물 이름을 넣지 않는다. 게임 팩은 다음과 같은 데이터로 구성된다.

```text
games/<pack>/
├─ world.yaml
├─ scenes/*.md
├─ characters/*.yaml
├─ items/*.yaml
├─ hooks.py
├─ policy.yaml
├─ schedule.yaml
├─ theme.css
└─ optional stat_profile
```

엔진은 상태 모델, DSL, 검증, 렌더링, 저장, LLM 슬롯이라는 프레임만 제공한다. 구체적인 장면, 수치, 조건, 성인 상태 축과 문구는 게임 팩이 제공한다.

# Markdown DSL

## 표현 span

`[#token]{text}` 형식은 색상, 크기, 속삭임, 외침, 흔들림, 흐림 같은 표현을 CSS class로 바꾼다. 표현만 바꿀 뿐 상태 변화는 일으키지 않는다.

## 상호작용 anchor

```markdown
[공원으로 간다](>loc_park)
[문을 연다](!evt_open_door)
[인물에게 말한다](@char_x?topic=music)
[책상을 살핀다](?item_desk)
[[#red]{이름}](@char_x)
```

파서 설계에서 특히 주의한 부분은 중첩 bracket과 `?`의 이중 의미였다. anchor label 안에 표현 span이 들어갈 수 있어 단순 정규식으로 처리하면 깨진다. 또한 `?loc_x`의 첫 `?`는 조사 sigil이지만, `@char_x?topic=music`의 `?`는 query separator다. 따라서 href의 첫 글자를 sigil로 먼저 분리한 뒤 나머지를 query로 파싱한다.

문법 오류, 존재하지 않는 ID, 허용되지 않은 행동, 런타임 guard 실패는 서로 다른 오류로 취급한다. 정적 목적지와 ID는 가능하면 pack load 단계에서 검증한다.

# 결정론적 턴과 스냅샷

결정론적 행동의 공통 흐름은 다음과 같다.

```text
파싱된 행동
→ 참조·조건 검증
→ 좁은 상태 변경 API
→ 이벤트 로그
→ 4-panel 렌더 계약
→ 필요 시 snapshot
```

핸들러마다 서로 다른 반환 형식을 만들지 않고 하나의 턴 결과 계약을 공유하는 것이 M1의 주요 설계 결정이었다. Snapshot에는 `GameState`처럼 복구에 필요한 권위 상태만 저장하고, WorldGraph·파싱된 장면·렌더 결과 같은 파생물은 다시 만든다. 엔진 버전과 게임 팩 버전을 함께 저장해 이후 migration 가능성을 남긴다.

# 시간과 스케줄

시간은 현실 시간에 따라 흐르지 않는다. 이동 edge의 minutes, 행동 cost, 사건 duration처럼 플레이어 행동의 비용으로만 진행한다. 이 때문에 스탯이나 성인 상태 축의 decay도 매 렌더나 실시간 timer가 아니라 scheduler tick에서 처리하는 방향이 선택됐다.

행동마다 decay를 걸면 행동을 잘게 쪼갠 게임 팩과 크게 묶은 게임 팩의 밸런스가 달라진다. 장면 입·퇴장만 기준으로 삼으면 장면 길이와 실제 경과 시간이 어긋난다. scheduler가 action cost로 누적된 시간만 보고 처리하는 편이 엔진 규칙과 일치한다.

# 성인 시스템 FSM

성인 시스템은 구체적인 콘텐츠가 아니라 frame만 제공한다.

- 축, 신체 슬롯, 의복 슬롯, 조건 registry
- 성인 여부·프라이버시·진행 플래그·동의·축 임계치를 확인하는 결정론적 gate
- 상태와 허용 행동을 관리하는 FSM runner
- 현재 상태의 안전한 힌트만 받아 산문을 만드는 FSM-guided writer

성인 상태의 Hard State와 전이는 LLM이 쓰지 않는다. 장면을 끝낼 때 작가가 정의한 관계·기억 변화는 LLM proposal validator에 억지로 통과시키기보다 GameState의 좁은 API로 직접 적용하되, Narrative State에는 `reason_event`와 이벤트 로그를 남기는 방향이 더 일관적이라고 검토됐다.

## raw tag 방화벽

Condition의 `raw_tag`는 LLM에 노출하지 않는다. Writer에는 `safe_hint`와 `public_description`만 제공한다. 기분과 기억 summary 같은 다른 prompt-visible 필드에 raw tag가 복사되면 우회 유출될 수 있으므로, prompt view adapter와 commit 시 sanitization이 필요하다는 위험도 확인됐다.

## flag guard와 안전 힌트 변형

게임 팩이 미리 굴린 NPC 선택이나 속성에 따라 한 행동만 보여주기 위해 `required_flags`·`forbidden_flags` guard가 추가됐다. guard를 통과하지 못한 행동은 disabled로 표시하지 않고 숨긴다. 모든 분기가 막혀도 엔진이 제공하는 abort는 남지만, 콘텐츠 dead end가 되지 않도록 작가는 정확히 한 분기 또는 fallback을 보장해야 한다.

`safe_hint`는 flag 값에 따라 다른 작가 작성 문구를 선택할 수 있다. flag가 없거나 변형 key가 없으면 기본 `safe_hint`로 돌아간다. 문자열·숫자·불리언 값은 문자열 key로 해석하므로 YAML key quoting 규칙도 문서화 대상이었다. 최종 구현에서는 UI의 `_adult_panel`과 LLM의 `build_fsm_request`가 같은 `resolve_hint`를 사용했고, 변형 표나 raw flag 값은 LLM에 넘기지 않았다.

# 캐릭터 생성과 게임 팩 저작 사례

엔진에 별도 캐릭터 생성 UI나 자유 텍스트 입력이 없기 때문에, 캐릭터 커스터마이즈도 데이터로 저작한다.

```text
성별 선택 장면
→ !event hook으로 pc_gender 설정
→ 배경 선택 장면
→ !event hook으로 초기 돈·인벤토리·스탯 설정
→ 확인 장면
→ 실제 >move anchor로 첫 플레이 공간 진입
```

설정 장면 사이에서는 hook이 직접 위치를 바꿔도 되지만, 살아 있는 월드에 들어가는 마지막 전환은 실제 move anchor를 사용해야 한다. event handler 내부의 `move_player()`는 화면상 위치는 바꾸지만 목적지의 `on_enter`, NPC observe, autosave를 건너뛰기 때문이다.

Finland slice-of-life 팩 상담에서는 공통 도시 hub를 공유하고 대학생·보호시설 출신·가출 배경마다 집과 초기 자원·관계만 다르게 두는 구성이 추천됐다. 세 배경을 별도 게임처럼 복제하면 상점·거리·NPC·일정을 모두 세 번 작성해야 하므로, 배경별 집과 도입부만 분리하는 것이 적절하다고 정리했다.

# 확인된 구현 범위와 검증

초기 M1은 manifest loader, GameState, NetworkX WorldGraph, SceneIR parser, 결정론적 turn lane, 4-panel JSON render contract, snapshot save/load를 목표로 했다. 이후 다음 기능까지 세션에서 확인된다.

- 시간·계절·조명 조건과 almanac token 검증
- scene frontmatter의 입력 정의와 참조 검사
- 성인 FSM, gate, condition registry, 안전 힌트
- 플래그 기반 행동 guard와 hint variant
- 게임 팩 저작·캐릭터 생성 패턴

2026-07-03 최종 검토에서는 새 flag guard와 hint variant를 포함해 145개 테스트가 통과했다. 다섯 개 테스트가 이 기능을 위해 추가됐고, missing flag가 문자열 `"None"` variant로 흘러가지 않고 기본 hint로 돌아가는 것도 확인됐다.

# GraphRAG와의 관계

두 프로젝트는 같은 문제를 다른 권위 모델로 풀었다.

| 축 | GraphRAG | Narragraph |
|---|---|---|
| 진행 방식 | 자유 입력과 Actor 응답 | 본문·링크·선택지 중심 |
| 상태 권위 | Kuzu Graph 또는 Wiki 문서 | 인메모리 GameState |
| LLM 역할 | 장면 서술과 상태 추출의 중심 | 제한된 prose slot |
| 콘텐츠 | 월드 설정과 prompt 자산 | 작가가 저작한 장면과 hook |
| 장점 | 높은 자유도와 자율 시뮬레이션 | 높은 재현성과 작가 통제 |
| 부담 | 상태 추출·검색·비용 복잡성 | 콘텐츠 저작량 증가 |

# 현재 상태와 남은 과제

마지막 확인일은 2026-07-03이다. 당시 엔진 기능과 테스트는 빠르게 확장됐지만, 이후 세션 기록은 없다.

- character creation을 공식 엔진 기능으로 둘지 게임 팩 패턴으로만 남길지
- event hook 내부 이동의 lifecycle 차이를 엔진에서 고칠지 문서 규칙으로 유지할지
- raw tag가 기분·기억 경로로 우회 유출되지 않는 구조적 검증
- snapshot schema migration 정책
- 실제 게임 팩의 장기 콘텐츠 제작 비용 검증

# 세션 근거

- `019f1c01` (2026-07-01): M1 설계 위험과 DSL parsing 규칙
- `019f1d50` (2026-07-01): 성인 FSM의 상태 권위·decay·raw tag 검토
- `019f2689` (2026-07-03): Finland 게임 팩과 데이터 기반 캐릭터 생성 설계
- `019f285e` (2026-07-03): flag guard와 safe_hint variant 설계
- `019f2875` (2026-07-03): 구현 후 회귀 검토, 145개 테스트 통과

# 관련 문서

- [[GraphRAG]]
- [[서사 생성 모델 연구 프로토타입]]
- [[Large Language Model]]
- [[Prompt Engineering]]
