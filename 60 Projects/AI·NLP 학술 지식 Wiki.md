---
type: project
title: "AI·NLP 학술 지식 Wiki"
summary: "논문·개념·연구 흐름을 연결된 지식으로 관리하고, 전용 스킬로 구조와 품질을 유지하는 Obsidian 프로젝트다."
aliases:
  - World
  - Obsidian Academic Wiki
category: ai-data-knowledge
session_period: "2026-07-13 ~ 2026-08-27"
last_session_date: 2026-08-27
status: active
state_source: repository
last_verified: 2026-09-04
session_refs:
  - "codex:019f597a"
  - "codex:01a02773"
tags:
  - domain/nlp
  - theme/evaluation
---

# 프로젝트 정의

AI·NLP 학술 지식 Wiki는 논문을 읽은 순서대로 요약문만 쌓는 저장소가 아니다. 논문에서 반복해서 쓰이는 개념은 canonical 개념 노트로 분리한다. 여러 논문 사이의 계보는 지도에, 같은 문제를 푸는 방법의 차이는 비교에, 여러 출처를 함께 봐야 나오는 결론은 종합에 남기는 Obsidian 기반 지식 시스템이다.

저장소 자체뿐 아니라 AI 에이전트가 이 구조를 안정적으로 유지하도록 만든 `obsidian-paper-notes` 스킬까지 프로젝트 범위에 포함된다.

# 시작 배경

초기 저장소에는 논문과 개념 Markdown 파일이 루트에 섞여 있었고 태그 표기도 일관되지 않았다.

- `#NLP`, `#RNNs`처럼 대소문자와 복수형이 섞임
- `noise_injection`, `matrix_factorization`처럼 underscore 표기 사용
- `#training-stabilty` 같은 오탈자
- `#MCTS`, `#ELMo`처럼 개별 모델·알고리즘 이름을 모두 태그로 사용
- 논문·개념·지도 파일이 같은 위치에 섞여 탐색 경로가 불분명

새 스킬은 아무 키워드나 태그로 삼는 습관을 막고, 폴더는 문서의 주 역할을, 태그와 위키링크는 교차 분류를 담당하도록 설계됐다.

# 핵심 운영 원칙

## Index first

작업 전에 전체 본문을 무작정 읽지 않는다. 관련 `30 Maps`와 파일명, YAML title·aliases·type·tags를 먼저 수집해 레지스트리를 만들고, 실제로 관련 있는 문서만 읽는다.

## Update, do not duplicate

같은 논문·개념·질문이 이미 있으면 새 파일에 숫자를 붙이지 않고 기존 canonical 문서를 확장한다. 더 일반적이고 정확한 정의를 기준으로 병합하되, 사용자가 직접 쓴 해석과 불완전한 메모는 보존한다.

## One canonical home

문서는 한 폴더에만 둔다. 다른 관점은 태그와 지도에서 연결한다. 예를 들어 추천 논문이 NLP 기법도 사용하더라도 주 연구 공동체가 추천 시스템이면 Recommender Systems 폴더에 둔다.

## Provenance visible

논문이 실제로 주장한 내용, 저자의 해석, 여러 출처의 공통점, 노트 작성자의 직관을 구분한다. 확인하지 않은 수치와 서지 정보를 채우지 않는다.

## Link deliberately

모든 기술 명사를 위키링크로 만들지 않는다. 이미 canonical 문서가 있거나, 여러 문서에서 반복되거나, 현재 문서를 이해하는 데 독립 정의가 필요할 때만 연결한다.

# 운영 기준

현재 폴더, 문서 유형, frontmatter, 검색 범위는 [[Vault Schema]]를 단일 기준으로 삼는다. 태그 이름과 의미는 [[태그 일람]]에서 관리한다. 이 프로젝트 문서에는 결정의 배경과 운영 경험만 남기며 현재 규칙을 복사하지 않는다.

2026-09-04에 comparison과 synthesis의 canonical home을 각각 `35 Comparisons`, `37 Syntheses`로 확정했다. 이전 위치인 `30 Maps/Comparisons`, `30 Maps/Syntheses`의 기존 파일은 자동으로 옮기지 않고, 승인된 migration에서만 처리한다.

# 전용 스킬

`D:\World\.agents\skills\obsidian-paper-notes` 아래에 프로젝트 전용 스킬을 만들었다. 스킬은 다음을 묶는다.

- 논문 PDF 수집과 저장 위치 결정
- 논문·개념·지도·비교·종합 템플릿
- 기존 문서 레지스트리와 중복 방지
- 읽기 상태와 원문 PDF 연결
- 통제된 태그 선택
- 고아 노트, 미해결 링크, 메타데이터 오류 감사
- 기존 루트 노트 마이그레이션과 정규화

상세 규칙은 SKILL 본문에 모두 넣지 않고 `references`와 `scripts`에 분리해 필요한 작업에서만 읽게 했다.

# 초기 마이그레이션

2026-07-13 세션에서 루트 Markdown 74개를 조사해 논문 12개, 지도 1개, 개념 61개로 분류했다. 이동 전에 모든 원본이 정확히 하나의 대상에 대응하고, 목적지가 `D:\World` 안에 있으며, 중복 목적지가 없는지 검증했다.

마이그레이션은 다음 원칙으로 진행됐다.

- 본문을 다시 쓰지 않고 기존 태그 줄과 상단 정보를 YAML로 변환
- 빈 노트도 삭제하지 않고 `to-read` 논문 또는 개념 stub로 보존
- 파일명 오탈자와 연결된 위키링크를 함께 수정
- 이동 뒤 링크·태그·구조 감사를 다시 실행

감사 스크립트가 Windows의 대소문자 무시 때문에 canonical 이름까지 이전 이름으로 오판하는 문제도 발견돼, 도구의 판정 자체도 검증해야 한다는 교훈이 남았다.

# 실제 논문 편입 사례

2026-08-22에는 텍스트 익명화 metric survey와 CluSanT 논문 PDF를 보관하고 상세 노트를 작성했다.

- 원문 PDF를 `40 Sources/Papers/NLP`에 저장
- 대응하는 paper 노트를 `10 Papers/NLP`에 생성
- 번역투와 과도한 영어 혼용을 다듬되 수식·링크·주장 강도는 유지
- [[프라이버시 보존 텍스트 재작성]] 지도에 연결해 고아 노트를 줄임
- 감사 스크립트로 unresolved link와 metadata를 확인

이 작업에서 개별 노트를 잘 쓰는 것만으로는 부족하고, 관련 지도에 연결해야 지식 Wiki 안에서 찾을 수 있다는 원칙이 실제로 적용됐다.

# 현재 주요 지식 흐름

- [[논문 읽기 프로젝트]]: 전체 읽기 목록과 프로젝트 운영
- [[NLP 표현 학습의 흐름]]: 분산 표현에서 Transformer까지의 계보
- [[암시적 피드백 추천]]: 암시적 상호작용 기반 추천 연구
- [[비전-언어 사전학습]]: 이미지·텍스트 표현 학습 흐름
- [[프라이버시 보존 텍스트 재작성]]: 텍스트 익명화·재식별 공격·평가

# 감사와 품질 관리

`audit-vault.ps1`은 다음을 검사한다.

- 중복 basename과 alias 충돌
- frontmatter 누락과 폴더·type 불일치
- 미등록 태그와 태그 수 초과
- 존재하지 않는 PDF와 잘못된 읽기 상태
- 미해결 위키링크와 고아 문서 후보
- map·synthesis가 필요한 주제

감사 결과만으로 파일을 자동 수정하지 않는다. 수정 우선순위는 깨진 구조, 잘못된 메타데이터, 링크, 중복, 종합 부족 순이다.

# 현재 상태와 남은 과제

2026-09-04에 Vault Schema v2와 scope-first 검색 정책을 도입하고, 스킬 안에 흩어져 있던 폴더 규칙을 단일 기준으로 모았다. 기존 노트와 legacy 위치는 일괄 변경하지 않았으며 감사 결과에서 migration 후보로 관리한다.

- 기존 학술 노트의 `summary`, concept `maturity`, 지식 문서 `last_reviewed`는 관련 문서를 다시 볼 때 점진적으로 채운다.
- legacy comparison·synthesis 파일은 별도 승인 뒤 이동한다.
- 오래된 서지·평가 결과를 재검토할 시점과 기준은 실제 사용 경험을 보고 보완한다.

# 관련 고유명사

- [[obsidian-paper-notes]]
- [[태그 일람]]
- [[audit-vault.ps1]]

# 세션 근거

- `019f597a` (2026-07-13): `obsidian-paper-notes` 스킬 설계와 태그·폴더 규칙 작성
- 같은 세션 후속 작업: 루트 노트 74개 마이그레이션과 감사
- `01a02773`, `01a0277d` (2026-08-22): 논문 PDF 보관, paper 노트 상세화, 문체 정리와 지도 연결
- `01a042ef` (2026-08-27): 개인 프로젝트 세션 Wiki 확장
