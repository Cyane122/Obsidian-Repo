---
type: project
title: "AI·NLP 학술 지식 Wiki"
aliases:
  - World
  - Obsidian Academic Wiki
category: ai-data-knowledge
session_period: "2026-07-13 ~ 2026-08-27"
last_session_date: 2026-08-27
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

# 폴더 구조

| 위치 | 역할 |
|---|---|
| `10 Papers` | 한 논문의 주장·방법·실험·한계와 PDF 추적 |
| `20 Concepts` | 여러 출처에서 재사용되는 개념·모델·평가 방법 |
| `30 Maps` | 연구 흐름과 읽기 경로 |
| `30 Maps/Comparisons` | 공통 판단 축으로 둘 이상의 대상을 비교 |
| `30 Maps/Syntheses` | 여러 출처의 합의·긴장·공백을 종합 |
| `40 Sources/Papers` | 논문 원문 PDF |
| `50 Courses` | 강의 순서와 개인 학습 기록 |
| `60 Projects` | 과거 AI 세션에서 복원한 개인 프로젝트 |
| `90 Meta` | 태그 사전과 저장소 운영 기준 |

현재 저장소에는 `35 Comparisons`, `37 Syntheses` 폴더도 존재하지만, 전용 스킬의 목표 구조에서는 comparison과 synthesis를 `30 Maps` 하위 유형으로 정의한다. 실제 폴더와 규칙 문서의 차이는 다음 구조 정리 때 확인할 대상이다.

# 문서 유형

## Paper

한 논문의 실제 섹션과 근거를 따라간다. title, authors, year, venue, url, pdf, status, read_date를 YAML로 관리한다. 읽기 상태는 `to-read`, `reading`, `read`, `review-needed`만 허용한다.

## Concept

특정 논문을 빼도 독립적인 교과서 개념인지, 대표 논문이 정의의 일부인 paper-origin concept인지 구분한다. 정의, 필요성, 작동 원리, 수식, 한계, 변형, 대표 논문, 관련 개념을 표준 골격으로 사용한다.

## Map

논문 목록이 아니라 한 연구가 이전 접근의 무엇을 바꾸었고 어떤 한계를 남겼는지를 설명하는 탐색 경로다.

## Comparison

문제 정의, 가정, 방법, 데이터·평가, 결과, 한계처럼 모든 대상에 공통으로 적용할 수 있는 축만 쓴다. 데이터셋과 split, metric, 모델 규모가 다르면 수치를 한 순위로 합치지 않는다.

## Synthesis

개별 논문 하나로는 답할 수 없는 반복 가능한 질문을 다룬다. 합의, 조건별 차이, 충돌하는 근거, 미해결 질문과 다음 읽기 경로를 함께 남긴다.

# 태그 체계

태그는 lowercase kebab-case 계층형 형태만 사용한다. 기본적으로 한 노트에 2~4개를 두며, 다음 네 축으로 제한한다.

- `domain/*`: NLP, machine learning, multimodal, recommender systems, privacy and safety
- `task/*`: language modeling, recommendation, text rewriting, summarization 등
- `method/*`: transformer, attention, matrix factorization, differential privacy 등
- `theme/*`: evaluation, generalization, computational efficiency 등

논문 제목, 저자, 연도, 개별 모델명과 데이터셋은 태그가 아니라 속성 또는 위키링크로 표현한다. 새 태그는 적어도 세 노트 이상에서 재사용될 때만 태그 일람에 먼저 등록한다.

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

2026-08-27 현재 프로젝트 Wiki를 추가하며 계속 사용 중이다. 현재 감사에서는 프로젝트 노트의 unresolved link와 고아 노트가 없지만, 기존 비교 문서 하나에 type·folder 불일치가 남아 있다.

- 실제 `35 Comparisons`, `37 Syntheses`와 스킬 목표 구조의 차이 정리
- 기존 비교 문서의 type·folder mismatch 검토
- 새 프로젝트 문서가 학술 Wiki 검색을 방해하지 않도록 metadata 규칙 고정
- 프로젝트 세션과 논문·개념 노트를 연결할 기준 마련
- 시간이 지나며 오래된 서지·평가 결과를 갱신하는 정책 마련

# 관련 고유명사

- [[obsidian-paper-notes]]
- [[태그 일람]]
- [[audit-vault.ps1]]

# 세션 근거

- `019f597a` (2026-07-13): `obsidian-paper-notes` 스킬 설계와 태그·폴더 규칙 작성
- 같은 세션 후속 작업: 루트 노트 74개 마이그레이션과 감사
- `01a02773`, `01a0277d` (2026-08-22): 논문 PDF 보관, paper 노트 상세화, 문체 정리와 지도 연결
- `01a042ef` (2026-08-27): 개인 프로젝트 세션 Wiki 확장
