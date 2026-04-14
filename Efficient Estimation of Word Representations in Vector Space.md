## 주요 정보
- 발표 연도: 2013년
- 저자: Tomas Mikolov 외
- tags: #NLP, #cbow, #skip-gram, #word-embedding, #word2vec, #distributed-representation
---
# Abstract
대규모 데이터셋에서 단어의 연속 벡터 표현([[Distributed Representation]])을 학습하기 위한 두 가지 새로운 모델 아키텍처를 제안한다.
- 표현의 품질은 단어 유사도 task로 측정하며, 기존 [[Neural Network Language Model|NNLM]] 기반 기법들과 비교함
- 훨씬 낮은 계산 비용으로 큰 정확도 향상을 달성
	- 16억 단어 데이터셋에서 고품질 word vector 학습에 하루도 걸리지 않음
- 학습된 벡터는 syntactic / semantic 유사도 측정 테스트셋에서 state-of-the-art 달성.

> [!note] 한 마디로 정리하면
> "기존보다 훨씬 싸게, 훨씬 잘 되는 word vector 학습법을 만들었다!"
> 성능이랑 효율, 두 마리 토끼를 동시에 잡았다는 뜻.

# Introduction
## 기존 NLP의 한계
대부분의 NLP 시스템은 단어를 원자 단위로 취급하며, 단어 사이의 유사도 개념이 없다.
단어를 어휘 내 인덱스([[One-hot Encoding]])으로 표현하는 방식은 다음과 같은 이유로 선택되어 왔다.
- 단순성과 견고성
- 대규모 데이터에 훈련된 단순 모델이 소규모 데이터의 복잡한 모델을 능가하는 경우가 많음
그러나, 단순한 기법은 현재 한계에 직면하고 있다.
- 음성 인식: 고품질의 데이터가 수백만 단어 수준으로 제한적이다.
- 기계 번역: 다수 언어 쌍에서 말뭉치 규모가 수십억 단어 이하이다.
- 단순 스케일업으로는 유의미한 성능 향상이 어렵다.

## 연구 목표
수십억 단어, 수백만 어휘 규모의 데이터에서 고품질 [[Word Embedding|word vector]]를 효율적으로 학습하는 방법을 제안한다. 기존 아키텍처들은 수억 단어 수준, 벡터 차원 50~100 규모를 넘어서지 못했다.
단순한 유사도를 넘어, 단어 벡터 사이의 선형 연산으로 의미 관계를 포착하는 것을 목표로 한다.
$$\displaystyle \vec{\text{King}} - \vec{\text{Man}} + \vec{\text{Woman}} ≈ \vec{\text{Queen}}$$
이러한 선형 규칙성([[Distributed Representation]]의 핵심 특성)을 최대한 보존하는 아키텍처를 설계하고, syntactic / semantic 규칙성을 모두 측정하는 새로운 데이터셋을 제안한다.

## 이전 연구
- Bengio et al. (2003): Feedforward [[Neural Network Language Model|NNLM]] 제안 - 투영층 + 비선형 은닉층으로 word vector와 언어 모델을 동시 학습
- Mikolov (2007, 2009): 단일 은닉층 신경망으로 word vector를 먼저 학습한 뒤 NNLM에 활용
- 이후 다양한 아키텍처가 제안되었으나 대부분 계산 비용이 높음

> [!note] 흐름을 정리하면
> 1. 기존 방법은 싸고 단순하지만 한계가 있다.
> 2. 복잡한 모델은 비싸다.
> 3. 그러면 저렴하면서 잘 되는 걸 만들어볼까?

# Model Architectures
모델 비교의 기준으로 계산 복잡도를 사용하자.
$$O = E \times T \times Q$$
- $E$: 학습 에폭 수 (일반적으로 3 ~ 50)
- $T$: 학습 데이터 단어 수 (일반적으로 최대 약 10억)
- $Q$: 아키텍처별 정의

모든 모델은 [[Backpropagation]]을 통한 [[Stochastic Gradient Descent]]로 학습한다.

## Feedforward NNLM
[[Neural Network Language Model]]의 구조. 입력층 → 투영층 → 은닉층 → 출력층의 구조를 따른다.
- 입력: 이전 $N$개 단어를 [[One-hot Encoding]]으로 인코딩
- 투영층 크기: $N \times D$ (공유 투영 행렬 사용)
- 은닉층 크기: $H$ (일반적으로 500 ~ 1000)
- 출력층: 전체 어휘 $V$에 대한 확률 분포
$$Q = N \times D + N \times D \times H + H \times V$$
지배적 항은 $H \times V$이나, [[Hierarchical Softmax]] 적용 시 $H \times \log_2 (V)$로 감소하므로 실질적인 병목 항은 $N \times D \times H$항이 된다.

## Recurrent NNLM
[[Recurrent Neural Networks]] 기반 언어 모델이다. 고정 문맥 길이 $N$의 제약을 재귀 연결로 극복한 점이 특징이다.
- 투영층이 없으며, 입력층 → 은닉층(재귀) → 출력층의 구조를 따른다.
- 단어 벡터 차원 $D$은 은닉층의 크기 $H$와 동일하다.
$$Q = H\times H + H \times V$$
[[Hierarchical Softmax]] 적용 시 $Q = H\times H + H \times \log_2V$이므로 실질적인 병목 항은 $H \times H$항이다.

## 두 모델의 공통 한계
두 아키텍처 모두 비선형 은닉층이 계산 복잡도의 핵심 원인이다.
이 논문은 은닉층을 제거한 경량 구조인 [[Continuous Bag-of-Words]], [[Skip-gram]]으로 복잡도를 극적으로 낮추는 것을 핵심 아이디어로 삼는다.

> [!TIP] $Q$의 의미
> $Q$는 학습 예제 하나당 복잡도이다.
> 전체 복잡도 $O = E \times T \times Q$에서 $T$가 수십억에 달하므로, $Q$를 조금만 줄여도 전체 비용이 크게 줄어든다.

# New Log-linear Models
## 핵심 아이디어
계산 복잡도의 주요 원인은 비선형 은닉층이었다. 은닉층은 신경망의 표현력을 높인다는 장점이 있지만, 그만큼 계산량도 커진다. 따라서 은닉층을 제거한 두 가지 log-linear model을 제안한다.

학습은 두 단계로 분리된 선행 연구의 접근을 따른다:
1. 단순한 모델로 연속 word vector를 먼저 학습
2. 학습된 word vector 위에 N-gram NNLM을 추가 학습.

본 논문은 1단계에만 집중해 이를 최대한 효율적으로 수행하고자 한다.

## CBOW
[[Continuous Bag-of-Words]]는 [[Neural Network Language Model]]에서 비선형 은닉층을 제거하고, 투영층을 모든 단어가 공유하는 구조이다.
- 입력: 중심 단어 앞뒤 각 $N$개 단어. (총 $2N$개)
- 문맥 단어 벡터들을 평균하여 중심 단어를 예측
- 단어 순서를 고려하지 않음
- 실험에서는 앞뒤 각 4개, 총 8개 단어를 사용.
$$Q=N\times D + D \times \log_2 (V)$$

## Skip-gram
[[Skip-gram]]는 CBOW와 반대로, 중심 단어로 주변 문맥 단어들을 예측한다.
- 입력: 중심 단어 하나.
- 최대 거리 $C$ 내에서 무작위로 $R$을 샘플링하여, 앞뒤 각 $R$개 단어를 예측
	- 거리가 먼 단어일수록 샘플링 확률이 낮아짐.
- 하나의 학습 단어당 $R\times 2$회의 분류 수행
- 실험에서는 $C=10$ 사용.
$$Q = C \times (D + D \times \log_2 (V))$$
> [!TIP] $C$의 역할
> $C$는 고정 윈도우 크기가 아니다. 매 학습 스텝마다 $1~C$ 사이에서 $R$을 무작위로 샘플링한다.
> 따라서, 가까운 단어가 자연스럽게 학습에 더 자주 등장한다.

## 모델의 복잡도 비교
| 모델               | 병목 항                          |
| ---------------- | ----------------------------- |
| Feedforward NNLM | $N \times D \times H$         |
| RNNLM            | $H \times H$                  |
| CBOW             | $D \times \log_2 (V)$         |
| Skip-gram        | $C \times D \times \log_2(V)$ |

# Results
## 테스트셋 설계
기존 word vector 평가 방식은 유사 단어 목록을 직관적으로 비교하는 수준에 머물렀다. 이 논문은 syntactic / semantic 두 축을 모두 정량적으로 측정하는 새로운 테스트셋을 제안한다.

## 구성
- Semantic 질문 5종 / Syntactic 질문 9종
- 총 8869개 semantic + 10675개 syntactic 질문
- 질문 형식: 두 단어 쌍 사이의 관계를 벡터 연산으로 답하는 유추(analogy) task.
	e.g. `Athens:Greece = Oslo:? -> Oslo - Athens + Greece의 최근접 벡터.`

## 평가 기준
- 정답 단어와 정확히 일치하는 경우에만 정답으로 인정 (synonyms = 오답)
- 100% 달성은 사실상 불가능 (형태론적 정보가 없기 때문에)
- 이 평가 기준의 상대적 순위는 downstream task 성능과 양의 상관관계를 가진다고 가정한다.

## 정확도 최대화 실험
Google News Corpus(약 60억 토큰), 어휘 100만 단어로 학습했다.
핵심 관찰
- 벡터 차원과 학습 데이터 양, 둘 다 늘려야 정확도가 오른다. 어느 한 쪽만 늘리면 어느 순간부터 정확도 향상 폭이 점점 작아진다.
- 데이터를 2배 늘리는 것과 벡터 차원을 2배 늘리는 것은 계산 복잡도 증가량이 거의 동일하다.
	- 지배항 $D\times \log_2(V)$에서, $T$가 2배가 되어도, $D$가 2배가 되어도 전체 복잡도인 $O=E \times T \times Q$는 똑같이 2배가 되기 때문이다.

## 아키텍처 비교
동일 데이터(320M 단어), 동일 차원(640)에서 비교했다.
결과 분석
- RNNLM: syntactic에서만 선전. semantic에서 현저히 약했다.
- NNLM: RNNLM 대비 전반적으로 우수했다. word vector가 비선형 은닉층과 직접 연결되기 때문이다.
- CBOW: syntactic에서 NNLM을 압도했으며, semantic은 유사했다.
- Skip-gram: semantic에서 모든 모델 중 압도적 우위이며, syntactic은 CBOW보다 조금 약했다.

 > [!note] CBOW vs Skip-gram 성능 차이
> CBOW는 문맥을 평균냄 → 문법적 패턴(syntactic)을 잡는 데 유리함!
> Skip-gram은 단어 하나로 여러 문맥을 예측하므로, 의미 관계(semantic)를 풍부하게 학습함.

## 학습 효율 실험
3 epochs vs 1 epoch으로 데이터량 및 차원 변화를 교차 비교했다.
결과 분석
- 같은 데이터를 3번 반복하는 것보다 2배 많은 데이터를 1번 학습하는 것이 비슷하거나 더 나은 성능을 보였다.
- 학습 시간도 단축되므로, 대규모 학습에서는 1 epoch + 데이터 확장 전략이 더 유리하다.

## 대규모 분산 학습
DistBelief 프레임워크, Google News 60억 토큰, 1000차원 벡터
결과 분석
- CBOW, Skip-gram 모두 NNLM 대비 압도적으로 짧은 학습 시간으로 더 높은 정확도를 달성했다.
- 분산 환경에서는 단일 머신 대비 CBOW와 Skip-gram의 속도 차이가 줄어든다(분산 오버헤드가 지배적이기 때문이다).

## Microsoft Sentence Completion Challenge
1040개 문장에서 빈칸에 가장 적절한 단어를 5지선다로 고르는 task.
결과 분석
- Skip-gram 단독으로는 LSA 유사도 기반 모델과 유사한 수준.
- RNNLM 결과와 결합 시, state-of-art인 58.9% 달성.
- Skip-gram의 점수가 RNNLM과 상호 보완적이라는 점을 시사한다. (두 모델이 서로 다른 종류의 정보를 포착함.)

# Conclusion
단순한 log-linear 모델([[Continuous Bag-of-Words]], [[Skip-gram]])으로도 기존 복잡한 [[Neural Network Language Model]]을 능가하는 고품질 [[Word Embedding]]을 학습할 수 있음을 보였다.
- 은닉층 제거로 계산 복잡도를 대폭 낮추면서도 표현 품질은 오히려 향상
- DistBelief 분산 프레임워크 적용 시 1조 단어 규모의 말뭉치, 무제한 어휘 크기로의 확장이 가능!