---
type: comparison
title: "Attack and Defense in LLM-based Text Anonymization: Anonymity at Risk and IncogniText"
subjects:
  - "[[Anonymity at Risk - Assessing Re-Identification Capabilities of Large Language Models in Court Decisions]]"
  - "[[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization]]"
sources:
  - "[[Anonymity at Risk - Assessing Re-Identification Capabilities of Large Language Models in Court Decisions]]"
  - "[[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization]]"
tags:
  - domain/nlp
  - task/text-rewriting
  - method/large-language-model
  - theme/privacy-preservation
aliases:
  - "Anonymity at Risk vs IncogniText"
---

# 비교 목적

두 논문을 LLM 기반 텍스트 익명화의 공격과 방어라는 상보적 관점에서 비교한다. [[Anonymity at Risk - Assessing Re-Identification Capabilities of Large Language Models in Court Decisions|Anonymity at Risk]]는 이미 익명화된 문서가 외부 지식과 검색을 통해 다시 식별될 수 있는지를 측정하고, [[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization|IncogniText]]는 작성자의 사적 속성 추론을 오답으로 유도하는 재작성 방법을 설계한다.

# 비교 축

| 축 | Anonymity at Risk | IncogniText |
|---|---|---|
| 문제 정의 | 익명화된 법원 판결문에서 가려진 개인의 이름을 복원할 수 있는가 | 텍스트에서 작성자의 사적 속성값을 정확히 추론하지 못하게 할 수 있는가 |
| 보호 대상 | 문서에 등장하는 특정 개인의 identity | 텍스트 작성자의 나이·성별·직업·거주지 등 private attribute |
| 핵심 가정 | 공격자는 모델의 사전학습 지식 또는 검색한 뉴스 기사를 이용한다 | 방어자는 실제 속성 또는 공격 모델의 추론을 이용해 텍스트를 반복 재작성할 수 있다 |
| LLM의 역할 | 이름 후보를 생성하고, RAG 설정에서는 판결문과 외부 기사를 결합해 재식별한다 | 공격자를 모사하고, 잘못된 목표 속성값을 암시하도록 텍스트를 생성한다 |
| 데이터·평가 | 스위스 판결문 7,673건, 수작업 연결 사건 7건, masked Wikipedia 1만 건; 이름 일치 기반 지표 | 합성 대화 525개와 실제 self-disclosure 196개; 속성 추론 accuracy와 ROUGE·BLEU·LLM utility judge |
| 주요 결과 | vanilla LLM은 일반 판결문에서 거의 실패했지만, 관련 뉴스를 제공한 RAG는 선별된 7건 중 GPT-4 기준 5건을 재식별했다 | 가장 좋은 합성 데이터 설정에서 공격자 accuracy를 71.2%에서 7.2%로 낮추고 비교적 높은 utility를 유지했다 |
| 보장의 성격 | 특정 시점의 모델·검색 설정에 대한 공격 가능성 측정 | 선택한 LLM 공격자에 대한 경험적 방어 성능이며 형식적 프라이버시 보장은 아님 |
| 핵심 한계 | 대규모 판결문에는 연구자가 확인 가능한 ground truth가 없고, RAG 평가는 재식별 가능하다고 선별한 7건에 한정된다 | 단일 텍스트와 제한된 속성·공격자에 집중하며, 허위 목표 단서가 사실성과 후속 활용을 왜곡할 수 있다 |

# 핵심 차이

두 논문이 말하는 anonymization failure의 단위가 다르다. Anonymity at Risk의 성공은 외부 자료를 결합해 특정 이름을 복원하는 **identity re-identification**이고, IncogniText의 성공은 텍스트만 본 공격자가 작성자의 **private attribute inference**에 실패하거나 다른 값을 예측하는 것이다. 따라서 IncogniText의 낮은 속성 추론 정확도가 법원 판결문의 이름 재식별 방어를 직접 보장하지는 않는다.

그럼에도 두 결과는 하나의 위협 모델을 이룬다. Anonymity at Risk는 직접 식별자를 가린 뒤에도 검색 가능한 공개 정보가 공격 표면을 넓힌다는 것을 보인다. IncogniText는 간접 속성 신호를 적극적으로 바꾸는 방어를 제안하지만, 평가 공격자는 외부 retrieval을 사용하지 않는다. 실제 배치에서는 재작성된 텍스트를 검색·뉴스·지식 그래프와 결합하는 공격까지 포함한 stress test가 필요하다.

# 비교 가능성의 한계

- 데이터셋, 보호 대상, 공격 성공 기준이 달라 두 논문의 수치를 직접 비교할 수 없다.
- Anonymity at Risk의 5/7은 재식별 가능하다고 미리 확인한 소규모 사례에 대한 결과이며 일반 판결문의 공격 성공률이 아니다.
- IncogniText의 7.2%는 합성 데이터와 지정된 속성 집합에서 별도 LLM 공격자가 낸 accuracy다. 이름 재식별률이나 모든 공격자에 대한 상한이 아니다.
- 두 논문 모두 [[Differential Privacy]] 같은 attacker-independent guarantee를 제공하지 않는다. 결과는 사용한 모델, context, 외부 자료, 평가 시점에 조건부다.

# 함께 읽을 때 얻는 설계 원칙

1. 익명화 평가는 단일 모델의 폐쇄형 추론뿐 아니라 retrieval-augmented attack을 포함해야 한다.
2. 방어 지표는 속성 분류 accuracy와 identity re-identification을 구분해 보고해야 한다.
3. 프라이버시 향상과 함께 의미 보존, 사실성, downstream utility를 별도로 측정해야 한다.
4. 경험적 익명화는 모델·검색 능력의 변화에 따라 반복적으로 재평가해야 한다.

# 관련 문서

- [[프라이버시 보존 텍스트 재작성]]
- [[프라이버시 보존 텍스트 재작성에서 무엇을 함께 평가해야 하는가]]
- [[Differential Privacy]]
