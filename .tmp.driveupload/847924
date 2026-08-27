---
type: paper
title: "Memorization Dynamics in Knowledge Distillation for Language Models"
authors:
  - "Jaydeep Borkar"
  - "Karan Chadha"
  - "Niloofar Mireshghallah"
  - "Yuchen Zhang"
  - "Irina-Elena Veliche"
  - "Archi Mitra"
  - "David A. Smith"
  - "Zheng Xu"
  - "Diego Garcia-Olano"
year: 2026
venue: "COLM 2026 (accepted; arXiv v1 reviewed)"
url: "https://arxiv.org/abs/2601.15394"
pdf: "[[40 Sources/Papers/NLP/Memorization Dynamics in Knowledge Distillation for Language Models.pdf]]"
status: read
read_date: "2026-08-08"
tags:
  - domain/nlp
  - task/language-modeling
  - method/large-language-model
  - theme/privacy-preservation
aliases: []
---

# 한 줄 요약

동일한 데이터와 같은 크기의 student를 비교했을 때 [[Knowledge Distillation]]은 표준 fine-tuning보다 정확 일치 방식의 훈련 데이터 memorization을 절반 이상 줄이면서 validation 성능을 개선하며, 남는 memorization은 낮은 압축 엔트로피와 낮은 perplexity를 가진 model-family-specific “easy-to-memorize” 예제에 집중된다.

# Abstract

이 논문은 언어 모델의 knowledge distillation(KD) 파이프라인 전체에서 훈련 데이터 memorization이 어떻게 전달·억제되는지를 조사한다. Teacher, 같은 크기의 일반 fine-tuned baseline, distilled student를 동일한 데이터에서 학습하고, 50-token prefix를 주었을 때 뒤의 50-token suffix를 greedy decoding으로 정확히 재현하는지를 측정한다. Pythia, OLMo-2, Qwen-3 계열과 FineWeb, WikiText-103, Nemotron-CC-v2를 사용한 결과는 다음과 같다.

1. Student는 동일 크기 baseline보다 memorization이 일관되게 적다. FineWeb의 Pythia에서는 0.17%에서 0.07%로 약 2.4배 감소한다.
2. Student가 외우는 예제의 대부분은 teacher와 baseline이 함께 외우는 낮은 entropy·낮은 perplexity의 “easy-to-memorize” 예제다.
3. Student를 학습하기 전 계산 가능한 zlib entropy, teacher/baseline perplexity, teacher-baseline [[KL Divergence|KLD]]로 student memorization을 매우 정확하게 분류할 수 있다.
4. Soft KD와 hard KD의 전체 memorization rate는 같지만, hard KD는 baseline이 외우지 않은 teacher-specific 예제를 soft KD보다 2.7배 더 많이 물려받는다.

# 1. Introduction

[[Knowledge Distillation]]은 큰 teacher의 예측 분포를 작은 student로 이전해 추론 비용을 낮추고 utility를 높이는 방법이다. 최근에는 teacher의 훈련 데이터를 student가 직접 보지 않게 하거나 teacher의 출력만 전달한다는 점에서 privacy-preserving mechanism으로도 논의된다. 그러나 다음 질문은 충분히 답해지지 않았다.

- Student는 teacher의 일반화 능력과 개별 훈련 예제 memorization 중 무엇을 얼마나 상속하는가?
- 같은 데이터와 같은 크기의 모델을 표준 [[Cross-Entropy]]로 fine-tuning했을 때보다 KD student가 더 많이, 혹은 더 적게 외우는가?
- 어떤 예제가 student에 남는가? 그 위험을 distillation 전에 예측할 수 있는가?
- Logit-level soft distillation과 sequence-level hard distillation은 같은 privacy risk를 갖는가?

논문의 핵심 관점은 memorization의 총량만 세는 데서 그치지 않고, teacher·baseline·student가 외운 예제 집합의 교집합을 추적하는 것이다. 이를 통해 일반화의 이전과 teacher-specific memorization의 이전을 구분한다.

# 2. Background and Experimental Setup

## 2.1 비교 대상

- **Teacher $M_{teacher}$**: 큰 base model을 데이터셋 $D$에 [[Cross-Entropy]]로 fine-tuning한 모델이다.
- **Student $M_{student}$**: 작은 base model을 같은 $D$에서 teacher의 token distribution과 맞도록 distillation한 모델이다.
- **Baseline $M_{baseline}$**: student와 같은 크기의 base model을 같은 $D$에 표준 cross-entropy로 독립 fine-tuning한 통제군이다.
- **Dataset $D$**: teacher, student, baseline이 공통으로 사용하는 훈련 데이터다.

이 설계에서 student와 baseline은 architecture·parameter scale·훈련 데이터가 같고 학습 objective만 다르다. 따라서 둘의 차이는 주로 soft distribution matching과 one-hot next-token supervision의 차이로 해석할 수 있다.

## 2.2 주 실험

- 데이터: July 2025 Common Crawl dump에서 가져온 FineWeb 100만 예제
- sequence length: 256 tokens
- teacher: Pythia 12B base를 cross-entropy로 fine-tuning
- student: Pythia 1.4B base를 teacher의 logit distribution으로 soft distillation
- baseline: Pythia 1.4B base를 cross-entropy로 fine-tuning
- learning rate: $5\times 10^{-5}$, cosine decay
- temperature: 주 실험에서 $T=2.0$
- epoch: teacher 3; Pythia student/baseline 4; OLMo-2와 Qwen-3 student/baseline 5
- 확장 검증: Pythia/WikiText-103, Pythia/Nemotron-CC-v2, OLMo-2/FineWeb, Qwen-3/FineWeb

Student와 baseline은 comparable compute budget 아래 학습하며, student가 held-out in-distribution validation loss와 perplexity에서 baseline을 앞서는 시점까지 비교한다.

## 2.3 Soft knowledge distillation objective

논문의 주 실험은 teacher distribution을 기준으로 한 forward KL을 최소화한다.

$$
\mathcal{L}_{KD}
=T^2\sum_{i=1}^{|V|}P^{\tau}_{teacher}(i)
\log\frac{P^{\tau}_{teacher}(i)}{P^{\tau}_{student}(i)}
$$

$$
P^{\tau}(i)=\operatorname{softmax}\left(\frac{z_i}{T}\right)
=\frac{\exp(z_i/T)}{\sum_{j=1}^{|V|}\exp(z_j/T)}
$$

$z_i$는 token $i$의 pre-softmax logit이고 $T$는 temperature다. $T$가 커지면 teacher distribution이 평평해져 정답 token 하나뿐 아니라 대안 token 사이의 상대적 구조도 student가 학습한다. 손실 앞의 $T^2$는 temperature scaling으로 줄어드는 gradient 크기를 보정한다.

## 2.4 Discoverable memorization

훈련 sequence $x\in D$의 처음 50 tokens를 prefix $x_{1:50}$, 다음 50 tokens를 suffix $x_{51:100}$로 둔다. Model의 greedy continuation $G$가 suffix 전체를 정확히 재현하면 memorized로 판정한다.

$$
G(x_{1:50})=x_{51:100}
$$

평가는 훈련 데이터 100만 예제 전체에 적용한다. 따라서 여기서 memorization rate 0.07%는 약 700개 sequence가 이 엄격한 exact-match test를 통과했다는 뜻이다.

# 3. Memorization During Distillation

## 3.1 Distilled models generalize better and memorize less

### FineWeb utility

| Family | Model    | Validation loss | [[Perplexity\|PPL]] |
| ------ | -------- | --------------: | ------------------: |
| Pythia | Teacher  |            2.75 |               15.66 |
| Pythia | Baseline |            2.87 |               17.69 |
| Pythia | Student  |        **2.85** |           **17.31** |
| OLMo-2 | Teacher  |            3.41 |               26.34 |
| OLMo-2 | Baseline |            3.67 |               34.61 |
| OLMo-2 | Student  |        **3.44** |           **28.15** |
| Qwen-3 | Teacher  |            3.34 |               23.49 |
| Qwen-3 | Baseline |            3.65 |               33.23 |
| Qwen-3 | Student  |        **3.40** |           **25.65** |

Student는 세 계열 모두 같은 크기의 baseline보다 validation loss와 PPL이 낮다. 즉 memorization 감소가 단순히 덜 학습된 모델의 부산물이라는 설명과 맞지 않는다.

### Memorization rate

| 설정 | Teacher | Baseline | Student | Baseline 대비 student |
|---|---:|---:|---:|---:|
| Pythia / FineWeb | 0.33% | 0.17% | **0.07%** | 약 2.4배 감소 |
| Pythia / WikiText | 1.75% | 0.21% | **0.10%** | 약 2.1배 감소 |
| Pythia / Nemotron-CC-v2 | 0.05% | 0.0091% | **0.0012%** | 약 7.6배 감소 |
| OLMo-2 / FineWeb | 8.90% | 0.40% | **0.09%** | 약 4.4배 감소 |
| Qwen-3 / FineWeb | 3.45% | 0.86% | **0.26%** | 약 3.3배 감소 |

자연 데이터뿐 아니라 synthetic Nemotron에서도 방향이 같다. Temperature를 높일수록 student memorization은 더 감소한다. 단, 논문은 이 extraction 결과가 “낮은 temperature가 membership inference에 덜 취약하다”는 이전 연구와 다른 방향임을 지적한다. 두 연구가 측정하는 leakage가 다르므로 직접 모순으로 볼 수는 없다.

### Teacher-specific memorization inheritance

저자들은 **teacher와 student가 외우지만 baseline은 외우지 않은 예제**를 memorization inheritance로 정의한다. FineWeb/Pythia에서 teacher-only-relative-to-baseline 예제는 1,955개였지만 student가 이어받은 것은 18개, 약 0.9%뿐이다. Student가 validation 성능은 teacher의 guidance로 개선하면서도 teacher가 독점적으로 외운 구체적 sequence 대부분은 거부했다는 근거다.

## 3.2 Some examples are easier to memorize

같은 model family에서는 어떤 예제가 외워지는지가 상당히 결정적이다.

- Pythia 1B가 외운 예제의 96%가 1.4B baseline에서도 유지된다.
- Pythia 12B teacher는 1.4B baseline memorized set의 약 80%를 포함한다.
- 데이터 순서와 initialization을 바꾼 세 번의 독립 run에서도 baseline이 반복해서 외우는 core set이 존재한다.
- Baseline이 세 run 모두에서 외웠지만 student는 어느 run에서도 외우지 않은 예제가 494개다.

논문은 이처럼 scale과 seed를 넘어 반복해서 외워지는 예제를 **easy-to-memorize examples**라고 부른다. FineWeb에는 sequence-level duplicate가 제거되어 있으므로, 이 현상을 단순 중복 빈도로 설명하기 어렵다.

### Easy-to-memorize example의 성질

저자들은 다음 두 feature를 조사한다.

- **zlib entropy**: token sequence를 text로 decode한 뒤 zlib으로 압축한 byte length. 낮을수록 반복적·규칙적이어서 압축하기 쉽다.
- **Baseline perplexity**: baseline이 해당 sequence를 얼마나 자연스럽고 예측 가능하게 보는지 나타낸다.

Easy examples는 무작위 25,000개 훈련 예제와 비교했을 때 낮은 zlib entropy와 낮은 baseline PPL의 조밀한 cluster를 이룬다. 다만 zlib 값은 tokenizer로 decode한 text에 의존하므로 model-dependent하다.

Student가 외운 706개 중 676개(95.7%)는 teacher와 baseline도 함께 외운 easy examples다. 반대로 teacher와 baseline이 함께 외운 예제 중 696개를 student는 외우지 않는다. 따라서 distillation은 쉬운 예제 쪽으로 memorization을 집중시키면서, 그 안에서도 memorization threshold를 높이는 regularizer처럼 작동한다.

## 3.2.1 Model family마다 다른 easy examples

Pythia 1.4B, OLMo-2 1B, Qwen-3 1.7B를 같은 데이터와 hyperparameter로 학습했을 때 family 간 memorized example overlap은 0이었다. 큰 모델인 Pythia 12B, OLMo-2 7B, Qwen-3 8B 사이에서도 overlap이 없었다.

흥미롭게도 세 tokenizer로 계산한 example compressibility는 매우 높은 상관을 보였다.

- Pythia–Qwen-3 zlib entropy: Pearson $r=0.95$
- Pythia–OLMo-2: $r=0.96$
- Qwen-3–OLMo-2: $r=0.99$

즉 세 계열은 어떤 텍스트가 전반적으로 단순한지에는 거의 동의하지만, 그 낮은-entropy pool 중 어느 예제를 실제로 외울지에는 동의하지 않는다. Pairwise perplexity를 보면 한 family가 외운 예제는 다른 family에는 높은 perplexity인 경향이 있다. 저자들은 이를 tokenizer, attention bias 등 model-specific inductive bias의 결과로 해석한다.

# 4. Identifying Memorization Risks Before Distillation

## 4.1 Memorization classifier

Student를 직접 학습·audit하지 않고도 위험 예제를 찾기 위해 logistic regression을 사용한다. 입력 feature는 다음 네 가지다.

1. Teacher perplexity
2. Baseline perplexity
3. Teacher와 baseline output 사이의 KL divergence
4. Text의 zlib entropy

FineWeb/Pythia에서 student가 외운 706개를 positive, non-memorized example을 negative로 둔다. Class ratio는 1:3이며 30%를 test로 남긴다. 매 trial마다 negative examples를 다시 표본화하여 100회 반복한다.

| Metric | Mean ± std |
|---|---:|
| ROC-AUC | $0.9997\pm0.0005$ |
| Recall | $1.0000\pm0.0000$ |
| Precision | $0.9917\pm0.0059$ |

표준화 feature의 logistic coefficient는 teacher PPL $-0.3341$, baseline PPL $-0.4010$, zlib entropy $-4.5001$, teacher–baseline KLD $-1.0579$다. 모든 feature가 낮을수록 memorization 확률이 높고, 특히 zlib entropy가 가장 강한 predictor다.

확장 실험에서도 높은 ROC-AUC를 보인다.

| 설정 | ROC-AUC | Precision | Recall |
|---|---:|---:|---:|
| Pythia / WikiText | $0.9964\pm0.0010$ | $0.9515\pm0.0111$ | $0.9690\pm0.0095$ |
| OLMo-2 / FineWeb | $0.9999\pm0.0002$ | $0.9952\pm0.0040$ | $1.0000\pm0.0000$ |
| Qwen-3 / FineWeb | $0.9999\pm0.0002$ | $0.9963\pm0.0017$ | $1.0000\pm0.0000$ |

Pythia/WikiText에서는 teacher PPL의 coefficient 절댓값이 가장 크고, OLMo-2와 Qwen-3/FineWeb에서는 zlib entropy가 가장 크다. 따라서 feature의 상대적 중요도는 dataset과 family에 따라 바뀌지만, 낮은 complexity와 낮은 model surprise라는 방향은 유지된다.

## 4.2 Pre-filtering

Classifier가 위험하다고 예측한 집합 $\hat D_{mem}$을 원래 데이터에서 제거해 $D_{clean}=D\setminus\hat D_{mem}$을 만들고, 같은 teacher로 student를 다시 distill한다. 제거 뒤에는 기존 memorized set 대신 새로운 4개 예제가 외워졌다. 저자들은 이를 privacy onion effect, 즉 일부 memorized example을 제거하면 다음으로 취약한 예제가 새로 드러나는 현상과 일관된다고 본다.

논문 본문은 전체 memorized examples가 1,698개에서 4개로 줄어 99.8% 감소했다고 보고한다.

# 5. Why Does Distillation Reduce Memorization?

저자들은 teacher와 baseline은 외우지만 student는 외우지 않는 696개 예제를 분석한다. Cross-entropy는 one-hot hard target의 정답 token 확률을 계속 밀어 올리는 반면, forward KL은 teacher의 전체 soft distribution을 근사하게 한다는 차이에 주목한다.

마지막 50 tokens에 대해 token-level Shannon entropy와 sequence log-probability를 계산한다.

$$
H_t(x)=-\sum_{v\in V}p_\theta(v\mid x_{<t})\log p_\theta(v\mid x_{<t})
$$

$$
\bar H_\theta(x)=\frac{1}{K}\sum_{t=T-K}^{T-1}H_t(x),\qquad K=50
$$

관찰된 세 가지 regime은 다음과 같다.

1. **Teacher의 자연스러운 memorization**: 12B teacher는 해당 예제에서 낮은 entropy와 높은 log-probability를 보인다. 큰 모델이 예제를 확신 있게 예측한다.
2. **Baseline의 forced memorization**: 1.4B baseline은 높은 entropy, 즉 높은 불확실성을 유지하면서도 ground-truth sequence에 높은 log-probability를 준다. 저자들은 hard target cross-entropy가 capacity에 비해 복잡한 예제를 억지로 맞추게 해 [[Overfitting|forced memorization]]을 만든다고 해석한다.
3. **Student의 regularized response**: 같은 1.4B capacity의 student도 어려운 예제에서 entropy가 높지만 sequence log-probability는 낮다. Soft distribution matching은 student가 teacher의 확신을 재현하지 못할 때 더 평평한 distribution을 허용하므로 exact reproduction까지 밀어붙이지 않는다.

Student가 실제로 외운 예제는 teacher와 함께 낮은-entropy, 높은-confidence 영역에 모인다. 이 분석은 “distillation이 teacher의 모든 답을 덜 배우는 것”이 아니라 “student capacity로 자연스럽게 확신할 수 없는 예제에 one-hot certainty를 강제하지 않는 것”이라는 설명을 지지한다.

# 6. Soft vs. Hard Distillation

## 6.1 Hard distillation setup

Hard 또는 sequence-level distillation에서는 teacher logit을 쓰지 않는다. 각 원래 sequence의 첫 50 tokens를 teacher에 입력하고 206 tokens를 greedy generation하여 길이 256의 synthetic sequence를 만든다. 이 $D_{hard}$로 Pythia 1.4B student를 cross-entropy fine-tuning한다.

$$
\mathcal L_{hard}(\theta)
=-\mathbb E_{\hat x\sim D_{hard}}
\left[\sum_{t=1}^{T}\log P_\theta(\hat x_t\mid\hat x_{<t})\right]
$$

Teacher API가 logit을 노출하지 않는 black-box 환경에서도 사용할 수 있다는 실용적 장점이 있다.

원본 real-data validation PPL은 $D$로 학습한 baseline에 구조적으로 유리하므로, hard student와의 utility 비교에는 LAMBADA와 WinoGrande를 사용한다.

| Model | LAMBADA PPL | LAMBADA accuracy | WinoGrande accuracy |
|---|---:|---:|---:|
| Baseline | 9.41 | 51.85% | 55.72% |
| Hard student | **6.43** | **56.65%** | **57.46%** |

## 6.2 Memorization 결과

- Hard student: 0.07%
- Soft student: 0.07%
- Baseline: 0.17%
- Teacher: 0.33%
- Hard와 soft가 외운 예제의 약 70%가 겹친다.
- Hard student memorization의 약 90%는 teacher와 baseline도 함께 외운 easy examples다.

총 memorization rate만 보면 soft와 hard는 동일하다. 그러나 composition은 다르다. Hard-only 영역에서 soft student와 baseline 어느 쪽도 외우지 않은 46개 중 80%를 teacher가 외웠다. Teacher와 student가 외우고 baseline은 외우지 않은 inheritance는 hard에서 50개로, soft의 18개보다 약 2.7배 많다.

Hard distillation은 teacher의 greedy output을 새로운 one-hot training target으로 고정한다. 그러므로 soft distribution이 표현하던 uncertainty가 사라지고, baseline이 자연스럽게 외우지 않는 어려운 teacher-specific sequence까지 student에 전달될 가능성이 커진다.

# 7. Additional Results

## WikiText generalization

| Model | Validation loss | PPL |
|---|---:|---:|
| Pythia 12B teacher | 2.72 | 14.49 |
| Pythia 1.4B baseline | 2.82 | 16.33 |
| Pythia 1.4B student | **2.75** | **15.36** |

## Architecture·dataset별 memorization composition

Student memorization 중 teacher와 baseline이 함께 외운 easy examples의 비율은 Pythia/WikiText 88%, OLMo-2/FineWeb 85%, Qwen-3/FineWeb 70%다. Teacher에서 직접 상속된 예제의 비율은 각각 9%, 13%, 27%다. “대부분 easy examples”라는 경향은 유지되지만, Qwen-3에서는 teacher-specific inheritance가 상대적으로 더 크다.

## Pre-training distillation pilot

Fine-tuning뿐 아니라 pre-training continuation에서도 같은 방향인지 보기 위한 초기 실험이다.

- Teacher: Pythia 12B 116k checkpoint
- Student initialization: Pythia 2.8B 115k checkpoint
- Distillation data: teacher가 115k→116k 사이에 본 약 100만 예제
- Student: forward KL, $T=2$, 5 epochs
- Baseline: 공식 Pythia 2.8B 116k checkpoint

| Model | Memorized examples | Rate |
|---|---:|---:|
| Teacher 12B | 16,133 | 1.57% |
| Baseline 2.8B | 2,785 | 0.27% |
| Student 2.8B | **638** | **0.06%** |

Baseline memorized examples 2,785개 중 2,117개(76%)를 teacher도 외웠고, 이 중 student에 남은 것은 361개다. Student가 teacher와 baseline 어느 쪽도 외우지 않은 새로운 예제도 92개 있었다. KD가 memorization을 단순히 teacher set의 부분집합으로 만드는 것은 아니라는 점이 중요하다.

# 8. 핵심 기여

1. **Teacher–baseline–student 전체 추적**: student와 teacher만 비교하지 않고 같은 크기의 cross-entropy baseline을 두어 capacity와 objective의 효과를 구분했다.
2. **Utility와 memorization의 동시 개선**: 세 model family와 세 dataset에서 student가 baseline보다 validation 성능은 좋고 exact memorization은 적다는 일관된 결과를 보였다.
3. **Memorization의 composition 분석**: student가 teacher-specific memorization 대부분을 거르고, 남는 memorization은 teacher와 baseline이 함께 외우는 easy examples에 집중된다는 것을 set overlap으로 보였다.
4. **Data property와 inductive bias의 분리**: 낮은 zlib entropy라는 공통적 단순성에도 불구하고 model family마다 실제 memorized set이 겹치지 않음을 보여, memorization risk가 data-only property가 아님을 밝혔다.
5. **사전 위험 예측 가능성**: teacher·baseline과 text에서 얻는 간단한 feature로 student memorization을 높은 AUC로 분류하고, pre-filtering 가능성을 제시했다.
6. **Soft/hard KD의 privacy 차이**: 전체 memorization rate가 같아도 teacher-specific inheritance가 다를 수 있으므로 aggregate rate만으로 KD protocol을 평가하면 안 된다는 점을 보였다.

# 9. 관련 개념과 읽기 경로

- [[Knowledge Distillation]]: soft target, temperature, hard/soft KD의 일반 원리
- [[KL Divergence]]: 주 실험의 forward KL objective
- [[Cross-Entropy]]: teacher·baseline과 hard student의 training objective
- [[Softmax]]: temperature-scaled token distribution
- [[Perplexity]]: utility 평가와 memorization predictor
- [[Overfitting]]: baseline의 forced memorization 해석
- [[Large Language Model]]: 연구 대상 model family의 상위 개념
- [[Differential Privacy]]: 이 논문의 empirical leakage reduction과 구분해야 할 formal privacy framework
