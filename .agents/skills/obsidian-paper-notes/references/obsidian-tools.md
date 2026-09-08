# Obsidian tool policy

이 스킬은 판단 규칙을 맡고, MCP·CLI·파일시스템은 실행 계층으로 다룬다. 특정 도구가 설치되어 있다고 가정하지 않는다.

## 우선순위

1. Obsidian-aware MCP: 일상적인 검색, metadata 확인, heading·frontmatter patch, rename
2. Obsidian CLI: MCP에 없는 앱 명령이나 안전한 단일 작업
3. 파일시스템: 도구가 없거나 정적 diff가 더 적합한 경우
4. 스크립트: vault 전체 감사, 정규화, 마이그레이션 같은 반복·대량 작업

도구 선택이 달라도 `read → 변경 판단 → 국소 수정 → reread → validate` 순서는 유지한다.

## MCP 쓰기 정책

Local REST API with MCP 계열 도구를 사용할 수 있다면 실제 노출된 schema를 먼저 확인한다.

- 검색은 `search_query`로 path·type·tags·maturity를 좁힌 뒤 `search_simple`로 본문 표현을 찾는다.
- 기존 파일은 `vault_get_document_map`으로 정확한 heading·frontmatter target과 version을 얻고 `vault_patch`로 수정한다.
- patch에는 가능하면 `ifMatch`를 사용해 읽은 뒤 다른 변경이 생긴 파일을 덮어쓰지 않는다.
- `vault_write`는 새 파일 생성에만 사용한다. 기존 파일 전체 overwrite에는 사용하지 않는다.
- `vault_append`는 append-only log나 명확한 목록 끝 추가에만 사용한다. 지식 문서 병합은 해당 heading을 patch한다.
- `vault_move`는 source와 destination을 정확히 확인하고, basename·alias 충돌을 검사한 뒤 사용한다.
- `vault_delete`, `command_execute`, bulk move는 사용자의 명시적 요청이 있을 때만 실행한다.
- 변경 뒤 `vault_read`로 대상 field나 heading을 다시 읽고 링크와 frontmatter를 검증한다.

heading target은 화면에 보이는 문자열을 다시 타이핑하지 말고 document map이 돌려준 경로를 그대로 사용한다. target이 모호하거나 client가 structured target을 전달하지 못하면 전체 overwrite로 우회하지 말고 CLI 또는 파일 patch로 전환한다.

## 보안 경계

MCP 설치와 연결은 이 스킬 실행에 포함되지 않는다. 도입할 때는 최신 보안 수정 버전을 확인하고 localhost에만 노출하며 API key를 문서, 로그, 명령 출력에 남기지 않는다. 인증서 우회나 평문 HTTP 사용을 기본값으로 권하지 않는다.

## 파일시스템 fallback

파일시스템으로 수정할 때도 기존 파일 전체를 새 내용으로 교체하지 않는다. 정확한 경로를 확인하고 필요한 frontmatter field나 섹션만 고친다. rename·move는 Obsidian이 링크를 갱신할 수 있는 MCP나 CLI가 열려 있을 때 우선하고, 그렇지 않으면 이동 뒤 unresolved link를 검사한다.
