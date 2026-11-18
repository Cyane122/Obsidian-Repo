# 9주차 시험 대비 | 지능형 화재 장면 분석과 에이전트 기반 감시

범위는 9주차 PPT 두 편이다. 아래에서 **A**는 *Intelligent Fire Scene Analysis* (40장), **B**는 *Agents based Intelligent Fire Monitoring* (19장)이며, 번호는 PPT를 처음부터 센 슬라이드 순서다. 설명과 예제, 영어 연습문제까지 이 파일에 담았다. 공부 순서는 두 자료에서 반복하는 내용과 알고리즘·시스템 도식을 기준으로 정했다.

## 0. 시험 직전 한 페이지

- **Detection**은 프레임이 Fire인지 Normal인지 분류한다. **Localization / segmentation**은 화재로 판단한 프레임에서 불이 있는 픽셀을 표시한다. **Context extraction**은 무엇이 타는지, 사람이 있는지, 어떤 위험이 있는지 등 소방대가 쓸 정보를 만든다.
- **학습 시 맵 선택**은 `레이어 L의 후보 m개 → 256×256 → 맵별 평균값으로 이진화 → 정답과의 해밍 거리 합산 → T1로 n개 선택`이다.
- **감시 시 화재 분할**은 `Fire 프레임 → 미리 고른 n개 맵 → 픽셀별 평균(FMA) → T2로 이진화 → 화재 ROI`다. 강의 예시는 **Fire2/Concat 층의 F8·F26·F32**다.
- **ROI**는 화재 영역이다. **ZOI**는 ROI를 원본에서 제외한 뒤 주변 물체를 살피는 영역이다. 일반적인 예측 확률 임계값은 고신뢰 샘플을 모아 **fine-tuning**에 쓰는 별도의 기준이다.
- **Agent 1**은 분류, **2**는 화재 심각도·확산, **3**은 물체 위치·분포, **4**는 사람·밀집도, **5**는 가연물, **6**은 물체 범주, **7**은 세부 유형, **8**은 대피·실내외 장면을 담당한다. **1–6은 필요한 입력을 받은 뒤 독립 처리**, **7–8은 다른 에이전트의 분석에 의존**한다.
- **Flat**은 보내고 계속 진행, **Call**은 호출하고 응답 대기, **Return**은 호출자에게 결과 반환이다. 병렬 처리 중 완료된 정보는 119 및 재난관리센터에 즉시 보고한다.
- **방법 1**은 조기 화재 탐지, **방법 2**는 정확도와 효율의 균형, **방법 3**은 위치 검출과 현장 정보, **방법 4**는 안개·눈·연기 등 불확실한 환경의 탐지다. 대표 결과에서 **방법 3이 가장 작고(3 MB), 방법 4가 가장 빠르다(34 FPS)**. 방법 4의 **오경보율 0%는 Dataset 1에서의 결과**다.

## 1. 문제 정의와 기존 방식

*근거 — A 3–14번, B 1–2번*

### 1.1 화재 감시에서 요구하는 출력

CCTV 영상 스트림 $V$는 $n$개 프레임으로 이루어진다. 프레임 $I_x$를 특징 벡터 $f_x$로 표현하면 첫 번째 목표는 그 프레임이 화재 또는 정상인지 판단하는 것이다. 이후 CNN의 공간 특징 맵을 이용하면 불이 있는 위치와 범위를 찾을 수 있다. 여기에 물체·사람·위험물 정보를 결합하면 신고를 받은 소방대가 구조와 진압의 우선순위를 정하는 데 도움이 된다.

| 과업 | 입력 | 출력 | 사례 |
|---|---|---|---|
| 화재 탐지·분류 | CCTV 프레임 | Fire / Normal 및 점수 | 차량이 보이는 장면을 Fire로 판정 |
| 화재 위치 검출·분할 | Fire로 분류된 프레임의 특징 맵 | 픽셀 단위 이진 화재 마스크 | 차량 위와 바닥의 화염 영역 표시 |
| 상황 정보 추출 | 원본, 분할 결과, 영상 분석 결과 및 메타데이터 | 소방대에 보고할 항목 | 차량 화재, 주변 인원, 화재 확산 여부, 카메라 위치 |

재난관리에서는 예방, 사전 경고, 조기 탐지와 통보, 대응 인력·자원 동원, 피해 확산 억제, 의료·구호가 이어진다. 이 강의의 CCTV 분석은 특히 **조기 탐지·통보와 대응 판단**에 해당한다. 밀양 병원, 제천 체육시설 등의 사례는 조기 파악이 필요한 배경으로 제시된다.

### 1.2 센서와 영상 기반 탐지

| 방식 | 쓰는 단서 | 장점과 한계 |
|---|---|---|
| 기존 센서 | 열, 연기 등 | 센서 가까이까지 변화가 전달되어야 하고 감시 범위가 제한될 수 있다. 센서 신호만으로 화재 크기, 위치, 주변 사람까지 파악하기 어렵다. |
| 영상의 색상 | RGB, HSI, YCbCr 등으로 표현한 불꽃 색 | 구현이 단순하지만 밝기·그림자·반사에 민감하다. 붉은 물체, 노을, 조명 등도 화재처럼 보일 수 있다. |
| 영상의 움직임 | 광류(Optical flow) 등으로 얻는 움직임의 크기와 방향 | 불꽃의 움직임을 포착하지만 정상 물체가 움직여도 화재로 오인할 수 있다. |
| 여러 특징의 결합 | 색상, 움직임, 형태·거칠기 등 | 서로 다른 근거를 함께 써서 판별하지만 여러 특징을 계산하는 비용이 든다. |
| CNN 기반 영상 분석 | 프레임으로부터 학습한 깊은 특징 | 원거리의 작은 불꽃을 탐지하고 위치·문맥도 분석하려는 접근이다. 모델이 크거나 계산량이 많으면 실시간 적용이 어렵다. |

영상 감시의 장점은 **기존 CCTV로 넓은 구역을 확인**, **현장에 들어가기 전 화재를 원격 확인**, **화재의 크기·위치·심각도 파악**, **화재 외에 연기 등 다른 이벤트에도 적용**이다.

- **OMT (Optimal Mass Transport)** 방식은 고전적인 광류가 불꽃 탐지에 적합하지 않다는 문제에서 출발해 움직임의 방향과 크기를 계산한다. 정상적인 움직임에서 오경보가 나는 사례도 제시된다.
- **Multi-expert 방식**은 색상·형태·움직임을 보는 전문가 세 개의 결정을 **가중 투표(weighted voting)**로 결합한다. 저수준 특징을 여러 개 추출하는 데 비용이 든다. 여기서 전문가 셋의 투표는 분류를 위한 결합이다. B의 에이전트는 사람 계수나 대피 분석처럼 서로 다른 결과를 만들어 보고한다.
- 강의가 정리한 기존 방식의 문제는 **오경보**, **계산 비용에 비해 부족한 분류·위치 검출 성능**, **상황 정보 부족**, **시야가 나쁜 환경에서의 성능 저하**, **큰 CNN의 실시간 배치 어려움**이다.

## 2. CNN 방법 네 가지와 실험

*근거 — A 15–35번*

### 2.1 어떤 문제를 해결하려는가

| 방법 | 입력과 처리 | 결과에서 볼 점 |
|---|---|---|
| **1. Early Fire Detection for Efficient Disaster Management** | CCTV 프레임을 **224×224×3**으로 입력한다. 도식에서 합성곱 5개, 풀링, FC6·FC7·FC8을 거치고 마지막 출력은 Fire / Normal 2개다. | 조기 탐지의 기준 모델이다. 미세조정 후 Dataset 1 정확도가 올라가고 특히 미탐이 줄었다. 모델이 238 MB라 배치 비용이 크다. |
| **2. Balancing Efficiency and Accuracy** | 학습 데이터로 CNN을 학습하고, 가정·산림·차량 등 영상 스트림에 적용한다. Fire이면 소방대에 알리고 Normal이면 별도 조치를 하지 않는다. A 34번 비교표의 모델명은 **GNetFire**다. | 방법 1과 비슷한 Dataset 1 정확도로 가장 큰 개선은 모델 크기·처리 속도·오경보다. Dataset 2의 F-measure는 방법 1이 더 높다. |
| **3. Fire Localization and Contextual Information Extraction** | 가벼운 CNN으로 분류하고 **Fire2/Concat** 특징 맵에서 화재 픽셀을 분할한다. ROI에서 불의 영역을 얻고 ZOI를 분석한다. 도식은 물체 정보 추출에 **ImageNet-SqueezeNet**을 사용한다. 비교표의 이름은 **CNNFire**다. | 모델이 약 3 MB이고, 탐지와 함께 **어디가 타는가, 무엇이 타는가**를 알려준다. |
| **4. Fire Detection in Uncertain Environment** | 안개·눈·연기 등의 영상에 **MobileNet 기반 EMN_Fire**를 적용한다. 도식은 MobileNet 블록과 1×1 합성곱 뒤에 **Global Pooling → 1×1 Conv 또는 FC → Softmax**로 분류한다. | 시야가 떨어지는 환경과 임베디드 장비를 겨냥한다. 방법 3이 더 작지만, 비교표에서 방법 4가 이미지당 연산량이 더 적다. |

A 34번의 방법 1 비교 모델명은 **ANetFire**다. 개별 방법 소개와 방법 4의 비교표에는 수치 차이가 있다. 예를 들어 방법 1의 크기는 **A 18번에서 238 MB**, 방법 4의 비교표에서는 **ANetFire 233 MB**로 보고한다. 방법 소개 수치를 묻는지, 같은 평가표에서 비교하라는 것인지 확인한다.

### 2.2 대표 성능

| 방법 | 정확도 | FP / 오경보 | FN / 미탐 | FPS | 모델 크기 |
|---|---:|---:|---:|---:|---:|
| 1 · A 18–19번 | 94.39% | 9.07% | 2.13% | 17 | 238 MB |
| 2 · A 22–23번 | 94.43% | 0.054% | 1.50% | 23 | 43 MB |
| 3 · A 25, 27번 | 94.50% | 8.87% | 2.12% | 20 | 3 MB |
| 4 · A 32, 34번의 Dataset 1 | 95.86% | 0% | 0.14% | 34 | 13.23 MB |

- **1 → 2**는 정확도 약 **+0.04%p**, 처리 속도 **+6 FPS**, 모델 크기 **−195 MB**다. 정확도가 거의 같은 상황에서 배치 효율 차이가 핵심이다.
- **방법 3**의 핵심 성과는 작은 모델에 **화재 분할과 상황 정보 추출**을 결합했다는 점이다. 대표값 기준으로 방법 2의 오경보율이 방법 3보다 낮다.
- **방법 4**의 Dataset 1 F-measure는 **0.99**, Dataset 2는 **0.92**다. Dataset 2의 정확도는 **92.04%**, FP는 **9.34%**, FN은 **6.72%**다. “방법 4는 오경보가 없다”라는 문장을 고치면 “방법 4는 **Dataset 1의 해당 실험에서** FP 0%를 기록했다”가 된다.
- 크기(MB)는 모델을 저장하는 데 필요한 공간, 속도(FPS)는 초당 처리 프레임 수, MFLOPS/image는 표가 제시한 이미지당 계산량이다. A 34번의 **EMN_Fire 569 / 13.23 MB**와 **CNNFire 833 / 3.06 MB**를 보면 모델 파일 크기와 계산량의 순위가 다를 수 있다.

### 2.3 미세조정 전후와 데이터셋

**A 19, 23, 27번의 Dataset 1**은 CCTV 영상에서 추출한 장면을 중심으로 한다. 작은 불이 멀리 보이는 영상, 실내외 불, 산불뿐 아니라 연기만 보이는 장면, 붉은 벽·공, 햇빛 반사처럼 헷갈리는 정상 사례가 포함된다. **Dataset 2**는 정지 이미지 **226장(화재 119, 비화재 107)**으로 구성된 작은 평가 자료다. PPT는 Dataset 1에서 정확도·FP·FN을, Dataset 2에서 Precision·Recall·F-measure를 제시한다.

| 방법 | Dataset 1 정확도, 미세조정 전 → 후 | Dataset 1 FN, 전 → 후 | Dataset 2 P / R / F, 전 → 후 |
|---|---|---|---|
| 1 | 90.06% → 94.39% | 10.65% → 2.13% | .85 / .92 / .88 → .82 / .98 / .89 |
| 2 | 88.41% → 94.43% | 5.50% → 1.50% | .86 / .89 / .88 → .80 / .93 / .86 |
| 3 | 89.80% → 94.50% | 10.39% → 2.12% | .84 / .87 / .85 → .86 / .97 / .91 |

이 표에서 **방법 2는 미세조정 후 Dataset 1 정확도와 Dataset 2 Recall이 올랐지만 Dataset 2 F-measure는 .88에서 .86으로 하락했다**. 개선 여부를 설명할 때는 데이터셋과 지표를 함께 말한다. 또 방법 1과 3의 미세조정 후 Dataset 2를 비교하면, 방법 1은 Recall이 조금 더 높고(.98 대 .97), 방법 3은 Precision과 F-measure가 더 높다(.86 대 .82, .91 대 .89).

**방법 4의 불확실 환경 평가(A 33–34번)**는 화재 여부와 관측 조건을 별도로 구분한다. **Uncertain**은 안개·눈·연기처럼 관측 조건이 까다롭다는 뜻이다. 안개 속 차량 불빛은 불확실한 **비화재**, 연기 사이의 실제 불꽃은 불확실한 **화재**다.

| 분할 | 전체 | 화재 Certain / Uncertain | 비화재 Certain / Uncertain |
|---|---:|---|---|
| Dataset 1 학습 | 8,032 | 1,604 / 240 | 4,807 / 1,381 |
| Dataset 1 평가 | 22,518 | 6,000 / 1,003 | 10,515 / 5,000 |
| Dataset 2 평가 | 226 | 100 / 19 | 90 / 17 |

**A 34번의 동일 비교표**에서 모델을 비교하면 EMN_Fire가 두 데이터셋 모두 정확도와 F-measure가 가장 높다. Dataset 2의 Recall은 ANetFire가 가장 높다. 모델별 숫자는 다음과 같다.

| 모델 | Dataset 1 정확도 / F1 | Dataset 2 정확도 / F1 | Dataset 2 FP / FN | MFLOPS/image | 크기 |
|---|---|---|---|---:|---:|
| **EMN_Fire** | 95.86% / .99 | 92.04% / .92 | 9.34% / 6.72% | 569 | 13.23 MB |
| CNNFire | 94.61% / .98 | 89.82% / .90 | 18.69% / 2.52% | 833 | 3.06 MB |
| GNetFire | 93.66% / .98 | 84.96% / .85 | 24.29% / 6.72% | 1,500 | 43.30 MB |
| ANetFire | 94.27% / .96 | 88.05% / .88 | 23.36% / 1.68% | 720 | 233 MB |

### 2.4 지표와 도식 읽기

| 용어 | 뜻 또는 식 |
|---|---|
| TP / TN | 실제 화재를 화재로 판단 / 실제 정상을 정상으로 판단 |
| FP / FN | 정상인데 화재라고 판단 / 화재인데 정상이라고 판단 |
| FPR / FNR | FP/(FP+TN) / FN/(TP+FN) |
| Precision / Recall | TP/(TP+FP) / TP/(TP+FN) |
| Accuracy | (TP+TN)/(TP+TN+FP+FN) |
| F-measure (F1) | 2 × Precision × Recall / (Precision + Recall) |

위 식은 지표의 일반적인 정의다. PPT의 표에 있는 FP·FN·정확도 수치는 원문 보고값이며, 원본 혼동행렬 없이 표의 수치들에서 건수를 역산할 필요는 없다. **프레임 분류**에서 TP는 화재 프레임이고, **위치 검출 평가**에서는 실제 화재 픽셀을 맞힌 결과다. 무엇을 한 건으로 세는지 구분한다.

- **A 20번의 교란 실험**에서 불꽃이 보이는 채로 주변에 잡음을 넣으면 화재 점수가 높게 남은 예가 있고, 화재 영역을 크게 막으면 **100% → 0.43%**로 떨어진 예가 있다. 불이 없는 집 사진에 불꽃을 합성하자 위치에 따라 Fire 점수가 달랐다. 모두 개별 이미지의 예측 점수다.
- **A 28번의 분할 비교 그래프**는 가로축 FPR, 세로축 TPR이다. FPR은 낮고 TPR은 높을수록 좋다. CNNFire의 threshold를 **0.40 → 0.45 → 0.50**으로 올리면 표시하는 화재 픽셀이 줄어 그래프에서 **FPR과 TPR이 함께 낮아진다**. 임계값을 조정할 때 오탐과 놓치는 화재 픽셀 사이의 균형을 잡아야 한다.
- **A 29–30번**은 입력, 정답 마스크, BoWFire·색상 기반 등의 결과와 제안 결과를 이미지별로 비교한다. 시험에서 그림을 받으면 **불 영역을 얼마나 잘 포함했는지**와 **배경을 불로 얼마나 칠했는지**를 함께 보면 된다.
- **A 35번의 안개 표본**에서 EMN_Fire는 원본 **100%**, 화재를 가렸을 때 **1.87%**, 화재 부위에 잡음이 있을 때 **85.4%**의 Fire 점수를 냈다. 같은 잡음 표본에서 CNNFire는 **9.0%**였다. 이 결과로 해당 예시에서의 견고함을 설명할 수 있다.

## 3. 특징 맵에서 화재 ROI까지

*근거 — A 24–31번, B 4–8번*

### 3.1 CNN과 SqueezeNet의 Fire module

**Feature map**은 CNN 채널이 이미지의 어느 위치에서 강하게 반응하는지를 담은 2차원 배열이다. 서로 다른 채널은 다른 패턴에 반응할 수 있다. **Fire2**는 SqueezeNet 블록 이름이고 `Fire`는 프레임의 예측 클래스다.

B 5번의 분류기는 **3×3 Conv(64 filters) → MaxPool → Fire2~Fire9 → 1×1 Conv(M filters) → Average Pooling → Softmax**로 이어진다. MaxPool은 Fire4와 Fire8 뒤에도 들어간다. Fire2 세부 구조는 다음과 같다.

```text
입력
  ↓
1×1 squeeze · 출력 채널 16 → ReLU
  ├─ 1×1 expand · 출력 채널 64 → ReLU ─┐
  └─ 3×3 expand · 출력 채널 64 → ReLU ─┤
                                        ↓
                           채널 방향 concat · 128채널
```

작은 squeeze 층으로 채널을 먼저 줄이면 뒤쪽 expand에서 필요한 연산을 줄일 수 있다. expand의 두 갈래는 같은 공간 위치에서 서로 다른 크기의 필터를 적용한다. **Conv·pooling은 특징을 만들고 축약하며, Softmax는 Fire/Normal 분류 점수를 확률 형태로 나타낸다.** 분할에 쓰는 공간 패턴은 Softmax 출력 앞의 특징 맵에서 얻는다.

### 3.2 학습 시점 — Feature map selection

**입력**은 학습 영상 프레임, 픽셀 단위 정답 마스크 **GT**, CNN이다. **출력**은 불에 민감한 특징 맵의 번호다.

1. CNN에 학습 프레임을 순전파하고 레이어 *L*의 후보 특징 맵 *m*개를 가져온다.
2. 정답 마스크와 후보 맵을 동일한 **256×256** 크기로 맞춘다. 대응 좌표끼리 비교하기 위한 과정이다.
3. 각 후보 맵 *i*의 평균 활성값을 구한다. 그 맵의 픽셀 활성값이 평균보다 **크면 1**, 작거나 같으면 **0**으로 이진화한다.
4. 각 이미지의 이진 맵과 GT를 비교해서 **해밍 거리**를 센다. 해밍 거리는 같은 위치에서 값이 다른 픽셀 수다.
5. 각 후보 맵에 대해 학습 이미지 전체에서 해밍 거리를 합산한다. **T1**을 기준으로 누적 거리가 작은 후보들을 추려 *n*개를 선택한다.
6. 화재 장면 분석 PPT의 예에서는 Fire2/Concat의 **F8, F26, F32**를 사용한다.

이진 마스크를 행 단위로 펼친 작은 예제를 보면, GT가 `1 0 1 0`, 맵 A가 `1 0 0 0`, 맵 B가 `0 1 1 0`일 때 해밍 거리는 각각 **1**, **2**다. 학습 샘플이 여럿이면 맵별로 거리를 더한 뒤 비교한다.

### 3.3 감시 시점 — ROI selection과 segmentation

**입력**은 새 영상 프레임과 미리 고른 특징 맵 번호다. **출력**은 화재 픽셀이 1인 이진 마스크다.

1. 프레임을 CNN으로 분류한다. **Normal**이면 이 프레임의 화재 분할을 건너뛰고 다음 프레임으로 간다.
2. **Fire**이면 레이어 *L*에서 선정된 *n*개 맵을 가져온다.
3. **같은 좌표의 활성값들을 평균**해 공간 정보를 유지한 **FMA(Mean Activation Map)**를 만든다. 강의 예에서는 $FMA(x,y) = (F_8(x,y) + F_{26}(x,y) + F_{32}(x,y))/3$이다.
4. 각 좌표에서 `FMA(x,y) > T2`이면 **1**, 나머지는 **0**으로 둔다. 이 결과가 segmented fire이며 화재 **ROI(Region of Interest)**가 된다.
5. 화재 픽셀은 크기와 심각도 추정에 쓰고, 여러 프레임에서는 면적 변화로 확산이나 감소를 추정한다. 화재 영역을 제외한 부분은 주변 분석에 연결한다.

예를 들어 어떤 좌표에서 선택된 세 맵이 **0.6, 0.3, 0.9**로 반응하면 FMA는 **0.6**이다. T2가 **0.5**이면 해당 픽셀은 **1**이다. 숫자는 계산을 보여주기 위한 예제다.

| 기준 | 비교 대상 | 결과 |
|---|---|---|
| 학습 중 각 맵의 평균 활성값 | 개별 맵의 각 픽셀 | GT와 비교할 이진 맵 |
| **T1** | 맵마다 합산한 해밍 거리 | 기억해 둘 특징 맵 번호 |
| **T2** | 선택한 맵들의 픽셀별 평균 FMA | 새 프레임의 이진 화재 ROI |
| **Prediction probability threshold** | 프레임 분류의 예측 확률 | 데이터 축적 및 fine-tuning 후보 |

**256×256**은 특징 맵과 GT 비교에 사용한 크기이고 **224×224×3**은 방법 1에서 제시한 CNN 프레임 입력 크기다. **해밍 거리와 GT는 미리 맵을 선정할 때**, **FMA와 T2는 들어오는 화재 프레임을 분할할 때** 등장한다.

## 4. 상황 정보 추출과 자동 신고

*근거 — A 24–25, 31번, B 3–4, 9–11번*

### 4.1 시스템 모듈과 데이터 흐름

```text
CCTV 비디오 프레임
   ↓
특징 추출 및 Fire / Normal 분류
   ├─ 예측 확률이 기준 이상 → 데이터 축적·저장 → fine-tuning
   └─ Fire → 선택한 특징 맵 분석 → ROI(화재 픽셀)
                                      ├─ 화재 규모·심각도·확산 추정
                                      └─ ZOI에서 물체·사람·위험 분석
                                                  ↓
                          상황 정보 + 카메라 GPS 등 메타데이터
                                                  ↓
                                    119 및 재난관리센터에 보고
```

B 3번에는 **Fire Detection and Localization**, **Contextual Information Extraction**, **Data Accumulation**, **Storage**, **Fine-Tuning**, **Broadcasting** 모듈이 나온다. B 4번에서는 **예측 확률이 기준 이상인 샘플만 축적**해 재학습에 활용한다. 그림의 Normal·Fire 가지가 모두 축적 모듈과 연결된다. 이 분기는 화재를 픽셀별로 표시하는 T2와 목적이 다르다.

### 4.2 수동 신고 질문과 자동 보고 대응

| 보고 번호 | 신고에 필요한 내용 | 시스템이 뽑는 정보 |
|---|---|---|
| **1** | 무엇이 타는가? | 건물, 차량, 숲 등 화재 대상 · **Agent 6** |
| **2** | 사람이 있는가? | 인원수와 군중 밀집도 · **Agent 4** |
| **3** | 어떤 유형의 물체가 있는가? | 주변 물체의 세부 유형 · **Agent 7** |
| **4** | 가연물이나 위험물이 있는가? | 가연성 물질·위험물의 존재와 종류 · **Agent 5** |
| **5** | 대피가 진행되고 있는가? | 대피 미시작·진행 중·완료 · **Agent 8** |
| **6** | 어디인가? | 카메라 GPS 등 위치 정보 · 메타데이터 |
| **7** | 신고 연락처는 무엇인가? | 스마트폰 사용자 전화번호 등 · 메타데이터 |
| **8a** | 불의 크기와 변화는? | 규모, 심각도, 확산·감소 · **Agent 2** |
| **8b** | 현장 유형은? | 실내·실외 판별 · **Agent 8** |

A 31번에는 ROI와 ZOI를 분석한 뒤 **Fire on Castle / Fire on Car / Fire on Church**라고 보고하는 예가 나온다. `Fire 99%`는 프레임에 화재가 있는지에 관한 점수이고, `Car 0.37` 같은 값은 별도의 물체 인식 결과다.

B 11번의 **물체 인식 우선순위**는 **사람 → 차량 → 동물 → 가연성 물체(연료·유조 차량·가스통 등) → 기타 물체 → 물체 유형 상세화**다. B 13번의 Agent 8 도식에도 자체 입력의 중요도를 표시한 예가 있다. 거기서는 사람·동물을 높게, 차량·건물을 낮게 둔다. **전체 인식 우선순위 표**와 **대피 분석에서 쓰는 우선순위 예시**를 각각 기억해 두면 된다.

## 5. 여덟 에이전트의 분업과 통신

*근거 — B 12–17번 및 관련 발표자 노트*

| Agent | 받는 정보 | 처리와 결과 |
|---|---|---|
| **1 · Feature extraction and classification** | 입력 영상 | CNN 특징 추출, Fire / Normal 분류. 화재로 판단한 영상을 다음 분석에 넘긴다. |
| **2 · Fire expansion monitoring** | Agent 1의 화재 영상 | 화재 영역 분할 → 화재 픽셀 수 계산 → 낮음·중간·높음 심각도 → 여러 프레임으로 확산·감소 판단 → **보고 8a**. |
| **3 · Objects localization and distribution** | 분석할 화재 장면 | 물체 영역과 분포를 파악해 물체·인원·위험물 분석에 전달한다. |
| **4 · Person detection and counting** | Agent 3의 물체 영역 | 사람 후보 검색과 탐지 → 가려짐(occlusion) 분석 → 인원수·밀집도 추정 → **보고 2**. |
| **5 · Flammable material recognition** | Agent 3의 물체 영역 | 위험물 픽토그램 탐색 → 후보 영역 추출 및 분할 → 가연물 종류와 위험 우선순위 판단 → **보고 4**. |
| **6 · Object detection and recognition** | Agent 3의 물체 영역 | 형태 분석과 후보 영역 선택 → 물체 검출·분할 → 물체 범주 인식 → **보고 1**, Agent 7에 범주 정보 제공. |
| **7 · Object type recognition** | 물체 영역과 Agent 6의 범주 | 범주 안에서 세부 유형 추정. 예를 들어 *vehicle*을 *bus*나 *truck*으로 좁힘 → **보고 3**. |
| **8 · Evacuation monitoring** | Agent 4–7의 인원·위험물·물체 정보 | 물체 간 관계와 장면 분석 → 실내·실외 판별, 대피 진행 판단 → **보고 5 및 8b**. |

**독립(Independent)**은 작업용 입력을 받은 뒤 다른 에이전트의 추가 분석을 기다리지 않고 임무를 수행할 수 있다는 뜻이다. 강의 예에서는 **1–6**이고, Agent 2와 4가 대표 사례다. **의존(Dependent)**은 다른 에이전트의 해석이 있어야 작업을 마무리할 수 있다는 뜻이다. Agent 7은 범주를, Agent 8은 여러 감시 결과를 받는다.

| 통신 | 기호 | 동작 |
|---|---|---|
| **Flat message** | 실선, 열린 화살촉 | 송신자가 메시지를 보낸 뒤 응답 대기 없이 진행한다. |
| **Call message** | 실선, 채운 화살촉 | 대상이 작업을 시작하게 호출하고 응답을 기다린다. |
| **Return message** | 점선, 열린 화살촉 | 호출받은 쪽이 원래 호출자 방향으로 결과를 돌려준다. |

**협업 순서.** 분할된 물체를 관련 에이전트들에 보낸다. 각 에이전트는 자기 작업이 끝나면 결과를 즉시 보고하고, 다른 작업에 필요한 정보를 전달한다. 추가 작업이 가능하다는 상태를 알리고, 협조 요청을 받으면 그 일을 수행하거나 다음 영상의 물체를 기다린다. 독립적인 업무를 **병렬로 진행**하고 항목별로 **완료 즉시 통보**하므로, 대피 상태 분석이 끝나기 전에도 규모나 인원수 같은 정보는 먼저 전달할 수 있다. 이전 경험에 따라 환경에 적응한다는 점도 B 17번에서 시스템의 특성으로 제시한다.

## 6. 한 장면으로 전체 흐름 복기

안개 속 도로 CCTV에 불붙은 차량과 주변 사람들이 보인다고 가정하자.

1. 기존 색상 방식은 안개 속 차량 불빛을 불로 착각할 수 있다. 불확실한 장면을 위한 방법 4는 이런 영상에서 Fire / Normal을 판단하도록 제안됐다.
2. 방법 3과 에이전트 시스템의 처리 흐름을 설명한다면, Agent 1이 Fire를 분류하고 선정된 특징 맵의 FMA를 T2로 이진화해 화재 ROI를 구한다. 두 방법의 설명은 슬라이드에 나온 각 모델의 역할을 보여준다.
3. Agent 2는 화재 픽셀을 세고, 이전 프레임과 비교해 불이 커지는지 본다. Agent 3이 넘긴 물체 영역으로 Agent 4는 사람 수를, Agent 5는 가연물을, Agent 6은 차량 범주를 확인한다.
4. Agent 7은 차량이 버스인지 트럭인지 판단한다. Agent 8은 사람·물체·위험 정보를 종합해 실외 상황과 대피 상태를 판단한다.
5. 인원이나 화재 확산처럼 먼저 확인한 사항은 바로 보고한다. 카메라 GPS가 있으면 위치 정보도 함께 전달한다.

## 7. 결론, 한계, 후속 연구

*근거 — A 37–38번, B 17–19번*

- CNN으로 실내외 화재를 탐지하고, 화재 픽셀과 주변 상황까지 추출하면 소방대가 대응 우선순위를 정하는 데 도움이 된다. 강의는 일반적인 감시 환경에 대한 방법 1–3, 불확실한 환경과 임베디드 비전을 위한 방법 4를 제시한다.
- 원거리이거나 안개가 짙으면 카메라에서 불꽃 자체가 잘 보이지 않는다. A 38번의 후속 연구 방향은 **연기 탐지(smoke detection)와 안개 제거(defogging)를 화재 분석과 결합**하는 것이다.
- **ShuffleNet**은 더 작은 CNN을 검토하는 후속 연구 예시다. 목표는 크기를 줄이면서 탐지 정확도, 오경보, 처리 시간을 함께 고려하는 것이다.
- B의 Further Study에는 화재 탐지·분할·분석, 자동 소화, 교통 시스템, 안개 환경의 연기 탐지가 소개된다. 이 목록은 관련 연구의 주제 파악용으로 정리했고, 아래 연습문제는 두 PPT 본문과 도식을 바탕으로 구성했다.

## 8. 실전 연습문제

영어 질문을 보고 핵심 용어를 포함해 한두 문장으로 답한 뒤 아래 답안을 확인한다. 아래 문항은 공부용이다.

1. **Distinguish fire detection, fire localization, and contextual information extraction.**
2. **Why can color-based fire detection produce false alarms? What limitation does motion-based detection have?**
3. **How does Hamming distance help select feature maps for fire localization?**
4. **What are T1 and T2 used for? Is the prediction-confidence threshold used for the same decision?**
5. **Explain how the system produces a binary fire mask for a new frame. What happens with a Normal prediction?**
6. **What is the difference between ROI and ZOI? Give one output from each.**
7. **Describe the squeeze and expand operations in SqueezeNet's Fire module.**
8. **Explain the main design objective of each of the four methods.**
9. **Method 2 improves Dataset 1 accuracy after fine-tuning. Does its Dataset 2 F-measure also improve?**
10. **EMN_Fire has 0% false positives on Dataset 1. What does Dataset 2 tell you?**
11. **Which agents recognize object category, determine detailed object type, and monitor evacuation?**
12. **What is the difference between an independent agent and a dependent agent? Give one example of each.**
13. **Compare flat, call, and return messages.**
14. **How does Agent 2 estimate severity and detect fire expansion?**
15. **What information can be reported without waiting for Agent 8, and why?**
16. **What happens to the false-positive and true-positive rates when the localization threshold is raised in the slide's experiment?**
17. **Why is camera GPS treated differently from the estimated number of people?**
18. **Compute the Hamming distance between binary masks `1 0 1 1` and `1 1 0 1`. If selected maps give values 0.2, 0.6 and 0.7 at one pixel, is it marked as fire with T2 = 0.5?**

### 모범답안

1. **Detection** classifies a frame as Fire or Normal. **Localization** identifies the fire pixels. **Context extraction** reports information about the scene that can support emergency response.
2. Lights, reflections, and red objects can resemble flame colors. Ordinary movement can also resemble flame motion and trigger an alarm.
3. Binarize the candidate maps, count their pixel-wise disagreements with the ground-truth masks, and sum the distances over the training examples. Select the maps with low aggregate distances.
4. **T1** is used to select feature maps by Hamming distance. **T2** binarizes the mean activation map. The prediction-confidence threshold selects samples for accumulation and fine-tuning.
5. If the prediction is Fire, average the selected maps pixel by pixel and set pixels above T2 to one. If the prediction is Normal, move to the next frame.
6. The **ROI** is the segmented fire region and can be used to estimate fire size. The **ZOI** is the surrounding area analyzed for people and nearby objects.
7. The 1×1 squeeze layer reduces the number of channels. The 1×1 and 3×3 expand branches process these activations, and their outputs are concatenated.
8. Method 1 targets early detection. Method 2 improves the efficiency–accuracy trade-off. Method 3 adds localization and context. Method 4 targets surveillance under uncertain conditions.
9. No. Its Dataset 2 F-measure drops from **0.88 to 0.86**, although recall increases from **0.89 to 0.93**.
10. Its false-positive rate is **9.34% on Dataset 2**. The result of 0% applies to the reported Dataset 1 test.
11. **Agent 6** recognizes the category, **Agent 7** determines the type, and **Agent 8** monitors evacuation.
12. **Agent 2** can finish once it receives a fire image. **Agent 8** needs the analysis results of Agents 4–7 before it can assess evacuation.
13. A flat message sends information without waiting. A call message starts an operation and waits for a response. A return message sends the result to the caller.
14. Agent 2 counts segmented fire pixels to estimate severity. It compares results across successive frames to judge whether the fire is expanding or shrinking.
15. Fire severity, person count, and other completed results can be reported as soon as the responsible agents finish. They do not need to wait for the evacuation assessment.
16. The false-positive rate decreases, and the true-positive rate also decreases. A stricter threshold labels fewer pixels as fire.
17. Camera GPS comes from metadata. Person count is estimated from the video.
18. The distance is **2**. The mean is **0.5**, so the pixel is **0** because the rule requires a value strictly greater than T2.

## 9. 슬라이드 확인 위치

| 내용 | PPT 위치 |
|---|---|
| 문제 정의, 센서와 영상 방식, OMT와 전문가 투표 | A 3–14번 |
| 방법 1과 2, 데이터셋, 미세조정 결과 | A 15–23번 |
| 방법 3, F8·F26·F32 및 위치 검출 결과 | A 24–31번 |
| 방법 4, MobileNet, 불확실 환경 데이터와 실험 | A 32–35번 |
| 결론과 후속 연구 | A 37–38번 |
| 모듈도, 데이터 축적과 SqueezeNet 구조 | B 3–5번 |
| 특징 맵 선택, 이진화, ROI 선택 순서도 | B 6–8번 |
| 상황 정보와 자동 신고 대응, 물체 우선순위 | B 9–11번 |
| 에이전트별 처리 흐름, 의존성, UML 통신 | B 12–17번 |

**원본 자료**

- [A. Intelligent Fire Scene Analysis](<C:/Users/bling/Downloads/Intelligent Fire Scene Analysis.pptx>)
- [B. Agents based Intelligent Fire Monitoring](<C:/Users/bling/Downloads/Agents based Intelligent Fire Monitoring.pptx>)
