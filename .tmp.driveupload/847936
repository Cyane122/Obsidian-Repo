---
type: paper
title: "CluSanT: Differentially Private and Semantically Coherent Text Sanitization"
authors:
  - "Ahmed Musa Awon"
  - "Yun Lu"
  - "Shera Potka"
  - "Alex Thomo"
year: 2025
venue: "NAACL 2025"
url: "https://aclanthology.org/2025.naacl-long.187/"
pdf: "[[40 Sources/Papers/NLP/CluSanT - Differentially Private and Semantically Coherent Text Sanitization.pdf]]"
status: read
read_date: "2026-08-22"
tags:
  - domain/nlp
  - task/text-rewriting
  - method/differential-privacy
  - theme/privacy-preservation
aliases:
  - "CluSanT"
---

# Abstract

CluSanT는 Metric Local Differential Privacy(MLDP)를 만족하는 텍스트 정제 framework다. 민감 token을 바꿀 때 먼저 의미적으로 가까운 cluster를 고르고, 그 안에서 대체 token을 뽑는다. cluster embedding의 계수 $k$를 조절하면 SanText의 강한 보호와 CusText의 높은 유용성 사이를 연속적으로 오갈 수 있다.

핵심은 CusText처럼 같은 cluster 안에서만 치환하면 유용성은 좋아지지만 표준 MLDP를 만족할 수 없다는 점이다. CluSanT는 덜 적합한 cluster도 작은 확률로 선택하도록 설계해 MLDP 보장을 유지한다. 저자들은 TAB 법원 판결문에서 의미 유사도, [[Perplexity]], GPT-4o 기반 문법·상식·응집성·일관성 평가, SST-2 sentiment classification으로 이 trade-off를 검증한다.

# 1 Introduction

텍스트 데이터가 늘면서 NLP에서 프라이버시 보호의 중요성도 커졌다. [[Differential Privacy]]는 강한 수학적 보장을 제공하지만, 텍스트에 적용하면 의미와 가독성이 쉽게 손상된다. 특히 사람이 읽을 수 있는 문장을 유지해야 하는 익명화에서는 프라이버시와 유용성의 균형이 핵심 과제다.

기존 대표 방식 두 가지는 서로 반대쪽에 놓여 있다.

- **SanText**는 민감 token을 전체 후보 집합에서 exponential mechanism으로 확률적으로 치환한다. MLDP를 만족하지만, 후보가 많아지면 품질이 낮은 대체어들의 확률 질량이 누적된다. 예를 들어 `Paris`의 적절한 대체어로 `Lyon`이 있더라도, 관련 없는 도시 이름이 많이 있으면 그중 하나가 선택될 가능성이 커진다.
- **CusText**는 유사한 token을 cluster로 묶고, 원래 token이 속한 cluster 안에서만 대체어를 뽑는다. 문맥에 맞는 치환이 늘어 유용성은 좋아지지만, 서로 다른 cluster의 출력 support가 겹치지 않아 표준 MLDP를 만족하지 못한다.

CluSanT는 이 둘 사이의 trade-off를 조절하는 framework를 제안한다. 민감 token의 대체어를 고를 때 우선 cluster를 사적으로 선택하고, 그 cluster 안에서 token을 선택한다. $k$가 커질수록 원래 token의 cluster가 선택될 확률이 높아져 유용성이 좋아지지만, cluster 간 구분 가능성도 커진다. 그럼에도 정리의 조건을 만족하는 설정에서는 MLDP가 유지된다.

## 1.1 Technical Challenges

저자들은 기존 연구의 문제와 대응 전략을 세 가지로 정리한다.

1. **SanText의 저품질 후보 누적**: 의미적으로 좋은 후보가 있어도 수많은 저품질 후보가 전체 확률을 잠식한다. CluSanT는 먼저 의미적으로 적절한 cluster를 높은 확률로 고른 뒤, 더 작은 후보 집합에서 치환한다.
2. **CusText의 보호 한계**: CusText는 cluster 안에서만 token을 고르므로 서로 다른 cluster의 입력을 쉽게 구별할 수 있다. CluSanT는 cluster embedding과 $k$를 이용해 cluster 선택 단계 자체를 MLDP 방식으로 무작위화한다.
3. **문장 품질의 미평가**: 기존 방법은 문법과 논리적 일관성을 충분히 다루지 않았다. 저자들은 사람이 읽을 수 있는 결과를 대상으로 의미 유사도와 [[Large Language Model|LLM]] 기반 품질 지표를 함께 평가한다.

## 1.2 Summary of Contributions

1. **조절 가능한 MLDP 정제 framework**: token clustering과 cluster embedding의 계수 $k$로 프라이버시·유용성 trade-off를 조절하는 CluSanT를 제안한다. SanText와 CusText를 각각 이 framework의 양 끝 사례로 설명한다.
2. **기존 방식에도 적용 가능한 실험 개선**: 민감 token 집합을 확장하고 multi-word phrase용 embedding을 도입하며, 의미 유사도와 문장 품질을 직접 측정한다.
3. **폭넓은 실험**: CluSanT의 여러 parameter setting을 SanText 및 CusText와 비교하여, CusText에 가까운 유용성을 얻으면서도 표준 MLDP를 유지할 수 있음을 보인다.

# 2 Related Works

가장 단순한 텍스트 정제 방식은 민감 요소를 직접 가리는 것이다. 그러나 이 방식은 문장의 유용성을 크게 낮출 수 있다. DP 기반 텍스트 정제는 quasi-identifier를 의미적으로 가까운 표현으로 바꾸는 대안을 제시하며, 이 계열의 대표 방법이 SanText와 CusText다.

RanText는 LLM prompt를 교란하기 위해 exponential mechanism 기반 token 치환을 사용한다. 다만 privacy guarantee는 특정 adjacency list 안의 token으로 한정된다. 이 목록은 partition이 아닐 수 있으므로 CusText나 CluSanT의 cluster 기반 보장과 직접 비교하기 어렵다. Carvalho et al. (2023)은 원래 단어 주변 반경 안에서 대체어를 고르려 했지만, 반경은 일반적으로 어휘를 disjoint cluster로 나누지 않으며, 저자들은 해당 구현 코드를 찾지 못해 실험 비교에서 제외했다.

이 논문은 민감 token을 임의로 고르는 대신 Text Anonymization Benchmark(TAB)를 사용한다. TAB는 European Court of Human Rights의 영어 법원 판결문 1,268건에 민감 정보 annotation을 붙인 corpus다.

텍스트 representation에 DP noise를 넣거나 adversarial training을 적용하는 연구는 사람이 읽을 수 없는 표현을 만들어 downstream ML pipeline에 쓰는 경우가 많다. CluSanT는 SanText·CusText와 마찬가지로 일반적인 용도로 읽을 수 있는 정제 텍스트를 만든다. token 단위 치환은 문법 오류와 제한된 syntax variation을 낳을 수 있어 GPT-2 paraphrasing이 대안으로 제시된 바 있다. 저자들은 두 방법이 경쟁 관계라기보다 보완적일 수 있다고 본다. 특히 법률 문서처럼 일정한 문장 구조가 필요한 경우 token 치환이 유용하며, `Britain`과 `British`처럼 문법적으로 다른 token을 별도 cluster에 두면 일부 오류를 줄일 수 있다.

# 3 Preliminaries

CluSanT는 민감하다고 판단한 token(예: `Paris`, `United States`)을 무작위로 바꾼다. 입력 token $x$를 정제한 출력 $y$만 보아서는 원래 입력이 $x$였는지 $x'$였는지를 구별하기 어렵게 만드는 것이 목표다.

## Local Differential Privacy와 Metric LDP

무작위 mechanism $M:X\rightarrow Y$가 $\epsilon$-LDP를 만족하려면 모든 $x,x'\in X$, $y\in Y$에 대해 다음이 성립해야 한다.

$$
\frac{\Pr[M(x)=y]}{\Pr[M(x')=y]} \leq e^{\epsilon}
$$

MLDP는 입력 간 거리를 반영해 유용성을 높인 확장이다. 거리 함수 $d:X\times X\rightarrow\mathbb{R}_{\geq0}$가 있을 때, $M$은 다음을 만족해야 한다.

$$
\frac{\Pr[M(x)=y]}{\Pr[M(x')=y]} \leq e^{\epsilon\cdot d(x,x')}
$$

서로 가까운 token은 출력만으로 더 구별하기 어렵게 만들고, 멀리 떨어진 token은 어느 정도 더 구별될 수 있도록 허용한다. 따라서 MLDP는 LDP보다 텍스트 치환의 의미 보존에 유리하다.

## Exponential Mechanism

Exponential mechanism은 입력 $x$에 대해 output $y$를 utility $u(x,y)$에 비례하는 확률로 뽑는다.

$$
\Pr[M_E(x)=y] = \frac{\exp(\epsilon_Eu(x,y)/(2\Delta u))}{\sum_{y'\in O}\exp(\epsilon_Eu(x,y')/(2\Delta u))}
$$

$\Delta u$는 utility sensitivity이고, 텍스트 정제에서는 보통 $u(x,y)=-d(x,y)$로 둔다. 즉 원본과 가까운 token일수록 뽑힐 가능성이 높다. 저자들은 다음 두 성질을 사용한다.

1. 두 입력에 대한 동일 output의 선택 확률 비율은 해당 output에 대한 utility 차이로 bound된다.
2. $\Delta u$를 sensitivity로 두면 mechanism은 $\epsilon$-LDP를 만족하고, $\Delta u=1$, $u(x,y)=-d(x,y)$이면 $\epsilon$-MLDP를 만족한다.

## Notation과 기존 방법

- $X$: 대상 텍스트에 등장하는 모든 token의 집합. 각 token은 $\mathbb{R}^{\ell}$의 embedding으로 표현한다.
- $X'$: 민감 token의 집합. 실험에서는 corpus에서 얻은 seed token을 비슷한 성격의 추가 token으로 확장한다.
- $Y$: 정제 mechanism의 output 집합. 공정한 비교를 위해 모든 실험에서 $Y=X'$로 둔다.
- $u$, $\Delta u$: 각각 utility function과 sensitivity.
- $M:X'\rightarrow Y$: token sanitization mechanism.

**SanText**는 $u(x,x')=-d(x,x')$, $\Delta u=1$인 exponential mechanism으로 $X'$ 안에서 token을 치환한다. 따라서 $\epsilon$-MLDP를 만족한다. 같은 논문의 SanText+는 비민감 token도 정제하지만, 더 많은 token을 바꾸면 유용성이 낮아지므로 저자들은 공정한 비교를 위해 SanText만 사용한다.

**CusText**는 어휘 $X$를 유사도에 따라 disjoint cluster로 나누고, 입력 $x$가 속한 cluster 안에서만 exponential mechanism을 수행한다. 이 제한된 domain에서는 $\epsilon$-LDP를 만족한다. 그러나 cluster가 둘 이상이면 일반적인 MLDP 또는 LDP를 만족할 수 없다. 서로 다른 cluster의 $x,x'$를 잡고 $x$의 cluster 안의 output $y$를 택하면 $\Pr[M(x)=y]>0$인 반면 $\Pr[M(x')=y]=0$이 되어, 확률 비율의 상한이 무한대로 발산하기 때문이다.

# 4 CluSanT: Cluster Exponential Mechanism with MLDP Guarantees

CluSanT는 먼저 token을 cluster로 묶고, 입력 $x$에 대해 cluster를 하나 고른 뒤 그 안에서 대체 token을 뽑는다. 어떤 clustering method를 쓰는지는 framework와 독립적이며, 보장은 clustering 자체의 품질이 아니라 정리의 parameter 조건에 의존한다.

## 4.1 Cluster Embedding

token embedding을 $f$, cluster embedding을 $f'$, $x$가 속한 cluster를 $C_x$라 하자. $C$의 centroid를 같은 기호로 쓰면 다음과 같다.

$$
C=\frac{1}{|C|}\sum_{x'\in C}f(x')
$$

CluSanT는 각 cluster와 token을 다음처럼 embedding한다.

$$
f'(C)=k\cdot C
$$

$$
f'(x)=k\cdot C_x+(f(x)-C_x)
$$

첫 식은 cluster centroid 사이의 거리를 $k$배로 벌리고, 둘째 식은 같은 cluster 안의 token이 centroid에서 떨어진 상대 위치를 보존한다. 따라서 $k$는 **cluster 선택 단계**만 바꾼다. 같은 cluster 안에서 token을 고르는 단계에는 표준 LDP mechanism을 쓰므로, 같은 cluster 안의 구별 가능성은 $k$에 따라 달라지지 않는다.

$k$가 커지면 원래 token의 cluster와 다른 cluster 사이 거리가 커진다. 이 때문에 더 적합한 cluster를 고를 확률이 높아져 유용성은 좋아진다. 반대로 서로 다른 cluster는 더 구별 가능해진다. 저자들은 이 효과를 MLDP의 거리 기반 guarantee 안에서 허용하되, Appendix D에서 보통의 LDP 관점에서는 $k$가 privacy leakage를 선형적으로 키운다고 정식화한다.

이 설계는 geo-indistinguishability의 직관을 따른다. 지리 정보에서는 가까운 지점의 반경이 자연스러운 cluster가 되듯, CluSanT는 word embedding의 의미·문법 유사도를 바탕으로 token cluster를 만든다. 다만 무엇을 유사하다고 볼지는 사용자가 정한다.

### 4.1.1 SanText와 CusText를 포함하는 parameter spectrum

CluSanT는 clustering, $k$, 거리 $d_c,d$를 바꾸어 여러 $\epsilon$-MLDP mechanism을 표현한다.

- **SanText**는 $k=1$, $d_c$는 Euclidean distance, 각 cluster에는 token 하나만 넣는 경우와 같다. 이때 첫 단계는 SanText의 전역 치환과 같고, 둘째 단계는 cluster에 token이 하나뿐이므로 아무 변화도 만들지 않는다.
- **CusText**는 CusText와 같은 clustering과 $d$를 쓰고 $d_c$를 Euclidean distance로 둔 채 $k\rightarrow\infty$로 보낼 때 점근적으로 얻어진다. 이 경우 첫 단계는 압도적으로 원래 cluster를 고르고, 둘째 단계가 CusText와 같은 cluster 내부 치환을 한다.

즉 CusText는 CluSanT의 유용성 쪽 극한이다. 다만 유한한 $k$를 쓰는 CluSanT는 MLDP를 유지하는 반면, CusText는 표준 MLDP를 만족하지 못한다.

## 4.2 Token Sanitization Mechanism과 MLDP Guarantee

입력은 민감 token $x\in X'$이고, 출력은 $Y$의 token이다. 전체 privacy budget $\epsilon$을 두 단계에 절반씩 나눈다.

1. **Cluster 선택**: input/output space를 전체 cluster 집합 $\{C\}$로 둔 exponential mechanism을 $\epsilon_E=\epsilon/2$로 실행한다. utility는 $u_c(C,C')=-d_c(C,C')$, sensitivity는 $\Delta u_c=1$이다.
2. **Cluster 내부 token 선택**: 선택한 cluster $C$ 안의 $C\cap Y$에서 $\epsilon_E=\epsilon/2$로 exponential mechanism을 실행한다. utility는 $u(x,x')=-d(x,x')$이고, sensitivity는 $\max(1,\max_{x,x',y\in X'}|d(x,y)-d(x',y)|)$다. 저자들이 쓴 MPNet embedding처럼 정규화된 embedding은 sensitivity가 이미 1일 수 있다.
3. 두 번째 단계에서 뽑힌 token을 반환한다.

Theorem 5는 다음 조건에서 이 mechanism이 embedding $f'$와 metric $d_c$에 대해 $\epsilon$-MLDP를 만족한다고 보인다.

- $d_c$가 metric일 것.
- 모든 $x,x'$에 대해 $d_c(x,x')\geq1$ 또는 $d_c(x,x')\geq d(x,x')$일 것.
- $C_x\neq C_{x'}$이면 $d_c(C_x,C_{x'})+1\leq2d_c(x,x')$일 것.

증명은 output $y$가 나올 확률을 cluster 선택 확률과, 해당 cluster 안에서 $y$를 고를 조건부 확률의 곱으로 분해한다. 입력 두 개가 같은 cluster에 있으면 첫 단계의 확률비가 1이고 둘째 단계의 LDP bound만 쓰면 된다. 서로 다른 cluster에 있으면 metric의 triangle inequality와 마지막 조건으로 두 단계의 지수를 합쳐 $e^{\epsilon d_c(x,x')}$ 이하임을 보인다.

# 5 Experiments

기존 연구는 정제 텍스트로 수행한 sentiment analysis 같은 downstream task 성능을 주로 평가했다. 이 논문은 정제 텍스트 자체의 의미 보존과 자연스러움을 더 직접적으로 평가한다.

## Metrics와 Dataset

- **Semantic similarity**: all-MiniLM-L6-v2 sentence embedder로 원문과 정제문 embedding의 cosine similarity를 구한다.
- **Perplexity**: GPT-2로 계산한다. 값이 낮을수록 일반적인 언어 패턴에 더 잘 맞아 자연스럽다고 본다.
- **GPT-4o 평가**: 문법, 상식성, coherence, cohesiveness를 각각 1~5점으로 채점한다. prompt는 네 항목의 정의와 함께 JSON만 반환하도록 지시한다.
- **데이터**: 민감 정보 annotation이 있는 TAB의 ECHR 영어 판결문 1,268건을 사용한다.

## Experimental Methodology

clustering은 CusText의 단순한 greedy 방법을 썼다. 아직 묶이지 않은 token 중 하나를 무작위로 고르고, 가장 유사한 $h-1$개를 같은 cluster에 넣은 뒤 이 과정을 반복한다. 각 cluster의 크기는 $h$로 같고, 실험에서는 cluster 수를 40, 180, 360, 720으로 바꿨다.

민감 token 집합 $X'$는 TAB의 민감 단어·구를 seed로 삼고, 각 seed마다 GPT-4o가 같은 종류의 단어·구 100개를 생성해 확장했다. 예를 들어 `Sinn Fein headquarters`에는 embedding만 비슷한 `Irish`가 아니라 `Labour Party headquarters`, `Conservative Party headquarters`처럼 실제 대체어가 될 수 있는 표현을 추가했다. SanText와 CusText는 제한된 민감 집합의 한계를 피하려고 비민감 단어도 대체어로 허용했지만, 이 때문에 `Sinn Fein headquarters`를 `Irish`로 바꾸는 식의 부자연스러운 치환이 생길 수 있다.

기존 방법이 단일 단어용 GloVe embedding에 의존한 것과 달리, 저자들은 multi-word phrase도 다룰 수 있는 all-MiniLM-L6-v2를 사용한다. 비교의 공정성을 위해 세 방법 모두 같은 $X'$와 같은 embedding, Euclidean distance를 사용했다.

## Numerical Results

heatmap은 $\epsilon\in\{0.5,1,2,4,8,16\}$, cluster 수, $k\in\{1,8,16,32,64,128\}$를 바꿔 SanText 대비 개선율을 보인다. 세로축은 cluster 수, 가로축은 $k$이며, CusText(CT)는 $k=\infty$인 특수 사례로 표시한다. 의미 유사도·상식성·coherence·문법·cohesiveness는 높을수록 좋고, perplexity는 낮을수록 좋다.

전반적인 경향은 명확하다. $k$와 cluster 수가 커질수록 CluSanT는 SanText보다 의미 유사도와 문장 품질에서 더 크게 개선되고 CusText에 가까워진다. CusText가 대부분 지표에서 조금 더 좋지만, 그 차이는 대체로 작고 표준 MLDP 보장을 잃는 대가가 있다. LLM 평가에는 noise가 있으므로 일부 setting에서는 더 작은 $k$가 우연히 더 높은 점수를 낸다.

본문에 제시한 $\epsilon=8$, 720 clusters의 수치를 보면 CluSanT $k=128$은 SanText보다 semantic similarity를 11.43% 높였고, CusText는 11.72% 높였다. 같은 조건에서 perplexity는 CluSanT가 5.22% 낮아졌고 CusText는 3.89% 낮아졌다. GPT-4o 평가의 SanText 대비 개선율은 common sense 71.11% 대 72.81%, coherence 39.12% 대 39.62%, grammar 21.09% 대 22.24%, cohesiveness 41.54% 대 41.84%였다. $\epsilon=16$에서는 CluSanT와 SanText 모두 원문과의 cosine similarity가 1에 가까워져, SanText 대비 개선 폭은 $\epsilon=8$보다 줄어든다.

## 치환 사례

TAB 판결문에서 $\epsilon=4$로 치환한 사례는 단어 수준 method의 차이를 잘 보여 준다.

| 방법 | cluster·$k$ | 평균 cosine similarity | 관찰 |
|---|---:|---:|---|
| SanText | 해당 없음 | 0.2264 | `Aliağa Public Prosecutor`를 `60,000 Norwegian kroner`로 바꾸는 등 문맥과 무관한 치환이 있었다. |
| CluSanT | 1,000 clusters, $k=16$ | 0.5718 | `Aliağa Public Prosecutor`를 `Manisa High Criminal Court`로 바꾸는 등 법률기관 범주를 더 잘 보존했다. |
| CluSanT | 1,000 clusters, $k=64$ | 0.6985 | 이 사례에서 가장 높은 평균 유사도를 보였다. `Republic of Turkey`를 `Republic of Slovenia`로 바꾸는 등 문맥상 더 자연스러운 대체어를 선택했다. |
| CusText | 1,000 clusters, $k\rightarrow\infty$ | 0.6703 | 대체로 합리적이지만 `Turkish Government`를 `Ottoman Empire`로 바꾸는 식의 의미 이탈도 있었다. |

이 사례만으로 일반적인 우열을 단정할 수는 없지만, 저자들이 주장하는 cluster 기반 후보 축소의 직관을 보여 준다.

## SST-2 Downstream Evaluation

저자들은 이미 학습된 binary sentiment classifier에 정제한 SST-2 validation set을 넣었다. CluSanT는 cluster 수 336에서 $k$를 바꾸었고, accuracy는 높을수록, loss는 낮을수록 좋다.

| $\epsilon$ | Method | $k$ | Accuracy | Loss |
|---:|---|---:|---:|---:|
| — | Unsanitized | — | 0.919540 | 0.263152 |
| 1 | SanText | — | 0.678161 | 1.467184 |
| 1 | CluSanT | 8 / 16 / 32 | 0.643678 / 0.666667 / 0.724138 | 1.762656 / 1.544436 / 1.129536 |
| 1 | CusText | — | 0.804598 | 0.828578 |
| 4 | SanText | — | 0.620690 | 1.799631 |
| 4 | CluSanT | 1 / 8 / 16 / 32 | 0.666667 / 0.712644 / 0.735632 / 0.793103 | 1.569011 / 1.466076 / 1.144738 / 1.056569 |
| 4 | CusText | — | 0.724138 | 1.346923 |
| 8 | SanText | — | 0.703561 | 1.394245 |
| 8 | CluSanT | 1 / 8 / 16 / 32 | 0.678161 / 0.689655 / 0.770115 / 0.793103 | 1.420536 / 1.543400 / 0.993965 / 0.860854 |
| 8 | CusText | — | 0.827586 | 0.760091 |
| 16 | SanText | — | 0.712644 | 1.474932 |
| 16 | CluSanT | 1 / 8 / 16 / 32 | 0.804598 / 0.850575 / 0.885057 / 0.882357 | 1.168481 / 0.564254 / 0.463717 / 0.463717 |
| 16 | CusText | — | 0.873563 | 0.486622 |

$\epsilon=1$에서는 낮은 $k$가 SanText보다도 낮은 accuracy를 낼 수 있지만, $k=32$는 0.724138로 SanText의 0.678161을 넘어선다. $\epsilon=4$에서는 $k=32$가 CusText보다 높은 accuracy와 낮은 loss를 보였다. $\epsilon=16$에서는 CluSanT $k=16$이 accuracy 0.885057, loss 0.463717로 CusText보다 정확도는 높고 loss는 낮았다. 이 표는 $k$를 키우면 SanText의 유용성 손실을 상당 부분 회복하면서도 MLDP를 유지할 수 있음을 보여 준다.

# 6 Conclusion

CluSanT는 token clustering, cluster embedding, 두 단계 token sanitization을 결합한 MLDP 텍스트 정제 framework다. $k$와 clustering을 바꾸어 SanText와 CusText 사이의 프라이버시·유용성 trade-off를 조절할 수 있고, 정리의 조건을 만족하면 clustering 방법과 무관하게 MLDP guarantee가 성립한다. 실험에서는 $k$와 cluster 수를 키울수록 SanText보다 의미 보존·자연스러움·downstream utility가 좋아지고 CusText에 가까워짐을 보였다.

# Limitations

- token 단위 정제는 polysemy를 충분히 다루지 못한다. sentence embedder는 `London, Ontario`와 `London, England`의 차이는 반영할 수 있어도, `Jordan`이 국가인지 사람 이름인지는 passage 전체의 의미를 보지 않으면 구별하기 어렵다.
- 민감 token 집합과 multi-word embedding은 개선했지만, clustering method는 CusText의 단순 방법 하나만 시험했고 거리도 주로 Euclidean distance만 사용했다. 최적의 clustering을 찾는 일은 어렵고 후속 연구 과제로 남는다.
- Theorem 5는 거리와 $k$의 관계에 관한 가정을 둔다. 흔한 거리 선택으로 만족할 수 있지만, 이 가정을 약화하는 것이 의미 있는 연구 방향이다.

# Appendix에서 확인한 보완 사항

CusText가 표준 LDP/MLDP를 만족하지 못한다는 증명은 서로 다른 cluster의 output support가 disjoint하다는 사실에 기초한다. 반대로 CluSanT의 Theorem 5 조건은 $d_c$를 Euclidean 같은 $L_p$ norm으로 두고 $k$를 충분히 크게 잡으면 만족시킬 수 있다. centroid와 token 사이의 거리는 $k$와 무관하게 유지되는 반면 cluster centroid 사이 거리는 $k$에 따라 커지기 때문이다.

Appendix D는 $d_c$가 $L_p$ norm일 때 보통 LDP 관점의 guarantee가 $\epsilon\Delta$-LDP가 됨을 보인다.

$$
\Delta=\max_{x,x'}d_c(f(x),f(x'))+k\cdot\max_{C,C'}d_c(f(C),f(C'))
$$

즉 $k$는 cluster 선택의 유용성을 높이는 동시에 일반 LDP 기준의 leakage bound를 선형으로 키운다. 이 결과는 "$k$를 키워도 MLDP가 유지된다"는 주장과 모순되지 않는다. MLDP는 입력 간 거리에 비례한 구별 가능성을 허용하는 반면, 일반 LDP는 모든 입력쌍에 같은 상한을 요구하기 때문이다.

부록은 GPT-4o에게 원래 민감 표현과 그 문맥을 주고 같은 category의 대체어 100개를 JSON list로 생성하게 한 prompt, 그리고 문법·상식성·coherence·cohesiveness를 각각 1~5점으로 JSON 응답하게 한 평가 prompt도 공개한다. 따라서 GPT-4o가 후보 집합 확장과 품질 평가에 모두 관여하며, LLM judgment의 noise가 작은 score 차이에 영향을 줄 수 있다는 점을 해석에 포함해야 한다.

# 관련 문서

- [[Differential Privacy]]: CluSanT가 사용하는 LDP·MLDP guarantee와 privacy budget의 기초 개념.
- [[Perplexity]]: 정제 텍스트의 자연스러움을 평가하는 지표.
- [[프라이버시 보존 텍스트 재작성]]: 단어 수준 MLDP 정제와 LLM 기반 재작성 연구를 함께 보는 흐름.
