# Reading workflow

논문 노트는 frontmatter에 `status`와 `read_date`를 둔다.

## Status values

- `to-read`: 읽을 후보이거나 PDF·서지 정보만 확보한 상태.
- `reading`: 읽는 중이거나 노트가 아직 불완전한 상태.
- `read`: 1차 정리가 끝나 핵심 주장, 방법, 근거, 한계가 노트에 남은 상태.
- `review-needed`: 읽었지만 복습, 재검증, 비교 정리가 필요한 상태.

## Rules

- 새 논문 노트의 기본값은 `reading`으로 둔다. 제목만 확보한 읽기 후보는 `to-read`를 사용한다.
- `read_date`는 `read`로 바꿀 때 `YYYY-MM-DD` 형식으로 채운다.
- `review-needed`는 이미 읽은 논문 중 다시 볼 이유가 있는 경우에만 사용한다.
- 상태만 바꿀 때는 본문을 고치지 않는다. `scripts/set-paper-status.ps1`을 우선 사용한다.
- PDF 수납은 읽기 상태를 자동으로 `read`로 바꾸지 않는다. 상태 변경은 별도 판단으로 처리한다.
