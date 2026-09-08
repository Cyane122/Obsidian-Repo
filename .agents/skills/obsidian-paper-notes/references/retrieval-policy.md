# Retrieval policy

학술 위키를 검색할 때는 질문의 범위와 필요한 근거 수준을 먼저 정한다. 폴더별 우선순위와 제외 대상은 `90 Meta/Vault Schema.md`의 `검색 범위`를 따른다.

## 검색 사다리

아래 단계에서 충분한 답을 얻었으면 더 넓게 읽지 않는다.

1. **Identity search**: 파일명, `title`, `aliases`로 같은 논문이나 개념이 있는지 확인한다.
2. **Structured search**: `type`, `tags`, path, `maturity`, `status`, `last_reviewed`로 후보를 줄인다.
3. **Lexical search**: 정확한 용어와 알려진 변형을 본문에서 찾는다.
4. **Graph context**: 관련 map, outgoing links, backlinks로 연구 흐름과 이웃 문서를 확인한다.
5. **Semantic search**: 정확한 표현을 모를 때 관련 후보를 넓힌다. 결과를 자동 링크나 병합 근거로 쓰지 않는다.
6. **Selective read**: 후보 문서의 `summary`, 필요한 heading, 주변 문단을 읽는다.
7. **Full read**: 비교, 종합, 모순 해결처럼 문서 전체 맥락이 필요한 경우에만 읽는다.
8. **Source verification**: 수치, 서지, 강한 주장, 최신성이 중요하면 PDF나 권위 있는 외부 원문을 확인한다.

`summary`는 어느 문서를 열지 고르는 필드다. `maturity: stub`인 concept는 존재 확인에는 쓸 수 있지만 답변 근거로 사용하지 않는다. `developing`은 불완전성을 밝히고 보조 근거로만 사용한다.

## Scope-first query

같은 단어라도 질문의 소유 범위에 따라 검색 위치가 달라진다.

- “Transformer가 뭐야?”는 학술 지식층에서 시작한다.
- “수업에서 Transformer를 어떻게 설명했지?”는 `50 Courses`에서 시작해 canonical concept로 연결한다.
- “내 GraphRAG에서 Transformer를 어디에 썼지?”는 `60 Projects`에서 시작한다.
- “스킬이 Transformer 노트를 어떻게 찾지?”는 `90 Meta`와 `.agents`를 본다.

질문이 애매하면 가장 좁고 가능성 높은 범위에서 시작한 뒤 결과가 부족할 때 확장한다. 일반 학술 질의에 `.git`, `.obsidian`, `.agents`, `.claude`, `.remember`, `_workspace`, `.tmp`, `tmp`를 섞지 않는다.

## 검색 결과 사용

- exact match가 있어도 `maturity`, 문서 범위, 본문을 확인한 뒤 canonical 대상으로 채택한다.
- lexical match는 같은 철자를 썼다는 뜻일 뿐 같은 개념이라는 뜻은 아니다.
- semantic similarity는 recall을 높이는 추천 신호다. 사람이나 agent가 내용을 확인하기 전에는 링크, 병합, 중복 판정을 확정하지 않는다.
- map과 index 같은 bookkeeping 문서는 모든 문서로 가는 지름길이므로 graph centrality나 의미적 근접성의 증거로 세지 않는다.
- 답을 찾지 못했으면 검색한 범위와 부족한 근거를 보고한다. 빈칸을 외부 상식으로 조용히 채우지 않는다.
