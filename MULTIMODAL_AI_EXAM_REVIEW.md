# 멀티모달 AI 시험 대비 정리

## 목차

- [[#Part 1. 시험 핵심 요약]]
  - [[#1. 자료 범위와 읽는 방법]]
  - [[#2. 가장 먼저 설명할 수 있어야 할 개념]]
  - [[#3. 반드시 연결해서 이해할 내용]]
  - [[#4. 우선순위가 낮은 세부사항]]
- [[#Part 2. 강의별 핵심 정리]]
  - [[#1. Week 01 — Introduction to Multimodal AI]]
    - [[#AI·ML·DL의 관계]]
    - [[#Modality와 멀티모달 접근의 목적]]
    - [[#Representation·Alignment·Fusion]]
    - [[#Fusion 방식의 비교]]
    - [[#활용 분야와 범위]]
  - [[#2. Week 03 — Deep Learning Foundations, Part A]]
    - [[#Neural Network와 비선형성]]
    - [[#학습 과정: 각 단계가 하는 일]]
    - [[#출력 과업과 Loss의 연결]]
    - [[#Representation Learning·Embedding·Latent Space]]
  - [[#3. Week 04 — Deep Learning Foundations, Part B]]
    - [[#CNN: 작은 특징을 쌓아 의미 있는 특징으로]]
    - [[#Pooling·Flatten·Classification]]
    - [[#CNN vs Transformer]]
  - [[#4. Week 05 — Attention & Transformers as the Multimodal Backbone]]
    - [[#Attention은 무엇을 해결하는가?]]
    - [[#Q·K·V와 Attention의 작동 원리]]
    - [[#Self-Attention vs Cross-Attention]]
    - [[#Transformer의 구성 요소]]
    - [[#서로 다른 입력을 어떻게 처리하는가?]]
  - [[#5. 사례 — Fake Call Analysis와 LISTEN]]
    - [[#두 흐름을 구분하기]]
    - [[#순간 예측을 이력·지식으로 보완]]
  - [[#6. 사례 — Intelligent Baby Monitoring]]
    - [[#목적과 관측의 어려움]]
    - [[#세 Motion Detection 방법과 Hybrid]]
    - [[#Motion Detection에서 Behavior Analysis로]]
  - [[#7. 사례 — Low-Level Vision and Image Enhancement]]
    - [[#Enhancement와 Recognition의 차이]]
    - [[#HazeSpace2M과 Haze-Aware Dehazing]]
    - [[#LoLI-Street와 TriFuse]]
    - [[#결과를 읽는 기준]]
- [[#Part 3. 논문 요약]]
  - [[#1. 논문을 어느 깊이까지 공부할 것인가?]]
  - [[#2. HazeSpace2M: A Dataset for Haze Aware Single Image Dehazing]]
  - [[#3. LoLI-Street: Benchmarking Low-Light Image Enhancement and Beyond — TriFuse]]
  - [[#4. Attention Is All You Need — Vaswani et al., 2017]]
  - [[#5. LeNet-5 — LeCun et al., 1998]]
  - [[#6. Intelligent baby behavior monitoring using embedded vision in IoT for smart healthcare centers]]
  - [[#7. CALL에서 도식으로 소개한 논문 5편]]
  - [[#8. 이름·참고문헌만 보고 깊게 확장하지 않을 항목]]
- [[#Part 4. 예상 서술형 문제]]
  - [[#1. Representation·Alignment·Fusion을 이미지 질문 응답으로 설명하라.]]
  - [[#2. 멀티모달이 단일 모달보다 유리하거나 불리할 수 있는 상황은?]]
  - [[#3. 입력 하나가 누락될 수 있는 감시 시스템에서 어떤 Fusion을 고려하겠는가?]]
  - [[#4. Self-Attention과 Cross-Attention의 차이와 역할을 설명하라.]]
  - [[#5. Attention weight가 큰 정보는 어떻게 출력에 반영되는가?]]
  - [[#6. Transformer에 Positional Encoding과 Multi-Head Attention이 필요한 이유는?]]
  - [[#7. Transformer가 이미지·텍스트·오디오를 처리할 수 있는 이유와 한계는?]]
  - [[#8. 신경망 학습에서 Forward·Loss·Backpropagation·Optimizer는 어떻게 다른가?]]
  - [[#9. 영상 분류에서 Convolution·Pooling·Flatten은 각각 무엇을 하는가?]]
  - [[#10. Haze-Aware 방식의 장점과 classifier가 틀렸을 때의 문제는?]]
  - [[#11. HazeSpace2M의 기여는 단순히 이미지 수가 많은 것인가?]]
  - [[#12. TriFuse는 왜 주파수를 분해하고 서로 다른 처리를 하는가?]]
  - [[#13. 영상 개선 모델은 PSNR이 높으면 충분히 좋다고 판단할 수 있는가?]]
  - [[#14. Baby Monitoring에서 Hybrid와 크기 보정이 각각 필요한 이유는?]]
  - [[#15. 아기 움직임이 거의 없을 때도 경고해야 하는가?]]
  - [[#16. SER에서 현재 예측보다 History를 믿는 방식의 장점과 한계는?]]
  - [[#17. 자신의 분야에 멀티모달 AI를 적용하는 아이디어를 제안하라.]]
- [[#Part 5. 시험 직전 압축 정리]]
  - [[#1. 핵심 흐름 8줄]]
  - [[#2. 논문·사례별 한 문장]]
  - [[#3. 혼동하기 쉬운 비교]]
  - [[#4. T/F에서 개념을 오해하기 쉬운 문장만 확인]]
  - [[#5. 답안 작성 틀]]
  - [[#6. 원본 대조에서 남긴 주의점]]

---

## Part 1. 시험 핵심 요약

### 1. 자료 범위와 읽는 방법

**시험 활용:** 오픈북·Ctrl+F 검색을 기준으로 구성했다. 대괄호까지 포함해 `[Cross-Attention]`처럼 검색하면 해당 개념 설명·관련 논문·예상 답안으로 이동할 수 있다. 같은 개념은 같은 영어 태그를 사용하고, 주요 약어는 전체 명칭과 함께 달았다. 출처용 `[W5, s.27–28]` 등과 검색 태그를 구분한다.

| 찾고 싶은 내용 | 검색 태그 예시 |
| --- | --- |
| 멀티모달의 기본 단계·결합 방식 | `[Multimodal AI]` `[Representation]` `[Alignment]` `[Fusion]` `[Early Fusion]` `[Intermediate Fusion]` `[Late Fusion]` |
| 신경망·학습·표현 | `[Neural Network]` `[Activation Function]` `[Loss Function]` `[Backpropagation]` `[Optimizer]` `[Embedding]` `[Latent Space]` |
| 영상 특징·분류 | `[CNN]` `[Convolution]` `[Pooling]` `[Flatten]` `[Classification]` `[Regression]` |
| Attention·Transformer | `[Attention]` `[QKV]` `[Self-Attention]` `[Cross-Attention]` `[Positional Encoding]` `[Multi-Head Attention]` `[Transformer]` |
| 영상 복원·논문 | `[Dehazing]` `[HazeSpace2M]` `[LLIE]` `[LoLI-Street]` `[TriFuse]` `[Diffusion]` `[DWT]` |
| 감시·음성·판단 보완 | `[Context]` `[Baby Monitoring]` `[Motion Detection]` `[SER]` `[Reasoning]` `[Reliability-Weighted Fusion]` |
| 데이터·평가·한계 | `[Paired Data]` `[Dataset Diversity]` `[Synthetic-to-Real Gap]` `[Image Quality]` `[Object Detection]` `[Evaluation]` |

논문은 **테마**를 먼저 읽고 Problem / Method / Result / Significance를 확인한다. 예를 들어 `[Fusion]`으로 검색하면 결합 방식의 정의, 음성 근거 결합, 영상 방법 결합과 관련 답안을 이어서 볼 수 있다.

현재 작업 디렉터리의 `50 Courses/2026-2학기/AAI3031-01 - 멀티모달AI`에서 강의 PDF·PPTX **9개**, 기존 Markdown 정리노트 **7개**를 확인했다. 원본을 우선하고 기존 노트는 누락 점검에 활용했다. 다른 과목 자료와 일반 AI 위키 문서는 시험 근거에 포함하지 않았다.

사용자가 설명한 예시문제의 난도를 기준으로 **개념 설명 → 논문 아이디어 → 상황에 적용하는 판단**에 분량을 배분했다. 예시문제 원본 파일은 해당 과목 폴더에서 확인되지 않았다. 아래 우선순위는 자료의 반복·분량·학습목표에 따른 학습 권고이며, 출제 예측이나 교수의 구두 강조를 확인한 결과가 아니다.

**출처 표기:** `[W5, s.27–28]`은 아래 파일의 실제 27–28번째 슬라이드, `[CALL, p.22]`는 PDF의 22번째 페이지다. 슬라이드 안의 잘못된 인쇄 번호보다 파일 내 순서를 따른다. 모든 원본은 위 과목 폴더의 `자료`에 있다.

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

주차는 **W1·W3·W4·W5의 실제 파일명**을 기준으로 했다. BABY·LOW·CALL에는 주차를 임의로 부여하지 않았다. 입문 자료의 계획표와 실제 첨부파일의 주차·순서가 일치하지 않으므로, 로드맵만으로 시험 범위를 넓히지 않았다. 현재 과목 목차의 중간고사 정리 목록은 입문·사례·DL·Attention·Baby·Low-Level Vision이다.

**자료의 한계:** 녹화 강의·구두 설명·영상 데모의 전사는 없다. PPT의 이미지 속 핵심 구조·표는 따로 확인했지만, 영상에만 있는 설명은 반영하지 못했다. 논문 원문이 별도로 첨부되지 않은 연구는 **슬라이드가 설명하는 범위**까지만 요약했다. 외부 검색으로 결과를 보충하지 않았다.

### 2. 가장 먼저 설명할 수 있어야 할 개념

| 우선순위 | 핵심 | 자기 언어로 설명할 수준 | 근거 |
| --- | --- | --- | --- |
| 최우선 | Representation → Alignment → Fusion | 입력을 벡터로 표현하고, 대응 관계를 찾고, 함께 판단에 사용하는 세 단계의 차이 | W1 s.27–32; W4 s.3–4; W5 s.45–46 |
| 최우선 | Attention·Q/K/V | 현재 질문에 관련된 정보를 찾고 가중합하는 원리 | W4 s.35–38; W5 s.17–28 |
| 최우선 | Self-Attention vs Cross-Attention | Q/K/V가 어디서 오는지와 어떤 관계를 학습하는지 | W5 s.23–28, 42–45 |
| 높음 | Transformer의 공통 처리 방식 | Text token·Image patch·Audio segment를 embedding으로 바꾸고 위치 정보를 주는 이유 | W5 s.31–39, 48–50 |
| 높음 | Neural Network 학습 | Forward → Loss → Backpropagation → Parameter update의 역할 | W3 s.20–31 |
| 높음 | CNN·Pooling | 필터로 특징을 추출하고 공간 크기를 줄여 분류하는 흐름 | W4 s.5–31 |
| 높음 | HazeSpace2M·TriFuse | 문제 → 핵심 설계 → 보고 결과 → 한계 | LOW s.3–22 |
| 높음 | Baby Monitoring | 세 motion 방법의 차이, ellipse의 Intensity/Diversity, Control Chart와 Alert | BABY s.12–20, 33–40 |
| 높음 | Context와 Reasoning | 입력의 의미를 문맥으로 이해하고, 순간 예측을 화자 이력·지식으로 보완하는 이유 | W5 s.9–10; CALL p.12–26 |
| 보완 | 데이터와 평가 조건 | 합성/실제, paired data, pretrained/dataset-trained, 영상 품질/downstream 성능 구분 | LOW s.5–7, 11, 15–22 |

### 3. 반드시 연결해서 이해할 내용

1. **Embedding만 만들면 끝나는가?** 각 입력을 수치로 바꾼 것과 모달리티 사이 의미가 정렬된 것은 다르다. Alignment로 대응을 학습하고 Fusion이나 Cross-Attention으로 필요한 정보를 함께 사용한다. [W1 s.28–32; W5 s.45–46]
2. **여러 모델이면 Multimodal인가?** 모델 수보다 정보의 종류를 봐야 한다. 같은 영상에 Frame Difference·Optical Flow·Background Subtraction을 적용한 Baby 사례는 단일 영상 입력의 여러 방법 결합이다. [W1 s.23–24; BABY s.12–17]
3. **불확실성은 어떻게 보완하는가?** SER은 화자 이력과 감정 지식으로, Dehazing은 열화 유형에 맞는 모델 선택으로 대응한다. 두 사례는 서로 다른 방식으로 입력·예측의 조건을 고려한다. [CALL p.12–23; LOW s.8, 22]
4. **보기 좋은 영상이면 좋은 시스템인가?** 복원 품질과 객체 검출 성능은 별도로 평가한다. 모델 비교에서도 같은 데이터·학습 조건·지표인지 확인한다. [LOW s.15–21]

### 4. 우선순위가 낮은 세부사항

- 필터별 중간 숫자 전체, 감정 조합표의 개별 확률, 논문별 정확한 PSNR·mAP·데이터 수 암기.
- 3D CNN의 층별 tensor 크기, TriFuse의 상세 residual 수식·noise schedule.
- 참고문헌의 저자·연도 전체.
- 연구실 소개·연구 실적·게재지 지표·과제 제출 절차.

다만 **계산 원리**는 남겨 둔다. 강의가 여러 장에 걸쳐 다룬 Convolution·Pooling은 작은 예시를 직접 계산할 수 있어야 하고, Attention 가중합·SER 가중 결합도 각 숫자가 무엇을 뜻하는지 이해하는 편이 좋다. [W4 s.7–28; W5 s.21–22; CALL p.22–23]

## Part 2. 강의별 핵심 정리

### 1. Week 01 — Introduction to Multimodal AI

#### AI·ML·DL의 관계

**검색 태그:** [AI] [ML] [DL] [Artificial Intelligence] [Machine Learning] [Deep Learning] [Explicit Rules]

**Artificial Intelligence(AI)**는 인지·학습·이해·추론·행동·생성과 같이 지능이 필요한 과업을 수행하는 계산 시스템을 다루는 분야다. **Machine Learning(ML)**은 예시 데이터에서 패턴을 배우는 접근이고, **Deep Learning(DL)**은 여러 신경망 층을 통해 표현과 패턴을 학습하는 ML의 한 종류다. 강의의 포함 관계는 `DL ⊂ ML ⊂ AI`다. 사람이 조건을 정하는 Explicit Rules와 데이터에서 규칙을 배우는 ML을 스팸 분류 예시로 비교한다. [W1 s.16–19; W3 s.6–9]

#### Modality와 멀티모달 접근의 목적

**검색 태그:** [Modality] [Multimodal AI] [Complementary Information] [Redundant Information] [Contextual Information] [Missing Modality]

**Modality**는 정보를 관찰하거나 표현하는 서로 다른 채널·형태다. 영상의 공간 구조, 텍스트의 이산 token, 음성의 시간·주파수, 센서의 측정값은 표현 방식과 실패 조건이 다르다. **Multimodal AI**는 이질적인 정보를 표현·연결하고 함께 추론한다. [W1 s.21–26]

야간 교차로에서는 영상이 외형·위치를, 소리가 접근하는 차량의 단서를, LiDAR가 깊이·기하 정보를, 지도·GPS가 위치 문맥을 제공할 수 있다. 여러 정보가 서로 다른 측면을 보완하는 **Complementary information**, 같은 판단을 확인하는 **Redundant information**, 다른 신호의 의미를 풀어 주는 **Contextual information**이 결합의 근거다. [W1 s.25, 32]

모달리티를 늘리면 정렬 오류·잡음·결측·비용도 고려해야 한다. “더 많이 결합하면 항상 더 좋다”보다 **필요한 단서가 무엇이고, 각 단서가 언제 실패하는가**로 설명한다. 이는 강의의 교차로 토의 질문과 학습목표에 대응한다. [W1 s.21, 45; W5 s.50]

#### Representation·Alignment·Fusion

**검색 태그:** [Representation] [Alignment] [Fusion] [Embedding] [Semantic Alignment] [Temporal Alignment]

| 개념 | 의미·작동 | 예시 |
| --- | --- | --- |
| Representation | 원시 입력을 모델이 처리할 수 있는 특징·embedding으로 변환 | 이미지 → 시각 벡터, 질문 → 언어 벡터 |
| Alignment | 서로 다른 정보의 의미적·시간적 대응을 찾음 | 질문의 bicycle ↔ 이미지의 자전거 영역; 발화 ↔ 해당 시간 구간 |
| Fusion | 여러 정보를 하나의 표현 또는 최종 판단에 결합 | 자전거 주변 시각 정보와 질문을 사용해 Dog라고 답함 |

**Embedding**은 입력의 유용한 특징·의미를 담은 학습된 밀집 벡터다. 의미가 비슷한 입력을 가까운 벡터로 표현하는 것이 목표다. 벡터 차원이나 형식이 같다는 이유만으로 의미적 대응까지 보장되는 것은 아니다. 강의는 의미 있는 Representation을 Alignment·Fusion의 토대로 설명한다. [W1 s.27–32]

#### Fusion 방식의 비교

**검색 태그:** [Fusion] [Early Fusion] [Intermediate Fusion] [Late Fusion] [Missing Modality]

| 방식 | 결합 지점·원리 | 장점과 고려점 |
| --- | --- | --- |
| Early Fusion | 깊은 처리 전에 원시 입력·낮은 수준의 특징을 결합 | 단순하지만 모달리티별 처리가 제한될 수 있음 |
| Intermediate Fusion | 각 encoder가 표현을 만든 뒤 interaction layer 등에서 결합 | 고유 구조를 보존하면서 Cross-Attention 같은 깊은 상호작용 가능 |
| Late Fusion | 각 모델이 독립적으로 예측한 뒤 결과를 결합 | 모달리티 결측에 상대적으로 대응하기 쉽지만 세밀한 상호작용은 제한됨 |

Late Fusion의 장점을 “어떤 입력이 없어도 무조건 정상 작동한다”로 외우지 않는다. 선택 이유는 **독립 예측을 결합하는 구조의 유연성**이고, 필요한 결측 대응은 시스템 설계에 달려 있다. [W1 s.31–32]

#### 활용 분야와 범위

**검색 태그:** [Applications] [Multimodal AI] [Robotics] [Healthcare]

강의는 자율주행·로봇 조작·접근성 지원·의료 정보 결합·산업 이상 탐지·안전 감시를 제시한다. 예를 들어 “빨간 컵을 집어라”는 언어 지시와 장면 속 대상의 대응이 필요하고, 이미지 설명은 Vision과 Language의 연결이 필요하다. [W1 s.33; W5 s.8]

Fire/Smoke, CHILD, CABAD/CABA_Net, IARD, ROAD-6, Industrial Anomaly Detection은 입문 슬라이드의 사례·향후 주제에 등장한다. 현재 자료에는 이들 각각의 독립적인 상세 강의가 없으므로 목적을 알아두는 수준으로 둔다. [W1 s.36–44, 46–47]

### 2. Week 03 — Deep Learning Foundations, Part A

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

#### 학습 과정: 각 단계가 하는 일

**검색 태그:** [Forward Propagation] [Loss Function] [Cost Function] [Backpropagation] [Gradient] [Chain Rule] [Optimizer] [Gradient Descent]

`Input → Forward Propagation → Prediction → Loss → Backpropagation → Parameter Update → 반복`

- **Forward Propagation:** 현재 Weight·Bias·Activation을 사용해 입력에서 예측을 계산한다.
- **Loss Function:** 예측과 실제 target의 차이를 수치화한다. 강의는 개별 손실과 데이터 전체 평균인 Cost를 구분한다.
- **Backpropagation:** Chain Rule을 이용해 각 파라미터가 손실에 미치는 영향인 Gradient를 뒤로 계산한다.
- **Optimization:** Gradient를 이용해 파라미터를 수정한다. Gradient Descent는 손실을 줄이는 방향으로 갱신한다.

Backpropagation의 핵심은 **Gradient 계산**, Optimizer의 핵심은 **그 Gradient를 이용한 갱신 규칙**이다. [W3 s.20–31]

#### 출력 과업과 Loss의 연결

**검색 태그:** [Classification] [Regression] [Loss Function] [Cross-Entropy] [MSE] [MAE] [Huber Loss] [SGD] [Momentum] [Adam] [RMSprop] [Adagrad]

| 과업 | 무엇을 예측하는가 | 예시·주요 Loss |
| --- | --- | --- |
| Classification | 어느 범주인가 | 스팸 여부·동물 종류; Binary/Categorical Cross-Entropy |
| Regression | 어떤 수치인가 | 온도·가격; MSE·MAE |

MSE는 큰 오차에 더 큰 벌점을 주고, MAE는 MSE보다 이상치에 덜 민감한 방식으로 소개된다. Huber는 두 방식의 성질을 결합하는 예다. SGD는 빠르지만 noisy한 갱신, Momentum은 진동 완화·수렴 가속, Adam은 Momentum과 적응적 학습률의 결합으로 설명된다. RMSprop·Adagrad는 이름과 적응적 조절의 취지를 아는 정도로 우선순위를 낮춘다. [W3 s.26–30]

#### Representation Learning·Embedding·Latent Space

**검색 태그:** [Representation Learning] [Representation] [Embedding] [Latent Space]

**Representation Learning**은 사람이 특징을 모두 지정하는 대신 과업에 유용한 표현을 데이터에서 학습하는 것이다. 이미지에서는 초기 층의 edge·line·color가 중간 층의 texture·shape, 깊은 층의 object 특징으로 이어진다. [W3 s.34–35]

**Embedding은 한 입력의 벡터**, **Latent Space는 그 벡터들의 관계가 조직되는 학습 공간**으로 구분한다. 이 표현은 분류·군집·검색·생성에 활용될 수 있고, 멀티모달에서는 서로 다른 입력의 의미를 비교하는 공통 표현 공간으로 이어진다. [W3 s.36–38; W4 s.3–4]

### 3. Week 04 — Deep Learning Foundations, Part B

#### CNN: 작은 특징을 쌓아 의미 있는 특징으로

**검색 태그:** [CNN] [Convolutional Neural Network] [Convolution] [Kernel] [Feature Map] [Kernel Size] [Stride] [Padding] [Number of Filters]

**Convolutional Neural Network(CNN)**은 이미지의 공간 구조를 처리하는 신경망이다. **Convolution**은 작은 Filter/Kernel을 이동시키며 입력 영역과 원소별 곱의 합을 계산하여 Feature Map을 만든다. 서로 다른 필터는 서로 다른 패턴에 반응한다. [W4 s.5–16]

- **Kernel Size:** 한 번에 보는 영역의 크기. 작은 필터는 세부 패턴, 큰 필터는 더 넓은 문맥과 연결된다.
- **Stride:** 필터의 이동 간격.
- **Padding:** 경계에 값을 추가해 출력의 공간 크기를 조절.
- **Number of Filters:** 학습할 특징과 출력 Feature Map의 수.

숫자 암기보다 “작은 영역을 곱해서 더한 뒤 이동한다”를 설명하고 한 영역의 값을 계산할 수 있어야 한다. 강의는 이 과정을 여러 슬라이드에 걸쳐 반복한다. [W4 s.6–16]

#### Pooling·Flatten·Classification

**검색 태그:** [Pooling] [Max Pooling] [Average Pooling] [Flatten] [Fully Connected] [Classification] [Softmax]

| 연산 | 어떻게 작동하는가 | 목적·차이 |
| --- | --- | --- |
| Max Pooling | 창 안의 최댓값 선택 | 강한 특징 반응을 남기면서 공간 크기 축소 |
| Average Pooling | 창 안의 평균 계산 | 전체 반응을 요약·평활화하며 공간 크기 축소 |
| Flatten | 다차원 Feature Map을 1차원 벡터로 펼침 | Dense 분류층에 전달할 형식으로 바꿈 |

예를 들어 영역 `[1, 3; 2, 6]`의 Max Pooling은 6, Average Pooling은 3이다. 이는 원리 확인용 계산 예시다. Pooling은 정보를 요약하며 줄이는 연산이고, Flatten은 배열 형태를 펼치는 연산이다. [W4 s.17–28]

강의의 분류 흐름은 `Image → Convolution/ReLU/Pooling → Flatten → Fully Connected → Softmax → Class`다. LeNet-5는 손글씨 숫자를 대상으로 이 흐름을 설명하는 대표 사례다. [W4 s.29–33]

#### CNN vs Transformer

**검색 태그:** [CNN] [Transformer] [ViT] [Swin Transformer] [VQA]

CNN은 가까운 영역의 필터 연산으로 시작하고, 깊은 층에서 더 넓은 문맥을 형성한다. Transformer는 token·patch 사이 관계를 Attention으로 결합한다. 강의는 ViT의 먼 patch 연결과 Swin의 local/shifted window도 구분한다. 따라서 “CNN은 문맥을 못 보고 Transformer는 언제나 모든 위치를 한꺼번에 본다”는 식의 단정은 피한다. 둘 다 Classification·Detection·Segmentation에 사용할 수 있다. [W4 s.35–39]

이미지 질문 응답에서는 CNN으로 얻은 시각 특징과 Transformer로 얻은 질문 표현을 결합해 답할 수 있다. 중요한 것은 모델 이름보다 **질문이 요구하는 시각 정보와 연결되는 과정**이다. [W4 s.40]

### 4. Week 05 — Attention & Transformers as the Multimodal Backbone

#### Attention은 무엇을 해결하는가?

**검색 태그:** [Attention] [Saliency Detection] [Soft Attention] [Hard Attention]

입력의 모든 부분이 현재 과업에 똑같이 중요한 것은 아니다. **Attention**은 관련 정보를 더 크게 반영하여 문맥과 관계를 이해하도록 하는 기법이다. “소년이 무엇을 찼는가?”에는 공과 동작의 관계가 중요하고, “차가 무슨 색인가?”에는 해당 차량 영역이 중요하다. [W5 s.4–11, 42]

**Saliency Detection**은 강의의 비교에서 질문과 독립적으로 시각적으로 눈에 띄는 영역을 찾는 방식이고, **Attention Mechanism**은 현재 query·task와 관련된 정보를 가중한다. 결과가 heatmap처럼 보여도 목적과 계산 역할이 같다 보기는 어렵다. [W5 s.15, 이미지 비교표]

**Soft Attention**은 여러 부분에 연속적인 가중치를 주어 결합한다. **Hard Attention**은 하나 또는 소수의 부분을 선택한다. Soft Attention은 중요도가 낮은 정보를 반드시 모두 버리는 방식은 아니다. [W5 s.12–14]

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

#### Self-Attention vs Cross-Attention

**검색 태그:** [Self-Attention] [Cross-Attention] [QKV] [VQA]

| 구분 | Q/K/V의 출처 | 이해할 관계·활용 |
| --- | --- | --- |
| Self-Attention | 같은 입력에서 Q·K·V 생성 | 문장 안의 단어 관계, 이미지 안의 patch 관계 |
| Cross-Attention | 한 입력의 Q와 다른 입력의 K·V | 텍스트 질문이 이미지 영역을 참조; Decoder가 Encoder 출력을 참조 |

“What is the person doing?”의 텍스트 Query가 이미지의 Key와 비교하여 달리는 사람의 Value를 가져오는 것이 Cross-Attention의 직관이다. Self/Cross의 가장 정확한 구분은 **Q와 K/V의 출처**다. Cross-Attention은 encoder–decoder 사이에도 쓰이므로, 반드시 서로 다른 감각 모달리티여야 하는 것은 아니다. [W5 s.23–28]

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

#### 서로 다른 입력을 어떻게 처리하는가?

**검색 태그:** [Tokenization] [Token] [Patch] [Audio Segment] [Embedding] [Transformer] [Preprocessing] [Alignment] [Computational Cost]

| 입력 | 단위로 나누는 방식 | 위치 정보가 필요한 이유 |
| --- | --- | --- |
| Text | word/subword token → embedding | 문장 내 순서 |
| Image | 고정 크기 patch → patch embedding | 이미지의 공간 위치 |
| Audio | 짧은 segment/frame → 특징·embedding | 소리의 시간 순서 |
| Video | frame의 patch 및 시간 정보 | 어디서, 언제 일어났는지 |

공통점은 벡터 sequence로 바꾸어 Attention을 적용할 수 있다는 것이다. **같은 구조 계열을 적용할 수 있음**과 **전처리·학습된 파라미터가 모두 같음**은 구분한다. 모달리티별 단위화·전처리가 필요하며, 관계 학습에는 잘 정렬된 양질의 데이터가 필요하다. 긴 영상 sequence는 계산 비용도 크다. [W5 s.36–39, 44, 48–50]

### 5. 사례 — Fake Call Analysis와 LISTEN

#### 두 흐름을 구분하기

**검색 태그:** [LISTEN] [Fraud Detection] [Speech Recognition] [SER] [Speech Emotion Recognition] [Spectrogram] [3D CNN]

CALL의 앞부분은 통화 내용 기반 사기 탐지와 LISTEN의 모듈을 소개한다. p.4의 도식은 **Call → Recording → Speech Recognition → Text → Fraud Detection Rules → Alert**다. 성별 추정·연령 예측·Speech Emotion Recognition(SER)·Fusion/Reasoning도 별도 기능으로 소개된다. 감정 하나를 예측한 결과가 곧 사기 확정이라는 뜻은 아니다. [CALL p.2–10]

후반부는 **추론 과정을 이용한 SER**을 설명한다. 음성을 Spectrogram으로 변환하고 시간 구간별로 나누어 쌓은 뒤, 3D CNN과 Softmax로 감정 후보를 출력한다. Spectrogram은 음성의 시간·주파수 표현이며, 이미지처럼 처리해도 정보원은 여전히 Audio다. [CALL p.11–14]

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

### 6. 사례 — Intelligent Baby Monitoring

#### 목적과 관측의 어려움

**검색 태그:** [Baby Monitoring] [Dataset] [Motion Detection]

보호자의 지속적인 관찰 부담을 줄이기 위해 카메라로 움직임을 관찰한다. 부착형 센서는 착용 유지가 어렵고, 카메라는 호흡처럼 작은 움직임을 검출하기 어렵다는 동기가 제시된다. 자체 데이터는 27 videos·6 subjects·여러 촬영 높이·상황으로 구성되며, 결과 예시에는 doll·company·YouTube 영상도 등장한다. 모든 평가 장면을 실제 아기 영상으로 해석하지 않는다. [BABY s.4–10, 21–31]

#### 세 Motion Detection 방법과 Hybrid

**검색 태그:** [Motion Detection] [Frame Difference] [Optical Flow] [Background Subtraction] [Hybrid] [Multiple-Method Fusion] [Fusion] [Computational Cost]

| 방법 | 비교하는 대상·원리 | 구분 포인트 |
| --- | --- | --- |
| Frame Difference | 연속 두 frame의 pixel 차이를 계산하고 threshold·형태학적 처리로 motion 영역 추출 | “무엇이 달라졌는가” |
| Optical Flow | 연속 frame 사이의 영상상 움직임을 추정하고 flow를 motion 영역으로 변환 | “어떻게 이동했는가” |
| Background Subtraction | 현재 frame과 background model을 비교해 foreground mask 추출 | “배경과 무엇이 다른가” |
| Hybrid | 세 방법의 binary motion 추정 결과를 결합 | 같은 영상의 서로 다른 검출 근거를 함께 사용 |

슬라이드의 Hybrid 도식은 Intersection을 표시한다. 세 입력 모달리티를 결합하는 것으로 외우지 않는다. 보고된 11개 영상의 accuracy에서는 Hybrid가 각 단일 방법보다 높지만, 평가 장면과 자료 범위가 제한되어 있다. 결론은 Hybrid를 권고하면서 **상대적으로 계산 비용이 크다**고 밝히고, 영상 수·상황·난점을 늘리는 dataset 확장을 후속 과제로 제시한다. [BABY s.12–20, 43]

#### Motion Detection에서 Behavior Analysis로

**검색 태그:** [Behavior Analysis] [Calibration] [Prior Knowledge] [Ellipse] [Intensity] [Diversity] [Control Chart] [LCL] [UCL] [Alert]

`Video → Interval → Baby Segmentation → Motion Area → Size Calibration → Ellipse → Intensity/Diversity → Control Chart → Alert`

- **Size Calibration:** 카메라 거리·Frame-to-Baby Ratio·신체 부위 크기 지식을 활용한다. 촬영 높이가 달라지면 동일 신체 부위의 pixel 크기도 달라지기 때문이다.
- **Movement Intensity(I):** ellipse의 크기로 나타내는 움직임의 정도.
- **Movement Diversity(D):** ellipse의 개수로 나타내는 움직임 영역의 다양성.
- **Control Chart:** interval 안의 움직임을 LCL(Lower Control Limit)·UCL(Upper Control Limit)과 비교하는 도표.
- **Alert:** I 또는 D가 허용 범위의 하한 아래·상한 위로 벗어나면 보호자에게 알린다. 움직임이 너무 적은 경우도 경고 대상이다.

**동작 영역 검출**과 **행동의 정상·이상 판단**은 별도 단계다. 크기 보정·특징 추출·범위 비교가 두 단계를 이어 준다. [BABY s.33–41]

### 7. 사례 — Low-Level Vision and Image Enhancement

#### Enhancement와 Recognition의 차이

**검색 태그:** [Low-Level Vision] [Image Enhancement] [Dehazing] [LLIE] [Low-Light Image Enhancement] [Object Detection]

**Low-Level Vision**의 이번 중심은 열화된 영상을 복원·개선하는 것이다. **Dehazing**은 haze에 의한 시야 저하, **Low-Light Image Enhancement(LLIE)**는 부족한 조명 조건을 다룬다. 출력은 개선된 이미지다. 반면 **Object Detection**의 출력은 객체의 class·위치이며, Enhancement 이후의 활용을 검증하는 downstream task다. [LOW s.3–4, 8, 12, 15, 21]

#### HazeSpace2M과 Haze-Aware Dehazing

**검색 태그:** [HazeSpace2M] [Dehazing] [Haze-Aware Dehazing] [Dataset Diversity] [Paired Data] [Ground Truth] [Specialized Dehazer] [Conditional Model Selection] [Classifier Dependency] [Synthetic-to-Real Gap]

기존 방법이 특정 haze나 합성 조건에 치우치고 다양한 데이터가 부족하다는 문제에 대응한다. **HazeSpace2M**은 Outdoor·Street·Farmland·Satellite의 네 scene, Fog·Environmental Haze(EH)·Cloud의 세 haze type, 여러 intensity와 Real Haze Testset을 제공한다. 모든 scene에 세 type이 전부 존재하는 구성은 아니다. 약 2.2M이라는 총량은 **GT와 hazy image의 합**이다. [LOW s.3–7]

**Paired Data**는 hazy input과 대응 GT reference가 연결된 자료다. 복원 기준과 비교할 수 있게 해 준다. GT 선정에서는 해상도·기존 haze 포함 여부·주제 관련성을 확인한다. [LOW s.5–7]

**Haze-Aware Dehazing**의 원리는 `Hazy Image → Haze Type Classification → Specialized Dehazer 선택 → 복원`이다. 서로 다른 열화 조건에 맞춘 모델을 선택한다. **Dataset은 HazeSpace2M, 처리 방식은 Haze-Aware Framework**라는 차이를 기억한다. [LOW s.8–10]

한계는 **Classifier Dependency**와 **Synthetic-to-Real Gap**이다. 잘못 분류하면 부적합한 dehazer를 선택할 수 있고, 합성 데이터가 실제 환경을 충분히 대표하지 못할 수 있다. 강의의 후속 방향은 여러 type을 처리하는 Unified Method와 계산 비용 절감이다. [LOW s.22]


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

## Part 3. 논문 요약

### 1. 논문을 어느 깊이까지 공부할 것인가?

| 구분 | 대상 | 학습 깊이 |
| --- | --- | --- |
| 본문에서 상세 설명 | HazeSpace2M, LoLI-Street/TriFuse | Problem·Method·Result·Significance와 한계 |
| 개념을 설명하는 중심 사례 | Attention Is All You Need, LeNet-5 | 논문의 핵심 아이디어와 수업 개념 연결 |
| 도식으로 짧게 소개 | CALL p.3–8의 연구 5편 | 그림의 처리 흐름과 목적. 없는 결과는 암기하지 않기 |
| 참고·이름 소개 | Perceptron, Backpropagation 원전, 기타 참고문헌·성과 목록 | 개념의 유래·관련성 수준 |

### 2. HazeSpace2M: A Dataset for Haze Aware Single Image Dehazing

**테마:** 열화 조건이 다양한 데이터셋 구축과 haze 유형에 따른 복원 모델 선택.

**검색 태그:** [HazeSpace2M] [Dehazing] [Dataset Diversity] [Paired Data] [Conditional Model Selection] [Specialized Dehazer] [Synthetic-to-Real Gap]

**분류:** 본문 상세 설명. ACM Multimedia 2024로 소개. [LOW s.4–10]

- **Problem:** 단일 haze 가정과 제한적인 데이터 다양성으로 실제 열화 조건을 충분히 다루기 어렵다.
- **Method:** scene·haze type·intensity를 다양화한 paired dataset과 real testset을 구성한다. Haze type을 분류한 뒤 해당 Specialized Dehazer를 선택하는 framework를 사용한다.
- **Result:** 다양한 학습·평가 자료를 제공했다. s.9 Table 6의 Fog·EH·Cloud 비교에서는 SDNets가 LDNet·GDNet보다 높은 평균 PSNR·SSIM, 낮은 평균 MSE를 보인다. 이는 해당 비교 조건의 결과다.
- **Significance:** 데이터의 규모뿐 아니라 **열화 유형을 구분하여 적합한 복원 전략을 선택하는 문제**를 부각한다. 실제 환경 검증과 classifier 오류 전파를 함께 생각하게 한다.

**연결 개념:** Dataset diversity, Paired data, Conditional model selection, Synthetic-to-real gap.

**직전 기억:** “다양한 haze 데이터를 만들고, 먼저 haze 종류를 알아본 뒤 전용 복원 모델을 고른다. 분류 오류와 실제 환경의 차이가 한계다.”

### 3. LoLI-Street: Benchmarking Low-Light Image Enhancement and Beyond — TriFuse

**테마:** 도로 저조도 영상의 benchmark·복원과 개선 후 객체 검출.

**검색 태그:** [LoLI-Street] [TriFuse] [LLIE] [Image Enhancement] [DWT] [Diffusion] [Transformer] [Cross-Attention] [CNM] [ESM] [Image Quality] [Object Detection]

**분류:** 본문 상세 설명. ACCV 2024로 소개. TriFuse는 이 연구에서 설명하는 제안 모델이다. [LOW s.11–21]

- **Problem:** 도로 저조도 영상에서는 밝기와 세부 구조가 손상되어 후속 시각 과업도 어려워진다. 적절한 benchmark와 실제 저조도 평가가 필요하다.
- **Method:** LoLI-Street paired data와 RLLT를 구성한다. TriFuse는 DWT로 주파수 band를 나누고, 저주파 복원에 Diffusion과 CNM을, 고주파 detail 보완에 ESM을 사용한 뒤 재구성한다.
- **Result:** 강의는 RLLT에서 SOTA 결과를 소개한다. s.15의 trained-weights 표에서 BRISQUE·NIQE가 비교 모델 중 가장 낮고, YOLOv10의 두 평균 mAP도 가장 높다. 다른 조건·개별 지표·객체 class까지 모두 최고인 결과는 아니다.
- **Significance:** 영상 품질과 **downstream 검출의 유용성**을 함께 평가한다. 주파수 분해·조건부 noise 예측·경계 보완이 하나의 복원 목적에 연결되는 사례다.

**연결 개념:** Transformer, Cross-Attention, Conditional processing, Reference/no-reference evaluation.

**직전 기억:** “TriFuse는 주파수를 나누어 noise와 detail을 각각 처리한다. LoLI-Street 연구는 밝아 보이는 정도뿐 아니라 실제 영상 품질과 객체 검출까지 확인한다.”

### 4. Attention Is All You Need — Vaswani et al., 2017

**테마:** Attention 중심의 sequence 처리와 Transformer의 공통 구조.

**검색 태그:** [Attention Is All You Need] [Attention] [Transformer] [Self-Attention] [Cross-Attention] [QKV] [Positional Encoding] [Multi-Head Attention] [Masking]

**분류:** 명시적으로 제시되고 구조가 반복 설명되는 중심 개념 논문. 원문 실험표는 자료에 없다. [W4 s.35–36; W5 s.6, 31–34]

- **Problem:** 강의의 설명은 RNN의 순차 처리와 긴 sequence의 이전 정보 활용 어려움을 출발점으로 삼는다.
- **Method:** Attention을 중심으로 관계를 연결한다. Multi-Head Attention·Positional Encoding·Feed-Forward·Add/Norm과 Encoder–Decoder 구조를 사용한다.
- **Result:** 강의는 관련 요소 연결과 병렬 처리의 이점을 설명한다. 원 논문의 번역 점수·학습 비용·정확한 개선 수치는 제공하지 않으므로 추가하지 않는다.
- **Significance:** token·patch·segment를 embedding으로 바꾸어 여러 입력 종류에 적용하는 공통 구조의 토대다.

**연결 개념:** Q/K/V, Self/Cross-Attention, Masking, Position, Multimodal interaction.

**직전 기억:** “Attention으로 관련 정보를 직접 연결한다. 위치는 Positional Encoding이, 여러 관계는 Multi-Head가, 다른 입력 참조는 Cross-Attention이 맡는다.”

### 5. LeNet-5 — LeCun et al., 1998

**테마:** 계층적 시각 특징 학습을 이용한 손글씨 숫자 분류.

**검색 태그:** [LeNet-5] [CNN] [Convolution] [Pooling] [Feature Map] [Classification]

**분류:** CNN 분류 흐름을 설명하는 명시적 연구 사례. 슬라이드는 LeNet-5 이름으로 소개하며 정식 논문 제목은 제시하지 않는다. [W4 s.32–33]

- **Problem:** 이미지에서 손글씨 숫자를 인식한다.
- **Method:** Convolution과 Subsampling/Pooling으로 계층적 특징을 추출하고, Dense 분류층으로 숫자 class를 예측한다.
- **Result:** 강의는 시각 인식에 CNN이 효과적임을 보인 초기 사례로 설명한다. 정확한 오류율·성능 비교는 제시하지 않는다.
- **Significance:** edge·curve·부분 모양에서 숫자 인식까지 이어지는 학습 과정을 보여 준다.

**연결 개념:** Local feature, Hierarchy, Feature map, Pooling, Classification.

**직전 기억:** “작은 시각 특징을 쌓아 손글씨 숫자를 분류하는 초기 CNN 사례다.”

### 6. Intelligent baby behavior monitoring using embedded vision in IoT for smart healthcare centers

**테마:** 비접촉 영상 감시와 여러 움직임 검출 방법의 비교.

**검색 태그:** [Baby Monitoring] [Motion Detection] [Frame Difference] [Optical Flow] [Background Subtraction] [Hybrid] [Multiple-Method Fusion] [Fusion]

**분류:** BABY s.44에 제시된 관련 논문(Hussain et al., 2019). 논문 원문은 첨부되지 않았으므로 아래는 강의의 motion 방법 비교를 중심으로 정리했다. Intensity·Diversity·Control Chart는 Part 2의 강의 개념 설명에서 다룬다.

- **Problem:** 보호자가 항상 지켜보기 어렵고 카메라로 미세한 아기 움직임을 검출하기도 어렵다.
- **Method:** Frame Difference·Optical Flow·Background Subtraction과 Hybrid를 비교한다.
- **Result:** 강의 s.19–20의 11개 영상 보고 accuracy는 Hybrid가 단일 방법보다 높다. s.43은 계산 비용의 증가와 dataset 확장 필요성도 제시한다.
- **Significance:** 같은 영상에서 서로 다른 움직임 검출 근거를 결합할 때의 성능과 계산 비용을 비교하는 사례다.

**연결 개념:** Multiple-method fusion, Motion detection, Computational cost. [BABY s.4–20, 43–44]

**직전 기억:** “세 움직임 검출법의 Hybrid가 보고된 비교에서 가장 좋았지만 계산 비용이 크다. 여러 방법과 여러 modality는 구분한다.”

### 7. CALL에서 도식으로 소개한 논문 5편

이 연구들은 참고문헌에 이름만 있는 경우보다 설명 근거가 많지만, 개별 슬라이드 수준의 소개다. 아래 **Result는 슬라이드에서 확인할 수 있는 출력·설명 범위**이며 원 논문의 미제공 정량 성과를 대신 만들지 않는다.

| 논문·근거 | Problem | Method | Result | Significance·직전 기억 | Theme / 검색 태그 |
| --- | --- | --- | --- | --- | --- |
| **Detecting telecommunication fraud by understanding the contents of a call** — Zhao et al., 2018. CALL p.3–4 | 통화 내용에서 사기 통화 탐지 | 녹음 → Speech Recognition → Text → Detection Rules → Alert | 사기 의심 시 경고하는 도식. 정확도 미제시 | “음성을 텍스트로 바꿔 내용 기반 탐지에 쓴다.” SER과 구별 | 내용 기반 통화 사기 탐지. [Fraud Detection] [Speech Recognition] [Text Analysis] [LISTEN] |
| **Gender identification using mfcc for telephone applications—a comparative study** — CALL p.5 | 전화 음성의 화자 속성 추정 | 음성 특징 추출, 학습 특징 저장, 인식 시 Pattern Matching·Decision Logic | 속성 판단 흐름. 비교 성능 미제시 | “특징을 만들고 저장된 패턴과 비교한다.” 자료의 연도 표기가 혼재하여 연도 암기 제외 | 음성 특징·패턴 매칭을 이용한 화자 속성 추정. [Gender Recognition] [MFCC] [Pattern Matching] |
| **Gender and age estimation methods based on speech using deep neural networks** — Kwasny & Hemmerling, 2021. CALL p.6 | 음성에서 나이·성별 추정 | Waveform 처리 → Feature Extractor → DNN Embedder → Age Regressor/Age Classifier/Gender Classifier | Exact age·Age label·Gender label을 출력하는 도식. 성능 미제시 | “공통 음성 embedding에서 수치 회귀와 범주 분류를 구분한다.” | 공통 음성 표현과 다중 출력 과업. [Age Estimation] [Gender Recognition] [Embedding] [Classification] [Regression] |
| **Deep features-based speech emotion recognition for smart affective services** — Badshah et al., 2019. CALL p.7 | 발화의 감정 분류 | Spectrogram을 chunk로 나누고 CNN의 예측을 Majority Voting으로 모음 | 최종 emotion label을 얻는 도식. 성능 미제시 | “시간 구간의 예측을 투표로 모은다.” 뒤의 이력·지식 기반 추론과 구별 | 음성의 구간별 감정 분류와 투표 결합. [SER] [Speech Emotion Recognition] [Spectrogram] [CNN] [Majority Voting] [Fusion] |
| **Dempster-Shafer fusion-based gender recognition for speech analysis applications** — Ahmad et al., 2016. CALL p.8 | 음성 구간의 속성 예측 결합 | MFCC → SVM 구간별 예측 → DS Fusion | Fusion-based gender prediction 도식. 성능 미제시 | “구간별 근거를 결합해 최종 판단한다.” DS의 상세 수식은 자료 설명 없음 | 구간별 예측 근거의 Dempster-Shafer 결합. [Gender Recognition] [MFCC] [SVM] [Dempster-Shafer Fusion] [Fusion] |


### 8. 이름·참고문헌만 보고 깊게 확장하지 않을 항목

- **The Perceptron — Rosenblatt, 1958:** W3 s.12에서 뉴런의 Weight·Bias 설명과 연결된다. 별도 실험 결과·상세 논문 방법은 제시되지 않는다.
- **Learning Representations by Back-Propagating Errors — Rumelhart, Hinton & Williams, 1986:** W3 s.28에서 Backpropagation의 원전으로 제시된다. Chain Rule과 Gradient의 목적을 이해하는 것이 우선이며 원문 결과는 자료에 없다.
- **Adam 및 Optimizer 링크:** W3 s.29의 갱신 방법 비교 근거다. 별도 논문 성과를 외울 근거는 부족하다.
- **SimpleFlow, Generalized Background Subtraction Using Superpixels with Label Integrated Motion Estimation:** BABY s.44의 관련 참고문헌이다. 강의가 설명한 Optical Flow·Background Subtraction의 원리를 우선한다.
- **3D convolutional neural networks for human action recognition**, 감정 공존 관련 연구: CALL p.13, 27의 기반·참고문헌이다. 3D CNN과 감정 지식의 역할까지만 연결한다.
- **MEXFIC·ROAD-6 등 LOW s.23의 성과 목록, LOW s.24–26의 비교·참고 논문:** 본문에서 제안 방법을 설명한 HazeSpace2M·LoLI-Street와 학습 비중을 구분한다. 비교표에 이름이 등장하는 모델도 전부 독립 논문 공부 대상으로 확장하지 않는다.

기존 노트·일반 위키의 CLIP·BLIP-2 같은 추가 연결은 원본 강의에서 상세 설명된 논문으로 간주하지 않았다.

## Part 4. 예상 서술형 문제

아래 질문은 강의의 개념·사례·한계에서 구성한 연습문제다. 실제 출제를 보장하지 않는다. 모범답안의 설계 판단·비판은 **자료에 기반한 응용 의견**이며 원 논문의 실험 결과가 아니다.

### 1. Representation·Alignment·Fusion을 이미지 질문 응답으로 설명하라.

**검색 태그:** [Representation] [Alignment] [Fusion] [VQA]

**모범답안:** 이미지를 시각 벡터로, 질문을 언어 벡터로 바꾸는 것이 Representation이다. 질문의 ‘자전거’와 해당 이미지 영역을 연결하는 것이 Alignment이며, 질문과 주변 객체의 정보를 함께 사용해 ‘개’라고 답하는 것이 Fusion과 추론이다. 벡터 표현·대응 관계·정보 결합은 서로 다른 역할이다.

**필수 개념:** Embedding, Correspondence, Joint use of information. [W1 s.27–32]

### 2. 멀티모달이 단일 모달보다 유리하거나 불리할 수 있는 상황은?

**검색 태그:** [Multimodal AI] [Alignment] [Missing Modality] [Computational Cost]

**모범답안:** 야간 교차로처럼 한 신호가 부족한 상황에서는 영상·소리·깊이·위치 정보가 서로 보완될 수 있다. 다만 신호의 시간 대응이 어긋나거나 데이터 품질이 낮으면 결합도 잘못될 수 있다. 필요한 단서와 실패 조건을 확인하고, 정렬·계산 비용을 감당할 가치가 있는지 판단해야 한다.

**필수 개념:** Complementarity, Alignment, Noise/Missing information, Cost. [W1 s.21, 25, 30, 45; W5 s.50]

### 3. 입력 하나가 누락될 수 있는 감시 시스템에서 어떤 Fusion을 고려하겠는가?

**검색 태그:** [Fusion] [Late Fusion] [Intermediate Fusion] [Missing Modality]

**모범답안:** 각 입력이 독립 예측을 만들 수 있다면 Late Fusion을 우선 고려하겠다. 결과를 결합하는 방식은 모달리티 결측에 상대적으로 유연하기 때문이다. 반면 소리의 특정 구간과 영상의 특정 동작을 세밀하게 연결해야 한다면 Intermediate Fusion이 더 적합할 수 있다. 결측 대응과 깊은 상호작용 사이의 요구를 비교하겠다.

**필수 개념:** Decision-level vs Representation-level, Missing modality, Interaction. [W1 s.31–32]

### 4. Self-Attention과 Cross-Attention의 차이와 역할을 설명하라.

**검색 태그:** [Self-Attention] [Cross-Attention] [QKV] [VQA]

**모범답안:** Self-Attention은 같은 입력에서 Q·K·V를 만들어 내부 요소의 관계를 학습한다. Cross-Attention은 한 입력의 Q가 다른 입력의 K·V를 참조한다. VQA에서는 질문을 내부적으로 이해하고, 질문 Query로 필요한 이미지 영역을 찾아 답에 사용할 수 있다.

**필수 개념:** Q/K/V의 출처, Within-input relation, Cross-input reference. [W5 s.23–28, 42]

### 5. Attention weight가 큰 정보는 어떻게 출력에 반영되는가?

**검색 태그:** [Attention] [QKV] [Softmax] [Weighted Sum]

**모범답안:** Query와 Key의 관련성 점수를 scaling하고 Softmax로 정규화해 가중치를 만든다. 각 Value를 해당 가중치로 곱해 더하므로, 큰 가중치의 정보가 출력에 더 크게 기여한다. 중요도가 낮은 정보가 언제나 완전히 삭제되는 것은 아니다.

**필수 개념:** Relevance score, Scaling, Softmax, Weighted sum. [W5 s.18–22]

### 6. Transformer에 Positional Encoding과 Multi-Head Attention이 필요한 이유는?

**검색 태그:** [Transformer] [Positional Encoding] [Multi-Head Attention]

**모범답안:** Attention의 관계 정보에 더해 입력의 위치·순서를 제공하려고 Positional Encoding을 사용한다. Multi-Head는 여러 관점의 관계를 병렬로 학습해 결합한다. 따라서 ‘무엇이 관련되는가’, ‘어디에 있는가’, ‘어떤 여러 관계가 있는가’를 함께 표현할 수 있다.

**필수 개념:** Position/order, Multiple relationships. [W5 s.31–34]

### 7. Transformer가 이미지·텍스트·오디오를 처리할 수 있는 이유와 한계는?

**검색 태그:** [Transformer] [Tokenization] [Preprocessing] [Alignment] [Computational Cost]

**모범답안:** Text는 token, Image는 patch, Audio는 segment로 나눈 뒤 embedding sequence로 바꾸면 공통 Attention 구조를 적용할 수 있다. 그러나 입력별 전처리는 다르며, 모달리티 관계 학습에는 잘 정렬된 데이터가 필요하다. 영상처럼 sequence가 길면 계산 비용도 커진다.

**필수 개념:** Tokenization, Embedding, Modality-specific preprocessing, Alignment, Cost. [W5 s.36–39, 48–50]

### 8. 신경망 학습에서 Forward·Loss·Backpropagation·Optimizer는 어떻게 다른가?

**검색 태그:** [Forward Propagation] [Loss Function] [Backpropagation] [Optimizer] [Gradient]

**모범답안:** Forward는 현재 파라미터로 예측을 만들고, Loss는 target과의 차이를 수치화한다. Backpropagation은 손실의 파라미터별 Gradient를 계산한다. Optimizer는 그 Gradient를 이용해 Weight·Bias를 갱신하며, 이를 반복해 손실을 줄인다.

**필수 개념:** Prediction, Error, Gradient, Parameter update. [W3 s.20–31]

### 9. 영상 분류에서 Convolution·Pooling·Flatten은 각각 무엇을 하는가?

**검색 태그:** [CNN] [Convolution] [Pooling] [Flatten]

**모범답안:** Convolution은 필터를 이동시키며 공간 패턴을 Feature Map으로 추출한다. Pooling은 지역의 최대·평균값 등으로 공간 크기를 줄여 특징을 요약한다. Flatten은 Feature Map을 1차원으로 펼쳐 Dense 분류층에 넘긴다. 추출·요약·형식 변환의 차이다.

**필수 개념:** Filter, Feature map, Downsampling, Dense input. [W4 s.5–31]

### 10. Haze-Aware 방식의 장점과 classifier가 틀렸을 때의 문제는?

**검색 태그:** [Haze-Aware Dehazing] [Dehazing] [Classifier Dependency] [Conditional Model Selection]

**모범답안:** 열화 유형을 먼저 구분하고 해당 Specialized Dehazer를 선택해 조건에 맞는 복원을 할 수 있다. 그러나 classifier가 틀리면 맞지 않는 복원 경로를 사용하게 된다. 따라서 분류 성능과 최종 복원 품질을 함께 보고, 강의가 제시한 unified method나 비용 절감 방향도 검토할 수 있다.

**필수 개념:** Conditional selection, Error propagation, Restoration evaluation. [LOW s.8–10, 22]

### 11. HazeSpace2M의 기여는 단순히 이미지 수가 많은 것인가?

**검색 태그:** [HazeSpace2M] [Dataset Diversity] [Paired Data] [Ground Truth]

**모범답안:** 규모와 함께 scene·haze type·intensity의 다양성이 핵심이다. Paired GT는 학습·평가 기준을 주고 real testset은 실제 환경 적용을 확인하는 데 필요하다. 따라서 기여를 설명할 때 데이터의 양·조건의 범위·reference 품질·실제 환경 평가를 연결해야 한다.

**필수 개념:** Diversity, Paired reference, Quality assurance, Real testset. [LOW s.5–7]

### 12. TriFuse는 왜 주파수를 분해하고 서로 다른 처리를 하는가?

**검색 태그:** [TriFuse] [LLIE] [DWT] [Diffusion] [CNM] [ESM]

**모범답안:** 저주파의 큰 구조·완만한 변화와 고주파의 방향별 경계·detail은 처리 목적이 다르기 때문이다. TriFuse는 저주파를 Diffusion과 조건부 noise 예측으로 복원하고 고주파는 ESM으로 보완한 뒤 Inverse DWT로 합친다. 같은 이미지의 성분별 처리를 결합하는 구조다.

**필수 개념:** DWT, Low/high frequency, CNM, ESM, Reconstruction. [LOW s.12–14]

### 13. 영상 개선 모델은 PSNR이 높으면 충분히 좋다고 판단할 수 있는가?

**검색 태그:** [Evaluation] [Image Quality] [PSNR] [Object Detection] [TriFuse]

**모범답안:** 하나의 지표만으로 실제 목적을 판단하기 어렵다. 강의는 reference 기반 품질, RLLT의 reference 없는 품질, Enhancement 후 객체 검출을 따로 평가한다. TriFuse가 모든 품질 지표에서 최고는 아니어도 downstream 평균 mAP에서 좋은 결과를 보이는 점이 평가 목적의 차이를 보여 준다.

**필수 개념:** Multiple evaluation views, Real images, Downstream utility. [LOW s.15–21]

### 14. Baby Monitoring에서 Hybrid와 크기 보정이 각각 필요한 이유는?

**검색 태그:** [Baby Monitoring] [Hybrid] [Fusion] [Calibration] [Intensity] [Diversity]

**모범답안:** Hybrid는 같은 영상에서 서로 다른 세 motion 검출법의 결과를 함께 사용한다. 크기 보정은 촬영 거리·높이에 따라 달라지는 pixel 크기를 신체 크기 지식과 연결한다. 검출 결과를 안정적으로 해석한 뒤 ellipse 크기·개수를 행동 특징으로 사용한다는 점에서 역할이 다르다.

**필수 개념:** Multiple methods, Calibration, Intensity/Diversity. [BABY s.12–17, 35, 41]

### 15. 아기 움직임이 거의 없을 때도 경고해야 하는가?

**검색 태그:** [Baby Monitoring] [Control Chart] [LCL] [UCL] [Alert]

**모범답안:** 강의 시스템은 움직임이 지나치게 큰 경우뿐 아니라 LCL 아래로 낮은 경우도 Alert 대상으로 둔다. Intensity나 Diversity 중 하나라도 범위를 벗어나는지 확인한다. 이는 설정한 행동 범위 이탈의 감지이며, 특정 질환을 확진하는 결과로 해석하지 않겠다.

**필수 개념:** LCL/UCL, I/D, Range-based alert. [BABY s.36–40]

### 16. SER에서 현재 예측보다 History를 믿는 방식의 장점과 한계는?

**검색 태그:** [SER] [Speaker History] [Emotion Co-existence] [Reliability-Weighted Fusion] [Reasoning]

**모범답안:** 순간 감정 score가 모호할 때 화자의 이전 경향과 감정 공존 지식으로 판단을 보완할 수 있다. 다만 실제 감정이 갑자기 바뀌면 과거 이력이 현재 변화를 억누를 수 있다. 따라서 이력을 무조건 정답으로 취급하기보다 신뢰도와 현재 근거를 함께 고려하는 설계가 필요하다.

**필수 개념:** Current prediction, Temporal history, Knowledge, Reliability weighting. 한계는 구조에서 도출한 의견. [CALL p.12–26]

### 17. 자신의 분야에 멀티모달 AI를 적용하는 아이디어를 제안하라.

**검색 태그:** [Applications] [Healthcare] [Multimodal AI] [Representation] [Alignment] [Fusion]

**모범답안:** 강의의 의료 응용을 따라 의료 영상과 임상 텍스트를 결합하는 판독 지원을 제안하겠다. 각 입력을 embedding으로 표현하고 같은 환자·검사에 대응시키며, 질문에 관련된 영상 정보를 텍스트와 연결해 사용한다. 단일 자료의 부족한 단서를 보완할 수 있지만 입력 대응 오류·결측·편향·신뢰도를 함께 검토해야 한다.

**필수 개념:** Task, Modalities, Representation → Alignment → Fusion, Limitations. 새로운 실험 성과를 주장하지 않는 제안 답안. [W1 s.33, 45; W5 s.28, 50]

## Part 5. 시험 직전 압축 정리

### 1. 핵심 흐름 8줄

1. **Multimodal AI:** 서로 다른 정보의 유용한 관계를 학습하고 함께 추론한다. 모델 여러 개를 쓰는 것만으로 결정되지 않는다.
2. **Representation → Alignment → Fusion:** 벡터로 표현 → 무엇이 대응하는지 연결 → 판단에 함께 사용.
3. **Neural Network:** Forward로 예측 → Loss 계산 → Backprop으로 Gradient 계산 → Optimizer로 갱신.
4. **CNN:** 필터로 지역 특징 추출 → Pooling으로 요약 → Flatten·Dense·Softmax로 분류.
5. **Attention:** Q와 K로 관련성 → Scaling·Softmax → V의 가중합.
6. **Self vs Cross:** 같은 입력의 Q/K/V vs 한 입력의 Q와 다른 입력의 K/V.
7. **Transformer:** Position + Multi-Head + FFN + Add/Norm. Text token·Image patch·Audio segment를 embedding으로 처리.
8. **응용 판단:** 어떤 단서를 더하는지, 언제 실패하는지, 실제 목적에 도움이 되는지를 설명한다.

근거: W1 s.23–32; W3 s.20–38; W4 s.5–31; W5 s.18–39, 50.

### 2. 논문·사례별 한 문장

| 이름 | 시험 직전 기억 |
| --- | --- |
| HazeSpace2M | 다양한 haze·scene·강도의 paired data와 real testset; haze type에 맞는 Specialized Dehazer 선택 |
| LoLI-Street / TriFuse | 저주파는 Diffusion·CNM, 고주파는 ESM, Inverse DWT로 재구성; 실제 품질과 Detection도 평가 |
| Attention Is All You Need | Attention으로 관계를 직접 연결하고 병렬 처리; 위치·다양한 관계·다른 입력 참조의 역할 구분 |
| LeNet-5 | Convolution·Subsampling·분류층으로 손글씨 숫자 인식 |
| Baby Monitoring | 세 motion 방법의 Hybrid → 보정 → ellipse 크기 I·개수 D → LCL/UCL → Alert; 계산 비용·평가 범위 고려 |
| SER Reasoning | 현재 예측 + 화자 이력 + 감정 공존 지식 → 신뢰도 가중 결합 |
| CALL의 짧은 논문 사례 | 내용 기반 사기 탐지 / 음성 특징·패턴 매칭 / 공통 embedding의 age·gender 출력 / 감정 chunk voting / DS 기반 구간 예측 결합 |

논문별 정확한 출처·제공된 결과 범위는 Part 3을 따른다.

### 3. 혼동하기 쉬운 비교

| A vs B | 한 줄 구분 |
| --- | --- |
| Embedding vs Latent Space | 한 입력의 벡터 vs 벡터 관계가 조직되는 공간 |
| Alignment vs Fusion | 대응 관계를 찾기 vs 정보를 결합하기 |
| Early vs Intermediate vs Late | 깊은 처리 전 vs 표현 상호작용 단계 vs 독립 예측 후 |
| Self vs Cross-Attention | 구분 기준은 Q와 K/V의 출처 |
| Soft vs Hard Attention | 여러 요소의 연속 가중 결합 vs 일부 선택 |
| Saliency vs Attention | 눈에 띄는 영역 vs 현재 질문·과업에 관련된 정보 |
| Backpropagation vs Optimizer | Gradient 계산 vs 갱신 규칙 |
| Max vs Average Pooling | 최대 반응 vs 평균 반응 |
| Frame Difference vs Background Subtraction | 연속 frame끼리 비교 vs 현재 frame과 배경 모델 비교 |
| Intensity vs Diversity | ellipse 크기 vs ellipse 개수 |
| Dehazing vs LLIE | haze 열화 복원 vs 저조도 개선 |
| Enhancement vs Detection | 개선 이미지 출력 vs 객체 class·위치 출력 |
| HazeSpace2M vs Haze-Aware Framework | dataset vs type별 복원 경로를 고르는 방법 |
| LoLI-Street vs TriFuse | benchmark dataset vs 제안 LLIE 모델 |
| Multimodal vs Multiple-method Fusion | 서로 다른 정보 형태 결합 vs 같은 영상에 여러 분석법 적용 |

근거: W1 s.30–32; W3 s.28–29, 36–38; W4 s.17–28; W5 s.12–15, 27; BABY s.12–17, 35; LOW s.4–15.

### 4. T/F에서 개념을 오해하기 쉬운 문장만 확인

- **“여러 AI 모델을 결합하면 반드시 멀티모달이다.” → F.** 입력 정보 형태와 상호작용을 봐야 한다. [W1 s.23–24; BABY s.16–17]
- **“Cross-Attention의 Q·K·V는 전부 같은 입력에서 온다.” → F.** 그것은 Self-Attention의 설명이다. [W5 s.27]
- **“Soft Attention은 가장 중요한 영역 외의 정보는 전부 삭제한다.” → F.** 여러 Value를 다른 가중치로 결합한다. [W5 s.12–15, 21]
- **“움직임이 너무 적어도 Baby Monitoring의 경고 조건이 될 수 있다.” → T.** LCL 아래도 확인한다. [BABY s.36–40]
- **“TriFuse는 자료의 모든 조건·지표·객체 class에서 최고다.” → F.** 평균 성과와 개별 지표를 구분한다. [LOW s.15]

### 5. 답안 작성 틀

**개념 문제:** “무엇인지 → 어떤 정보를 어떻게 처리하는지 → 왜 필요한지 → 강의 예시 한 개.”

**논문 문제:** “기존 문제 → 핵심 설계 → 자료가 보고한 결과 범위 → 의미·한계 한 개.”

**생각 문제:** “내 선택 → 강의 개념으로 근거 → 구체적 적용 → 실패 조건 한 개.”

### 6. 원본 대조에서 남긴 주의점

- W1의 중복 PDF·PPTX는 같은 내용을 중복 학습하지 않도록 통합했다. 원본의 계획표만 있는 향후 강의를 본문 강의로 확장하지 않았다.
- BABY s.19–20의 일부 correct-frame count와 accuracy는 서로 맞지 않는다. **보고 percentage에서의 Hybrid 우위**까지만 사용하고 세부 숫자 계산 문제로 만들지 않았다.
- CALL p.23의 Happy 결합 점수는 표기 0.691, 제시 항의 계산은 `0.15×0.31 + 0.50×0.8 + 0.35×0.7 = 0.6915`다. 최종 Happy 선택은 동일하다.
- LOW s.11의 본문은 33k paired images, 비교표는 image quantity 34,000을 표시한다. 구성 범주를 임의로 합쳐 설명하지 않고 본문의 paired data와 별도 real testset을 구분했다.
- LOW s.15의 TriFuse 결과는 표·학습 조건별로 확인했다. BABY의 motion 방법 비교와 행동 분석 개념, CALL p.7의 chunk voting과 p.11 이후 SER reasoning도 구분했다.
- 영상 데모의 세부 내용·교수의 구두 강조·미제공 논문 원문의 실험 결과는 미확인이다. 학습 우선순위는 현재 파일에서 확인한 반복·설명 비중에 근거한다.
