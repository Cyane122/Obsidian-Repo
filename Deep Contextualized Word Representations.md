## 주요 정보
- 발표 연도: 2018년
- 저자: Matthew E.Peters 외
- tags: #ELMo , #contextualized-embedding, #biLM, #biLSTM, #transfer-learning, #NLP, #word-representation, #semi-supervised
---
# Abstract
기존 [[Word2Vec]], [[GloVe - Global Vectors for Word Representation|GloVe]] 등의 사전 학습 단어 표현은 단어마다 하나의 고정된 벡터를 부여한다. 이 논문은 다음 두 가지 한계를 동시에 해결하는 새로운 단어 표현 방식을 제안한다.
1. 단어 사용의 복잡한 특성 (구문론적, 의미론적 정보) 포착
2. 문맥에 따른 의미 변화 포착 (다의어 처리)
이를 위해 대규모 텍스트 말뭉치에서 사전 학습된 [[bidirectional Language Model]]의 내부 상태를 활용하는 ELMo(Embeddings from Language Models) 표현을 제안한다. ELMo는 biLM의 모든 내부 레이어를 선형 결합하여 단어 표현을 구성한다는 점에서 기존 방식과 구별된다.
기존 NLP 모델에 ELMo를 추가하는 것만으로 QA, textual entailment, sentiment analysis 등 6개 task에서 SOTA를 갱신하였다.

# Introduction
## 기존 Word Embedding의 한계
사전 학습된 [[Word Embedding]]([[Word2Vec]], [[GloVe - Global Vectors for Word Representation|GloVe]] 등)은 대부분의 NLP 모델에서 핵심 구성 요소로 사용된다. 그러나 기존 방식은 단어마다 하나의 고정된 표현만을 부여하므로 두 가지 문제를 해결하지 못한다.
1. 문맥 독립성: 동일한 단어가 문맥에 따라 다른 의미를 가질 수 있음에도, 항상 동일한 벡터가 부여된다.
2. 단층 표현: 구문론적 정보와 의미론적 정보가 하나의 벡터에 혼재되며, 레이어별로 분리된 정보(polysemy를 활용할 수 없다.

## ELMo의 제안
이 논문은 위 두 문제를 동시에 해결하는 ELMo (Embeddings fro Language Models)를 제안한다. ELMo의 핵심 특성은 다음과 같다.
- 각 토큰의 표현이 입력 문장 전체의 함수로 결정됨 (문맥 의존적)
- 대규모 텍스트 말뭉치에서 사전 학습된 [[bidirectional Language Model]]의 내부 레이어를 모두 활용
- 기존 모델에 쉽게 추가 가능

## 기존 Contextualized Representation과의 차이
기존의 모델들도 문맥 의존 표현을 학습하지만, biLM 또는 MT 인코더의 최상위 레이어만을 활용했다. ELMo는 모든 내부 레이어의 표현을 task별로 가중합산한다는 점에서 구별된다.
이 차이가 중요한 이유는 레이어마다 인코딩하는 정보의 종류가 다르기 때문이다.
- 하위 레이어: syntax 관련 정보
- 상위 레이어: semantic 관련 정보
모든 레이어를 동시에 노출함으로써, downstream 모델이 task에 필요한 semi-supervision signal을 선택적으로 활용할 수 있다.

# Method
## [[Bidirectional Language Model]]
Forward LM과 Backward LM의 log likelihood를 최대화하는 방식으로 학습되는 모델이다. Token 표현 파라미터 $\theta_x$와 [[Softmax]] 파라미터 $\theta_s$는 양방향이 공유하며, LSTM 파라미터는 방향별로 독립 유지된다.

## ELMo
ELMo는 [[bidirectional Language Model]]의 중간 레이어 표현들을 task별로 결합한 단어 표현이다.

### 레이어 표현 집합
$L$층 biLM은 각 토큰 $t_k$에 대해 $2L+1$개의 표현을 생성한다.
$$R_k = \{h_{k, j}^{LM} | j = 0, \cdots, L \}$$
여기서 $j=0$은 문맥 독립적인 Token Embedding (입력층), $j \geq 1$은 각 biLSTM 레이어의 결합 표현이다.

### Task별 가중 합산
Downstream task에 활용할 때, 모든 레이어를 단일 벡터로 압축한다.
$$\mathrm{ELMo}_k^{task} = \gamma^{task} \displaystyle \sum_{j=0}^L s_j^{task} h_{k, j}^{LM}$$
- $s_j^{task}$: softmax-normalized 레이어 가중치. task마다 학습됨.
- $\gamma^{task}$: ELMo 벡터 전체를 스케일링하는 scalar 파라미터로, 최적화를 돕기 위해 도입되었다.
가장 단순한 경우는 최상위 레이어만 선택하는 것($E(R_k) = h_{k, L}^{LM}$)이며, ELMo는 이를 일반화한 형태다.
레이어별로 activation 분포가 다를 수 있으므로, 경우에 따라 각 biLM 레이어에 Layer Normalization을 적용하기도 한다.
>[!note] $\gamma$의 역할
>biLM 내부 표현과 downstream task 표현의 분포가 다르면 그냥 합쳤을 때 최적화가 잘 되지 않는다. $\gamma$가 그 스케일 차이를 보정해주는 역할을 수행한다.
>없으면 학습이 아예 실패해버리기도 한다.

## Using biLMs for Supervised NLP Tasks
사전 학습된 biLM을 supervised NLP task에 적용하는 방법은 다음과 같다.

### 기본 적용 방식
대부분의 supervised NLP 모델은 최하위 레이어에서 동일한 구조를 공유한다. 토큰 시퀀스 $(t_1, \cdots, t_N)$에 대해 문맥 독립적 표현 $x_k$를 만들고, 이를 bidirectonal RNN 등으로 처리하여 문맥 의존 표현 $h_k$를 생성하는 구조다.

ELMo를 추가하는 절차는 단순하다.
1. biLM 가중치를 freeze한 채로 각 토큰의 모든 레이어 표현을 추출
2. $x_k$에 $\mathrm{ELMo}^{task}_k$를 concatenate하여 task RNN의 입력으로 사용: $[x_k;\mathrm{ELMo}_k^{task}]$

### 출력층 추가 적용
일부 task(SNLI, SQuAD)에서는 task RNN의 출력 $h_k$에도 ELMo를 추가하면 성능이 더 향상된다.
$$h_k \rightarrow [h_k; \mathrm{ELMo}_k^{task}]$$
단, task에 따라 효과가 다르므로 입력층 적용이 기본이고, 출력층은 선택적으로 적용한다.

### 정규화
- ELMo 표현에 적당한 수준의 Dropout 적용
- 경우에 따라 $\gamma ||w||^2_2$ 정규화 항을 추가하여, 레이어 가중치가 uniform average에 가깝게 유지되도록 유도한다.

## Pre-trained biLM Architecture
이 논문에서 사용한 biLM의 구체적인 아키텍처 설계를 설명한다.

### 기본 설계 방향
CNN-BIG-LSTM(Jozefowicz et al., 2016)을 기반으로 하되, 양방향 동시 학습과 레이어 간 residual connection을 추가하였다. 전체 모델 크기와 downstream task의 계산 비용을 고려해 임베딩 및 hidden 차원을 절반으로 축소했다.

### 최종 아키텍처
- biLSTM 레이어 수 $L=2$
- 각 LSTM: 4096 untis, 512차원 projection, 1번째-2번째 레이어 간 residual connection
- Token 표현: 2048개의 character n-gram CNN filter -> 2개의 Highway layer -> 512차원 linear projection

Character 기반 입력을 사용하므로 학습 데이터에 없는 단어(`OOV`)에 대해서도 표현을 생성할 수 있다. 기존 Word Embedding 방식이 각 토큰에 1개의 레이어만 제공하는 것과 달리, 이 biLM은 토큰당 3개의 레이어 표현을 제공한다.

### 사전 학습 결과
1B Word Benchmark (Chelba et al., 2014)에서 10 epoch 학습 후 forward/backward perpelxity 평균 39.7을 달성했다. 원본 단방향 perplexity 30 대비 다소 높으나, 모델 크기를 절반으로 줄인 것을 감안한 trade-off.

### Domain Fine-tuning
특정 task의 도메인 데이터로 biLM을 fine-tuning하면 perplexity가 크게 감소하고 downstream 성능도 향상된다. 대부분의 실험에서 fine-tuned biLM을 사용하였다.

# Evaluation
6개의 NLP task에 ELMo를 추가한 결과, 모든 task에서 SOTA를 갱신했다. Error reduction은 6~20% 범위.
- SQuAD: BiDAF 기반 Baseline에 ELMo 추가 시 F1 + 4.7%.
- SNLI: ESIM 모델에 추가했다. 5개 ensemble은 89.3%로 기존 88.9% 초과.
- SRL: 8-layer deep biLSTM 모델에 추가 시 single model이 기존 ensemble best를 1.2% F1 초과.
- Coference Resolution: End-to-end span-based 모델에 추가. 기존 ensemble best를 single model이 1.6% F1 초과.
- [[Named Entity Recognition]]: biLSTM-CRF에 추가. 모든 레이어 활용의 효과가 핵심.
- SST-5: CoVe 기반 BCN 모델에서 CoVe를 ELMo로 교체. 1.0% 향상.

# Analysis
## Alternate Layer Weighting Schemes
모든 레이어를 사용하는 것이 최상위 레이어만 사용하는 것보다 일관되게 성능이 높음이 확인되었다.

| 설정                           | SQuAD | SNLI | SRL  |
| ---------------------------- | ----- | ---- | ---- |
| Baseline                     | 80.8  | 88.1 | 81.6 |
| Last layer only              | 84.7  | 89.1 | 84.1 |
| All layers ($\lambda = 1$)   | 85.0  | 89.3 | 84.6 |
| All layers ($\lambda=0.001$) | 85.2  | 89.5 | 84.8 |
- 최상위 레이어만 써도 baseline 대비 향상되지만, 모든 레이어를 쓰면 추가 향상됨
- $\lambda$가 작을수록 (즉, 레이어 가중치를 자유롭게 학습할수록) 성능이 소폭 더 좋아짐
- CoVe도 동일한 경향을 보이나, 향상 폭이 ELMo보다 작음.

## Where to Include ELMo?

| 적용 위치          | SQuAD | SNLI | SRL  |
| -------------- | ----- | ---- | ---- |
| Input only     | 85.1  | 88.9 | 84.7 |
| Input + Output | 85.6  | 89.5 | 84.3 |
| Output only    | 84.8  | 88.7 | 80.9 |
- SNLI, SQuAD는 Input & Output 모두 적용했을 때 성능이 가장 높았다. 두 task 모두 biRNN 이후 attention layer가 존재하므로, output에 ELMo를 추가하면 attention이 biLM 내부 표현을 직접 참조할 수 있기 때문으로 보인다.
- SRL은 input only가 최적이었다. Task-specific context 표현이 biLM 표현보다 더 중요한 task로 보인다.

## What Information is Captured?
biLM의 레이어별 인코딩 특성을 POS tagging과 WSD를 probe로 삼아 분석하였다.
- WSD: biLM 2층(상위)이 1층(하위)보다 [[F1 Score]]가 높다 -> 상위 레이어가 의미론적 정보를 더 잘 인코딩한다.
- POS tagging: biLM 1층이 2층보다 [[Accuracy]]가 높다 -> 하위 레이어가 구문론적 정보를 더 잘 인코딩한다.
- 논외로, 두 평가 모두에서 biLM이 CoVe보다 높은 성능을 보였다.

## Sample Efficiency
ELMo 추가 시 학습 효율이 크게 향상됐다.
- SRL 기준 ELMo 없이 최고 성능 도달에 486 epoch가 필요했지만, ELMo 추가 시 10 epoch로 동일한 성능을 달성할 수 있었다.
- 학습 데이터가 적을수록 이 효과는 더 두드러졌다. SRL에서 baseline과 함께 10%의 데이터를 추가한 것은 ELMo와 함께 1% 정도의 데이터를 늘린 것과 유사했다.

## Learned Weights
task별로 학습된 레이어 가중치 분포를 분석한 결과,
- Input layer: 대체로 1번째 biLSTM 레이어를 선호했다. Coreference, SQuAD에서 특히 강하게 집중되었다.
- Output layer: 레이어 간 가중치가 비교적 균등하게 분포되며, 하위 레이어를 소폭 선호했다.

# Conclusion
깊은 문맥 의존 표현을 biLM으로부터 학습하는 일반적인 방법론을 제안했다. ELMo를 다양한 NLP task에 적용한 결과, 모든 task에서 성능이 크게 향상되었으며 biLM의 레이어별 표현이 서로 다른 종류의 구문론적, 의미론적 정보를 효율적으로 인코딩함을 실험을 통해 확인했다. 모든 레이어를 활용하는 것이 전체 task 성능 향상에 핵심적임을 ablation을 통해 검증하였다.