# 9주차 시험 대비 | Intelligent Fire Scene Analysis

**추가 예시**는 강의 자료 밖의 연습용 사례다. 수업에서 구두로 다룬 예시와 겹치면 다른 사례를 고른다.

## 0. 시험 직전 요약

교수님이 이전에 냈던 유형을 기준으로 **① 강의 예시 N개와 추가 예시 N개 ② 데이터셋의 특징과 구성 이유 ③ 방법별로 도입한 요소와 그 효과** 순서로 공부한다. 숫자는 **226장 = 화재 119 + 비화재 107**, 불확실 환경 데이터의 **학습 8,032 / 평가 22,518·226**을 먼저 기억한다.

| 무엇을 물으면 | 답안에 넣을 핵심 |
|---|--- |
| 기존 기술의 기여와 한계 | **OMT**로 움직임 크기·방향 추정 / **색상·형태·움직임** 전문가의 **가중 투표** |
| 강의 사례와 추가 사례 | 오경보 원인, 재난관리 서비스, CCTV 적용처, 상황 정보, 불확실 환경, 후속 연구 |
| Dataset 1 / Dataset 2 | 실제 감시 **영상**과 헷갈리는 정상 사례 / 어려운 **정지 이미지 226장** |
| 불확실 환경 데이터의 기여 | **Fire / Non-fire × Certain / Uncertain**. 안개 속 정상 장면도 포함 |
| Method 1–4의 기여 | **조기 탐지 → 효율 개선 → 위치·상황 추출 → 불확실 환경 탐지** |
| Method 3 알고리즘 | **해밍 거리로 맵 선택 → 선택한 맵의 평균을 이진화해 화재 위치 검출** |
| 후속 연구 | **ShuffleNet**, **Smoke detection**, **Defogging**과 각각의 목적 |

답안은 **예시라면 ‘사례 + 이유’**, **데이터셋이라면 ‘형태 + 구성 + 무엇을 평가하는지’**, **방법이라면 ‘기존 문제 + 도입한 요소 + 개선된 점’**으로 쓰면 된다.

## 1. 강의 예시와 추가 예시

### 1.1 시스템이 답하는 세 가지 질문

| 과업 | 질문 | 예시 |
|---|---|---|
| **Fire detection** | 이 프레임에 불이 있는가? | 사진을 Fire / Non-fire로 분류 |
| **Fire localization** | 프레임의 어느 부분이 불타는가? | 차량 보닛 주변의 화재 픽셀을 표시 |
| **Contextual information extraction** | 소방대가 현장에 대해 무엇을 알아야 하는가? | 차량이 타고 있는지, 사람이 있는지, 어디인지 전달 |

작고 멀리 있는 불꽃은 영상에서 차지하는 픽셀이 적고, 평범한 붉은 물체나 반사광도 불처럼 보일 수 있다. 강의의 CNN 접근은 이런 상황에서 화재를 탐지하고, 필요한 경우 불 위치와 주변 상황까지 분석하는 것이다. 배경 사례는 밀양 세종병원과 제천 체육시설 화재다.

### 1.2 영상 기반 화재 탐지의 장점과 적용 사례

- **PPT의 장점** — 낮은 비용으로 넓은 범위를 감시, 빠른 대응, 현장에 가지 않고 화재를 확인, 위치·크기·심각도 등 영상 정보 확인, 화재·연기·폭력 등 여러 사건에 적용.
- **추가 장점 예시** — 여러 관제 구역의 영상을 한곳에서 확인할 수 있다. 사건 전후 영상을 검토해 화재가 어떻게 확대됐는지 조사할 수 있다.
- **PPT의 적용처 3개** — 가정 감시(**Home**), 산림 감시(**Forest**), 차량 감시(**Vehicle**).
- **추가 적용처 3개** — 물류창고(긴 통로와 적재 구역), 지하철역(승강장·통로), 데이터센터(서버실·전력 설비실).

기존 열·연기 감지기는 화재의 신호가 센서에 닿아야 하고 설치 지점 근처를 감시한다. CCTV는 카메라 시야 안의 구역을 원격으로 보며 위치와 크기 등을 추정한다.

### 1.3 오경보를 일으킬 수 있는 장면

**오경보(False positive)**는 실제로 불이 없는 장면을 Fire로 분류하는 것이다. 사례를 쓰고 **색·밝기·움직임 중 어떤 특징이 불처럼 보이는지** 설명한다.

| PPT에 나온 사례 | 헷갈리는 이유 |
|---|---|
| 닫힌 창문에 보이는 연기와 붉은 햇빛 반사 | 붉은 반사광이 불꽃처럼 보이고 연기가 주변 맥락을 강화한다. |
| 연기에 덮인 붉은색 건물 | 붉은색과 연기의 조합이 화재 장면과 비슷하다. |
| 붉은 공이나 가방을 들고 움직이는 사람 | 붉은 영역이 움직여 색상과 움직임 모두 화재처럼 보일 수 있다. |
| 붉은 벽이나 탁자가 있는 실험실 | 고정된 배경도 색상 규칙에 걸릴 수 있다. |
| 멀리 보이는 언덕의 연기 | 자료에서 Normal로 분류한 흐릿한 장면이다. 연기가 보이지만 화염이 확인되는 장면과 구분해야 한다. |

| 추가 예시 | 헷갈리는 이유 |
|---|---|
| 바람에 흔들리는 붉은 깃발 | 붉은색과 불규칙한 형태 변화가 함께 나타난다. |
| 비에 젖은 바닥에 비친 점멸 공사등 | 주황색 반사가 밝아졌다 어두워지고 물결에 따라 모양이 변한다. |
| 무대 뒤에서 천으로 구현한 가짜 불꽃 | 주황색 조명과 천의 출렁임이 실제 불꽃의 색과 움직임을 흉내 낸다. |
| 정상 작업 중 비산하는 금속 연마 스파크 | 밝고 작은 주황색 점이 빠르게 이동한다. 지속적인 화염과 구분할 필요가 있다. |

**예시 만드는 법** — 색상 방식이면 붉은색·주황색·반사광을, 움직임 방식이면 흔들림이나 형태 변화를 떠올린다. 여러 특징을 결합하는 방식의 오경보를 묻는다면 **색도 비슷하고 움직임도 비슷한** 사례를 고른다.

### 1.4 재난관리 서비스

| PPT의 서비스 | 뜻 |
|---|---|
| **Prevention** | 재난 발생을 예방한다. |
| **Advance warning** | 위험이 임박했음을 사전에 알린다. |
| **Early detection** | 이미 시작된 사건을 일찍 발견한다. |
| **Early notification** | 발견한 사건을 관계 기관에 신속히 알린다. |
| **Response mobilization** | 인력과 장비를 동원한다. |
| **Damage containment** | 추가 피해와 확산을 억제한다. |
| **Medical care and relief** | 치료와 피해자 구호를 제공한다. |

**예방 → 경고 → 탐지 → 통보 → 동원 → 억제 → 구호.** CCTV 자동 감시는 주로 **조기 탐지와 조기 통보**에 해당한다. 추가 서비스 예시는 **피해 규모 평가**, **복구 진행 상황 관리**, **대피소 배정 안내**다.

### 1.5 상황 정보의 예시

| PPT에서 제시한 정보 | 의미 |
|---|---|
| **What is on fire?** | 건물, 자동차, 숲 등 무엇이 타는지 |
| **Existence of people** | 사람이 현장에 있는지 |
| **Camera GPS** | 현장을 가리키는 카메라의 위치 |
| **Phone number / Camera IP** | 스마트폰 사용자 연락처나 카메라 식별에 쓰이는 정보 |
| **Fire size / expansion** | 불이 차지하는 범위와 확산 여부 |
| **Indoor / outdoor** | 실내인지 실외인지 |

수동 신고에서는 **건물 종류, 주변 위험요소, 대피 진행 여부**도 묻는다. 자동 추출 목록을 묻는 문제에서는 위 표의 항목을 먼저 쓴다. 영상으로 얻는 물체·사람·화재 영역 정보와 GPS·연락처·IP처럼 기기에서 제공하는 정보의 차이도 설명할 수 있어야 한다.

**추가 예시 3개**

1. **가까운 소화전의 위치** — 지도 데이터에서 가져와 출동 계획에 사용한다.
2. **소방차가 접근 가능한 도로** — 교통 정보와 현장 영상으로 진입 가능 여부를 확인한다.
3. **현장 풍향** — 기상 정보나 센서에서 받아 실외 화재가 퍼질 방향을 판단하는 데 활용한다.

추가 사례는 **소방대가 도착하기 전에 어떤 판단을 해야 하는지** 떠올리면 만들기 쉽다. 영상만으로 알기 어려운 정보에는 지도·센서 등 정보 출처를 덧붙인다.

### 1.6 Certain / Uncertain 환경

**Certain / Uncertain**은 영상에서 화재 단서가 얼마나 잘 보이는지를 가르는 **관측 조건**이다. 실제로 화재가 있는지는 **Fire / Non-fire**라는 별도 축이다.

| | Fire | Non-fire |
|---|---|---|
| **Certain** | 불꽃이 선명하게 보이는 실내 양동이 화재 | 시야가 선명한 일반 실험실 영상 |
| **Uncertain** | 안개 사이로 불꽃이 보이거나 연기가 화염을 일부 가리는 장면 | 안개 속 차량 전조등이나 철도 차량 불빛만 보이는 장면 |

**PPT의 불확실 조건 3개는 안개(fog), 눈(snow), 연기(smoke)**다. **추가 예시 3개**는 야간의 극심한 저조도, 렌즈에 맺힌 빗방울로 인한 흐림, 강한 역광으로 인한 노출 손실이다. 답안에는 각각 **대비 저하 / 일부 가림 / 밝은 영역에서 세부 정보 손실**처럼 시각 단서가 약해지는 이유를 적는다.

## 2. 데이터셋의 특징과 구성 이유

### 2.1 Dataset 1과 Dataset 2

| 항목 | **Dataset 1** | **Dataset 2** |
|---|---|---|
| 출처와 형식 | Foggia 연구의 감시 **비디오** | Chino의 BoWFire 연구에 쓰인 **정지 이미지** |
| 특징 | 실내외, 근거리·원거리, 크고 작은 화재, 화재처럼 보이는 정상 영상 | 작지만 어려운 이미지 집합. 총 **226장** 중 **Fire 119장, Non-fire 107장** |
| 담긴 단서 | 연속 프레임에서 시간에 따른 변화도 살펴볼 수 있다. | 한 장면의 색상·형태·질감 등 공간 단서를 활용한다. |
| 평가할 수 있는 것 | 감시 영상에서 다양한 화재와 혼동하기 쉬운 정상 장면을 구분하는지 | 어려운 정지 이미지에서도 화재와 비화재를 구분하는지 |

**Dataset 1의 Fire 사례** — Fire1은 사람이 주변을 걷는 양동이 화재, Fire2는 원거리 양동이 화재, Fire3은 대형 산불, Fire6은 지면의 붉은 화재, Fire13은 실내 양동이 화재, Fire14는 종이 상자 내부의 화재다. **Normal 사례**로는 붉은 창문의 반사와 연기, 언덕의 연기, 붉은 건물, 붉은 공·가방을 움직이는 장면이 있다.

- **Dataset 1에 원거리 화재가 왜 중요한가?** 화면에서 불꽃 픽셀이 적으므로 작은 화재 단서도 포착하는지 평가할 수 있다.
- **정상 영상에 왜 붉은 물체를 넣는가?** 단순히 붉은색에 반응하는 방식이 오경보를 내는지 확인할 수 있다.
- **Dataset 2에 optical flow를 바로 쓸 수 있는가?** 정지 이미지에는 앞뒤 프레임이 없어 프레임 간 움직임을 직접 추정할 수 없다.

### 2.2 Newly Created Uncertain Fire Dataset

**Method 4의 연구 기여는 MobileNet 기반 모델과 함께 안개·눈·연기가 있는 환경을 위한 데이터를 구축한 것**이다. 화재 여부와 관측 조건을 교차시켜 평가한다.

| 분할 | Certain Fire | Uncertain Fire | Certain Non-fire | Uncertain Non-fire | 총계 |
|---|---:|---:|---:|---:|---:|
| Dataset 1 학습 | 1,604 | 240 | 4,807 | 1,381 | **8,032** |
| Dataset 1 평가 | 6,000 | 1,003 | 10,515 | 5,000 | **22,518** |
| Dataset 2 평가 | 100 | 19 | 90 | 17 | **226** |

**왜 Uncertain Non-fire까지 넣었는가?** 안개가 낀 영상에 항상 불이 있다면, 모델이 안개 자체를 화재 단서로 학습할 수 있다. **안개 속 화재**와 **안개 속 정상 장면**을 모두 포함하면, 안개와 실제 화재를 구분하는지 학습하고 평가할 수 있다. 표에는 관측 조건까지 붙인 네 가지 조합이 있고, **모델의 최종 출력은 Fire / Non-fire 두 클래스**다.

**서술형 답안 골격** — “데이터는 화재 여부와 시야 조건을 함께 표시한다. Uncertain Fire와 Uncertain Non-fire를 넣어 안개 속 불꽃과 안개 속 정상 불빛을 구분하는 능력을 평가한다.” 숫자를 요구하면 분할별 총계를 붙인다.

## 3. 기존 연구와 제안 방법의 기여

### 3.1 기존 연구에서 새로 도입한 것

| 접근 | 무엇으로 판단하는가 | 기여와 한계 |
|---|---|---|
| **Color-based** | RGB, HSI, YCbCr 등의 색 단서 | 불꽃 색을 이용한다. 붉은 물체와 반사광을 오인하고 밝기·그림자에 민감하다. |
| **Motion-based / OMT** | 연속 프레임의 움직임 크기(**magnitude**)와 방향(**direction**) | 고전적 optical flow의 한계를 보완하기 위해 **Optimal Mass Transport(OMT)**를 도입했다. 정상 물체의 움직임도 불꽃처럼 보일 수 있다. |
| **Multi-expert** | **Color, Shape, Movement** 전문가의 판단 | 서로 다른 저수준 특징을 보고 **가중 투표(weighted voting)**로 결정한다. 여러 특징을 추출하므로 계산 비용이 든다. |

**기존 방법의 문제점 6개**

1. 높은 오경보율
2. 계산 복잡도에 비해 불충분한 탐지·위치 검출 정확도
3. 화재 장면의 상황 정보 추출 기능 부재
4. 안개 등 불확실한 환경에서 제한적인 성능
5. CNN의 높은 계산 복잡도
6. 실제 감시 시스템에 적용하기 어려움

### 3.2 Method 1–4에서 도입한 것

| 방법과 기반 모델 | 풀려는 문제 | 연구에서 도입하거나 개선한 것 |
|---|---|---|
| **1. Early Fire Detection · AlexNet 계열(ANetFire)** | 색상·움직임처럼 제한된 단서로 다양한 화재를 탐지하기 어렵다. | **CNN의 깊고 판별력 있는 특징**으로 CCTV 프레임을 Fire / Normal로 분류한다. 화재 과업에 **fine-tuning**을 적용한다. 도식은 224×224×3 입력, 합성곱과 풀링, 마지막 두 클래스 출력을 보여준다. |
| **2. Balancing Efficiency and Accuracy · GoogLeNet 계열(GNetFire)** | 큰 모델은 실제 CCTV에 배치하기 부담스럽다. | **정확도와 효율의 균형**을 개선한다. 강의의 대표 비교에서 방법 1과 정확도가 비슷하고 모델은 작아지며 FPS가 늘었다. 가정·산림·차량 감시 프레임워크를 제시한다. |
| **3. Localization and Context · SqueezeNet 계열(CNNFire)** | 화재 여부만 알면 어느 부분이 타며 주변에 무엇이 있는지 알기 어렵다. | **해밍 거리에 기반한 특징 맵 선택**, **선택 맵을 이용한 화재 위치 검출**, **ZOI 분석과 상황 정보 추출**을 도입한다. |
| **4. Uncertain Environment · MobileNet 기반(EMN_Fire)** | 시야가 떨어지고 임베디드 장비는 자원이 제한된다. | **MobileNet을 화재 분류에 적용**하고 **Uncertain Fire Dataset**을 구축한다. PPT 도식의 분류부는 global pooling, 1×1 conv 또는 FC, softmax 순서다. |

**“새롭게 도입한 것”의 주어를 확인한다.** Method 3의 연구 기여를 묻는다면 SqueezeNet에 이미 있는 Fire module을 설명하는 데 그치지 말고, **화재에 민감한 특징 맵을 해밍 거리로 고르고 이를 분할·상황 분석에 활용했다**고 쓴다. Method 4는 시야가 어려운 영상에서의 효율적 **분류**가 핵심이다.

## 4. Method 3 알고리즘을 쉽게 이해하기

CNN의 **특징 맵(feature map)**은 영상의 위치마다 특정 패턴에 얼마나 반응하는지 나타내는 배열이다. 맵이 여러 개 있으므로 **불꽃이 있는 위치에 잘 반응하는 맵을 먼저 찾고**, 이후 새 영상에서 그 맵들을 사용한다.

### 4.1 해밍 거리와 특징 맵 선택

**해밍 거리(Hamming distance)**는 **길이가 같은 두 대상을 같은 위치끼리 비교해 서로 다른 위치의 수**를 세는 것이다.
- 정답이 `1 0 1 0`, 후보 A가 `1 0 0 0`, 후보 B가 `0 1 1 0`이라면 각각 **1개**, **2개** 좌표가 다르다. 이 비교에서 A의 이진 패턴이 정답에 더 가깝다.

| 순서 | **Feature Map Selection**에서 하는 일 |
|---|---|
| 1 | 학습 이미지를 CNN에 통과시키고 레이어 L에서 후보 특징 맵을 가져온다. |
| 2 | 후보 맵과 정답 화재 마스크(GT)의 크기를 **256×256**으로 맞춘다. |
| 3 | 맵별 평균 활성값을 구한다. 각 픽셀이 해당 맵의 평균보다 크면 1, 그 외는 0으로 이진화한다. |
| 4 | 이진 맵과 정답의 **해밍 거리**를 구한다. 후보 맵별로 모든 학습 샘플의 거리를 합산한다. |
| 5 | 누적 거리가 작은 맵을 임계값 기준으로 선택한다. PPT 예시는 **Fire2/Concat 층의 F8·F26·F32**다. |

### 4.2 새 프레임의 화재 영역 검출

1. 새 프레임을 CNN으로 분류한다. Non-fire이면 다음 프레임으로 간다.
2. Fire이면 이미 선정한 **F8·F26·F32**를 가져온다.
3. 세 맵의 **같은 위치끼리 평균**해 **FMA(Mean Activation Map)**를 만든다.
4. FMA에서 임계값보다 큰 위치는 1, 그 외는 0으로 표시한다. 출력은 **이진 화재 마스크**다.
5. 표시된 화재 영역은 크기·심각도 추정에, 주변의 **ZOI(Zone of Influence)**는 현장 물체 분석에 활용한다. 자동 보고 예는 **Fire on Castle / Fire on Car / Fire on Church**다.

예를 들어 같은 좌표의 활성값이 `0.6, 0.3, 0.9`면 평균은 **0.6**이다. 분할 임계값이 **0.5**라면 해당 위치는 1로 표시한다.

| 구분 | 비교하는 값 | 결과 |
|---|---|---|
| **특징 맵 선택** | 학습 샘플의 누적 해밍 거리 | 사용할 맵 번호 |
| **화재 영역 검출** | 새 프레임의 픽셀별 평균 활성값 | 0 또는 1로 표시한 화재 위치 |

두 알고리즘은 임계값을 각각 **T**로 표기한다. 하나는 **누적 해밍 거리**에, 다른 하나는 **평균 활성값**에 적용한다.

## 5. 실험 결과와 후속 연구

### 5.1 대표 성능

| 방법 | 정확도 | FP / 오경보 | FN / 미탐 | FPS | 모델 크기 |
|---|---:|---:|---:|---:|---:|
| 1 | 94.39% | 9.07% | 2.13% | 17 | 238 MB |
| 2 | 94.43% | 0.054% | 1.50% | 23 | 43 MB |
| 3 | 94.50% | 8.87% | 2.12% | 20 | 3 MB |
| 4 · Dataset 1 | 95.86% | 0% | 0.14% | 34 | 13.23 MB |

- **1 → 2**는 정확도 약 **+0.04%p**, 처리 속도 **+6 FPS**, 모델 크기 **−195 MB**다. 정확도가 거의 같은 상황에서 배치 효율 차이가 핵심이다.
- **방법 3**의 핵심 성과는 작은 모델에 **화재 분할과 상황 정보 추출**을 결합했다는 점이다. 대표값 기준으로 방법 2의 오경보율이 방법 3보다 낮다.
- **방법 4**의 Dataset 1 F-measure는 **0.99**, Dataset 2는 **0.92**다. Dataset 2의 정확도는 **92.04%**, FP는 **9.34%**, FN은 **6.72%**다. “방법 4는 오경보가 없다”라는 문장을 고치면 “방법 4는 **Dataset 1의 해당 실험에서** FP 0%를 기록했다”가 된다.
- 크기(MB)는 모델을 저장하는 데 필요한 공간, 속도(FPS)는 초당 처리 프레임 수, MFLOPS/image는 표가 제시한 이미지당 계산량이다. **EMN_Fire 569 / 13.23 MB**와 **CNNFire 833 / 3.06 MB**를 보면 모델 파일 크기와 계산량의 순위가 다를 수 있다.

### 5.2 미세조정 전후와 데이터셋

| 방법 | Dataset 1 정확도, 미세조정 전 → 후 | Dataset 1 FN, 전 → 후 | Dataset 2 P / R / F, 전 → 후 |
|---|---|---|---|
| 1 | 90.06% → 94.39% | 10.65% → 2.13% | .85 / .92 / .88 → .82 / .98 / .89 |
| 2 | 88.41% → 94.43% | 5.50% → 1.50% | .86 / .89 / .88 → .80 / .93 / .86 |
| 3 | 89.80% → 94.50% | 10.39% → 2.12% | .84 / .87 / .85 → .86 / .97 / .91 |

이 표에서 **방법 2는 미세조정 후 Dataset 1 정확도와 Dataset 2 Recall이 올랐지만 Dataset 2 F-measure는 .88에서 .86으로 하락했다**. 개선 여부를 설명할 때는 데이터셋과 지표를 함께 말한다. 또 방법 1과 3의 미세조정 후 Dataset 2를 비교하면, 방법 1은 Recall이 조금 더 높고(.98 대 .97), 방법 3은 Precision과 F-measure가 더 높다(.86 대 .82, .91 대 .89).

같은 조건에서 모델을 비교하면 EMN_Fire가 두 데이터셋 모두 정확도와 F-measure가 가장 높다. Dataset 2의 Recall은 ANetFire가 가장 높다. 모델별 숫자는 다음과 같다.

| 모델 | Dataset 1 정확도 / F1 | Dataset 2 정확도 / F1 | Dataset 2 FP / FN | MFLOPS/image | 크기 |
|---|---|---|---|---:|---:|
| **EMN_Fire** | 95.86% / .99 | 92.04% / .92 | 9.34% / 6.72% | 569 | 13.23 MB |
| CNNFire | 94.61% / .98 | 89.82% / .90 | 18.69% / 2.52% | 833 | 3.06 MB |
| GNetFire | 93.66% / .98 | 84.96% / .85 | 24.29% / 6.72% | 1,500 | 43.30 MB |
| ANetFire | 94.27% / .96 | 88.05% / .88 | 23.36% / 1.68% | 720 | 233 MB |

### 5.3 지표와 도식 읽기

| 용어 | 뜻 또는 식 |
|---|---|
| TP / TN | 실제 화재를 화재로 판단 / 실제 정상을 정상으로 판단 |
| FP / FN | 정상인데 화재라고 판단 / 화재인데 정상이라고 판단 |
| FPR / FNR | FP/(FP+TN) / FN/(TP+FN) |
| Precision / Recall | TP/(TP+FP) / TP/(TP+FN) |
| Accuracy | (TP+TN)/(TP+TN+FP+FN) |
| F-measure (F1) | 2 × Precision × Recall / (Precision + Recall) |

위 식은 지표의 일반적인 정의다. PPT의 FP·FN·정확도는 보고값이다. 표에 원본 혼동행렬과 지표의 산출 방식이 제시되어 있지 않으므로 지표 정의는 개념 설명에, 수치는 조건을 붙인 결과 비교에 사용한다. **프레임 분류**에서 TP는 화재 프레임이고, **위치 검출 평가**에서는 실제 화재 픽셀을 맞힌 결과다. 무엇을 한 건으로 세는지 구분한다.

- **교란 실험**에서 불꽃이 보이는 채로 주변에 잡음을 넣으면 화재 점수가 높게 남은 예가 있고, 화재 영역을 크게 막으면 **100% → 0.43%**로 떨어진 예가 있다. 불이 없는 집 사진에 불꽃을 합성하자 위치에 따라 Fire 점수가 달랐다. 모두 개별 이미지의 예측 점수다.
- **분할 비교 그래프**는 가로축 FPR, 세로축 TPR이다. FPR은 낮고 TPR은 높을수록 좋다. CNNFire의 threshold를 **0.40 → 0.45 → 0.50**으로 올리면 표시하는 화재 픽셀이 줄어 그래프에서 **FPR과 TPR이 함께 낮아진다**. 임계값을 조정할 때 오탐과 놓치는 화재 픽셀 사이의 균형을 잡아야 한다.
- **분할 결과를 정답 마스크와 비교할 때는** **불 영역을 얼마나 잘 포함했는지**와 **배경을 불로 얼마나 칠했는지**를 함께 보면 된다.
- **안개 표본**에서 EMN_Fire는 원본 **100%**, 화재를 가렸을 때 **1.87%**, 화재 부위에 잡음이 있을 때 **85.4%**의 Fire 점수를 냈다. 같은 잡음 표본에서 CNNFire는 **9.0%**였다. 이 결과로 해당 예시에서의 견고함을 설명할 수 있다.

### 5.4 차단·잡음 실험은 왜 했는가?

| 조건 | 확인하려는 것 |
|---|---|
| **Original input** | 변형 전 화재 예측의 기준 점수 |
| **Fire blocked** | 불꽃 부분을 가리면 Fire 점수가 떨어지는지를 보고 실제 화재 영역에 얼마나 의존하는지 확인 |
| **Fire region affected with noise** | 화재 부분이 남아 있지만 단서가 훼손되었을 때도 탐지할 수 있는지 확인 |

추가 검증 예시는 **초점 흐림**(경계가 뭉개져도 탐지하는가), **밝기 변경**(다른 조명에서도 탐지하는가), **다운샘플링**(원거리처럼 불꽃 픽셀이 줄어도 탐지하는가)이다. PPT의 예시는 개별 이미지의 예측 점수이며 여러 영상에 대한 평균 성능은 별도 평가 항목이다.

### 5.5 Future Work

| PPT가 제안한 방향 | 목적 |
|---|---|
| **ShuffleNet 검토** | 정확도·오경보·실행 시간을 고려하며 모델을 더 작게 만든다. |
| **Smoke detection 결합** | 너무 멀거나 불꽃이 가려져도 연기라는 단서를 활용한다. |
| **Defogging 결합** | 안개로 낮아진 영상 가시성을 개선한다. |

**추가 개선 아이디어** — **열화상 결합**은 어둠 속 열원 신호를 보완한다. **시간 정보 활용**은 여러 프레임에서 불꽃의 변화와 지속성을 본다. **센서 융합**은 영상에 온도·연기 센서를 결합한다. **양자화(quantization)**는 낮은 정밀도의 표현을 써서 저장량과 배치 비용을 줄이는 방향이다.

## 6. 영어 서술형 연습

예시를 N개 요구하면 **개수를 맞추고, 예시마다 한 가지 이유를 붙인다**. 아래 답안의 추가 예시는 연습용이다.

| 문제 | 짧은 모범답안 |
|---|---|
| **1. Give three false-alarm examples from the slides and three additional ones. Explain why each can be mistaken for fire.** | Slide examples are a red window reflection, a red building covered by smoke, and a person moving with a red ball. These imitate flame color, smoke context, or flame-like color and motion, respectively. Additional examples are a red flag waving, an orange warning light reflected in wet pavement, and a stage prop that imitates moving flames. Each combines flame-like color with movement or flickering. |
| **2. List three applications shown in the slides and three additional applications.** | The slides list home, forest, and vehicle surveillance. Additional applications include warehouse, subway station, and data center surveillance. |
| **3. Give three contextual data items from the slides and three additional items.** | The slides include the burning object, the presence of people, and the camera’s GPS location. Additional items include nearby hydrant locations from a map, accessible roads from traffic data, and wind direction from weather data. |
| **4. Contrast the two benchmark datasets.** | Dataset 1 contains surveillance videos with varied fires and visually confusing normal scenes. Dataset 2 contains 226 challenging still images, including 119 fire and 107 non-fire images. Motion across frames can be examined in the video dataset. |
| **5. What is new about the uncertain fire dataset? Why include uncertain non-fire scenes?** | It organizes examples by both fire status and visibility condition. Uncertain non-fire scenes help check whether the model distinguishes actual fire from fog, smoke, or lights under poor visibility. |
| **6. Give three uncertain conditions from the slides and three additional conditions.** | The slides show fog, snow, and smoke. Additional conditions include severe low light, raindrops on the lens, and strong backlighting. Each can obscure or weaken visual evidence of fire. |
| **7. What did the OMT and multi-expert methods introduce? Give one limitation of each.** | The OMT method estimates the magnitude and direction of flame motion, but ordinary motion can still trigger false alarms. The multi-expert method combines color, shape, and movement decisions through weighted voting, and computing multiple features increases cost. |
| **8. State the main contribution of each of the four methods.** | Method 1 applies a fine-tuned CNN to early fire detection. Method 2 improves the accuracy–efficiency trade-off. Method 3 selects feature maps for localization and contextual analysis. Method 4 uses a MobileNet-based detector and introduces a benchmark for uncertain scenes. |
| **9. How are feature map selection and fire localization different?** | Selection uses training images and ground-truth masks to identify maps with low aggregate Hamming distance. Localization averages the selected maps for a new fire frame and thresholds the result to obtain a binary fire mask. |
| **10. What is the Hamming distance between 1011 and 1101? Why is it useful here?** | The distance is two. It counts mismatched positions and measures how closely a binarized feature map matches a ground-truth fire mask. |
| **11. What do fire blocking and noise corruption test?** | Blocking the fire tests how much the prediction relies on the fire region. Adding noise tests whether detection still works when the visible fire evidence is partly degraded. |
| **12. Name three future directions proposed in the slides and explain them.** | ShuffleNet could reduce model size. Smoke detection could provide a cue when flames are hard to see. Defogging could improve visibility before detection. |
| **13. Name three disaster management services from the slides and three other services.** | The slides include early detection, early notification, and response mobilization. Other services include damage assessment, recovery tracking, and shelter assignment. |
| **14. What can you conclude from the 0% false-positive result?** | EMN_Fire reported 0% false positives on Dataset 1 and 9.34% on Dataset 2. The false-positive result depends on the evaluation dataset. |
