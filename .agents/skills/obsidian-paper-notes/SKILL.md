---
name: obsidian-paper-notes
description: Obsidian의 AI·NLP·ML 학술 위키에 논문·PDF·웹 자료를 편입하고 paper·concept·map·comparison·synthesis 노트를 생성·갱신·연결·질의·복습·감사한다. 사용자가 논문 정리, 개념 문서, 논문 비교, 주제 종합, 위키 질의, 링크·태그·PDF·읽기 상태 관리를 요청할 때 사용한다. 일반 Obsidian 문법 안내나 비학술 메모 편집만 필요한 작업에는 사용하지 않는다.
---

# Obsidian Academic Wiki

자료를 고립된 요약으로 쌓지 않고 기존 지식과 연결된 학술 위키로 편입한다. 본문은 간결한 한국어 문어체로 쓰고 기술 용어와 canonical wikilink는 English-first로 유지한다.

## 기준과 라우팅

폴더, 문서 유형, frontmatter, 질문별 검색 범위는 저장소의 `90 Meta/Vault Schema.md`를 따른다. 태그 이름과 의미는 `90 Meta/태그 일람.md`가 단일 기준이다. skill reference와 template가 두 문서와 다르면 vault의 기준을 우선한다.

| 작업 | 읽을 자료 |
|---|---|
| 자료 수집, 병합, 비교, 종합, 위키 질의 | [references/wiki-workflow.md](references/wiki-workflow.md) |
| 검색 범위와 읽기 순서 | [references/retrieval-policy.md](references/retrieval-policy.md) |
| 위키링크 생성·검증 | [references/linking-policy.md](references/linking-policy.md) |
| 출처, 주장 강도, 해석 구분 | [references/provenance-policy.md](references/provenance-policy.md) |
| MCP·CLI·파일시스템 선택과 쓰기 안전 | [references/obsidian-tools.md](references/obsidian-tools.md) |
| 새 문서 생성 | [references/note-templates.md](references/note-templates.md)에서 해당 유형만 |
| PDF 보관·연결 | [references/pdf-library.md](references/pdf-library.md) |
| 읽기 상태 변경 | [references/reading-workflow.md](references/reading-workflow.md) |
| 구조·메타데이터·링크 감사 | [references/audit-policy.md](references/audit-policy.md) |
| 승인된 기존 구조·태그 정리 | [references/legacy-migration.md](references/legacy-migration.md) |

## 핵심 원칙

1. **Compile, do not merely summarize.** 새 자료의 재사용 가능한 지식을 기존 canonical 문서에 편입하고, 자료 하나를 노트 하나로 기계적으로 대응시키지 않는다.
2. **Index first.** 관련 지도, 제목, aliases, tags, frontmatter를 먼저 훑고 필요한 본문만 읽는다.
3. **Update, do not duplicate.** 같은 논문·개념·질문·비교가 있으면 기존 문서를 확장한다. 숫자 접미사로 중복을 회피하지 않는다.
4. **Keep provenance visible.** 원문 사실, 저자의 주장, 여러 출처의 공통점, 외부 해설, 불확실한 해석을 구분한다. 확인하지 못한 수치나 결론을 만들지 않는다.
5. **One canonical home.** 폴더는 주 분류를, 태그와 위키링크와 지도는 교차 분류를 담당한다. 같은 문서를 여러 폴더에 복제하지 않는다.
6. **Preserve human work.** 기존 문체, 수식, 링크, 불완전한 섹션, 사용자의 개인적 메모를 삭제하거나 덮어쓰지 않는다.
7. **Link deliberately.** 독립 문서로 발전할 가치가 있는 대상만 연결하고 첫 자연스러운 언급을 우선한다. 존재하지 않는 링크나 stub을 자동 생성하지 말고 의도를 보고한다.
8. **Make broad changes explicit.** 사용자가 요청하지 않은 대량 이동, 전면 재태깅, 자동 교차 링크 삽입은 하지 않는다. 감사는 기본적으로 report-only로 수행한다.

## 문서 유형

| 유형 | 역할 | 기본 위치 |
|---|---|---|
| `paper` | 한 논문의 주장·방법·실험·한계와 원문 PDF를 추적한다 | `10 Papers/` |
| `concept` | 여러 출처에서 재사용되는 개념·모델·알고리즘·평가 방법을 정의한다 | `20 Concepts/` |
| `map` | 분야의 연구 흐름과 탐색 경로를 설명한다 | `30 Maps/` |
| `comparison` | 둘 이상의 논문·개념을 동일한 판단 축으로 비교한다 | `35 Comparisons/` |
| `synthesis` | 여러 출처의 합의·긴장·빈틈을 재사용 가능한 설명으로 종합한다 | `37 Syntheses/` |

## 표준 작업 흐름

1. 요청을 `ingest`, `update`, `query`, `compare`, `synthesize`, `review`, `audit` 중 하나 이상으로 판별한다.
2. 질문이 학술 지식, 특정 논문, 연구 흐름, 수업, 프로젝트, Wiki 관리 중 어디에 속하는지 먼저 정한다. 이 스킬은 `10`~`40`의 학술 영역을 맡고, 수업·프로젝트 자체의 편집은 범위 밖이다.
3. [references/retrieval-policy.md](references/retrieval-policy.md)의 사다리로 identity → structured → lexical → graph → semantic 순서에서 후보를 좁힌다. 필요한 섹션만 읽고 full read는 마지막에 한다.
4. 각 대상을 `create`, `update`, `link`, `mention only`, `unchanged`로 판정한다. 새 자료에서 paper에 남길 내용과 canonical concept·comparison·synthesis에 편입할 내용을 분리한다.
5. 기존 문체와 template를 따라 최소 범위로 수정한다. 기존 파일은 heading 또는 frontmatter 단위 patch를 우선하고 전체 overwrite는 피한다.
6. 변경한 부분을 다시 읽어 frontmatter, 태그, 링크 대상, PDF, 읽기 상태, maturity, 주장 강도를 검증한다.
7. 결과를 `created`, `updated`, `linked`, `unchanged`, `needs review`로 나눠 보고한다. 새 지식이 연구 흐름을 바꾸지만 요청 범위 밖이라면 map·synthesis 갱신을 제안만 한다.

## 문서화 판단

- PDF가 있으면 이를 1차 출처로 삼고 제목, 저자, 연도, 실제 섹션 구조를 확인한다. 제목이나 링크만 있으면 출판사, 학회, arXiv 등 권위 있는 원문을 우선한다.
- 새 문서는 독립적으로 다시 쓸 가치가 있고 같은 canonical 대상이 없을 때만 만든다. 그 밖에는 기존 문서를 갱신하거나 현재 문서에서만 언급한다.
- 파일명은 논문의 공식 제목 또는 개념의 full English name을 쓴다. 같은 이름이 있으면 숫자 접미사가 아니라 병합, alias, 명확한 canonical name으로 해결한다.
- generic concept는 특정 기원 논문을 빼도 교과서적 개념으로 독립한다. 대표 논문이 정의의 핵심이면 paper-origin concept로 두고 출처 연결을 보존한다.
- 새 학술 노트에는 `summary`를 쓴다. concept에는 `maturity`, paper를 제외한 검토된 지식 문서에는 `last_reviewed`를 `90 Meta/Vault Schema.md`에 맞춰 기록한다.
- 태그는 `90 Meta/태그 일람.md`에 등록된 값만 2~4개 쓴다. 논문 제목, 저자, 연도, 단일 모델·데이터셋 이름은 태그가 아니다.

## 반복 작업

- 구조·태그·링크 검사: `scripts/audit-vault.ps1` — 기본 report-only
- concept 표준 섹션 정리: `scripts/normalize-concept-notes.ps1 -DryRun`
- PDF 수납과 연결: `scripts/import-paper-pdf.ps1 -DryRun`
- paper 읽기 상태 변경: `scripts/set-paper-status.ps1 -DryRun`
- 승인된 legacy migration: `scripts/migrate-vault.ps1 -DryRun` 뒤 실제 실행과 재감사

Dry Run이 있는 스크립트는 먼저 Dry Run으로 확인한다. 일상적인 단일 문서 수정은 [references/obsidian-tools.md](references/obsidian-tools.md)의 patch 정책을 따른다.

## 완료 기준

- `type`, canonical home, `title`, `aliases`, `tags`, `summary`, maturity·날짜 값이 schema와 맞는다.
- 새 링크는 실제 대상 또는 명시한 미래 후보와 일치하고 alias 충돌이나 모호한 basename을 만들지 않는다.
- `pdf`가 있으면 대상이 실제로 존재하며, `status`와 `read_date`가 허용 형식이다.
- 요약, 비교, 종합이 원문의 주장과 실험 결과보다 강한 결론을 내리지 않는다.
- 변경하지 않은 항목과 검토가 필요한 항목을 완료한 작업처럼 보고하지 않는다.

## 금지 사항

- 페르소나, 성격 연기, 관계 설정, 성적 농담, 습관적 말버릇을 넣지 않는다.
- 등록되지 않은 태그를 즉석에서 만들지 않는다.
- `#NLP`, `#RNNs`, `#MCTS`처럼 대문자·복수형·약어 중심 태그를 새로 사용하지 않는다.
- generic 문구, 동사, 논문에 한 번 등장한 부차적 요소를 위키링크나 태그로 과잉 연결하지 않는다.
- 사용자의 명시적 요청 없이 기존 노트의 개인적 메모나 불완전한 섹션을 삭제하지 않는다.
- 감사 결과만으로 문서를 자동 수정하거나 존재하지 않는 링크 대상의 stub을 자동 생성하지 않는다.

