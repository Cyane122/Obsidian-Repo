# PDF library

## 저장 위치

논문 원문 PDF를 `40 Sources/Papers/<분야>/`에 저장한다. 분야 폴더는 논문 노트가 속한 `10 Papers/<분야>/`와 동일하게 선택한다.

```text
40 Sources/Papers/
  NLP/
  Recommender Systems/
  Multimodal/
  General Machine Learning/
```

## 파일명과 연결

- PDF basename을 대응하는 논문 노트 basename과 정확히 맞춘다.
- 출판사에서 받은 임의 파일명이나 arXiv 번호만 있는 파일명은 공식 제목을 확인한 뒤 변경한다.
- 논문 노트의 `pdf` 속성에 vault-relative wikilink를 기록한다.
- 단일 PDF를 가져올 때는 `scripts/import-paper-pdf.ps1`을 우선 사용한다. 이 스크립트는 원본 외부 파일을 삭제하지 않고, PDF를 복사한 뒤 논문 노트의 `pdf` 필드만 갱신한다.

```yaml
pdf: "[[40 Sources/Papers/NLP/Attention Is All You Need.pdf]]"
```

- 페이지 근거를 직접 연결할 때 `[[40 Sources/Papers/NLP/Attention Is All You Need.pdf#page=7]]` 형식을 사용한다.
- 같은 논문의 PDF가 이미 있으면 중복 복사하지 않는다. 버전이 다르면 최종 출판본을 기본 파일로 두고, 버전 구분이 실제로 필요할 때만 ` (arXiv)` 또는 ` (supplement)` 접미사를 사용한다.
- supplementary material은 본문 PDF와 같은 폴더에 `Paper Title (supplement).pdf`로 둔다.

## 자동 수납

```powershell
& .agents/skills/obsidian-paper-notes/scripts/import-paper-pdf.ps1 `
  -PdfPath "C:\Downloads\attention.pdf" `
  -PaperNote "Attention Is All You Need" `
  -VaultRoot "D:\World"
```

- `-PaperNote`에는 논문 노트의 basename, 파일명, 또는 vault 내부 경로를 줄 수 있다.
- `-PaperNote`를 생략하면 PDF basename과 같은 논문 노트를 찾는다. 정확히 하나만 찾을 수 있을 때만 자동 연결한다.
- 대상 PDF가 이미 있으면 기본적으로 덮어쓰지 않고 기존 파일을 연결한다. 교체가 필요할 때만 `-Overwrite`를 사용한다.
- 실제 쓰기 전에 결과만 보려면 `-DryRun`을 사용한다.

## 보존 규칙

- PDF 내용 자체를 수정하지 않는다.
- PDF가 스캔본이거나 텍스트 추출에 실패해도 원본은 그대로 보존한다.
- PDF가 아직 없으면 `pdf: ""`를 유지한다. 존재하지 않는 경로를 미리 링크하지 않는다.
- 외부 첨부 파일을 저장소로 가져온 뒤 원본 외부 파일을 삭제하지 않는다.
