---
type: meta
title: "Vault Schema"
aliases:
  - World Vault Schema
schema_version: 2
updated: 2026-09-04
---

# 범위

이 문서는 `World`의 폴더, 문서 유형, 핵심 frontmatter, 검색 범위를 정하는 단일 기준이다. 태그 이름과 의미는 [[태그 일람]]에서 관리한다. `.agents/skills/obsidian-paper-notes`는 이 규칙을 복사해 소유하지 않고, 학술 지식 작업에 적용한다.

기존 파일이 이 문서와 다르더라도 자동으로 이동하거나 다시 쓰지 않는다. 새 문서부터 v2를 적용하고, 기존 문서는 관련 작업으로 의미가 바뀌거나 사용자가 마이그레이션을 요청했을 때 고친다.

# 지식 레이어와 폴더

| 레이어 | 위치 | 역할 |
|---|---|---|
| Capture | `00 Inbox/Captures`, `00 Inbox/Attachments` | 아직 분류하지 않은 메모와 첨부 파일 |
| Semantic Knowledge | `10 Papers`, `20 Concepts`, `30 Maps`, `35 Comparisons`, `37 Syntheses` | 오래 남길 학술 지식 |
| Evidence | `40 Sources/Papers` | 논문 PDF 등 원문 |
| Learning Context | `50 Courses/<학기>/<강의>` | 강의 흐름과 개인 학습 기록 |
| Project Memory | `60 Projects` | 프로젝트의 결정, 상태, 세션 기반 기억 |
| Governance | `90 Meta`, `.agents` | 저장소와 agent의 운영 규칙 |
| Operational | `.git`, `.obsidian`, `.claude`, `.remember`, `_workspace`, `.tmp`, `tmp` | 앱·동기화·작업용 파일. 일반 지식 검색에서 제외 |

`comparison`과 `synthesis`의 canonical home은 각각 `35 Comparisons/`, `37 Syntheses/`다. `30 Maps/Comparisons/`와 `30 Maps/Syntheses/`는 이전 구조로 간주한다. 그곳의 기존 파일은 감사에서 이전 후보로 보고하되 자동 이동하지 않는다.

# 문서 유형

| `type` | canonical home | 역할 |
|---|---|---|
| `paper` | `10 Papers/<분야>/` | 한 논문의 주장, 방법, 실험, 한계와 원문을 추적한다 |
| `concept` | `20 Concepts/<기능>/` | 여러 출처에서 다시 쓰는 개념, 모델, 알고리즘, 평가 방법을 설명한다 |
| `map` | `30 Maps/` | 연구 흐름과 읽기 경로를 안내한다 |
| `comparison` | `35 Comparisons/` | 둘 이상의 대상을 같은 판단 축에서 비교한다 |
| `synthesis` | `37 Syntheses/` | 여러 출처의 합의, 긴장, 빈틈을 상위 관점에서 정리한다 |
| `course` | `50 Courses/<학기>/<강의>/`의 강의 index | 강의 식별 정보와 학술·프로젝트 연결만 관리한다 |
| `project` | `60 Projects/` | 프로젝트의 목표, 결정, 현재 상태와 근거 시점을 기록한다 |
| `project-entity` | `60 Projects/Entities/<프로젝트>/` | 한 프로젝트 안에서만 의미가 있는 구성 요소를 설명한다 |
| `meta` | `90 Meta/` | 저장소 운영 기준을 관리한다 |

폴더는 문서의 주 역할 하나만 나타낸다. 다른 관점은 태그, 위키링크, map으로 연결하고 같은 문서를 복제하지 않는다. 이미 다른 레이어에 canonical 문서가 있는 대상은 `project-entity`로 다시 만들지 않는다.

# 공통 frontmatter

학술 지식 문서에는 다음 공통 필드를 둔다.

| 필드 | 규칙 |
|---|---|
| `type` | 위 표의 허용값 가운데 하나 |
| `title` | 논문의 공식 제목 또는 canonical name |
| `summary` | 본문을 열기 전에 범위를 판단할 수 있는 1~2문장, 200자 이하. 위키링크와 서식은 넣지 않는다 |
| `aliases` | 약어, 한국어 이름, 과거 이름 가운데 실제 검색에 필요한 값만 |
| `tags` | [[태그 일람]]에 등록된 값 2~4개 |
| `last_reviewed` | 본문과 출처를 마지막으로 대조한 날짜. `YYYY-MM-DD` |

`summary`는 검색용 미리보기이지 근거가 아니다. 질문에 답하거나 문서를 갱신할 때는 해당 본문이나 원문을 확인한다. 기존 문서는 `summary`나 `last_reviewed`가 없다는 이유만으로 일괄 수정하지 않는다.

## Paper

필수 필드는 `type`, `title`, `summary`, `authors`, `year`, `venue`, `url`, `pdf`, `status`, `read_date`, `tags`, `aliases`다.

`status`는 다음 값만 사용한다.

- `to-read`: 제목, 서지 정보, 원문만 확보한 상태
- `reading`: 읽거나 정리하는 중인 상태
- `read`: 문제, 방법, 근거, 한계까지 1차 정리가 끝난 상태
- `review-needed`: 읽었지만 재검증이나 비교 정리가 필요한 상태

`read_date`는 `read`로 바꿀 때 채운다. `last_reviewed`는 이후 원문과 노트를 다시 대조한 경우에만 사용한다.

## Concept

필수 필드는 `type`, `title`, `summary`, `maturity`, `last_reviewed`, `aliases`, `tags`다.

`maturity`는 문서의 존재와 완성도를 구분한다.

- `stub`: 이름과 canonical 위치만 확보했다. 답변의 근거로 사용하지 않는다.
- `developing`: 설명은 있으나 빈 섹션, 출처 부족, 미확인 내용이 남아 있다.
- `reviewed`: 정의, 핵심 원리, 한계와 출처를 현재 기준으로 검토했다. canonical 설명의 우선 근거로 사용할 수 있다.

`reviewed`에는 유효한 `last_reviewed`가 있어야 한다. 날짜가 오래됐다고 자동으로 등급을 내리지 말고, 감사에서 재검토 후보로만 보고한다.

## Map, Comparison, Synthesis

- `map`: 공통 필드와 연구 흐름, 핵심 개념, 다음 읽기 경로를 갖는다.
- `comparison`: 공통 필드 외에 직접 비교하는 `subjects`와 실제 판단 근거인 `sources`를 둔다.
- `synthesis`: 공통 필드 외에 다루는 범위인 `scope`와 실제로 사용한 `sources`를 둔다.

comparison과 synthesis의 수치나 결론은 dataset, split, metric, 모델 규모, 학습 조건이 맞는지 확인한 뒤 쓴다.

# Course와 Project

강의 index는 `type: course`, `course`, `semester`, `related_maps`, `related_projects`를 사용할 수 있다. 주차별 필기와 과제 노트는 강의의 문맥과 개인 메모를 보존하며 학술 템플릿으로 강제 정규화하지 않는다.

project에는 `status`, `state_source`, `last_verified`를 둔다. `state_source`는 `session-history`, `repository`, `user-confirmed` 중 하나다. 세션에서 복원한 상태는 실제 저장소의 현재 상태처럼 단정하지 않는다. `project-entity`는 반드시 `project` 링크를 갖고, 전역 canonical 문서와 이름·alias가 충돌하지 않아야 한다.

# 검색 범위

질문의 대상을 먼저 정한 뒤 아래 순서로 범위를 잡는다.

| 질문 | 먼저 검색 | 부족할 때 확장 |
|---|---|---|
| 연구·개념 | `20 Concepts` → `30 Maps`, `35 Comparisons`, `37 Syntheses` → `10 Papers` | `40 Sources` |
| 특정 논문 | `10 Papers` | `20 Concepts`, `30 Maps`, `40 Sources` |
| 연구 흐름 | `30 Maps` → `37 Syntheses` → `35 Comparisons` | `10 Papers`, `20 Concepts` |
| 수업 | `50 Courses` | 관련 `10`~`37` |
| 프로젝트 | `60 Projects` | 관련 `20`~`37` |
| Wiki 관리 | `90 Meta`, `.agents` | 필요한 vault 범위 |
| 출처 검증 | 해당 노트 → `40 Sources` | 권위 있는 외부 원문 |

일반 질문에서는 Operational 레이어를 검색하지 않는다. `.agents` 역시 Wiki 운영이나 skill 유지보수 질문일 때만 포함한다.

# 기계 판독 블록

감사 스크립트는 아래 블록을 읽는다. 사람이 읽는 표와 값이 다르면 이 블록을 먼저 고친 뒤 표를 맞춘다.

<!-- vault-schema:start -->
```json
{
  "schema_version": 2,
  "academic_roots": {
    "10 Papers": "paper",
    "20 Concepts": "concept",
    "30 Maps": "map",
    "35 Comparisons": "comparison",
    "37 Syntheses": "synthesis"
  },
  "legacy_locations": {
    "30 Maps/Comparisons": "comparison",
    "30 Maps/Syntheses": "synthesis"
  },
  "required_fields": {
    "paper": ["type", "title", "summary", "authors", "year", "venue", "url", "pdf", "status", "read_date", "tags", "aliases"],
    "concept": ["type", "title", "summary", "maturity", "last_reviewed", "tags", "aliases"],
    "map": ["type", "title", "summary", "last_reviewed", "tags", "aliases"],
    "comparison": ["type", "title", "summary", "last_reviewed", "subjects", "sources", "tags", "aliases"],
    "synthesis": ["type", "title", "summary", "last_reviewed", "scope", "sources", "tags", "aliases"]
  },
  "adoption_warning_fields": ["summary", "maturity", "last_reviewed"],
  "paper_status": ["to-read", "reading", "read", "review-needed"],
  "concept_maturity": ["stub", "developing", "reviewed"],
  "concept_sections": ["정의", "왜 필요한가", "작동 원리", "수식 / 알고리즘", "특징과 한계", "대표 변형", "등장/대표 논문", "관련 개념"]
}
```
<!-- vault-schema:end -->

# 변경 원칙

스키마를 바꿀 때는 이 문서와 [[태그 일람]] 중 해당 기준을 먼저 수정한다. 그다음 template, skill reference, audit script가 기준을 참조하도록 고친다. 프로젝트 회고 문서는 당시 결정과 이유만 남기고 현재 규칙을 복사하지 않는다.
