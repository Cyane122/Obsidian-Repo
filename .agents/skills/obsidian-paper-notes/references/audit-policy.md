# Audit policy

감사는 문제를 찾는 작업과 문제를 고치는 작업을 분리한다. 기본 실행은 report-only다. 각 규칙은 독립적으로 판정하며, 한 규칙의 자동 수정이 다른 규칙의 결과를 바꿀 수 있으면 작은 묶음으로 나눠 다시 감사한다.

## Severity

- `error`: 구조나 참조가 깨졌거나 허용값을 위반했다. 감사 명령은 실패로 끝난다.
- `warning`: 당장 깨지지는 않지만 schema drift, 오래된 지식, 모호한 링크가 있다.
- `info`: 사람이 검토하면 좋은 품질·연결 후보다.

## 규칙

| ID | 검사 | Severity | Safe autofix |
|---|---|---|---|
| `structure/missing-root` | schema의 academic root가 없음 | error | no |
| `structure/type-path` | `type`과 canonical home이 다름 | error | no |
| `structure/legacy-location` | comparison·synthesis가 이전 30 하위 폴더에 있음 | warning | no |
| `identity/duplicate-basename` | vault 안에 basename이 겹침 | error | no |
| `identity/alias-collision` | alias가 다른 canonical 문서와 충돌 | error | no |
| `metadata/frontmatter` | frontmatter가 없거나 파싱할 수 없음 | error | no |
| `metadata/required` | 기존 필수 필드가 없음 | error | maybe |
| `metadata/v2-adoption` | `summary`, `maturity`, `last_reviewed`가 아직 없음 | warning | no |
| `metadata/enum` | status·maturity가 허용값이 아님 | error | no |
| `metadata/date` | 날짜 형식이 `YYYY-MM-DD`가 아님 | error | no |
| `metadata/summary` | summary가 200자를 넘거나 서식을 포함함 | warning | no |
| `tag/unregistered` | [[태그 일람]]에 없는 태그 | error | only obvious spelling form |
| `tag/count` | 학술 노트의 태그가 2~4개가 아님 | warning | no |
| `file/missing-pdf` | paper의 `pdf` 대상이 없음 | error | no |
| `link/unresolved` | 위키링크 대상이 없음 | warning, `-StrictLinks`에서는 error | no |
| `link/ambiguous` | 둘 이상의 basename·alias로 해석됨 | error | no |
| `graph/orphan` | map을 제외한 학술 문서에 incoming link가 없음 | info | no |
| `quality/stub` | concept가 `maturity: stub`임 | info | no |
| `quality/stale` | reviewed 문서가 장기간 재검토되지 않음 | warning | no |

`safe autofix`가 `yes`여도 감사 자체는 수정하지 않는다. 사용자가 수정까지 요청했을 때만 별도 단계에서 적용한다. `maybe`와 `no`는 문서 의미나 canonical identity 판단이 필요하므로 자동 수정하지 않는다.

## 수정 순서

`깨진 구조 → identity 충돌 → 필수 metadata → 파일 경로 → 링크 → v2 metadata → 고아·stub·stale` 순으로 처리한다. 대량 수정 전에 대상과 예상 변경 수를 보고하고 Dry Run을 먼저 실행한다. 수정 뒤에는 같은 규칙을 다시 돌리고 diff를 확인한다.
