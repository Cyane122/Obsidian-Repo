# Folder layout

## 목표 구조

```text
00 Inbox/
10 Papers/
  NLP/
  Recommender Systems/
  Multimodal/
  General Machine Learning/
20 Concepts/
  Foundations/
  Representations/
  Architectures/
  Training and Optimization/
  Tasks and Evaluation/
  Privacy and Safety/
  Recommender Systems/
30 Maps/
  Comparisons/
  Syntheses/
40 Sources/
  Papers/
    NLP/
    Recommender Systems/
    Multimodal/
    General Machine Learning/
90 Meta/
```

## 배치 규칙

1. 새 자료의 유형을 먼저 정한다.
   - 아직 분류하지 않은 자료나 임시 메모: `00 Inbox/`
   - 한 편의 학술 논문을 따라가는 노트: `10 Papers/`
   - 여러 논문에서 재사용되는 독립 개념: `20 Concepts/`
   - 읽기 목록, 계보, 주제별 MOC: `30 Maps/`
   - 동일한 축으로 둘 이상의 대상을 비교하는 문서: `30 Maps/Comparisons/`
   - 여러 출처의 합의·차이·연구 공백을 종합하는 문서: `30 Maps/Syntheses/`
   - 논문 원문 PDF: `40 Sources/Papers/<논문 노트와 같은 분야>/`
   - 태그 사전과 저장소 운영 규칙: `90 Meta/`
2. 논문은 논문이 기여한 주 연구 공동체 하나를 canonical home으로 고른다.
   - 언어 모델, 번역, 텍스트 재작성, NLP 프라이버시: `10 Papers/NLP/`
   - 협업 필터링, 랭킹, 추천 평가: `10 Papers/Recommender Systems/`
   - vision-language와 이미지-텍스트 학습: `10 Papers/Multimodal/`
   - 위 셋에 속하지 않는 범용 ML: `10 Papers/General Machine Learning/`
3. 개념은 적용 분야보다 기능을 우선한다.
   - 수학, 확률, 기본 표현: `Foundations/`
   - embedding, distributional representation, matrix representation: `Representations/`
   - model, layer, architecture component: `Architectures/`
   - optimizer, loss, regularization, gradient issue: `Training and Optimization/`
   - task, dataset-independent metric, evaluation protocol: `Tasks and Evaluation/`
   - privacy definition, attack, defense: `Privacy and Safety/`
   - 추천 전용 개념: `Recommender Systems/`
4. 두 폴더에 모두 맞더라도 파일을 복제하지 않는다. 더 본질적인 정의를 담는 폴더 하나를 선택하고 다른 관점은 태그와 주제 지도에서 연결한다.
5. `Comparisons/`와 `Syntheses/`는 해당 유형의 문서가 실제로 생길 때 사용한다. 그 밖의 하위 폴더는 같은 기준의 파일이 5개 이상 쌓일 때만 추가한다. 한 파일만 위한 새 분류 폴더를 만들지 않는다.
6. 논문 PDF는 대응하는 논문 노트와 basename을 맞추고, 세부 규칙은 `pdf-library.md`를 따른다.
7. map, comparison, synthesis는 역할이 겹쳐 보여도 구분한다.
   - 탐색 순서와 연구 흐름을 안내하면 map이다.
   - 정해진 축으로 대상을 나란히 판단하면 comparison이다.
   - 여러 출처에서 하나의 상위 결론과 미해결 질문을 도출하면 synthesis다.

## 현재 저장소에 대한 예시

- `Attention Is All You Need.md` → `10 Papers/NLP/`
- `Collaborative Filtering for Implicit Feedback Datasets.md` → `10 Papers/Recommender Systems/`
- `Learning Transferable Visual Models From Natural Language Supervision.md` → `10 Papers/Multimodal/`
- `Transformer.md` → `20 Concepts/Architectures/`
- `Word Embedding.md` → `20 Concepts/Representations/`
- `Stochastic Gradient Descent.md` → `20 Concepts/Training and Optimization/`
- `ROUGE.md` → `20 Concepts/Tasks and Evaluation/`
- `Differential Privacy.md` → `20 Concepts/Privacy and Safety/`
- `논문 읽기 프로젝트.md` → `30 Maps/`
- `Text Anonymization Methods.md` → `30 Maps/Comparisons/`
- `What Makes Text Anonymization Effective.md` → `30 Maps/Syntheses/`

## 이동 안전 규칙

- Obsidian에서 파일명 기반 위키링크는 보통 이동 후에도 유지되지만, 같은 이름의 파일이 여러 개 있으면 링크가 모호해질 수 있다.
- 대량 이동 전에는 같은 basename이 있는지 확인하고, 이동 후 미해결 위키링크를 검사한다.
- 사용자가 마이그레이션을 요청하지 않았다면 현재 루트 파일은 그대로 두고 새 파일부터 목표 구조를 적용한다.
