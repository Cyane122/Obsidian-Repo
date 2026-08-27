# Legacy migration

기존 노트의 일괄 정리는 사용자가 명시적으로 요청한 경우에만 수행한다.

## 순서

1. 현재 파일과 태그를 목록화한다.
2. 동일 basename, alias 충돌, 깨진 위키링크 후보를 기록한다.
3. inline `tags:`와 문서 하단 `#tag`를 YAML `tags` 목록으로 변환한다.
4. `90 Meta/태그 일람.md`의 legacy normalization 표를 적용한다.
5. 의미가 모호한 태그는 자동 치환하지 말고 문서의 중심 주제를 읽어 canonical tag를 선택한다.
6. 파일을 유형별 폴더로 이동한다.
7. 이동 후 모든 위키링크 대상, 중복 파일명, YAML 파싱, 미등록 태그를 다시 검사한다.

## 자동 치환해도 되는 형태

- 대소문자만 다른 태그
- 단수/복수 차이만 있는 태그
- underscore와 hyphen 차이
- 명백한 오탈자

## 문맥 확인이 필요한 형태

- `#text-generation`: 생성 자체가 핵심 task인지, 단지 출력 형태인지 확인한다.
- `#text-analysis`: 분류, NLI, 평가 등 더 구체적인 task가 있는지 확인한다.
- 모델명·데이터셋명 태그: 재사용 가능한 method인지 단일 고유명사인지 확인한다.
- `#alignment`: 번역 정렬, representation alignment, safety alignment를 구분한다.
- `#training`: optimizer, objective, stability, regularization 중 실제 중심을 선택한다.

## 안전 장치

- 한 번에 작은 묶음으로 이동하고 diff를 확인한다.
- 사용자가 직접 작성한 본문은 태그와 frontmatter 변환 과정에서 재서술하지 않는다.
- 모호한 위키링크는 경로를 억지로 넣기보다 파일명 또는 alias를 정규화한다.
