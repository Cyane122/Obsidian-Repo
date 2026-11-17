# 멀티모달 AI 오픈북 답안 준비

## 목차

- [[#Part 1. 문제 유형별 답안 작성법]]
  - [[#읽는 법과 근거]]
  - [[#유형 1 — 자신의 생각을 5줄로 설명]]
  - [[#유형 2 — 기술적 어려움 4개와 각각의 해결책]]
  - [[#유형 3 — 수업 시스템의 원리와 전공·일상 적용]]
  - [[#유형 4 — 두 개념 비교와 확인되는 다른 명칭]]
  - [[#유형 5 — 수업 사례 2개와 새 사례 2개]]
- [[#Part 2. 핵심 주제별 답안 재료]]
  - [[#1. 멀티모달 표현·정렬·결합]]
  - [[#2. 신경망 학습과 표현]]
  - [[#3. CNN과 계층적 시각 특징]]
  - [[#4. Attention과 Transformer]]
  - [[#5. 음성 감정 인식과 문맥 추론]]
  - [[#6. 움직임 검출과 Baby Monitoring]]
  - [[#7. 영상 개선과 목적별 평가]]
- [[#Part 3. 논문을 응용 답안에 사용하는 방법]]
  - [[#논문 선택 기준]]
  - [[#논문 — HazeSpace2M: A Dataset for Haze Aware Single Image Dehazing]]
  - [[#논문 — LoLI-Street: Benchmarking Low-Light Image Enhancement and Beyond — TriFuse]]
  - [[#논문 — Attention Is All You Need — Vaswani et al., 2017]]
  - [[#논문 — LeNet-5 — LeCun et al., 1998]]
  - [[#논문 — Intelligent baby behavior monitoring using embedded vision in IoT for smart healthcare centers]]
  - [[#CALL의 짧은 논문 — 목적과 활용만 연결]]
- [[#Part 4. 유형별 예상문제와 한·영 모범답안]]
  - [[#Q1 — 멀티모달 AI에 대한 5줄 의견]]
  - [[#Q2 — Attention에 대한 5줄 의견]]
  - [[#Q3 — 멀티모달 학습 도우미의 네 가지 어려움]]
  - [[#Q4 — SER의 네 가지 어려움]]
  - [[#Q5 — 영상 개선의 네 가지 어려움]]
  - [[#Q6 — Baby Monitoring을 공부 중 자세 점검에 적용]]
  - [[#Q7 — Haze-Aware 원리를 필기 사진 정리에 적용]]
  - [[#Q8 — VQA를 냉장고 확인에 적용]]
  - [[#Q9 — Early Fusion과 Late Fusion 비교]]
  - [[#Q10 — Self-Attention과 Cross-Attention 비교]]
  - [[#Q11 — 멀티모달 AI의 사례 네 가지]]
  - [[#Q12 — Attention의 사례 네 가지]]
- [[#Part 5. 시험 중 빠른 검색용 요약]]
  - [[#빠른 표 — 개념과 차이]]
  - [[#빠른 표 — 수업 사례와 새 제안]]
  - [[#빠른 표 — 어려움과 대응]]
  - [[#빠른 표 — 논문 아이디어와 쓸 질문]]
  - [[#빠른 표 — 영어 시작·연결 문장]]
  - [[#빠른 확인 — 답안 조건과 자료 해석]]

## Part 1. 문제 유형별 답안 작성법

### 읽는 법과 근거

예시에서 드러난 다섯 질문 방식에 맞춘 준비 문서다. 실제 출제 유형·분량을 확정하는 자료는 아니다. 기존 정리본의 개념·강의 근거는 유지하고, 답안에 필요한 비교·원인 분석·적용을 보강했다.

- **수업 확인:** 제공 강의자료에 있는 개념·사례·보고 결과. 사례 이름 뒤에 페이지나 슬라이드를 표시한다.
- **강의 개념을 이용한 제안:** 아래의 대응책·개선 설계·생활 응용 중 제안이라고 표시한 부분. 구현·성능을 검증한 결과가 아니다.
- **새 응용 제안 — 제공 자료에서 미확인:** 학생이 일상에서 생각해 낼 만한 구체적 활용. 논문·제품을 새 사례로 가져오지 않는다. 강의 전체에서 다루지 않았다는 뜻은 아니다.
- **외부 확인 사실:** 이번 문서에는 별도 외부 사실을 추가하지 않았다. 논문 내용도 강의가 설명한 범위로 한정한다.

검색은 `[Fusion]` 같은 개념 태그와 `[Application]` `[Challenge]` `[Solution]` `[Comparison]` `[Opinion]` `[System]`을 함께 사용한다. 기존 `[Applications]` 태그도 유지한다. 먼저 [[#Part 5. 시험 중 빠른 검색용 요약]]에서 찾고, 개념과 근거는 Part 2, 논문은 Part 3, 완성 답안은 Part 4로 이동한다.

**근거 위치:** 모든 원본은 `50 Courses/2026-2학기/AAI3031-01 - 멀티모달AI/자료`에 있다. `s.`는 파일 안의 실제 슬라이드 순서, `p.`는 PDF 페이지 순서다.

| 약칭 | 원본 파일명 | 분량·처리 |
| --- | --- | --- |
| INTRO | `Week 01_Multimodal AI_Course Introduction.pdf` | 31쪽. 초기 개요·로드맵 확인 |
| W1-PDF | `Week 01_Introduction to Multimodal AI_Full.pdf` | 51쪽. W1과 중복되는 본문 통합 |
| W1 | `Week 01_Introduction to Multimodal AI_Full_Revised.pptx` | 51슬라이드. 입문 개념의 주된 근거 |
| W3 | `Week 03_Deep_Learning_Foundations, Part A_Final.pptx` | 39슬라이드. 신경망·학습·표현 |
| W4 | `Week 04_Deep_Learning_Foundations, Part B_Final.pptx` | 40슬라이드. CNN·Pooling·Transformer 입문 |
| W5 | `Week 05_Attention & Transformers as the Multimodal Backbone_Final.pptx` | 52슬라이드. Attention·Transformer 심화 |
| BABY | `Intelligent Baby Monitoring.pptx` | 45슬라이드. 움직임 검출·행동 분석 |
| LOW | `Low-Level Vision and Image Enhancement.pptx` | 27슬라이드. HazeSpace2M·LoLI-Street·TriFuse |
| CALL | `Fake Call Analysis.pdf` | 28쪽. LISTEN·음성 감정 인식·추론 |

녹화·구두 설명·영상 데모 전사는 제공되지 않았다. 아래에서 수업 사례의 상세 처리 단계가 자료에 없으면 확인된 범위만 쓰고, 구체화는 제안이라고 구분한다.

### 유형 1 — 자신의 생각을 5줄로 설명

[Opinion] [Five Lines]

| 항목 | 작성법 |
| --- | --- |
| 질문에서 확인 | 대상 기술, 개인 의견인지 정의인지, 정확히 5줄인지, 장단점·사례가 필수인지 |
| 구성 순서 | ① 내 입장 ② 기술의 작동 ③ 선택 근거 ④ 구체적 적용 ⑤ 한계와 조건 |
| 자주 생기는 문제 | 정의만 다섯 번 바꾸어 씀; 근거 없는 찬양; 사례를 별도 문단으로 늘려 분량 초과; 한계 없이 항상 좋다고 단정 |

**바로 쓰는 영어 틀 — 한 번호가 한 줄:**

1. I think [technology] is useful for [task].
2. It uses [input] to [operation].
3. This helps because [reason tied to the task].
4. For example, I would use it to [specific action and output].
5. However, I would check [failure condition] before trusting the result.

장점과 한계를 묻는다면 첫 줄에서 조건부 입장을 밝힌다. 줄 수는 문장 수와 다를 수 있으므로 시험에서는 줄바꿈을 명확히 하고 한 줄에 한 문장으로 쓴다. 예시: [[#Q1 — 멀티모달 AI에 대한 5줄 의견]], [[#Q2 — Attention에 대한 5줄 의견]].

### 유형 2 — 기술적 어려움 4개와 각각의 해결책

[Challenge] [Solution]

| 항목 | 작성법 |
| --- | --- |
| 질문에서 확인 | 어려움이 정확히 4개인지, 각 해결책도 필요한지, 특정 시스템의 제약이 있는지 |
| 구성 순서 | 각 번호 안에서 **문제 → 원인 → 대응 방법 → 왜 도움이 되는지 → 남는 한계** |
| 자주 생기는 문제 | 문제 4개 뒤에 해결책을 뭉뚱그림; 결측·데이터 부족·정보 부족을 같은 뜻으로 반복; 모든 해결책을 더 많은 데이터로 끝냄; 제안을 이미 입증된 성과로 씀 |

**영어 틀:** “First, [problem] occurs because [cause]. I would [response] so that [mechanism of help]. However, [remaining limit].” 이를 First / Second / Third / Fourth로 네 번 쓴다. 서로 다른 축으로 시간 대응·입력 결측·의미 관계·계산량 등을 고르면 중복을 줄일 수 있다. 실제 질문의 기술에 맞는 네 개만 고른다.

예시: [[#Q3 — 멀티모달 학습 도우미의 네 가지 어려움]], [[#Q4 — SER의 네 가지 어려움]], [[#Q5 — 영상 개선의 네 가지 어려움]].

### 유형 3 — 수업 시스템의 원리와 전공·일상 적용

[System] [Application]

| 항목 | 작성법 |
| --- | --- |
| 질문에서 확인 | 어떤 수업 시스템인지, 원리와 적용 모두 필요한지, 입력·출력·한계 조건 |
| 구성 순서 | 수업 시스템의 목적 → 입력 → 핵심 단계 → 출력 → 일상에서 바꿀 입력·판단 기준 → 한계 |
| 자주 생기는 문제 | 시스템 이름만 빌려 씀; 분야 이름만 바꿈; 원래 경고와 질병 확진을 혼동; 원 논문이 새 적용도 검증했다고 서술 |

**영어 틀:** “In the lecture, [system] takes [input]. It first [step], then [step], and outputs [result]. I would apply the same idea to [ordinary situation]. I would replace [original input or criterion] with [new input or criterion]. This could help [purpose], but [limit].”

입력·시간 단위·출력·기준 중 무엇을 유지하고 무엇을 바꾸는지 말해야 실제 적용이 된다. 예시: [[#Q6 — Baby Monitoring을 공부 중 자세 점검에 적용]], [[#Q7 — Haze-Aware 원리를 필기 사진 정리에 적용]], [[#Q8 — VQA를 냉장고 확인에 적용]].

### 유형 4 — 두 개념 비교와 확인되는 다른 명칭

[Comparison]

| 항목 | 작성법 |
| --- | --- |
| 질문에서 확인 | 비교 대상 두 개, 요구된 기준·사례, 다른 명칭도 요구하는지 |
| 구성 순서 | 공통 목적 → 같은 기준으로 A와 B 비교 → 같은 과업 안의 예 → 확인되는 명칭과 그 범위 |
| 자주 생기는 문제 | A는 정의, B는 장점만 씀; 관련 개념을 동의어로 바꿈; Cross-Attention은 반드시 다른 감각 입력이라고 단정 |

**영어 틀:** “Both A and B [shared purpose]. For [criterion], A [property], whereas B [property]. In [same task], A [role] and B [role]. The lecture also describes A as [verified label] and B as [verified label].”

다른 명칭은 강의가 직접 병기한 표현이나 약어만 사용한다. Early Fusion의 **Input-level integration**, Late Fusion의 **Decision-level integration**은 강의의 설명 명칭이다. Intermediate Fusion은 **Representation-level interaction**으로 설명한다. [W1 s.31–32] Self-Attention과 Cross-Attention에 대해 “within-input / across-input”은 설명 문구이며 별도의 공식 동의어가 아니다. [[#Q9 — Early Fusion과 Late Fusion 비교]], [[#Q10 — Self-Attention과 Cross-Attention 비교]].

### 유형 5 — 수업 사례 2개와 새 사례 2개

[Application] [Applications]

| 항목 | 작성법 |
| --- | --- |
| 질문에서 확인 | 총 4개인지, 수업 2＋새 제안 2인지, 기술의 적용 범위가 제한되는지 |
| 구성 순서 | **수업 확인 1·2 / 새 응용 제안 1·2**로 나눈 뒤 각 항목에 상황·입력·처리·출력·적합성·한계 |
| 자주 생기는 문제 | 수업 사례를 새 사례로 재사용; 실제 논문 이름만 가져옴; 의료·교육 같은 분야명만 나열; 같은 상황에서 이름만 바꿈 |

**영어 틀:** “Lecture example 1 is [case, source]. It takes [inputs], uses [method], and produces [output]. This fits [need], but [limit].” 새 제안은 “My first proposed use is … I would … It could …”로 시작한다. 새 사례의 영어 구분은 **New proposal — unconfirmed in the provided materials**로 표시한다.

새 사례는 예를 들어 **녹음과 필기 사진으로 복습 구간 찾기**, **냉장고 사진과 부족한 물건 메모로 장보기 목록 만들기**처럼 과업 자체가 보여야 한다. 이미 만들어진 연구·제품을 외워 와서 자기 제안처럼 쓰지 않는다. [[#Q11 — 멀티모달 AI의 사례 네 가지]], [[#Q12 — Attention의 사례 네 가지]].

## Part 2. 핵심 주제별 답안 재료

가장 먼저 Representation–Alignment–Fusion, Attention–Transformer를 연결한다. 그다음 SER·Baby Monitoring·영상 개선을 원인 분석과 시스템 적용의 근거로 활용한다. 작은 연산·약어는 설명과 비교 중심으로 두고 사례 네 개씩을 억지로 붙이지 않는다.

### 1. 멀티모달 표현·정렬·결합

#### AI·ML·DL의 관계

**검색 태그:** [AI] [ML] [DL] [Artificial Intelligence] [Machine Learning] [Deep Learning] [Explicit Rules]

**Artificial Intelligence(AI)**는 인지·학습·이해·추론·행동·생성과 같이 지능이 필요한 과업을 수행하는 계산 시스템을 다루는 분야다. **Machine Learning(ML)**은 예시 데이터에서 패턴을 배우는 접근이고, **Deep Learning(DL)**은 여러 신경망 층을 통해 표현과 패턴을 학습하는 ML의 한 종류다. 강의의 포함 관계는 `DL ⊂ ML ⊂ AI`다. 사람이 조건을 정하는 Explicit Rules와 데이터에서 규칙을 배우는 ML을 스팸 분류 예시로 비교한다. [W1 s.16–19; W3 s.6–9]

**English answer:** AI is the broad field. Machine learning learns patterns from examples, and deep learning uses multiple neural network layers within machine learning.

#### Modality와 멀티모달 접근의 목적

**검색 태그:** [Modality] [Multimodal AI] [Complementary Information] [Redundant Information] [Contextual Information] [Missing Modality]

**Modality**는 정보를 관찰하거나 표현하는 서로 다른 채널·형태다. 영상의 공간 구조, 텍스트의 이산 token, 음성의 시간·주파수, 센서의 측정값은 표현 방식과 실패 조건이 다르다. **Multimodal AI**는 이질적인 정보를 표현·연결하고 함께 추론한다. [W1 s.21–26]

야간 교차로에서는 영상이 외형·위치를, 소리가 접근하는 차량의 단서를, LiDAR가 깊이·기하 정보를, 지도·GPS가 위치 문맥을 제공할 수 있다. 여러 정보가 서로 다른 측면을 보완하는 **Complementary information**, 같은 판단을 확인하는 **Redundant information**, 다른 신호의 의미를 풀어 주는 **Contextual information**이 결합의 근거다. [W1 s.25, 32]

모달리티를 늘리면 정렬 오류·잡음·결측·비용도 고려해야 한다. “더 많이 결합하면 항상 더 좋다”보다 **필요한 단서가 무엇이고, 각 단서가 언제 실패하는가**로 설명한다. 이는 강의의 교차로 토의 질문과 학습목표에 대응한다. [W1 s.21, 45; W5 s.50]

**English answer:** A modality is a channel or form of information. Multimodal AI combines different forms to use complementary, redundant, or contextual clues, but more inputs can also add errors and cost.

#### Representation·Alignment·Fusion

**검색 태그:** [Representation] [Alignment] [Fusion] [Embedding] [Semantic Alignment] [Temporal Alignment]

| 개념 | 의미·작동 | 예시 |
| --- | --- | --- |
| Representation | 원시 입력을 모델이 처리할 수 있는 특징·embedding으로 변환 | 이미지 → 시각 벡터, 질문 → 언어 벡터 |
| Alignment | 서로 다른 정보의 의미적·시간적 대응을 찾음 | 질문의 bicycle ↔ 이미지의 자전거 영역; 발화 ↔ 해당 시간 구간 |
| Fusion | 여러 정보를 하나의 표현 또는 최종 판단에 결합 | 자전거 주변 시각 정보와 질문을 사용해 Dog라고 답함 |

**Embedding**은 입력의 유용한 특징·의미를 담은 학습된 밀집 벡터다. 의미가 비슷한 입력을 가까운 벡터로 표현하는 것이 목표다. 벡터 차원이나 형식이 같다는 이유만으로 의미적 대응까지 보장되는 것은 아니다. 강의는 의미 있는 Representation을 Alignment·Fusion의 토대로 설명한다. [W1 s.27–32]

**English answer:** Representation encodes inputs as features or embeddings. Alignment links corresponding meanings or times, and fusion combines evidence for a result. Equal vector sizes alone do not align meanings.

#### Fusion 방식의 비교

**검색 태그:** [Fusion] [Early Fusion] [Intermediate Fusion] [Late Fusion] [Missing Modality]

| 방식 | 결합 지점·원리 | 장점과 고려점 |
| --- | --- | --- |
| Early Fusion | 깊은 처리 전에 원시 입력·낮은 수준의 특징을 결합 | 단순하지만 모달리티별 처리가 제한될 수 있음 |
| Intermediate Fusion | 각 encoder가 표현을 만든 뒤 interaction layer 등에서 결합 | 고유 구조를 보존하면서 Cross-Attention 같은 깊은 상호작용 가능 |
| Late Fusion | 각 모델이 독립적으로 예측한 뒤 결과를 결합 | 모달리티 결측에 상대적으로 대응하기 쉽지만 세밀한 상호작용은 제한됨 |

Late Fusion의 장점을 “어떤 입력이 없어도 무조건 정상 작동한다”로 외우지 않는다. 선택 이유는 **독립 예측을 결합하는 구조의 유연성**이고, 필요한 결측 대응은 시스템 설계에 달려 있다. [W1 s.31–32]

**English answer:** Early fusion combines inputs or low-level features before deep processing. Intermediate fusion allows encoded representations to interact. Late fusion combines independent predictions; missing-input handling still needs design.

#### 활용 분야와 범위

**검색 태그:** [Applications] [Multimodal AI] [Robotics] [Healthcare]

강의는 자율주행·로봇 조작·접근성 지원·의료 정보 결합·산업 이상 탐지·안전 감시를 제시한다. 예를 들어 “빨간 컵을 집어라”는 언어 지시와 장면 속 대상의 대응이 필요하고, 이미지 설명은 Vision과 Language의 연결이 필요하다. [W1 s.33; W5 s.8]

Fire/Smoke, CHILD, CABAD/CABA_Net, IARD, ROAD-6, Industrial Anomaly Detection은 입문 슬라이드의 사례·향후 주제에 등장한다. 현재 자료에는 이들 각각의 독립적인 상세 강의가 없으므로 목적을 알아두는 수준으로 둔다. [W1 s.36–44, 46–47]

**English answer:** Lecture examples include a robot linking a red-cup instruction to a scene and image captioning linking visual content to words. Introductory application names alone do not establish detailed system designs.

#### 멀티모달 응용 카드 네 가지

[Application] [Multimodal AI] [Representation] [Alignment] [Fusion]

**수업 확인 1 — 이미지 질문 응답(VQA).** 상황: 이미지 속 자전거 옆에 무엇이 있는지 답한다. 입력: 이미지＋텍스트 질문. 처리: 각각 embedding → 질문의 bicycle과 해당 영역의 의미 대응 → 관련 시각·언어 정보 결합. 출력: “Dog.” 적합성: 질문만으로는 알 수 없는 시각 근거를 사용한다. **한계 분석:** 물체가 가려지거나 엉뚱한 영역에 대응하면 답도 틀릴 수 있다. [W1 s.27–32; W5 s.42]

**수업 확인 2 — 언어 지시를 따르는 로봇.** 상황: “Pick up the red cup”에서 대상을 고른다. 입력: 장면 이미지＋언어 지시. 처리: 지시와 장면 속 빨간 컵을 대응시키고 그 영역에 주목한다. 출력: 집어야 할 대상 선택 및 집기 행동. 적합성: 주변 다른 물체와 목표를 구분한다. **한계 분석:** 비슷한 컵이나 가림이 있으면 선택이 어려울 수 있다. 강의는 대상에 집중하는 예를 제공하며, 실제 제어 알고리즘·성공률은 제시하지 않는다. [W5 s.8]

**새 응용 제안 — 제공 자료에서 미확인 1 — 복습할 녹음 구간 찾기.** 상황: 필기 사진의 한 식이 언제 설명됐는지 찾는다. 입력: 학생의 강의 녹음＋필기 사진＋“이 식 설명 부분”이라는 질문. 처리 제안: 음성을 구간별 표현으로, 사진을 영역별 표현으로 바꾸고 질문과 관련된 내용·기록 시각을 맞춘 뒤 정보를 결합한다. 출력: 후보 녹음 시각과 대응 필기 영역. 적합성: 사진은 식을, 음성은 설명을 보완한다. 한계: 필기를 늦게 쓰면 기록 시각만으로는 맞지 않으므로 의미도 확인해야 한다.

**새 응용 제안 — 제공 자료에서 미확인 2 — 장보기 전 냉장고 확인.** 상황: 물건을 중복 구매하지 않도록 목록을 정리한다. 입력: 냉장고 사진＋“우유와 달걀이 필요해”라는 메모. 처리 제안: 메모의 물건 이름을 사진 속 대상에 대응시키고 있는 것으로 보이는 항목을 구분한다. 출력: 구매 후보와 사진에서 확인할 항목. 적합성: 개인의 필요와 눈에 보이는 재고를 함께 쓴다. 한계: 가려진 물건·남은 양·유통기한을 사진만으로 확정할 수 없다.

#### 멀티모달의 어려움 네 쌍

[Challenge] [Solution] [Alignment] [Missing Modality]

아래 **원인**은 W1 s.30, W5 s.50의 문제를 활용한다. **대응책·효과·남는 한계는 설계 제안**이다.

| 문제 | 원인 | 대응 방법 | 왜 도움이 되는가 | 남는 한계 |
| --- | --- | --- | --- | --- |
| 시간 대응 오류 | 음성·영상·메모의 시간 단위와 기록 시각이 다름 | 공통 시각을 기록하고 짧은 구간의 의미도 대조 | 다른 순간의 단서를 섞는 오류를 줄일 수 있음 | 기록 지연·모호한 내용은 남음 |
| 입력 결측 | 녹음 중단·사진 누락으로 한 채널이 없음 | 독립 예측이 가능한 부분은 Late Fusion으로 설계하고 누락 상태를 표시 | 남은 근거로 제한된 기능을 제공할 수 있음 | 사라진 정보가 필수인 질문에는 답할 수 없음 |
| 의미 대응 실패 | 비슷한 물체·표현, 잘못 짝지어진 학습 자료 | 정확히 짝지어진 사례를 점검하고 헷갈리는 후보를 보여 줌 | 잘못된 연결을 배우거나 확신하는 위험을 줄임 | 모든 모호성을 제거하지 못함 |
| 과도한 계산량 | 긴 음성·영상 전체의 token 수가 많음 | 질문 관련 구간을 먼저 좁히고 그 안에서 세밀하게 결합 | 처리할 길이가 줄어듦 | 처음 구간을 잘못 고르면 정답 근거를 놓침 |

**짧은 영어 응용:** I would combine a lecture recording with a photo of my notes. I would match the relevant audio segment to the formula in the photo and return a replay time. The two inputs provide different clues, but delayed note-taking can cause alignment errors.

**연결:** 수업 VQA·로봇 예 / [[#Q3 — 멀티모달 학습 도우미의 네 가지 어려움]] / [[#Q11 — 멀티모달 AI의 사례 네 가지]].

### 2. 신경망 학습과 표현

#### Neural Network와 비선형성

**검색 태그:** [Neural Network] [Weight] [Bias] [Activation Function] [Nonlinearity] [ReLU] [Sigmoid] [Softmax] [Tanh]

신경망은 입력층·은닉층·출력층으로 이루어지며, 연결의 Weight와 Bias를 학습한다. 뉴런은 입력에 가중치를 곱해 더하고 Bias를 적용한 뒤 Activation Function으로 출력을 만든다. Weight는 입력의 기여도를, Bias는 반응 기준의 이동을 담당한다. 비선형 Activation은 복잡한 비선형 관계를 표현하기 위해 사용한다. [W3 s.11–15]

| 함수 | 핵심 작동 | 강의의 주요 용도 |
| --- | --- | --- |
| ReLU | 음수는 0, 양수는 유지 | 은닉층 |
| Sigmoid | 값을 0–1 범위로 변환 | 이진 분류 출력 |
| Softmax | 여러 logit을 합이 1인 클래스 확률로 변환 | 다중 클래스 분류 |
| Tanh | 비선형 활성화의 예로 소개 | 상세 계산보다 비선형성의 예로 기억 |

Sigmoid는 각 값의 변환이고, Softmax는 여러 클래스 점수를 **함께 정규화**한다. Softmax 출력에서 가장 큰 값을 선택하는 분류와, 확률값을 다른 근거와 결합하는 CALL 사례를 연결할 수 있다. [W3 s.14–18; CALL p.12–14, 22]

**English answer:** A neuron applies weights and a bias, then an activation function. Nonlinear activations allow complex relationships. ReLU keeps positive values; sigmoid maps a value to 0–1, while softmax normalizes class scores together.

#### 학습 과정: 각 단계가 하는 일

**검색 태그:** [Forward Propagation] [Loss Function] [Cost Function] [Backpropagation] [Gradient] [Chain Rule] [Optimizer] [Gradient Descent]

`Input → Forward Propagation → Prediction → Loss → Backpropagation → Parameter Update → 반복`

- **Forward Propagation:** 현재 Weight·Bias·Activation을 사용해 입력에서 예측을 계산한다.
- **Loss Function:** 예측과 실제 target의 차이를 수치화한다. 강의는 개별 손실과 데이터 전체 평균인 Cost를 구분한다.
- **Backpropagation:** Chain Rule을 이용해 각 파라미터가 손실에 미치는 영향인 Gradient를 뒤로 계산한다.
- **Optimization:** Gradient를 이용해 파라미터를 수정한다. Gradient Descent는 손실을 줄이는 방향으로 갱신한다.

Backpropagation의 핵심은 **Gradient 계산**, Optimizer의 핵심은 **그 Gradient를 이용한 갱신 규칙**이다. [W3 s.20–31]

**English answer:** Forward propagation makes a prediction, and loss measures its error. Backpropagation calculates gradients. The optimizer uses them to update parameters.

#### 출력 과업과 Loss의 연결

**검색 태그:** [Classification] [Regression] [Loss Function] [Cross-Entropy] [MSE] [MAE] [Huber Loss] [SGD] [Momentum] [Adam] [RMSprop] [Adagrad]

| 과업 | 무엇을 예측하는가 | 예시·주요 Loss |
| --- | --- | --- |
| Classification | 어느 범주인가 | 스팸 여부·동물 종류; Binary/Categorical Cross-Entropy |
| Regression | 어떤 수치인가 | 온도·가격; MSE·MAE |

MSE는 큰 오차에 더 큰 벌점을 주고, MAE는 MSE보다 이상치에 덜 민감한 방식으로 소개된다. Huber는 두 방식의 성질을 결합하는 예다. SGD는 빠르지만 noisy한 갱신, Momentum은 진동 완화·수렴 가속, Adam은 Momentum과 적응적 학습률의 결합으로 설명된다. RMSprop·Adagrad는 이름과 적응적 조절의 취지를 아는 정도로 우선순위를 낮춘다. [W3 s.26–30]

**English answer:** Classification predicts a category, while regression predicts a number. Cross-entropy is used for classification; MSE or MAE can be used for regression. The choice should match the target and error behavior.

#### Representation Learning·Embedding·Latent Space

**검색 태그:** [Representation Learning] [Representation] [Embedding] [Latent Space]

**Representation Learning**은 사람이 특징을 모두 지정하는 대신 과업에 유용한 표현을 데이터에서 학습하는 것이다. 이미지에서는 초기 층의 edge·line·color가 중간 층의 texture·shape, 깊은 층의 object 특징으로 이어진다. [W3 s.34–35]

**Embedding은 한 입력의 벡터**, **Latent Space는 그 벡터들의 관계가 조직되는 학습 공간**으로 구분한다. 이 표현은 분류·군집·검색·생성에 활용될 수 있고, 멀티모달에서는 서로 다른 입력의 의미를 비교하는 공통 표현 공간으로 이어진다. [W3 s.36–38; W4 s.3–4]

**English answer:** Representation learning learns useful features from data. An embedding represents an input as a vector; a latent space organizes such representations and their relationships.

#### 학습·표현 개념의 응용과 어려움

[Application] [Challenge] [Solution] [Embedding] [Classification] [Regression]

**수업 확인:** 스팸 분류는 메시지에서 패턴을 학습하여 범주를 출력하는 사례다. 명시 규칙과 예시 학습을 비교하는 데 적합하다. 단, 처음 보는 표현에 대한 성능까지 보장하지 않는다. [W1 s.18–19; W3 s.6–9] 음성 기반 나이·성별 사례는 공통 음성 표현에서 나이 수치와 범주를 각각 출력한다. 정확한 성능은 자료에 없다. [CALL p.6]

**새 응용 제안 — 제공 자료에서 미확인:** 학생이 모은 분실물 사진을 embedding으로 바꾸고 “파란 물병”이라는 메모와 관련된 후보 사진을 찾는다. 출력은 후보 목록이다. 의미 공간의 활용을 설명하기 좋지만 비슷한 물병을 동일 물건이라고 확정할 수는 없다. 단순히 벡터 길이를 맞추는 것으로 이미지–텍스트 정렬이 완성되지 않는다.

| 문제 → 원인 | 대응 제안 → 도움이 되는 이유 → 한계 |
| --- | --- |
| 원하는 출력과 학습 목표 불일치 → 수치 예측에 범주 목표를 잘못 사용 | 범주에는 분류 목표, 수치에는 회귀 목표를 연결 → 원하는 종류의 출력을 학습 → 알맞은 목표라도 데이터 오류는 남음 |
| 큰 오차 몇 개가 학습을 좌우 → MSE의 큰 오차 제곱 | 오류 원인을 확인한 뒤 MAE·Huber 고려 → 극단적 오차의 영향을 조절 → 중요한 큰 오차까지 가볍게 볼 수 있음 |
| 표현 형식만 같고 의미는 다름 → 모달리티 사이 대응 학습 부족 | 올바른 짝의 자료로 관계 학습 → 같은 대상을 가깝게 표현하도록 유도 → 데이터의 편향은 남음 |

대응은 제안이며 Loss·표현 개념은 W3 s.26–38에 근거한다. 작은 주제에 중복된 네 번째 문제를 붙이지 않는다.

**짧은 영어:** Backpropagation calculates gradients. The optimizer uses them to update parameters. For a lost-item search, I would compare the meaning of a text note with image representations, but matching vector sizes alone would not align their meanings.

### 3. CNN과 계층적 시각 특징

#### CNN: 작은 특징을 쌓아 의미 있는 특징으로

**검색 태그:** [CNN] [Convolutional Neural Network] [Convolution] [Kernel] [Feature Map] [Kernel Size] [Stride] [Padding] [Number of Filters]

**Convolutional Neural Network(CNN)**은 이미지의 공간 구조를 처리하는 신경망이다. **Convolution**은 작은 Filter/Kernel을 이동시키며 입력 영역과 원소별 곱의 합을 계산하여 Feature Map을 만든다. 서로 다른 필터는 서로 다른 패턴에 반응한다. [W4 s.5–16]

- **Kernel Size:** 한 번에 보는 영역의 크기. 작은 필터는 세부 패턴, 큰 필터는 더 넓은 문맥과 연결된다.
- **Stride:** 필터의 이동 간격.
- **Padding:** 경계에 값을 추가해 출력의 공간 크기를 조절.
- **Number of Filters:** 학습할 특징과 출력 Feature Map의 수.

숫자 암기보다 “작은 영역을 곱해서 더한 뒤 이동한다”를 설명하고 한 영역의 값을 계산할 수 있어야 한다. 강의는 이 과정을 여러 슬라이드에 걸쳐 반복한다. [W4 s.6–16]

**English answer:** A CNN moves filters over local regions to create feature maps. Kernel size sets the viewed area, stride sets the movement, padding controls boundaries, and the number of filters sets output channels.

#### Pooling·Flatten·Classification

**검색 태그:** [Pooling] [Max Pooling] [Average Pooling] [Flatten] [Fully Connected] [Classification] [Softmax]

| 연산 | 어떻게 작동하는가 | 목적·차이 |
| --- | --- | --- |
| Max Pooling | 창 안의 최댓값 선택 | 강한 특징 반응을 남기면서 공간 크기 축소 |
| Average Pooling | 창 안의 평균 계산 | 전체 반응을 요약·평활화하며 공간 크기 축소 |
| Flatten | 다차원 Feature Map을 1차원 벡터로 펼침 | Dense 분류층에 전달할 형식으로 바꿈 |

예를 들어 영역 `[1, 3; 2, 6]`의 Max Pooling은 6, Average Pooling은 3이다. 이는 원리 확인용 계산 예시다. Pooling은 정보를 요약하며 줄이는 연산이고, Flatten은 배열 형태를 펼치는 연산이다. [W4 s.17–28]

강의의 분류 흐름은 `Image → Convolution/ReLU/Pooling → Flatten → Fully Connected → Softmax → Class`다. LeNet-5는 손글씨 숫자를 대상으로 이 흐름을 설명하는 대표 사례다. [W4 s.29–33]

**English answer:** Max pooling selects a local maximum, while average pooling takes a local mean. Both summarize regions. Flattening only reshapes feature maps into a vector for a dense layer.

#### CNN vs Transformer

**검색 태그:** [CNN] [Transformer] [ViT] [Swin Transformer] [VQA]

CNN은 가까운 영역의 필터 연산으로 시작하고, 깊은 층에서 더 넓은 문맥을 형성한다. Transformer는 token·patch 사이 관계를 Attention으로 결합한다. 강의는 ViT의 먼 patch 연결과 Swin의 local/shifted window도 구분한다. 따라서 “CNN은 문맥을 못 보고 Transformer는 언제나 모든 위치를 한꺼번에 본다”는 식의 단정은 피한다. 둘 다 Classification·Detection·Segmentation에 사용할 수 있다. [W4 s.35–39]

이미지 질문 응답에서는 CNN으로 얻은 시각 특징과 Transformer로 얻은 질문 표현을 결합해 답할 수 있다. 중요한 것은 모델 이름보다 **질문이 요구하는 시각 정보와 연결되는 과정**이다. [W4 s.40]

**English answer:** CNNs start with local filters and build wider context in deeper layers. Transformers connect elements through attention; some use local windows. Both can support visual tasks, so neither name alone determines the best choice.

#### CNN 응용과 비교에 쓸 재료

[Application] [Challenge] [Solution] [Comparison] [CNN]

**수업 확인 — LeNet-5:** 손글씨 숫자 이미지 → convolution과 subsampling으로 계층적 특징 추출 → 분류층 → 숫자 class. 작은 획·곡선을 쌓아 대상을 분류하는 흐름에 적합하다. 강의에 구체적 오류율은 없다. [W4 s.32–33] 음성 spectrogram의 chunk를 CNN으로 분류하고 투표로 감정을 모으는 별도 예도 있다. 음성을 그림 모양으로 바꿨다고 새로운 센서 모달리티가 생기지는 않는다. [CALL p.7]

**새 응용 제안 — 제공 자료에서 미확인:** 책상 위 학용품 사진을 직접 모아 연필·지우개·자 등으로 분류하는 정리 도우미. 사진 → CNN 특징 → 물건 범주 → 정리할 칸 표시. 반복되는 형태를 분류하는 데 적합하지만, 한 장에 여러 물건이 겹치면 단일 분류만으로 각각의 위치를 알 수 없다.

| 문제 → 원인 | 대응 제안 → 도움이 되는 이유 → 한계 |
| --- | --- |
| 작은 획·부품 손실 → 지나친 Pooling으로 공간 정보 축소 | 초기 단계의 축소를 줄임 → 작은 패턴 유지 → 계산·메모리 증가 |
| 떨어진 부분 사이 관계 부족 → 지역 특징만으로 판단 | 더 넓은 계층 문맥 또는 Attention 결합 검토 → 멀리 있는 단서 연결 → 데이터·계산 비용 증가 |

**짧은 영어:** A CNN extracts local patterns and combines them in deeper layers. Pooling summarizes regions, while flattening only reshapes feature maps. I would use these ideas to classify my stationery, but a class label alone would not locate every object.

**연결:** LeNet-5 / [[#Q10 — Self-Attention과 Cross-Attention 비교]]의 출처 기준 / [[#빠른 표 — 개념과 차이]].

### 4. Attention과 Transformer

#### Attention은 무엇을 해결하는가?

**검색 태그:** [Attention] [Saliency Detection] [Soft Attention] [Hard Attention]

입력의 모든 부분이 현재 과업에 똑같이 중요한 것은 아니다. **Attention**은 관련 정보를 더 크게 반영하여 문맥과 관계를 이해하도록 하는 기법이다. “소년이 무엇을 찼는가?”에는 공과 동작의 관계가 중요하고, “차가 무슨 색인가?”에는 해당 차량 영역이 중요하다. [W5 s.4–11, 42]

**Saliency Detection**은 강의의 비교에서 질문과 독립적으로 시각적으로 눈에 띄는 영역을 찾는 방식이고, **Attention Mechanism**은 현재 query·task와 관련된 정보를 가중한다. 결과가 heatmap처럼 보여도 목적과 계산 역할이 같다 보기는 어렵다. [W5 s.15, 이미지 비교표]

**Soft Attention**은 여러 부분에 연속적인 가중치를 주어 결합한다. **Hard Attention**은 하나 또는 소수의 부분을 선택한다. Soft Attention은 중요도가 낮은 정보를 반드시 모두 버리는 방식은 아니다. [W5 s.12–14]

**English answer:** Attention weights information by relevance to a task or query. Soft attention combines multiple parts with continuous weights, while hard attention selects particular parts. Saliency and task relevance are different criteria.

#### Q·K·V와 Attention의 작동 원리

**검색 태그:** [Attention] [QKV] [Query] [Key] [Value] [Scaled Dot-Product Attention] [Softmax] [Weighted Sum]

| 구성 | 뜻 | 하는 일 |
| --- | --- | --- |
| Query(Q) | 지금 찾는 정보 | 각 Key와 관련성 비교 |
| Key(K) | 어떤 정보를 제공하는지 나타내는 단서 | Query와의 점수 계산에 사용 |
| Value(V) | 실제로 가져와 결합할 정보 | Attention weight에 따라 가중합 |

계산의 흐름은 **Q와 K 비교 → Score scaling → Softmax → 가중치 → V의 가중합**이다. 높은 가중치의 Value가 결과에 더 크게 기여한다. [W5 s.18–22]

강의 식을 읽을 수 있는 수준으로 남기면 다음과 같다.

`Attention(Q,K,V) = softmax(QKᵀ / √dₖ)V`

`QKᵀ`는 관련성 점수, `√dₖ`는 점수 크기 조절, Softmax는 가중치 정규화, 마지막 `V`와의 곱은 정보 결합이다. 복잡한 행렬 유도보다 각 항의 목적이 우선이다. 예컨대 가중치가 0.7·0.2·0.1이면 결과는 `0.7V₁ + 0.2V₂ + 0.1V₃`다. [W4 s.36; W5 s.18, 21–22]

**English answer:** Attention compares queries with keys, scales the scores, and applies softmax. It then takes a weighted sum of values. A larger weight gives a value greater influence.

#### Self-Attention vs Cross-Attention

**검색 태그:** [Self-Attention] [Cross-Attention] [QKV] [VQA]

| 구분 | Q/K/V의 출처 | 이해할 관계·활용 |
| --- | --- | --- |
| Self-Attention | 같은 입력에서 Q·K·V 생성 | 문장 안의 단어 관계, 이미지 안의 patch 관계 |
| Cross-Attention | 한 입력의 Q와 다른 입력의 K·V | 텍스트 질문이 이미지 영역을 참조; Decoder가 Encoder 출력을 참조 |

“What is the person doing?”의 텍스트 Query가 이미지의 Key와 비교하여 달리는 사람의 Value를 가져오는 것이 Cross-Attention의 직관이다. Self/Cross의 가장 정확한 구분은 **Q와 K/V의 출처**다. Cross-Attention은 encoder–decoder 사이에도 쓰이므로, 반드시 서로 다른 감각 모달리티여야 하는 것은 아니다. [W5 s.23–28]

**English answer:** Self-attention takes Q, K, and V from the same input. Cross-attention takes Q from one input and K and V from another. The sources, rather than the sensory types alone, define the difference.

#### Transformer의 구성 요소

**검색 태그:** [Transformer] [Positional Encoding] [Multi-Head Attention] [Feed-Forward Network] [Residual Connection] [Normalization] [Encoder] [Decoder] [Masking]

- **Positional Encoding:** token의 위치·순서를 제공한다. 같은 단어도 앞뒤 관계가 바뀌면 의미가 달라지므로 Attention의 관계 정보와 위치 정보를 함께 사용한다.
- **Multi-Head Attention:** 여러 head가 서로 다른 관계를 병렬로 학습하고 출력을 합친다.
- **Feed-Forward Network:** Attention으로 결합된 표현을 추가 변환한다.
- **Residual Connection(Add)·Normalization(Norm):** 정보 흐름과 층 사이 값의 안정성을 돕는다.
- **Encoder:** 입력의 관계를 반영한 표현을 만든다.
- **Decoder:** Masked Self-Attention과 Encoder를 참조하는 Cross-Attention 등을 통해 출력 token을 만든다. 미래 token을 미리 보지 않도록 mask를 사용한다.
- **Linear·Softmax:** Decoder 출력을 다음 token의 확률로 변환한다.

여기서 Encoder–Decoder는 **강의가 설명하는 원형 Transformer 구조**다. 핵심 학습 포인트는 RNN의 순차 처리와 비교한 Attention의 관계 연결·병렬 처리다. 이를 모든 환경에서 무조건 빠르고 저렴하다는 주장으로 확장하지 않는다. [W5 s.31–34, 50]

**English answer:** Position information supplies order or location, and multiple heads can learn different relations. Feed-forward layers transform features; residual connections and normalization help information flow. The lecture decoder masks future tokens and refers to encoder outputs.

#### 서로 다른 입력을 어떻게 처리하는가?

**검색 태그:** [Tokenization] [Token] [Patch] [Audio Segment] [Embedding] [Transformer] [Preprocessing] [Alignment] [Computational Cost]

| 입력 | 단위로 나누는 방식 | 위치 정보가 필요한 이유 |
| --- | --- | --- |
| Text | word/subword token → embedding | 문장 내 순서 |
| Image | 고정 크기 patch → patch embedding | 이미지의 공간 위치 |
| Audio | 짧은 segment/frame → 특징·embedding | 소리의 시간 순서 |
| Video | frame의 patch 및 시간 정보 | 어디서, 언제 일어났는지 |

공통점은 벡터 sequence로 바꾸어 Attention을 적용할 수 있다는 것이다. **같은 구조 계열을 적용할 수 있음**과 **전처리·학습된 파라미터가 모두 같음**은 구분한다. 모달리티별 단위화·전처리가 필요하며, 관계 학습에는 잘 정렬된 양질의 데이터가 필요하다. 긴 영상 sequence는 계산 비용도 크다. [W5 s.36–39, 44, 48–50]

**English answer:** Text tokens, image patches, and audio segments can become embedding sequences. This supports a shared architecture family, but each modality needs suitable preprocessing and position information. Long sequences and poor alignment remain problems.

#### Attention 응용 카드 네 가지

[Application] [Attention] [Cross-Attention] [QKV]

**수업 확인 1 — 자동차 색 VQA.** 상황: 장면 속 자동차 색 질문. 입력: 이미지＋“What color is the car?” 처리: 질문의 Query가 이미지의 Key와 관련성을 계산하고 Value를 가중합한다. 출력: “Red.” 적합성: 배경보다 해당 자동차의 정보를 쓰게 한다. **한계 분석:** 자동차가 여러 대이고 질문이 대상을 특정하지 않으면 모호하다. [W5 s.27–28, 42]

**수업 확인 2 — 이미지 설명 생성.** 상황: 사진을 문장으로 설명. 입력: 사진과 생성 중인 단어 문맥. 처리: “boy”를 만들 때 소년 영역, “football”을 만들 때 공 영역에 주목한다. 출력: 이미지 설명 문장. 적합성: 각 단어와 관련된 시각 정보를 사용할 수 있다. **한계 분석:** 가려진 행동은 시각 근거만으로 확정하기 어렵다. [W5 s.8, 28, 42]

**새 응용 제안 — 제공 자료에서 미확인 1 — 준비물 메모와 책상 사진 점검.** 상황: 외출 전에 “학생증·충전기·노트”를 챙겼는지 본다. 입력: 준비물 텍스트＋책상 사진. 처리 제안: 각 물건 이름을 Query, 사진 영역을 Key/Value로 두어 대응 후보를 찾는다. 출력: 확인된 준비물과 다시 확인할 항목. 적합성: 질문마다 다른 물건 영역을 참조한다. 한계: 가방 속 물건은 사진에 없어도 실제로 준비되어 있을 수 있다.

**새 응용 제안 — 제공 자료에서 미확인 2 — 조별회의에서 내 할 일 찾기.** 상황: 긴 회의 녹음에서 자신의 담당과 관련된 부분을 찾는다. 입력: 녹음 구간 표현＋“내가 다음 주까지 할 일”이라는 질문과 사용자 이름. 처리 제안: 질문을 Query로 두고 관련 발언 구간을 참조한다. 출력: 할 일 후보와 재생 시각. 적합성: 전체 발언을 같은 비중으로 요약하지 않아도 된다. 한계: 이름이 생략되거나 말이 겹치면 담당자를 확정하지 못한다.

#### Attention·Transformer의 어려움 네 쌍

[Challenge] [Solution] [Transformer] [Positional Encoding] [Multi-Head Attention]

| 문제 | 원인 | 대응 제안 | 왜 도움이 되는가 | 한계 |
| --- | --- | --- | --- | --- |
| 순서·위치 혼동 | 관련성 계산만으로 단어 순서·patch 위치가 충분히 주어지지 않음 | 시간·공간에 맞는 위치 정보 추가 | 같은 요소도 순서와 장소에 따라 구분 | 잘못 기록된 위치까지 고치지는 못함 |
| 엉뚱한 대상 참조 | 질문이 모호하거나 이미지–텍스트 짝이 부정확 | 대상 조건을 명확히 하고 paired data 점검 | Query–Key 관계 학습의 근거 개선 | 완전히 가려진 대상은 복원 못함 |
| 한 관계만으로 부족 | 색·동작·주변 물체 등 필요한 관계가 다름 | Multi-Head로 여러 관계를 학습하도록 설계 | 서로 다른 관계를 함께 표현 가능 | head 수 증가가 서로 다른 역할·정확도 향상을 보장하지 않음 |
| 긴 sequence 비용 | 모든 구간을 세밀하게 비교하면 처리량 증가 | 관련 시간 구간이나 영상 영역을 먼저 줄임 | Attention에 들어갈 단위 수 감소 | 사전 선택이 필요한 단서를 버릴 수 있음 |

위치·여러 head의 역할과 긴 입력의 비용은 수업 개념이다. 구체적 대응 설계와 한계는 응용 판단이다. [W5 s.31–39, 50]

**짧은 영어:** Attention compares a query with keys and combines values using the resulting weights. I would use a checklist as queries over a desk photo. The output would show matching objects, but a missing match would not prove that an item was lost.

**연결:** Attention Is All You Need / [[#Q2 — Attention에 대한 5줄 의견]] / [[#Q12 — Attention의 사례 네 가지]].

### 5. 음성 감정 인식과 문맥 추론

#### 두 흐름을 구분하기

**검색 태그:** [LISTEN] [Fraud Detection] [Speech Recognition] [SER] [Speech Emotion Recognition] [Spectrogram] [3D CNN]

CALL의 앞부분은 통화 내용 기반 사기 탐지와 LISTEN의 모듈을 소개한다. p.4의 도식은 **Call → Recording → Speech Recognition → Text → Fraud Detection Rules → Alert**다. 성별 추정·연령 예측·Speech Emotion Recognition(SER)·Fusion/Reasoning도 별도 기능으로 소개된다. 감정 하나를 예측한 결과가 곧 사기 확정이라는 뜻은 아니다. [CALL p.2–10]

후반부는 **추론 과정을 이용한 SER**을 설명한다. 음성을 Spectrogram으로 변환하고 시간 구간별로 나누어 쌓은 뒤, 3D CNN과 Softmax로 감정 후보를 출력한다. Spectrogram은 음성의 시간·주파수 표현이며, 이미지처럼 처리해도 정보원은 여전히 Audio다. [CALL p.11–14]

**English answer:** Content-based call analysis converts speech to text and applies fraud rules. The later SER pipeline uses spectrogram segments and a 3D CNN to predict emotions. An emotion label alone does not establish fraud.

#### 순간 예측을 이력·지식으로 보완

**검색 태그:** [SER] [Speech Emotion Recognition] [Reasoning] [Confidence] [Speaker History] [Emotion Co-existence] [Reliability-Weighted Fusion] [Fusion] [Fine-Tuning]

현재 예측의 최대 확률로 High·Medium·Low confidence를 구분한다. 낮은 신뢰도 결과는 버리고, 모호하거나 충돌하는 감정 후보는 다음 근거로 보완한다. [CALL p.12, 14–23]

| 근거 | 무엇을 제공하는가 |
| --- | --- |
| Original Prediction | 현재 구간의 classifier score |
| Speaker's History | 이전 N개 구간에서 감정이 나타난 비율 |
| Emotion Co-existence Knowledge | 감정 조합의 공존·충돌에 대해 지식표가 주는 score |

이력 점수는 `H(E) = 이전 N개 중 감정 E의 횟수 / N`, 가중 결합은 `F(E) = r₁S₁(E) + r₂S₂(E) + r₃S₃(E)`다. 후보별 결합 점수 중 가장 큰 감정을 선택한다. 과거 감정이 Sad 4회·Neutral 3회이면 이력 점수는 각각 4/7·3/7이다. [CALL p.18, 22–23]

p.22의 예시에서 현재 score는 Neutral이 높지만, 이력·공존 지식을 결합한 최종 score는 Happy가 높다. **순간 classifier의 1등이 최종 결정의 1등과 달라질 수 있음**이 핵심이다. 예시 weight 0.15·0.50·0.35는 이 사례의 설정으로 이해한다. [CALL p.22]

신뢰도 높고 충돌하지 않는 결과를 Emotional History에 유지하고, 신뢰도 높은 spectrogram·annotation을 누적해 iterative fine-tuning에 사용하는 흐름도 제시된다. 이력은 다음 구간의 추론과 통화 전체 감정 요약에 활용한다. [CALL p.12, 24–26]

**답변에 쓸 한계 — 자료 기반 추론:** 이력에 큰 비중을 두면 실제 감정 변화가 과거 상태에 눌릴 수 있고, 잘못된 이력이 후속 판단에 영향을 줄 수 있다. 이는 제안 구조에서 도출한 검토 의견이며, 강의가 보고한 실패 실험 결과는 아니다. 감정 공존표도 이 자료의 reasoning 가정으로 설명한다.

**English answer:** The system combines current emotion scores, speaker history, and co-existence knowledge using reliability weights. It filters predictions by confidence. History can support unclear input, but strong history may hide a real change.

#### SER 응용·대응 재료

[Application] [Challenge] [Solution] [SER] [Speaker History] [Reasoning]

**수업 확인 1 — 구간별 감정 투표:** 음성 spectrogram → chunk → CNN 감정 예측 → Majority Voting → 최종 감정 label. 여러 구간의 판단을 모으는 예이며 이력·지식 reasoning과 다른 방법이다. 투표는 짧은 실제 감정 변화를 가릴 수 있다는 한계를 추론할 수 있다. [CALL p.7]

**수업 확인 2 — 이력·지식 기반 감정 보완:** 현재 speech segment＋이전 감정 이력＋공존 지식 → confidence 점검과 세 score의 가중 결합 → 감정 label·통화 감정 요약. 모호한 순간 예측에 문맥을 보탠다. 이력도 모델 예측이므로 정답으로 간주할 수 없다. [CALL p.12–26]

**새 응용 제안 — 제공 자료에서 미확인:** 자신의 발표 연습을 녹음하여 긴장해 보이는 음성 구간을 다시 듣는 도우미. 음성 → 구간별 표현·감정 후보 → 이전 구간과 함께 검토 → 확인할 시각 목록. 짧은 잡음 구간을 그대로 전체 감정으로 확대하지 않는 데 도움이 될 수 있다. 음성에서 추정한 감정과 실제 감정은 다를 수 있으므로 사용자가 다시 듣고 판단한다. 연구 성과나 심리 평가 도구로 주장하지 않는다.

| 문제 | 원인 | 대응 방법 | 왜 도움이 되는가 | 남는 한계 |
| --- | --- | --- | --- | --- |
| 낮은 confidence | 잡음·불분명한 신호 | **수업:** 낮은 confidence 결과 제외 | 약한 결과를 후속 판단 근거로 삼지 않음 | 제외 구간에 중요한 변화가 있을 수 있음 |
| 비슷한 후보·충돌 | 현재 score만으로 감정 구별이 어려움 | **수업:** 이력·공존 지식을 reliability weight로 결합 | 추가 근거가 후보를 구분 | 가중치·지식표가 맞아야 함 |
| 갑작스러운 변화 억제 | 과거 이력이 현재보다 지배적 | **제안:** 오래된 이력 비중을 줄이고 변화 구간 재확인 | 현재 변화가 반영될 여지 | 잡음도 변화로 볼 수 있음 |
| 잘못된 이력·학습 자료 누적 | 높은 confidence도 실제 정답을 보장하지 않음 | **제안:** 일부 구간을 직접 확인한 뒤 이력·fine-tuning 자료로 사용 | 자기 예측 오류의 반복을 줄임 | 사람 확인 비용이 필요 |

수업 방법: CALL p.12, 18, 22–26. 마지막 두 문제와 대응은 구조에서 도출한 설계 의견이다. **Confidence는 모델 score이지 검증된 정답률이 아니다.**

**짧은 영어:** The SER system combines current predictions, speaker history, and emotion knowledge. History can support an unclear segment. However, I would check sudden changes and review some high-confidence labels because confidence alone does not prove correctness.

**원본 표현 정정:** 현재 score보다 결합 score가 다른 감정을 선택하는 설명은 CALL **p.22와 p.23**의 예다. p.22는 Original Prediction의 Neutral 0.58이 Happy 0.5보다 높지만 결합 후 Happy를 선택한다. p.23은 Happy 0.691 표기와 제시 항의 계산값 0.6915가 약간 다르며 선택은 같다.

**연결:** CALL의 짧은 논문 / [[#Q4 — SER의 네 가지 어려움]].

### 6. 움직임 검출과 Baby Monitoring

#### 목적과 관측의 어려움

**검색 태그:** [Baby Monitoring] [Dataset] [Motion Detection]

보호자의 지속적인 관찰 부담을 줄이기 위해 카메라로 움직임을 관찰한다. 부착형 센서는 착용 유지가 어렵고, 카메라는 호흡처럼 작은 움직임을 검출하기 어렵다는 동기가 제시된다. 자체 데이터는 27 videos·6 subjects·여러 촬영 높이·상황으로 구성되며, 결과 예시에는 doll·company·YouTube 영상도 등장한다. 모든 평가 장면을 실제 아기 영상으로 해석하지 않는다. [BABY s.4–10, 21–31]

**English answer:** Camera monitoring aims to reduce continuous observation by caregivers. Small movements are hard to detect. The lecture examples include different recording conditions and some non-baby videos, which limits the scope of the evidence.

#### 세 Motion Detection 방법과 Hybrid

**검색 태그:** [Motion Detection] [Frame Difference] [Optical Flow] [Background Subtraction] [Hybrid] [Multiple-Method Fusion] [Fusion] [Computational Cost]

| 방법 | 비교하는 대상·원리 | 구분 포인트 |
| --- | --- | --- |
| Frame Difference | 연속 두 frame의 pixel 차이를 계산하고 threshold·형태학적 처리로 motion 영역 추출 | “무엇이 달라졌는가” |
| Optical Flow | 연속 frame 사이의 영상상 움직임을 추정하고 flow를 motion 영역으로 변환 | “어떻게 이동했는가” |
| Background Subtraction | 현재 frame과 background model을 비교해 foreground mask 추출 | “배경과 무엇이 다른가” |
| Hybrid | 세 방법의 binary motion 추정 결과를 결합 | 같은 영상의 서로 다른 검출 근거를 함께 사용 |

슬라이드의 Hybrid 도식은 Intersection을 표시한다. 세 입력 모달리티를 결합하는 것으로 외우지 않는다. 보고된 11개 영상의 accuracy에서는 Hybrid가 각 단일 방법보다 높지만, 평가 장면과 자료 범위가 제한되어 있다. 결론은 Hybrid를 권고하면서 **상대적으로 계산 비용이 크다**고 밝히고, 영상 수·상황·난점을 늘리는 dataset 확장을 후속 과제로 제시한다. [BABY s.12–20, 43]

**English answer:** Frame difference compares consecutive frames, optical flow estimates apparent motion, and background subtraction compares a frame with a background model. The hybrid combines motion estimates from the same video. It adds computation and does not add input modalities.

#### Motion Detection에서 Behavior Analysis로

**검색 태그:** [Behavior Analysis] [Calibration] [Prior Knowledge] [Ellipse] [Intensity] [Diversity] [Control Chart] [LCL] [UCL] [Alert]

`Video → Interval → Baby Segmentation → Motion Area → Size Calibration → Ellipse → Intensity/Diversity → Control Chart → Alert`

- **Size Calibration:** 카메라 거리·Frame-to-Baby Ratio·신체 부위 크기 지식을 활용한다. 촬영 높이가 달라지면 동일 신체 부위의 pixel 크기도 달라지기 때문이다.
- **Movement Intensity(I):** ellipse의 크기로 나타내는 움직임의 정도.
- **Movement Diversity(D):** ellipse의 개수로 나타내는 움직임 영역의 다양성.
- **Control Chart:** interval 안의 움직임을 LCL(Lower Control Limit)·UCL(Upper Control Limit)과 비교하는 도표.
- **Alert:** I 또는 D가 허용 범위의 하한 아래·상한 위로 벗어나면 보호자에게 알린다. 움직임이 너무 적은 경우도 경고 대상이다.

**동작 영역 검출**과 **행동의 정상·이상 판단**은 별도 단계다. 크기 보정·특징 추출·범위 비교가 두 단계를 이어 준다. [BABY s.33–41]

**English answer:** The system calibrates motion regions and represents intensity by ellipse size and diversity by ellipse number. It compares them with lower and upper limits. Either too little or too much movement can trigger an alert.

#### Baby Monitoring을 일상으로 옮기는 재료

[Application] [Challenge] [Solution] [Baby Monitoring] [Control Chart]

**수업 확인 — 움직임 경고:** 카메라 영상 → 세 motion 검출법의 Hybrid → 크기 보정 → ellipse 크기(Intensity)·개수(Diversity) → LCL/UCL 비교 → 보호자 경고. 여러 검출법과 행동 판단은 시스템 안의 단계들이므로 별개의 응용 사례 두 개로 세지 않는다. [BABY s.12–17, 33–40]

**새 응용 제안 — 제공 자료에서 미확인 1 — 공부 중 자세 점검.** 입력: 자기 책상 옆 카메라 영상. 처리: 일정 구간의 몸 움직임 영역·크기를 기록하고 촬영 거리에 맞게 크기를 보정한다. 출력: 오래 고정된 자세를 스스로 확인할 알림. 적합성: 관찰→구간별 요약→기준 이탈 알림이라는 수업 원리를 옮긴다. 한계: 가만히 있다고 나쁜 자세는 아니며, 아기용 기준을 그대로 쓰면 안 된다.

**새 응용 제안 — 제공 자료에서 미확인 2 — 세탁 종료 확인.** 입력: 세탁기 창을 고정 촬영한 영상. 처리: 창 영역의 구간별 움직임을 요약하고 일정 시간 낮은 상태가 이어지는지 확인한다. 출력: 세탁기 표시를 확인하라는 알림. 적합성: 매번 직접 보러 가는 부담을 줄이는 보조 신호다. 한계: 세탁 중 일시 정지도 있어 움직임 없음만으로 종료를 확정할 수 없다.

#### Baby Monitoring의 어려움 네 쌍

| 문제 | 원인 | 대응 방법 | 왜 도움이 되는가 | 남는 한계 |
| --- | --- | --- | --- | --- |
| 검출법마다 실패 조건 다름 | 두 frame 차이·flow·배경 차이가 보는 근거가 다름 | **수업:** binary motion 결과를 Hybrid로 결합 | 서로 다른 검출 근거를 함께 사용 | intersection은 한 방법이 놓친 작은 동작도 제외할 수 있음 |
| 촬영 높이에 따른 특징 변화 | 같은 신체 부위도 pixel 크기가 달라짐 | **수업:** frame-to-baby ratio·신체 크기 지식으로 보정 | 움직임 크기를 더 일관되게 해석 | 가림·잘못된 segmentation에는 취약 |
| 실시간 처리 부담 | 세 검출법을 함께 수행 | **제안:** 관찰 목적에 맞춰 영상 해상도·처리 간격 조절 | 처리량을 줄일 수 있음 | 미세하거나 짧은 움직임을 놓칠 수 있음 |
| 다른 상황에서의 일반화 불확실 | 자료의 촬영 환경·대상·영상 수 제한 | **수업 후속 방향:** 더 다양한 상황의 dataset 확장과 평가 | 범위 밖 실패를 발견하는 데 도움 | 자료 확대만으로 실제 사용 신뢰성이 입증되지는 않음 |

근거: BABY s.4–10, 12–20, 35, 43. Hybrid의 교집합 누락 가능성·해상도 조절은 설계 분석과 제안이다.

**짧은 영어:** The system measures motion and compares it with lower and upper limits. I would adapt this idea to a study reminder, using my own recording distance and activity limits. An alert would ask me to check my posture; it would not prove a health problem.

**연결:** 관련 Baby 논문 / [[#Q6 — Baby Monitoring을 공부 중 자세 점검에 적용]].

### 7. 영상 개선과 목적별 평가

#### Enhancement와 Recognition의 차이

**검색 태그:** [Low-Level Vision] [Image Enhancement] [Dehazing] [LLIE] [Low-Light Image Enhancement] [Object Detection]

**Low-Level Vision**의 이번 중심은 열화된 영상을 복원·개선하는 것이다. **Dehazing**은 haze에 의한 시야 저하, **Low-Light Image Enhancement(LLIE)**는 부족한 조명 조건을 다룬다. 출력은 개선된 이미지다. 반면 **Object Detection**의 출력은 객체의 class·위치이며, Enhancement 이후의 활용을 검증하는 downstream task다. [LOW s.3–4, 8, 12, 15, 21]

**English answer:** Enhancement outputs an improved image. Dehazing treats haze, and low-light enhancement treats poor illumination. Detection instead outputs object classes and locations, so its usefulness needs a separate check.

#### HazeSpace2M과 Haze-Aware Dehazing

**검색 태그:** [HazeSpace2M] [Dehazing] [Haze-Aware Dehazing] [Dataset Diversity] [Paired Data] [Ground Truth] [Specialized Dehazer] [Conditional Model Selection] [Classifier Dependency] [Synthetic-to-Real Gap]

기존 방법이 특정 haze나 합성 조건에 치우치고 다양한 데이터가 부족하다는 문제에 대응한다. **HazeSpace2M**은 Outdoor·Street·Farmland·Satellite의 네 scene, Fog·Environmental Haze(EH)·Cloud의 세 haze type, 여러 intensity와 Real Haze Testset을 제공한다. 모든 scene에 세 type이 전부 존재하는 구성은 아니다. 약 2.2M이라는 총량은 **GT와 hazy image의 합**이다. [LOW s.3–7]

**Paired Data**는 hazy input과 대응 GT reference가 연결된 자료다. 복원 기준과 비교할 수 있게 해 준다. GT 선정에서는 해상도·기존 haze 포함 여부·주제 관련성을 확인한다. [LOW s.5–7]

**Haze-Aware Dehazing**의 원리는 `Hazy Image → Haze Type Classification → Specialized Dehazer 선택 → 복원`이다. 서로 다른 열화 조건에 맞춘 모델을 선택한다. **Dataset은 HazeSpace2M, 처리 방식은 Haze-Aware Framework**라는 차이를 기억한다. [LOW s.8–10]

한계는 **Classifier Dependency**와 **Synthetic-to-Real Gap**이다. 잘못 분류하면 부적합한 dehazer를 선택할 수 있고, 합성 데이터가 실제 환경을 충분히 대표하지 못할 수 있다. 강의의 후속 방향은 여러 type을 처리하는 Unified Method와 계산 비용 절감이다. [LOW s.22]


**English answer:** HazeSpace2M provides diverse paired haze data and a real test set. The haze-aware method classifies the haze type and selects a specialized dehazer. Wrong classification and synthetic-to-real differences remain limits.

#### LoLI-Street와 TriFuse

**검색 태그:** [LoLI-Street] [TriFuse] [LLIE] [Low-Light Image Enhancement] [RLLT] [DWT] [Wavelet] [Diffusion] [CNM] [ESM] [Cross-Attention]

**LoLI-Street**은 도로 저조도 영상 개선의 benchmark다. 본문은 33k paired low-light images와 실제 저조도 testset **RLLT(Real-Life Low-Light Testset)**를 소개한다. Light·Moderate·Dense 조건을 다루며, 합성/paired 조건과 실제 영상에서의 일반화를 나누어 평가한다. [LOW s.11, 15–21]

**TriFuse**는 같은 RGB 이미지에서 주파수 성분별 처리와 Diffusion·Transformer를 결합하는 LLIE 모델이다.

1. **DWT(Discrete Wavelet Transform):** Haar wavelet으로 저주파와 방향별 고주파 성분을 분해한다.
2. **저주파 경로:** Diffusion Denoising으로 복원한다. Forward Diffusion은 점진적으로 noise를 더하고, Reverse Diffusion은 학습한 방식으로 noise를 제거하는 방향이다.
3. **CNM(Conditional Noise Module):** Encoder·Transformer blocks·Decoder를 통해 조건을 반영한 noise prediction을 제공한다.
4. **ESM(Edge Sharpening Module):** 고주파의 경계·세부 구조를 보완한다. Residual·Cross-Attention 등을 사용한다.
5. **Inverse DWT:** 처리한 성분을 이미지로 재구성한다.

큰 구조·완만한 변화와 방향별 경계·detail을 나누어 처리한다는 아이디어가 핵심이다. **여러 주파수 band·여러 모델 구성 요소와 여러 modality는 구분**한다. [LOW s.12–14, Fig.7]

**English answer:** LoLI-Street is a low-light benchmark, while TriFuse is an enhancement model. TriFuse separates frequency bands, uses diffusion and CNM for low-frequency restoration and ESM for details, then reconstructs the image. All bands come from one RGB image.

#### 결과를 읽는 기준

**검색 태그:** [Evaluation] [Image Quality] [PSNR] [SSIM] [MS-SSIM] [MSE] [MAE] [LPIPS] [BRISQUE] [NIQE] [Object Detection] [YOLOv10] [mAP] [Pretrained] [Dataset-Trained]

| 평가 관점 | 자료의 지표·비교 | 기억할 의미 |
| --- | --- | --- |
| 분류 | ACC·Precision·Recall | haze type을 올바르게 고르는가 |
| Reference 기반 복원 | PSNR·SSIM·MS-SSIM은 높게, MSE·MAE·LPIPS는 낮게 | 기준 이미지와의 오차·구조·지각적 차이를 평가하는 관점 |
| 실제 저조도 품질 | BRISQUE·NIQE는 낮게 | reference 없이 품질 평가 |
| Downstream Detection | YOLOv10의 mAP | 개선된 이미지가 실제 객체 검출에 도움이 되는가 |
| 학습 조건 | Pretrained vs LoLI-Street-trained weights | 다른 학습 조건의 표를 같은 조건처럼 비교하지 않기 |

위 지표의 방향과 평가 용도는 강의 표를 읽기 위한 수준이다. 상세 정의·수식은 현재 자료가 충분히 설명하지 않으므로 암기 대상으로 추가하지 않았다. [LOW s.9–10, 15–16]

TriFuse는 RLLT의 trained-weights 비교와 downstream 평균 mAP에서 좋은 결과를 보이지만, Light 조건 PSNR 등에서는 다른 방법이 더 높다. 따라서 핵심 결론은 **실제 환경·평가 지표·학습 조건을 나누어 강점을 설명한다**는 것이다. [LOW s.15, Tables 12–14]

**English answer:** Evaluation separates reference image quality, no-reference quality, and downstream detection. Training conditions must also match. Good average results do not mean that a method is best for every metric or condition.

#### 영상 개선 응용 카드 네 가지

[Application] [Image Enhancement] [Dehazing] [LLIE]

**수업 확인 1 — Haze-Aware Dehazing.** 상황: haze 유형이 달라 같은 복원 방식만으로 충분하지 않음. 입력: hazy image. 처리: haze type 분류 → Specialized Dehazer 선택. 출력: 복원 이미지. 적합성: 열화 조건에 맞는 처리를 선택. 한계: 분류 오류 전파와 합성–실제 차이. [LOW s.8–10, 22]

**수업 확인 2 — LoLI-Street/TriFuse.** 상황: 어두운 도로 영상의 가시성·검출 유용성 평가. 입력: 저조도 RGB 이미지. 처리: DWT → 저주파 Diffusion/CNM, 고주파 ESM → Inverse DWT. 출력: 개선 이미지이며 후속으로 객체 class·위치를 평가. 적합성: 큰 구조와 세부 경계를 나누어 다룸. 한계: 모든 조건·지표에서 최고는 아니며 실제 환경과 검출을 따로 확인해야 함. [LOW s.11–21]

**새 응용 제안 — 제공 자료에서 미확인 1 — 어두운 필기 사진 정리.** 입력: 늦은 시간에 찍은 필기 사진. 처리 제안: 조명 개선과 noise 억제를 적용하고 글자 획이 남는지 확인. 출력: 읽기 좋은 후보 사진과 원본 비교. 적합성: 밝기뿐 아니라 획 보존이 목적. 한계: 흐림으로 사라진 획은 밝게 한다고 복구되지 않으며 식을 바꿔 보이게 할 수 있음.

**새 응용 제안 — 제공 자료에서 미확인 2 — 야간 동아리 단체사진 정리.** 입력: 어두운 단체사진. 처리 제안: 전체 밝기와 세부 경계를 분리해 조절하고 원본과 비교. 출력: 사진첩용 개선 후보. 적합성: 얼굴·배경을 보기 쉽게 만드는 일상 과업. 한계: 지나친 밝기·선명도 조절은 noise나 부자연스러운 경계를 만들 수 있으며 실제 얼굴 정보를 복원했다고 주장하지 않음.

#### 영상 개선의 어려움 네 쌍

[Challenge] [Solution] [Classifier Dependency] [Synthetic-to-Real Gap] [Evaluation]

| 문제 | 원인 | 대응 방법 | 왜 도움이 되는가 | 남는 한계 |
| --- | --- | --- | --- | --- |
| 부적절한 복원 경로 선택 | haze classifier가 잘못 분류 | **수업 후속 방향:** 여러 유형을 처리하는 Unified Method 검토 | 잘못된 유형 선택에 대한 의존을 줄이는 방향 | 모든 조건을 한 모델이 잘 처리하는지는 평가 필요 |
| 실제 영상에서 성능 저하 | 합성 열화가 실제 조건을 충분히 대표하지 못함 | **수업:** real testset으로 별도 확인; **제안:** 실제 실패 유형을 반영해 자료 보완 | 실제 환경 차이를 발견·완화하는 데 도움 | 수집하지 못한 환경은 남음 |
| 밝기와 세부 획·경계 보존 충돌 | 전체 밝기 처리만으로 noise·detail을 함께 다루기 어려움 | **수업 아이디어:** TriFuse처럼 성분별 처리; **제안:** 원본과 획 보존 비교 | 큰 구조와 세부 정보에 다른 처리를 적용 | 과한 보정은 인공적 경계를 만들 수 있음 |
| 품질 점수와 사용 목적 불일치 | reference 품질과 검출·가독성이 서로 다른 목표 | **수업:** 영상 품질과 detection을 나눠 평가; **제안:** 필기라면 실제 판독도 확인 | 원하는 사용 목적에 맞게 판단 | 평가에 포함하지 않은 목적에는 일반화 못함 |

수업 근거: LOW s.12–22. 제안의 개선 효과는 아직 검증되지 않았다.

**짧은 영어:** I would enhance a dark photo of my notes, but I would check the original letter strokes. A brighter image is useful only if the text remains correct. This is a proposed use of enhancement, not a result reported for TriFuse.

**연결:** HazeSpace2M·LoLI-Street 논문 / [[#Q5 — 영상 개선의 네 가지 어려움]] / [[#Q7 — Haze-Aware 원리를 필기 사진 정리에 적용]].

## Part 3. 논문을 응용 답안에 사용하는 방법

### 논문 선택 기준

논문 이름을 많이 쓰기보다 **문제와 설계 사이의 연결**을 빌려 쓴다. HazeSpace2M·LoLI-Street/TriFuse는 방법·강의 보고 결과 중심, Attention·LeNet-5는 개념 원리 중심, Baby 논문은 강의 비교 범위 중심이다. CALL의 짧은 도식은 처리 목적까지만 쓴다. 아래 **Result는 강의자료에서 확인되는 범위**이며 새 적용의 성과가 아니다.

### 논문 — HazeSpace2M: A Dataset for Haze Aware Single Image Dehazing

**Theme:** 열화 조건이 다양한 데이터셋 구축과 haze 유형에 따른 복원 모델 선택.

**검색 태그:** [HazeSpace2M] [Dehazing] [Dataset Diversity] [Paired Data] [Conditional Model Selection] [Specialized Dehazer] [Synthetic-to-Real Gap]

**분류:** 본문 상세 설명. ACM Multimedia 2024로 소개. [LOW s.4–10]

- **Problem:** 단일 haze 가정과 제한적인 데이터 다양성으로 실제 열화 조건을 충분히 다루기 어렵다.
- **Method:** scene·haze type·intensity를 다양화한 paired dataset과 real testset을 구성한다. Haze type을 분류한 뒤 해당 Specialized Dehazer를 선택하는 framework를 사용한다.
- **Result:** 다양한 학습·평가 자료를 제공했다. s.9 Table 6의 Fog·EH·Cloud 비교에서는 SDNets가 LDNet·GDNet보다 높은 평균 PSNR·SSIM, 낮은 평균 MSE를 보인다. 이는 해당 비교 조건의 결과다.
- **Significance:** 데이터의 규모뿐 아니라 **열화 유형을 구분하여 적합한 복원 전략을 선택하는 문제**를 부각한다. 실제 환경 검증과 classifier 오류 전파를 함께 생각하게 한다.

**연결 개념:** Dataset diversity, Paired data, Conditional model selection, Synthetic-to-real gap.

**활용할 질문:** 조건에 따라 처리 방법을 바꿀 이유, classifier 오류 전파, 데이터 다양성·실제 환경 차이. [[#Q5 — 영상 개선의 네 가지 어려움]], [[#Q7 — Haze-Aware 원리를 필기 사진 정리에 적용]].

**내 확장 제안 — 제공 자료에서 미확인:** 필기 사진을 어두움·흔들림·문제없음으로 나누고 조명 개선·재촬영 권유·원본 유지 중 하나를 고른다. 새 입력·열화 범주·경로·판독 평가가 필요하다. 원래 haze class와 모델을 그대로 재사용한다고 가정하지 않는다. 새로운 사례의 근거는 일상의 불편이며, 논문은 조건별 선택 원리를 설명하는 데만 사용한다.

**짧은 영어 답안:** The lecture's haze-aware system classifies haze and selects a suitable dehazer. I would use condition-based selection for my note photos, choosing enhancement or retaking the photo. I would need different condition labels and would check whether the text stays correct.

### 논문 — LoLI-Street: Benchmarking Low-Light Image Enhancement and Beyond — TriFuse

**Theme:** 도로 저조도 영상의 benchmark·복원과 개선 후 객체 검출.

**검색 태그:** [LoLI-Street] [TriFuse] [LLIE] [Image Enhancement] [DWT] [Diffusion] [Transformer] [Cross-Attention] [CNM] [ESM] [Image Quality] [Object Detection]

**분류:** 본문 상세 설명. ACCV 2024로 소개. TriFuse는 이 연구에서 설명하는 제안 모델이다. [LOW s.11–21]

- **Problem:** 도로 저조도 영상에서는 밝기와 세부 구조가 손상되어 후속 시각 과업도 어려워진다. 적절한 benchmark와 실제 저조도 평가가 필요하다.
- **Method:** LoLI-Street paired data와 RLLT를 구성한다. TriFuse는 DWT로 주파수 band를 나누고, 저주파 복원에 Diffusion과 CNM을, 고주파 detail 보완에 ESM을 사용한 뒤 재구성한다.
- **Result:** 강의는 RLLT에서 SOTA 결과를 소개한다. s.15의 trained-weights 표에서 BRISQUE·NIQE가 비교 모델 중 가장 낮고, YOLOv10의 두 평균 mAP도 가장 높다. 다른 조건·개별 지표·객체 class까지 모두 최고인 결과는 아니다.
- **Significance:** 영상 품질과 **downstream 검출의 유용성**을 함께 평가한다. 주파수 분해·조건부 noise 예측·경계 보완이 하나의 복원 목적에 연결되는 사례다.

**연결 개념:** Transformer, Cross-Attention, Conditional processing, Reference/no-reference evaluation.

**활용할 질문:** 큰 구조·경계에 서로 다른 처리를 할 이유, 평가 기준 비교, PSNR만으로 충분한지. [[#Q5 — 영상 개선의 네 가지 어려움]].

**내 확장 제안 — 제공 자료에서 미확인:** 어두운 단체사진에서 전체 밝기와 경계 보존을 나누어 살펴본다. 도로 대신 사람 사진이므로 대상 데이터와 평가 목적을 바꾸어야 한다. 사진첩용 자연스러움과 원본의 세부 보존을 확인하며, 도로의 검출 결과를 사람 사진 성능으로 옮기지 않는다.

**짧은 영어 답안:** TriFuse separates frequency bands and treats broad structures and details differently. I would consider this principle when adjusting a dark group photo. I would check natural appearance and preserved details, because street-image results do not establish performance on my photos.

### 논문 — Attention Is All You Need — Vaswani et al., 2017

**Theme:** Attention 중심의 sequence 처리와 Transformer의 공통 구조.

**검색 태그:** [Attention Is All You Need] [Attention] [Transformer] [Self-Attention] [Cross-Attention] [QKV] [Positional Encoding] [Multi-Head Attention] [Masking]

**분류:** 명시적으로 제시되고 구조가 반복 설명되는 중심 개념 논문. 원문 실험표는 자료에 없다. [W4 s.35–36; W5 s.6, 31–34]

- **Problem:** 강의의 설명은 RNN의 순차 처리와 긴 sequence의 이전 정보 활용 어려움을 출발점으로 삼는다.
- **Method:** Attention을 중심으로 관계를 연결한다. Multi-Head Attention·Positional Encoding·Feed-Forward·Add/Norm과 Encoder–Decoder 구조를 사용한다.
- **Result:** 강의는 관련 요소 연결과 병렬 처리의 이점을 설명한다. 원 논문의 번역 점수·학습 비용·정확한 개선 수치는 제공하지 않으므로 추가하지 않는다.
- **Significance:** token·patch·segment를 embedding으로 바꾸어 여러 입력 종류에 적용하는 공통 구조의 토대다.

**연결 개념:** Q/K/V, Self/Cross-Attention, Masking, Position, Multimodal interaction.

**활용할 질문:** 관련 정보 선택, Self/Cross 비교, 위치 정보·Multi-Head의 역할, 여러 입력을 sequence로 바꾸는 이유. [[#Q2 — Attention에 대한 5줄 의견]], [[#Q10 — Self-Attention과 Cross-Attention 비교]].

**내 확장 제안 — 제공 자료에서 미확인:** 준비물 메모를 Query로 책상 사진의 물건 후보를 참조한다. 이미지 encoder·text 표현·짝지어진 자료·사진 위치 표현이 필요하며, 원형 text Transformer의 구조 설명만으로 해당 기능이 완성되지는 않는다.

**짧은 영어 답안:** Attention combines values according to query-key relevance. I would use checklist words to query regions of a desk photo. This would require image and text representations and data that link them; the architecture alone does not guarantee correct matches.

### 논문 — LeNet-5 — LeCun et al., 1998

**Theme:** 계층적 시각 특징 학습을 이용한 손글씨 숫자 분류.

**검색 태그:** [LeNet-5] [CNN] [Convolution] [Pooling] [Feature Map] [Classification]

**분류:** CNN 분류 흐름을 설명하는 명시적 연구 사례. 슬라이드는 LeNet-5 이름으로 소개하며 정식 논문 제목은 제시하지 않는다. [W4 s.32–33]

- **Problem:** 이미지에서 손글씨 숫자를 인식한다.
- **Method:** Convolution과 Subsampling/Pooling으로 계층적 특징을 추출하고, Dense 분류층으로 숫자 class를 예측한다.
- **Result:** 강의는 시각 인식에 CNN이 효과적임을 보인 초기 사례로 설명한다. 정확한 오류율·성능 비교는 제시하지 않는다.
- **Significance:** edge·curve·부분 모양에서 숫자 인식까지 이어지는 학습 과정을 보여 준다.

**연결 개념:** Local feature, Hierarchy, Feature map, Pooling, Classification.

**활용할 질문:** Convolution–Pooling–분류 흐름, feature map과 입력의 차이, 분류와 검출 비교.

**내 확장 제안 — 제공 자료에서 미확인:** 학용품 사진 분류. 숫자 class 대신 연필·지우개·자 등 출력 범주를 정의하고 그 물건 사진으로 학습·평가해야 한다. 물체 위치가 필요하다면 숫자 분류의 출력만 바꾸는 것으로 충분하지 않다.

**짧은 영어 답안:** LeNet-5 illustrates digit classification with convolution and subsampling. I would adapt the feature-learning idea to classify stationery using my own labeled images. I would change the output classes, and a class label alone would not locate each object.

### 논문 — Intelligent baby behavior monitoring using embedded vision in IoT for smart healthcare centers

**Theme:** 비접촉 영상 감시와 여러 움직임 검출 방법의 비교.

**검색 태그:** [Baby Monitoring] [Motion Detection] [Frame Difference] [Optical Flow] [Background Subtraction] [Hybrid] [Multiple-Method Fusion] [Fusion]

**분류:** BABY s.44에 제시된 관련 논문(Hussain et al., 2019). 논문 원문은 첨부되지 않았으므로 아래는 강의의 motion 방법 비교를 중심으로 정리했다. Intensity·Diversity·Control Chart는 Part 2의 강의 개념 설명에서 다룬다.

- **Problem:** 보호자가 항상 지켜보기 어렵고 카메라로 미세한 아기 움직임을 검출하기도 어렵다.
- **Method:** Frame Difference·Optical Flow·Background Subtraction과 Hybrid를 비교한다.
- **Result:** 강의 s.19–20의 11개 영상 보고 accuracy는 Hybrid가 단일 방법보다 높다. s.43은 계산 비용의 증가와 dataset 확장 필요성도 제시한다.
- **Significance:** 같은 영상에서 서로 다른 움직임 검출 근거를 결합할 때의 성능과 계산 비용을 비교하는 사례다.

**연결 개념:** Multiple-method fusion, Motion detection, Computational cost. [BABY s.4–20, 43–44]

**활용할 질문:** 여러 방법 결합과 멀티모달의 차이, 검출 성능과 계산량, 관찰 시스템의 일상 적용. [[#Q6 — Baby Monitoring을 공부 중 자세 점검에 적용]].

**내 확장 제안 — 제공 자료에서 미확인:** 공부 중 자세 확인 알림. 새 촬영 거리와 움직임 요약 시간·알림 기준을 설정하고 사용자에게 유용한 알림인지 확인해야 한다. 수업 후반의 Intensity/Diversity·Control Chart는 강의 시스템 설명으로 사용하며, 첨부되지 않은 관련 논문 원문의 검증 결과라고 합쳐 쓰지 않는다.

**짧은 영어 답안:** The lecture compares three motion methods and their hybrid combination. I would use motion summaries for a study reminder, with new recording conditions and activity limits. The reported baby-video comparison does not validate this new use.

### CALL의 짧은 논문 — 목적과 활용만 연결

[SER] [Speech Recognition] [Embedding] [Fusion] [Application]

| 논문·수업 근거 | Theme / Problem | 핵심 Method | 강의에서 확인되는 Result | Significance·활용 질문 | 짧은 영어 답안 |
| --- | --- | --- | --- | --- | --- |
| Detecting telecommunication fraud by understanding the contents of a call — CALL p.3–4 | 통화 내용 기반 사기 의심 탐지 | 녹음→음성 인식→텍스트→탐지 규칙 | 경고 도식; 정확도 미제시 | 감정 추정과 내용 분석 비교 | Speech is converted to text, and content rules determine whether to issue an alert. This differs from predicting an emotion. |
| Gender identification using mfcc for telephone applications—a comparative study — CALL p.5 | 전화 음성의 화자 속성 추정 | 특징 추출·저장→pattern matching·decision logic | 속성 판단 흐름; 비교 성능 미제시 | 표현→판단의 연결 | The slide extracts speech features and compares them with stored patterns to make a decision. It gives no comparative accuracy. |
| Gender and age estimation methods based on speech using deep neural networks — CALL p.6 | 음성 기반 나이·성별 출력 | 공통 embedding→회귀·분류 head | exact age·age label·gender label 도식; 수치 성능 미제시 | 분류 vs 회귀, 공통 표현 | A shared speech representation supports age regression and age and gender classification. A number and a class label are different output types. |
| Deep features-based speech emotion recognition for smart affective services — CALL p.7 | 구간별 감정 분류·통합 | spectrogram chunk→CNN→majority vote | 최종 감정 label; 정확도 미제시 | 다수결 vs 이력·지식 reasoning | A CNN predicts emotions for spectrogram chunks, and majority voting combines them. This differs from the later history-and-knowledge system. |
| Dempster-Shafer fusion-based gender recognition for speech analysis applications — CALL p.8 | 음성 구간의 예측 근거 결합 | MFCC→SVM→DS fusion | 결합 판단 도식; 성능·상세 식 미제시 | 같은 모달리티 안의 여러 예측 결합 | Segment-level SVM predictions are combined using DS fusion. Combining predictions does not by itself add another input modality. |

이 짧은 도식들은 비교·원리 답안의 근거로 사용한다. 별도 응용을 억지로 붙이지 않고, 유형 5의 새 사례는 Part 2의 생활 상황 카드에서 고른다.

Perceptron·Backpropagation 원전·Optimizer 참고 링크·SimpleFlow 등은 개념 연결까지만 유지한다. 강의에서 방법·결과를 설명하지 않은 연구의 실험 성과를 추가하지 않는다.

## Part 4. 유형별 예상문제와 한·영 모범답안

다섯 유형을 총 12문제로 연습한다. 실제 출제 예측이 아니라 조건을 맞추는 답안 연습이다. 번호별 요구 조건 안에서 답하며, 아래 새 적용·대응 제안은 검증된 성과를 뜻하지 않는다.

### Q1 — 멀티모달 AI에 대한 5줄 의견

[Opinion] [Multimodal AI] [Fusion]

**한국어 질문:** 멀티모달 AI를 언제 유용하게 사용할 수 있다고 생각하는가? 작동 원리, 일상 적용, 한계를 포함해 5줄로 설명하라.

**English question:** When do you think multimodal AI is useful? Answer in five lines, including how it works, an everyday use, and a limitation.

**요구 조건:** 한·영 각 5줄, 입장＋원리＋근거＋새 적용 1개＋한계. 사례 2＋2 조건 없음.

**한국어 모범답안:**

1. 나는 한 입력만으로 답하기 어려울 때 멀티모달 AI가 유용하다고 생각한다.
2. 이 기술은 서로 다른 입력을 표현하고 대응시킨 뒤 함께 사용한다.
3. 예를 들어 사진은 눈에 보이는 물건을, 메모는 내가 필요한 것을 알려 준다.
4. 나는 냉장고 사진과 메모를 결합해 장보기 후보 목록을 만드는 데 쓰고 싶다.
5. 다만 사진에 가려진 물건이 있으므로 결과를 직접 확인하겠다.

**English model answer:**

1. I think multimodal AI is useful when one input is not enough.
2. It represents different inputs, aligns them, and uses them together.
3. A photo can show visible items, while a note can state what I need.
4. I would combine a fridge photo and my note to make a shopping list.
5. However, I would check hidden items before trusting the list.

**반드시 포함:** Representation·Alignment·Fusion, 보완 정보, 한계. 근거 W1 s.27–32. 냉장고 사례는 **새 응용 제안 — 제공 자료에서 미확인**.

### Q2 — Attention에 대한 5줄 의견

[Opinion] [Attention] [QKV] [Cross-Attention]

**한국어 질문:** Attention이 멀티모달 시스템에 유용하다고 생각하는 이유를 Q/K/V, 사례, 한계를 포함해 5줄로 설명하라.

**English question:** Explain in five lines why you think attention is useful in a multimodal system. Include Q/K/V, an example, and a limitation.

**요구 조건:** 한·영 각 5줄. Q/K/V의 역할＋효용＋구체 예＋한계. 사례 수업 1개, 새 사례 필수 아님.

**한국어 모범답안:**

1. 나는 Attention이 현재 질문에 필요한 정보를 선택적으로 반영해서 유용하다고 생각한다.
2. Query는 찾는 정보를, Key는 비교할 단서를, Value는 가져올 정보를 나타낸다.
3. Query와 Key로 구한 가중치에 따라 Value를 합치므로 관련 정보가 더 기여한다.
4. 수업의 자동차 색 질문에서는 질문이 해당 자동차 영역을 참조해 Red라고 답한다.
5. 다만 자동차가 여러 대인데 질문이 모호하면 엉뚱한 영역을 참조할 수 있다.

**English model answer:**

1. I think attention is useful because it focuses processing on the current question.
2. Queries state what is needed, keys describe candidates, and values supply information.
3. Query-key scores give weights for a weighted sum of values.
4. In the lecture's car-color example, the question uses the car region to answer red.
5. However, an unclear question may select the wrong car when several cars are present.

**반드시 포함:** Q–K 점수·V 가중합·질문 관련성. W5 s.18–28, 42. 마지막 한계는 구조에서 추론한 의견.

### Q3 — 멀티모달 학습 도우미의 네 가지 어려움

[Challenge] [Solution] [Alignment] [Missing Modality] [Fusion]

**한국어 질문:** 강의 녹음과 필기 사진을 연결해 복습 구간을 찾는 도우미를 제안한다. 서로 다른 기술적 어려움 4개와 각각의 원인·대응·효과·한계를 설명하라.

**English question:** You propose a study helper that links lecture recordings to note photos. Explain four distinct technical challenges, with a cause, response, reason it helps, and limit for each.

**요구 조건:** 정확히 4쌍. 같은 어려움 반복 금지. 전체 시스템은 **새 응용 제안 — 제공 자료에서 미확인**.

**한국어 모범답안:**

1. **시간 대응:** 녹음과 필기 작성 시점이 달라 잘못 연결될 수 있다. 시각 정보와 짧은 구간의 의미를 함께 대조하겠다. 다른 순간의 자료를 섞는 일을 줄일 수 있지만 필기 지연과 모호한 내용은 남는다.
2. **입력 결측:** 녹음 중단이나 사진 누락으로 한 입력이 없을 수 있다. 독립 처리가 가능한 기능은 Late Fusion과 누락 표시로 설계하겠다. 남은 근거로 제한된 결과를 줄 수 있지만 없는 자료에만 있는 내용은 답하지 못한다.
3. **의미 정렬:** 비슷한 식이나 단어를 잘못 대응할 수 있다. 올바른 음성–필기 짝을 확인하고 모호한 후보는 함께 제시하겠다. 잘못된 연결을 줄일 수 있지만 모호성 자체가 사라지지는 않는다.
4. **계산량:** 긴 녹음의 모든 구간을 세밀히 비교하면 비용이 크다. 먼저 관련 구간을 좁혀 정밀 처리하겠다. 처리 단위 수는 줄지만 처음 선택에서 필요한 구간을 놓칠 수 있다.

**English model answer:**

1. **Timing:** Notes may be written after the explanation. I would check both timestamps and short-segment meaning to avoid linking different moments. Delayed or unclear notes can still cause errors.
2. **Missing input:** A recording or photo may be absent. I would use late fusion where independent predictions are possible and mark missing inputs. This allows limited use of the remaining evidence, but it cannot recover absent content.
3. **Semantic alignment:** Similar formulas may be confused. I would check audio-note pairs and show unclear candidates. This could reduce wrong links, but some matches would remain ambiguous.
4. **Computation:** Comparing every part of a long recording is costly. I would select likely segments before detailed processing. This reduces the input length, but early selection may miss the right segment.

**반드시 포함:** 시간 정렬·결측·의미 대응·계산량의 구별, 각 대응의 작동 이유와 한계. W1 s.30–32; W5 s.50. 대응 설계는 제안.

### Q4 — SER의 네 가지 어려움

[Challenge] [Solution] [SER] [Reasoning] [Reliability-Weighted Fusion]

**한국어 질문:** 수업의 이력·지식 기반 SER에서 서로 다른 어려움 4개와 대응 방법을 설명하라. 수업 방법과 자신의 개선 제안을 구분하라.

**English question:** Explain four different challenges and responses in the lecture's history-and-knowledge SER system. Distinguish lecture methods from your proposed improvements.

**요구 조건:** 정확히 4쌍, 수업 대응 2개＋개선 제안 2개. 각 항목 원인·대응·효과·한계.

**한국어 모범답안:**

1. **낮은 confidence:** 불분명한 신호로 약한 예측이 나온다. 수업은 낮은 confidence 결과를 제외한다. 약한 결과가 이력에 영향을 주는 것을 막지만 중요한 구간도 빠질 수 있다.
2. **후보 감정 충돌:** 현재 score만으로 감정을 가르기 어렵다. 수업은 현재 예측·이력·공존 지식을 가중 결합한다. 추가 근거를 사용할 수 있지만 가중치와 지식의 적절성에 의존한다.
3. **갑작스러운 변화 누락:** 과거 이력이 현재 변화를 누를 수 있다. 나는 오래된 이력의 비중을 줄이고 변화 구간을 재확인하겠다. 새 상태가 반영되기 쉽지만 잡음을 변화로 오해할 수 있다.
4. **오류 누적:** confidence가 높은 오답이 이력과 fine-tuning 자료에 남을 수 있다. 나는 일부 구간을 사람이 확인한 뒤 사용하겠다. 잘못된 자기 예측의 반복을 줄일 수 있지만 확인 비용이 든다.

**English model answer:**

1. **Low confidence:** Unclear speech can produce weak predictions. The lecture discards low-confidence outputs to keep weak evidence out of later decisions. Important segments may also be removed.
2. **Conflicting candidates:** Current scores may not clearly separate emotions. The lecture weights current predictions, history, and co-existence knowledge. This adds evidence, but the weights and knowledge must fit the task.
3. **Sudden changes:** Strong history can hide a real change. I would reduce the weight of old history and review change segments. This gives new evidence more influence, but noise may look like a change.
4. **Accumulated errors:** A high-confidence mistake can enter history and training data. I would manually review some labels before reuse. This could reduce repeated mistakes, but review takes time.

**반드시 포함:** confidence·conflict·history inertia·error feedback, score와 정답 구별. CALL p.12, 18, 22–26. 3·4번은 개선 제안.

### Q5 — 영상 개선의 네 가지 어려움

[Challenge] [Solution] [Dehazing] [TriFuse] [Evaluation]

**한국어 질문:** Haze-Aware Dehazing과 TriFuse를 참고하여 영상 개선의 기술적 어려움 4개와 대응·한계를 설명하라.

**English question:** Using haze-aware dehazing and TriFuse as lecture references, explain four technical challenges in image enhancement, with a response and a limit for each.

**요구 조건:** 정확히 4쌍. 분류·데이터·복원·평가의 서로 다른 축. 두 시스템의 모든 한계를 동일한 것으로 서술하지 않기.

**한국어 모범답안:**

1. **경로 선택 오류:** Haze-Aware에서는 classifier 오류가 부적절한 dehazer 선택으로 이어진다. 수업의 후속 방향인 Unified Method를 검토하겠다. 분류 의존을 줄이는 방향이지만 다양한 haze 성능은 다시 평가해야 한다.
2. **실제 환경 차이:** 합성 데이터가 실제 열화를 충분히 대표하지 못할 수 있다. 수업처럼 real testset을 분리해 평가하고 실제 실패 유형을 자료에 보완하겠다. 환경 차이를 찾는 데 도움이 되지만 모든 환경을 포함할 수는 없다.
3. **detail 손상:** 밝기를 바꾸면서 noise와 경계도 손상할 수 있다. TriFuse의 성분별 처리 원리를 참고해 큰 구조와 경계를 나누어 다루겠다. 서로 다른 정보에 맞춘 처리가 가능하지만 과한 보정의 인공적 detail은 확인해야 한다.
4. **평가 목표 불일치:** 좋은 복원 점수가 좋은 검출을 보장하지 않는다. 수업처럼 영상 품질과 downstream detection을 별도 평가하겠다. 실제 목적을 확인할 수 있지만 검출 결과가 다른 목적의 성능까지 보장하지는 않는다.

**English model answer:**

1. **Wrong model selection:** A wrong haze class can select the wrong dehazer. I would consider the lecture's proposed unified method to reduce this dependency. Its performance across haze types would still need testing.
2. **Real-world gap:** Synthetic degradation may differ from real images. I would evaluate a separate real test set and add real failure cases to the data. This reveals environment gaps, but it cannot cover every condition.
3. **Detail damage:** Brightness changes can affect noise and edges. I would use the idea of separate frequency processing from TriFuse to treat broad structures and edges differently. Artificial details could still appear and need checking.
4. **Evaluation mismatch:** A good restoration score does not guarantee good detection. I would evaluate image quality and downstream detection separately, as in the lecture. This checks task usefulness, but detection results do not prove usefulness for every other task.

**반드시 포함:** Classifier dependency·Synthetic-to-real gap·성분별 처리·품질/검출 구분. LOW s.8, 12–22. 적용 선택과 일반적 손상 가능성은 분석 의견.

### Q6 — Baby Monitoring을 공부 중 자세 점검에 적용

[System] [Application] [Baby Monitoring] [Calibration] [Control Chart]

**한국어 질문:** 수업의 Baby Monitoring 원리를 설명하고, 그 원리를 공부 중 자세를 확인하는 일상 시스템에 적용하라.

**English question:** Explain the lecture's baby-monitoring pipeline and apply its principle to a study-posture reminder.

**요구 조건:** 수업 원리 1개＋일상 적용 1개. 입력·처리·출력, 유지할 원리·바꿀 기준·한계를 명시.

**한국어 모범답안:** 수업 시스템은 영상에서 motion을 검출하고 크기를 보정한 뒤 ellipse 크기와 개수로 Intensity·Diversity를 표현한다. 이를 Control Chart의 LCL/UCL과 비교해 너무 적거나 큰 움직임을 보호자에게 알린다. Hybrid는 같은 영상에 세 검출법을 결합한 것으로 세 모달리티가 아니다. 나는 옆에서 찍은 공부 영상을 시간 구간별로 요약해 오랫동안 자세가 고정되면 스스로 확인할 알림을 제안한다. 관찰→특징→기준 비교 원리는 유지하되 촬영 거리·관찰 시간·개인 기준을 새로 설정한다. 가만히 있어도 집중 중일 수 있으므로 알림은 자세 확인 요청이며 건강 문제의 확정은 아니다.

**English model answer:** The lecture system detects motion in video, calibrates its size, and represents intensity and diversity by ellipse size and number. A control chart compares them with LCL and UCL and alerts the caregiver for too little or too much movement. The hybrid combines three methods on one video modality. I would summarize side-view study video over time and give a reminder when my posture stays fixed for a long period. I would keep the observe-measure-compare principle but set new camera, time, and personal limits. Stillness may simply mean concentration, so the reminder would ask me to check my posture.

**반드시 포함:** Hybrid·Calibration·Intensity/Diversity·LCL/UCL·새 기준. BABY s.12–17, 33–40. 자세 알림은 **새 응용 제안 — 제공 자료에서 미확인**.

### Q7 — Haze-Aware 원리를 필기 사진 정리에 적용

[System] [Application] [Haze-Aware Dehazing] [Conditional Model Selection]

**한국어 질문:** Haze-Aware Dehazing의 원리를 설명하고, 자신의 필기 사진 정리에 적용한다면 바꿔야 할 점을 제안하라.

**English question:** Explain haze-aware dehazing and propose how to adapt its principle to organizing your note photos.

**요구 조건:** 수업 시스템 1개＋생활 적용 1개. 원래 haze 복원과 새 적용 구분. 새 입력 조건·처리·출력·실패 조건 포함.

**한국어 모범답안:** 수업의 Haze-Aware 방식은 hazy image의 유형을 분류하고 해당 Specialized Dehazer를 선택해 복원한다. HazeSpace2M은 그 방법과 관련된 데이터셋이며 방법 자체의 다른 이름은 아니다. 나는 필기 사진을 어두움·흔들림·문제없음으로 나누어 조명 개선·재촬영 권유·원본 유지로 연결하겠다. 출력은 개선 후보 또는 재촬영 안내다. 상태에 따라 처리를 선택하는 원리를 유지하되 분류 범주·자료·처리 경로·평가를 바꿔야 한다. 흔들려 사라진 글자 획을 밝기 조정으로 복구했다고 주장할 수 없으며 잘못 분류하면 잘못된 처리를 고를 수 있다.

**English model answer:** The lecture's haze-aware method classifies a hazy image and selects a specialized dehazer. HazeSpace2M is a dataset, not another name for the method. For my note photos, I would distinguish dark, blurred, and acceptable images. I would then suggest lighting enhancement, retaking the photo, or keeping the original. The output would be an improved candidate or a retake message. I would need new labels, data, processing paths, and a text-readability check. Brightening cannot reliably recover strokes lost to blur, and wrong classification can still select the wrong action.

**반드시 포함:** 조건별 선택·Dataset/Method 구분·classifier 오류 전파·새 평가. LOW s.4–10, 22. 필기 사진 적용은 **새 응용 제안 — 제공 자료에서 미확인**.

### Q8 — VQA를 냉장고 확인에 적용

[System] [Application] [VQA] [Representation] [Alignment] [Fusion]

**한국어 질문:** 수업의 이미지 질문 응답 원리를 설명하고, 장보기 전 냉장고 확인에 적용하라.

**English question:** Explain the lecture's visual question answering principle and apply it to checking a fridge before shopping.

**요구 조건:** 수업 VQA 원리＋일상 제안 각 1개. 세 핵심 단계·출력·적합성·한계 포함.

**한국어 모범답안:** 수업 VQA는 이미지와 질문을 각각 표현하고 질문의 대상과 이미지 영역을 대응시킨 뒤 관련 정보를 결합해 답한다. 자전거 옆에 무엇이 있느냐는 질문에는 이미지 근거로 Dog라고 답한다. 나는 냉장고 사진과 필요한 물건 메모를 입력받아 이름과 물건 후보를 대응시키고 구매 후보 목록을 만드는 도우미를 제안한다. 사진은 보이는 재고를, 메모는 개인의 필요를 제공한다. 다만 사진에 안 보인다고 없다고 단정할 수 없으므로 가려진 물건·남은 양을 직접 확인할 항목도 함께 출력하겠다.

**English model answer:** In the lecture's VQA example, the system represents the image and question, aligns the named object with an image region, and combines relevant information to answer. It uses the picture to answer dog when asked what is beside the bicycle. I would take a fridge photo and a note of needed items, match item names to visible objects, and return shopping candidates. The photo provides visible stock and the note provides personal needs. A hidden item may still be present, so I would also list items that need manual checking.

**반드시 포함:** Representation→Alignment→Fusion·보완 정보·가림 한계. W1 s.27–32. 냉장고 적용은 **새 응용 제안 — 제공 자료에서 미확인**.

### Q9 — Early Fusion과 Late Fusion 비교

[Comparison] [Early Fusion] [Late Fusion] [Missing Modality]

**한국어 질문:** Early Fusion과 Late Fusion을 동일한 기준으로 비교하고, 강의에 제시된 다른 설명 명칭을 쓰라.

**English question:** Compare early fusion and late fusion using the same criteria, and give the alternative descriptive labels used in the lecture.

**요구 조건:** 비교 대상 2개, 기준 3개(결합 지점·단위·선택 조건), 각 설명 명칭 1개. 단순 관련어를 동의어로 제시하지 않기.

**한국어 모범답안:**

| 기준 | Early Fusion | Late Fusion |
| --- | --- | --- |
| 결합 지점 | 깊은 처리 전 | 각 모델의 독립 예측 후 |
| 결합 단위 | 원시 입력·낮은 수준 특징 | 예측·판단 |
| 선택 조건 | 초기부터 정보를 함께 처리하려 할 때 고려하나 모달리티별 처리가 제한될 수 있음 | 독립 판단을 결합하고 결측에 유연하게 대응하려 할 때 고려하나 세밀한 상호작용이 제한됨 |

강의는 각각 **Input-level integration**, **Decision-level integration**으로 설명한다. Late Fusion도 결측 시 남은 예측을 어떻게 결합할지 설계해야 한다.

**English model answer:** Both methods combine information. In terms of timing, early fusion combines it before deep processing, while late fusion combines it after independent predictions. In terms of units, early fusion uses raw inputs or low-level features, while late fusion uses predictions. For choosing a method, early fusion supports combined processing from the start but may limit modality-specific processing. Late fusion is flexible for missing inputs but offers less detailed interaction. The lecture labels them input-level integration and decision-level integration. Missing-input handling must still be designed.

**반드시 포함:** 같은 세 기준·설명 명칭·결측 조건. W1 s.31–32.

### Q10 — Self-Attention과 Cross-Attention 비교

[Comparison] [Self-Attention] [Cross-Attention] [QKV]

**한국어 질문:** Self-Attention과 Cross-Attention을 Q/K/V의 출처와 관계 범위로 비교하고 VQA에서의 역할을 설명하라. 확인되는 다른 명칭이 없으면 설명 표현과 동의어를 구분하라.

**English question:** Compare self-attention and cross-attention by the sources of Q/K/V and the scope of relationships. Explain their roles in VQA. Distinguish descriptions from verified alternative names.

**요구 조건:** 대상 2개, 공통 기준 2개, 같은 VQA 안의 역할. 자료에 없는 다른 명칭은 만들지 않음.

**한국어 모범답안:** Self-Attention은 같은 입력에서 Q/K/V를 만들어 입력 내부 관계를 다룬다. Cross-Attention은 한 입력의 Q로 다른 입력의 K/V를 참조하여 두 입력 사이 관련 정보를 가져온다. VQA에서는 질문 내부 단어 관계를 Self-Attention으로 표현하고, 질문이 이미지 영역을 참조하는 데 Cross-Attention을 쓸 수 있다. 둘 다 관련성 점수·가중치·Value 결합을 사용한다. 수업의 “Look within yourself / Look at another input”은 직관적 설명이지 별도 공식 동의어가 아니다. Cross-Attention은 encoder–decoder 사이에도 쓰므로 항상 다른 감각 모달리티를 뜻하지 않는다.

**English model answer:** By source, self-attention makes Q, K, and V from the same input, while cross-attention takes Q from one input and K and V from another. By scope, self-attention models relations within an input, while cross-attention retrieves relevant information across inputs. In VQA, self-attention can represent relationships within the question, and cross-attention can connect it to image regions. Both use scores, weights, and value aggregation. The lecture's “look within yourself” and “look at another input” are explanations, not separate formal names. Cross-attention can also connect an encoder and decoder, so different sensory modalities are not required.

**반드시 포함:** 출처·관계 범위·공통 연산·VQA·설명 문구와 명칭 구별. W5 s.23–28, 42–45.

### Q11 — 멀티모달 AI의 사례 네 가지

[Application] [Multimodal AI] [Alignment] [Fusion]

**한국어 질문:** 멀티모달 AI 응용 네 가지를 수업 사례 2개와 자신의 새 제안 2개로 구분하여 제시하라.

**English question:** Give four multimodal AI applications: two confirmed lecture examples and two new everyday proposals of your own. Explain the input, process, output, suitability, and limitation of each.

**요구 조건:** 수업 확인 정확히 2개＋새 제안 정확히 2개. 모든 사례에 상황·입력·처리·출력·적합성·한계.

**한국어 모범답안:**

**수업 확인 1. VQA:** 이미지에서 자전거 옆 대상을 묻는다. 이미지와 질문을 embedding으로 바꾸고 대상 영역을 대응·결합해 Dog라고 답한다. 질문에 필요한 시각 근거를 사용할 수 있지만 가려진 대상은 잘못 연결될 수 있다. [W1 s.27–32]

**수업 확인 2. 로봇 조작:** “빨간 컵을 집어라”라는 지시와 장면을 사용한다. 언어의 목표와 해당 물체 영역을 대응시켜 집을 대상을 고른다. 다른 물건보다 목표에 집중할 수 있지만 비슷한 컵·가림은 선택을 어렵게 한다. 강의는 attention 예를 설명하며 제어 성능은 제시하지 않는다. [W5 s.8]

**새 응용 제안 — 제공 자료에서 미확인 1. 복습 구간 찾기:** 강의 녹음·필기 사진·질문을 입력받아 관련 설명과 필기 영역을 대응시키고 녹음 시각을 출력하겠다. 음성이 설명을, 사진이 식을 보완한다. 필기 시점이 늦으면 시간만으로 대응할 수 없다는 한계가 있다.

**새 응용 제안 — 제공 자료에서 미확인 2. 장보기 목록:** 냉장고 사진과 필요한 물건 메모의 항목을 대응시키고 구매 후보·확인 항목을 출력하겠다. 보이는 재고와 개인 필요를 함께 사용한다. 가려진 물건이나 남은 양은 직접 확인해야 한다.

**English model answer:**

**Lecture example 1 — VQA:** The system takes a picture and a question about what is beside a bicycle. It represents and aligns the inputs, then combines relevant information to answer dog. This uses visual evidence needed by the question, but hidden objects can cause wrong matches. [W1 s.27–32]

**Lecture example 2 — Robot manipulation:** The inputs are a scene and the instruction to pick up the red cup. Attention links the target words to the relevant object region so that the robot can select the cup. This separates the target from other objects, but similar or hidden cups can cause confusion. The slide does not report control performance. [W5 s.8]

**New proposal — unconfirmed in the provided materials 1 — Study replay:** I would combine a recording, a note photo, and a question. I would match the relevant explanation to the note region and return a replay time. Audio supplies the explanation and the photo supplies the formula, but delayed notes make time alignment unreliable.

**New proposal — unconfirmed in the provided materials 2 — Shopping list:** I would match items in a needed-items note to a fridge photo and return shopping candidates and items to check. This combines visible stock with personal needs. Hidden items and remaining quantities still need manual checking.

**반드시 포함:** 2＋2 구분·서로 다른 일상 목적·Representation/Alignment/Fusion·각 한계. 새 제안에 성능 수치 없음.

### Q12 — Attention의 사례 네 가지

[Application] [Attention] [Cross-Attention]

**한국어 질문:** Attention 응용을 수업에서 확인되는 사례 2개와 학생이 생각할 만한 새 사례 2개로 제시하라.

**English question:** Give two lecture examples of attention and two new everyday proposals. For each, explain the situation, input, processing, output, suitability, and limitation.

**요구 조건:** 정확히 수업 2＋새 제안 2. 단순 분야명 나열 금지.

**한국어 모범답안:**

**수업 확인 1. 자동차 색 VQA:** 이미지와 자동차 색 질문을 입력받아 질문에 관련된 차량 영역의 정보를 가중하고 Red라고 답한다. 배경보다 목표 차량을 사용할 수 있지만 여러 자동차를 질문이 구분하지 않으면 모호하다. [W5 s.42]

**수업 확인 2. 이미지 설명:** 사진과 생성 중인 단어 문맥을 사용해 boy나 football에 관련된 영역에 주목하고 설명 문장을 만든다. 단어마다 필요한 시각 근거를 반영하지만 가려진 행동은 확정하기 어렵다. [W5 s.8, 28]

**새 응용 제안 — 제공 자료에서 미확인 1. 준비물 확인:** 준비물 메모를 Query로 책상 사진 영역을 참조하고 확인된 물건과 재확인 항목을 출력하겠다. 각 물건에 필요한 영역을 찾을 수 있지만 가방 속 준비물까지 없다고 판단해서는 안 된다.

**새 응용 제안 — 제공 자료에서 미확인 2. 조별회의 할 일 찾기:** 녹음 구간과 내 이름·할 일 질문을 사용해 관련 발언을 가중하고 할 일 후보와 재생 시각을 출력하겠다. 긴 녹음 중 필요한 부분에 집중할 수 있지만 담당자 이름 생략과 겹친 음성은 직접 확인해야 한다.

**English model answer:**

**Lecture example 1 — Car-color VQA:** The inputs are an image and a car-color question. Attention uses the relevant car region to answer red. It focuses on the target instead of the background, but the target is unclear if several cars are not distinguished. [W5 s.42]

**Lecture example 2 — Image captioning:** The model uses an image and the current word context. It attends to the boy or ball region when producing the relevant word and outputs a description. This links words to visual evidence, but hidden actions remain hard to determine. [W5 s.8, 28]

**New proposal — unconfirmed in the provided materials 1 — Packing check:** I would use checklist words as queries over a desk photo and return matched items and items to recheck. Each query selects relevant regions. An item inside my bag may be ready even if it is not visible.

**New proposal — unconfirmed in the provided materials 2 — Meeting tasks:** I would use my name and a task question to query recorded meeting segments and return task candidates with replay times. This focuses on relevant speech, but omitted names and overlapping voices need manual review.

**반드시 포함:** 네 사례의 Query/관련 정보/출력·정확한 2＋2·각 한계. 새 제안은 연구·제품에서 가져온 검증 사례가 아님.

## Part 5. 시험 중 빠른 검색용 요약

### 빠른 표 — 개념과 차이

| A vs B | 한 줄 구분 | English wording |
| --- | --- | --- |
| Embedding vs Latent Space | 한 입력의 벡터 vs 벡터 관계가 조직되는 공간 | A vector for one input vs the learned space organizing representations and their relationships. |
| Alignment vs Fusion | 대응 관계를 찾기 vs 정보를 결합하기 | Establish correspondences vs combine information. |
| Early vs Intermediate vs Late | 깊은 처리 전 vs 표현 상호작용 단계 vs 독립 예측 후 | Before deeper processing vs interaction between representations vs combining independent predictions. |
| Self vs Cross-Attention | 구분 기준은 Q와 K/V의 출처 | The distinction is where Q and K/V come from. |
| Soft vs Hard Attention | 여러 요소의 연속 가중 결합 vs 일부 선택 | Continuous weighting of multiple parts vs selecting particular parts. |
| Saliency vs Attention | 눈에 띄는 영역 vs 현재 질문·과업에 관련된 정보 | Visually noticeable regions vs information relevant to the current task or query. |
| Backpropagation vs Optimizer | Gradient 계산 vs 갱신 규칙 | Calculate gradients vs apply a parameter-update rule. |
| Max vs Average Pooling | 최대 반응 vs 평균 반응 | Select the maximum vs calculate the mean. |
| Frame Difference vs Background Subtraction | 연속 frame끼리 비교 vs 현재 frame과 배경 모델 비교 | Compare consecutive frames vs compare the current frame with a background model. |
| Intensity vs Diversity | ellipse 크기 vs ellipse 개수 | Ellipse size vs number of ellipses. |
| Dehazing vs LLIE | haze 열화 복원 vs 저조도 개선 | Restore haze-degraded images vs enhance poorly illuminated images. |
| Enhancement vs Detection | 개선 이미지 출력 vs 객체 class·위치 출력 | Output an improved image vs output object classes and locations. |
| HazeSpace2M vs Haze-Aware Framework | dataset vs type별 복원 경로를 고르는 방법 | A dataset vs a method that selects restoration models by haze type. |
| LoLI-Street vs TriFuse | benchmark dataset vs 제안 LLIE 모델 | A benchmark dataset vs the proposed LLIE model. |
| Multimodal vs Multiple-method Fusion | 서로 다른 정보 형태 결합 vs 같은 영상에 여러 분석법 적용 | Combine different information modalities vs apply multiple analysis methods to the same video. |

근거: W1 s.30–32; W3 s.28–29, 36–38; W4 s.17–28; W5 s.12–15, 27; BABY s.12–17, 35; LOW s.4–15.

| 정의·원리 | 한 줄 답안 | 바로 이동 |
| --- | --- | --- |
| [Representation] [Alignment] [Fusion] | 벡터 표현 → 의미·시간 대응 → 표현·판단 결합 | [[#Representation·Alignment·Fusion]] |
| [QKV] [Attention] | Q–K 관련성→scaling→softmax→V 가중합 | [[#Q·K·V와 Attention의 작동 원리]] |
| [Transformer] | 위치 정보＋여러 head＋FFN＋Add/Norm; 각 입력은 embedding sequence로 | [[#Transformer의 구성 요소]] |
| [Backpropagation] [Optimizer] | gradient 계산 / gradient를 이용한 파라미터 갱신 | [[#학습 과정: 각 단계가 하는 일]] |
| [CNN] [Pooling] [Flatten] | 지역 특징 추출 / 지역 요약 / 벡터로 형태 변환 | [[#Pooling·Flatten·Classification]] |

### 빠른 표 — 수업 사례와 새 제안

| 주제 | 수업에서 확인 | 새 응용 제안 — 제공 자료에서 미확인 | 입력→처리→출력 검색 |
| --- | --- | --- | --- |
| [Multimodal AI] | VQA: W1 s.27; 빨간 컵 로봇: W5 s.8 | 녹음＋필기 사진→대응→복습 시각; 냉장고 사진＋메모→대응→장보기 후보 | [[#멀티모달 응용 카드 네 가지]] / Q11 |
| [Attention] | 자동차 색 VQA: W5 s.42; 이미지 설명: W5 s.8 | 메모＋책상 사진→관련 영역→준비물 확인; 질문＋회의 녹음→관련 구간→내 할 일 후보 | [[#Attention 응용 카드 네 가지]] / Q12 |
| [SER] | chunk voting: CALL p.7; 이력·지식 결합: CALL p.12–26 | 발표 녹음→구간별 감정 후보 확인→재청취 시각 | [[#SER 응용·대응 재료]] / Q4 |
| [Baby Monitoring] | motion→보정→I/D→LCL/UCL→경고: BABY s.33–40 | 공부 영상→자기 기준 비교→자세 확인; 세탁기 영상→움직임 구간 요약→표시 확인 | [[#Baby Monitoring을 일상으로 옮기는 재료]] / Q6 |
| [Image Enhancement] | Haze-Aware: LOW s.8; LoLI-Street/TriFuse: LOW s.11–21 | 어두운 필기→밝기·획 점검→개선 후보; 단체사진→밝기·경계 조절→사진첩 후보 | [[#영상 개선 응용 카드 네 가지]] / Q5·Q7 |
| [CNN] | LeNet-5 숫자 인식: W4 s.32–33 | 학용품 사진→특징→정리 범주 | [[#CNN 응용과 비교에 쓸 재료]] |

### 빠른 표 — 어려움과 대응

대응의 구체 설계·예상 효과는 해당 본문의 제안 표시를 따른다.

| 주제·서로 다른 네 축 | 대응 요약 | 빠른 답안 |
| --- | --- | --- |
| 멀티모달: 시간·결측·의미·계산량 | 시각＋의미 대조 / 독립 판단＋누락 표시 / paired data 점검 / 관련 구간 선택 | [[#Q3 — 멀티모달 학습 도우미의 네 가지 어려움]] |
| Attention: 위치·오대응·관계 다양성·긴 입력 | 위치 정보 / 질문·paired data 점검 / Multi-Head / 구간·영역 축소 | [[#Attention·Transformer의 어려움 네 쌍]] |
| SER: 낮은 confidence·충돌·변화 억제·오류 누적 | 낮은 결과 제외 / 세 score 결합 / 오래된 이력 비중 조절 / 일부 label 직접 검토 | [[#Q4 — SER의 네 가지 어려움]] |
| Baby: 검출 차이·크기·처리량·일반화 | Hybrid / 크기 보정 / 해상도·간격 검토 / 다양한 상황 평가 | [[#Baby Monitoring의 어려움 네 쌍]] |
| 영상 개선: 경로·환경 차이·detail·평가 | unified 방향 / real testset / 성분별 처리 / 품질＋downstream | [[#Q5 — 영상 개선의 네 가지 어려움]] |

### 빠른 표 — 논문 아이디어와 쓸 질문

| 논문·근거 | 핵심 아이디어 | 답안에 쓸 곳 |
| --- | --- | --- |
| HazeSpace2M — LOW s.4–10, 22 | 다양한 paired data와 real testset; haze 유형별 모델 선택 | 조건별 처리·분류 오류·실제 환경 차이·Q5·Q7 |
| LoLI-Street/TriFuse — LOW s.11–21 | DWT·저주파 Diffusion/CNM·고주파 ESM; 품질과 검출 평가 | 왜 다른 성분을 다르게 처리하는가·평가 목표·Q5 |
| Attention Is All You Need — W4 s.35–36; W5 s.31–34 | Attention 기반 관계·Position·Multi-Head | Q/K/V·Self/Cross·여러 입력 표현·Q2·Q10 |
| LeNet-5 — W4 s.32–33 | Convolution·Subsampling·숫자 분류 | CNN 원리·feature hierarchy·분류 출력 |
| Baby 관련 논문 — BABY s.19–20, 43–44 | 여러 motion 검출법의 Hybrid와 비용 | 여러 방법 vs 여러 모달리티·Q6 |
| CALL 짧은 연구 — p.3–8 | 내용 규칙 / 특징 분류 / 공통 표현의 회귀·분류 / chunk 투표 / 구간 근거 결합 | SER과 내용 분석 비교·Classification/Regression·Fusion |

정량 결과가 필요한 경우 Part 3의 **보고 조건**까지 확인한다. Attention·LeNet-5·CALL 도식에서 제공하지 않은 숫자는 쓰지 않는다.

### 빠른 표 — 영어 시작·연결 문장

| 쓸 상황 | 영어 문장 틀 |
| --- | --- |
| 정의 | [Concept] means … It takes … and produces … |
| 개인 의견 | I think … is useful for … because … |
| 원인 | This problem occurs because … |
| 대응·이유 | I would … so that … This could help by … |
| 한계 | However, … may still … |
| 비교 | By [criterion], A …, whereas B … |
| 수업 사례 | In the lecture example, the inputs are … The system … |
| 새 제안 | My proposed use is … I would take … and return … |
| 논문 결과 | In the lecture's reported comparison, … |
| 결과 미제공 | The slide shows the pipeline but gives no numerical performance. |
| 적용 변경 | I would keep … but change … for the new task. |
| 확장 경계 | This is my proposal, not a reported result of the paper. |

### 빠른 확인 — 답안 조건과 자료 해석

| 확인할 것 | 한 줄 점검 |
| --- | --- |
| 5줄 | [[#Q1 — 멀티모달 AI에 대한 5줄 의견]]처럼 명시적 5줄, 각 줄의 역할이 다름 |
| 네 문제·해결 | 각 번호 안에서 원인·대응·도움 이유·남는 한계가 연결됨 |
| 수업 2＋새 2 | 두 집단 표시, 네 항목, 새 제안은 제공 자료에서 미확인이라고 명시 |
| 비교·명칭 | 양쪽에 같은 기준; 설명 표현과 공식 동의어를 구별 |
| 수업 자료의 제한 | BABY correct-frame count와 percentage 일부 불일치: 보고 비율의 경향만 사용; LOW s.11의 33k 본문과 표의 34,000을 임의 통합하지 않음 |
| 과장 방지 | TriFuse의 모든 지표 최고 주장 금지; Baby 경고를 확진으로 확대하지 않음; 여러 알고리즘·spectrogram·주파수 band를 새 입력 모달리티로 세지 않음 |
