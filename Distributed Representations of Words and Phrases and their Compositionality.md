## 주요 정보
- 발표 연도: 2013년
- 저자: Tomas Mikolov 외
- tags: #NLP, #word2vec, #skip-gram , #word-embedding , #negative-sampling, #phrase-representation
- ---
# Abstract
[[Skip-gram]] 모델의 여러 확장을 제안하여 벡터 품질과 학습 속도를 동시에 개선한다.
- [[Subsampling of Frequent Words]]: 학습 속도를 크게 향상시키고, 저빈도 단어 표현의 품질을 개선.
- [[Negative Sampling]]: [[Hierarchical Softmax]]를 대체하는 단순하고 효율적인 학습 목표 함수.

단어 표현의 근본적 한계는 단어의 순서를 무시하고, 관용구를 표현하지 못한다는 점이다. "Canada"와 "Air"의 의미를 조합해도 "Air Canada"가 나오지 않는 것이 대표적인 예다. 이를 해결하기 위해 텍스트에서 구(phrase)를 탐지하는 간단한 방법을 제안하고, 수백만 개의 구에 대해 고품질 벡터 표현을 학습할 수 있음을 보인다.

# Introduction
## 배경
벡터 공간에서의 단어 분산 표현([[Word Embedding]])은 유사한 단어를 군집화하여 NLP task의 성능을 높인다. 단어 표현의 역사는 Rumelhart et al. (1986)의 [[Backpropagation]] 연구까지 거슬러 올라가며, 이후 통계적 언어 모델링, 음성 인식, 기계번역 등 광범위한 역사에 적용되었다.

[[Skip-gram]] 모델은 대규모 비정형 텍스트에서 고품질 단어 벡터를 효율적으로 학습한다. 밀집 행렬 연산(dense matrix multiplication)이 없어 학습이 매우 효율적이며, 단일 머신으로 하루에 1000억 단어 이상을 처리할 수 있다.

## 학습된 벡터의 특성
신경망으로 학습된 단어 표현은 다양한 언어적 규칙성(linguistic regularity)를 인코딩한다. 특히 많은 패턴이 선형 변환으로 표현된다:
`vec("Madrid") - vec("Spain") + vec("France") ≈ vec("Paris")`

## 기여
1. [[Subsampling of Frequent Words]]: 학습 속도 2~10배 향상. 저빈도 단어 표현 품질 개선.
2. [[Negative Sampling]]: [[Noise Contrastive Estimation]]의 단순화 변형. 기존 [[Hierarchical Softmax]]보다 빠르고, 빈출 단어에 대해 더 좋은 벡터를 학습.
3. 구(phrase) 표현 학습: 단어 단위 모델을 구 단위로 확장. "Air Canada", "Boston Globe"와 같이 개별 단어 의미의 합으로 환원되지 않는 표현을 단일 토큰으로 처리.
4. Additive Compositionality: 벡터 덧셈만으로 의미 있는 합성이 가능함을 발견.

> [!note] 3번과 4번은
> phrase token으로 직접 학습하는 게 기여 3번, 그게 없어도 벡터 덧셈으로 어느 정도 의미가 합성이 된다는 게 기여 4.
> 즉, 두 접근을 같이 사용하면 긴 텍스트 표현도 꽤 강력해진다.

# The Skip-gram Model
## 학습 목표
Skip-gram 모델의 목표는 문장 내 주변 단어들을 잘 예측하는 단어 표현을 찾는 것이다. 학습 단어 시퀀스 $w_1, w_2, \cdots, w_T$가 주어졌을 때, 평균 로그 확률을 최대화한다.
$$\dfrac{1}{T} \displaystyle \sum_{t=1}^T \sum_{-c\geq j \geq c, j \neq 0} \log p(w_{t+j}| w_t)$$
- $c$: 학습 컨텍스트 크기(윈도우 크기). 클수록 학습 예제가 많아져 정확도가 높아지지만, 학습 시간이 증가한다.
기본 Skip-gram은 $p(w_O | w_I)$를 [[Softmax]]로 정의한다.
$$P(w_O | w_I) = \dfrac{\exp(v^{'⊤}_{w_O}v_{w_I})}{\sum_{w=1}^W \exp(v_w^{'⊤}v_{w_I})}$$
- $v_w$, $v^{'}_w$: 단어 $w$의 입력/출력 벡터 표현
- $W$: 어휘 크기
분모 계산 비용이 $O(W)$로 어휘가 클수록($10^5 ~ 10^7$) 비현실적이므로, 아래의 두 근사 기법을 사용한다.

## Hierarchical Softmax
[[Hierarchical Softmax]]는 출력층을 $W$개의 리프를 가진 이진 트리로 표현한다. 단어 $w$의 확률은 루트에서 해당 리프까지 경로의 각 내부 노드에서 이진 분류 확률의 곱으로 계산된다.
$$p(w|w_I = \displaystyle \prod_{j=1}^{L(w)-1} \sigma \left([\mkern-2mu[ n(w, j+1) = \text{ch}(n(w, j)) ]\mkern-2mu]\cdot v_{n(w, j)}^{'⊤}v_{w_I} \right)$$
- $L(w)$: 루트에서 $w$까지의 경로 길이
- $n(w, j)$: 경로 상 $j$번째 노드
- $\text{ch}(n)$: 노드 $n$의 고정된 자식 노드
- $[\mkern-2mu[x]\mkern-2mu]$: $x$가 참이면 1, 거짓이면 -1.
- 
계산 비용은 $O(L(w))$이며, 평균적으로 $O(\log W)$이하다.

## Negative Sampling
[[Negative Sampling]]은 Skip-gram 목표의 각 $\log P(w_O | w_I)$항을 다음으로 대체한다:
$$\log \sigma(v^{'⊤}_{w_O}v_{w_I}) + \displaystyle \sum_{i=1}^k \mathbb{E}_{w_i ~ P_n(w)} [\log \sigma(-v^{'⊤}_{w_i}v_{w_I})]$$
정답 단어 $w_O$를 노이즈 분포 $P_n(w)$에서 추출한 $k$개의 오답 단어와 구별하는 이진 분류 문제로 학습을 단순화한다. 노이즈 분포는 $U(w)^{3/4}/Z$가 가장 우수한 성능을 보였다.

## [[Subsampling of Frequent Words]]
대규모 코퍼스에서 "the", "in" 같은 고빈도 단어는 수억 번 등장하지만 정보량은 적다. 각 단어 $w_i$를 다음 확률로 학습 데이터에서 제거한다:

$$P(w_i) = 1 - \sqrt{\dfrac{t}{f(w_i)}}$$
- $f(w_i)$: 단어 $w_i$의 말뭉치 내 빈도
- $t$: 임계값(threshold). 일반적으로 $10^{-5}$ 사용.
- $f(w_i) > t$인 단어를 공격적으로 제거하되, 빈도 순위는 보존.

> [!tip] Hierarchical Softmax vs Negative Sampling
>  Hierarchical Softmax와 Negative Sampling은 대안 관계이다.
>  즉, 둘 다 쓰는 게 아니라 하나를 선택해서 사용한다.
>  반면, Subsampling은 어느 쪽과도 함께 사용할 수 있다.

# Empirical Results
## 평가 방법
[[Efficient Estimation of Word Representations in Vector Space|이전 논문]]에서 제안한 단어 유추 태스크(analogical resonaing task)를 사용한다.
`Germany : Berlin :: France : ?` 형태의 유추를 코사인 거리 기반 벡터 연산으로 풀며, 두 가지 범주로 구성된다.
- Syntactic: 형태론적 유추. (`quick:quickly :: slow:?`)
- Semantic: 의미적 유추 (국가 - 수도 관계 등)
학습 데이터는 약 10억 단어 규모의 뉴스 기사 말뭉치(Google 내부 데이터셋)이며, 5회 미만 등장 단어를 제거해 어휘 크기 692K로 구성했다.

## 주요 시사점
### NEG vs Hierarchical Softmax
[[Negative Sampling]]이 유추 task 전반에서 [[Hierarchical Softmax]]를 능가했다. 특히 [[Subsampling of Frequent Words]] 없이는 NEG가 semantic/syntactic 양쪽에서 모두 우세했다.

## Subsampling의 효과
[[Subsampling of Frequent Words]] 적용 시 두 가지 효과가 함께 나타난다.
학습 속도가 수 배 향상되면서 semantic 유추 정확도도 함께 올라간다. 속도와 품질이 함께 개선되는 것이 핵심이다.

### 선형성과 벡터 표현
Skip-gram의 선형 구조가 유추 task에 유리하게 작용한다고 생각할 수 있다. 그러나, 고도로 비선형인 [[Recurrent Neural Networks]] 계열 모델도 학습 데이터가 충분히 커지면 동일 task에서 성능이 향상된다는 선행 연구가 있어, 선형성 자체가 필수 조건은 아님을 시사한다.

# Learning _Phrases_
## 구 표현의 필요성
많은 구는 개별 단어 의미의 단순 합성으로 환원되지 않는다. "Boston Globe"는 신문사이지만, "Boston"과 "Globe"의 의미 조합이 아니며, "New York Times", "Toronto Maple Leafs"도 마찬가지다. 이러한 관용적 구를 단일 토큰으로 처리하면 [[Skip-gram]] 모델의 표현력이 크게 올라간다.

## 구 탐지 방법
구는 데이터 기반 접근으로 자동 탐지한다. Unigram/Bigram 빈도를 이용한 점수 함수로 구 후보를 선정한다.
$$\text{score}(w_i, w_j) = \dfrac{\text{count}(w_iw_j) - \delta}{\text{count}(w_i) \times \text{count}(w_j)}$$
- $\text{count}(w_iw_j) - \delta$: 두 단어가 함께 등장하는 빈도. $\delta$는 희귀 단어 쌍으로 구성된 구가 과도하게 생성되는 것을 방지하는 계수.
- $\text{count}(w_i) \times \text{count}(w_j)$: 두 단어가 독립적으로 등장할 때 기대되는 공통 등장 빈도.
- 점수가 임계값 이상인 Bigram을 구로 확정한다.
학습 데이터를 임계값을 낮춰가며 2~4회 반복 순회하여, 2어절 이상의 긴 구도 단계적으로 포착한다.

## Phrase Skip-Gram 실험 결과
구 단위 유추 task(3218개 예제)에서 평가한다. 구성은 신문사, NHL/NBA 팀, 항공사, 기업 임원의 5개 범주.

### Subsampling의 역할
[[Subsampling of Frequent Words]] 없이는 [[Negative Sampling]]이 [[Hierarchical Softmax]]보다 우수했다. 그러나, 적용 시엔 Hierarchical Softmax가 역전하여 최고 성능을 달성한다. 구 수준 task에서는 subsampling과 Hierarchical Softmax의 조합이 가장 효과적임을 시사한다.

### 학습 데이터 규모의 중요성
최고 성능(72% 정확도) 모델은 약 330억 단어 규모의 데이터셋, 1000차원 벡터, 전체 문장 컨텍스트 조합으로 달성했다. 데이터를 60억 단어로 줄이면 정확도가 66%로 하락하여, 구 표현 학습에서 데이터 규모가 결정적임을 보인다.

# Addictive Compositionality
## 현상
[[Skip-gram]] 벡터는 단순 벡터 덧셈만으로도 의미 있는 합성이 가능하다.
$$\text{vec("Russia") + vec("river") ≈ vec("Volga River")}$$$$\text{vec("Germany") + vec("capital") ≈ vec("Berlin")}$$
두 벡터의 합에 가장 가까운 벡터가 의미적으로 자연스러운 결과를 가져온다.

## 이론적 설명
이 현상은 학습 목표 함수의 구조에서 비롯된다.
- 단어 벡터는 [[Softmax]] 비선형성의 입력과 선형 관계에 있다.
- 단어 벡터는 해당 단어가 등장하는 문맥의 분포를 표현한다고 할 수 있다.
- 출력층에서 계산되는 확률과 로그 관계에 있으므로, 두 벡터의 합은 두 문맥 분포의 곱에 대응한다.
- 이 곱은 `AND` 함수처럼 작동한다. 두 벡터 모두에서 높은 확률을 부여받은 단어만 합산 후에도 높은 확률을 가진다.

따라서, "Russian"과 "river" 두 문맥에서 모두 자주 등장하는 단어, 즉 "Volga River"가 합산 벡터와 가장 가까워진다.

# Comparision to Published Word Representations
기존에 공개된 단어 표현 모델들과 본 논문의 Skip-gram 모델을 희귀 단어의 최근접 이웃을 통해 정성적으로 비교한 결과, 330억 단어로 학습한 Skip-gram 모델은 모든 비교 대상을 크게 앞선다. 이는 두 요인의 복합 효과다:
- 데이터 규모: 기존 모델 대비 2~3배 이상 많은 학습 데이터
- 학습 효율: 훨씬 많은 데이터에도 불구하고 학습 시간은 기존 모델보다 짧음
모델 구조의 계산 효율이 데이터 규모 확장을 가능하게 하고, 그 규모가 표현 품질로 직결된다는 걸 보여준다.

# Conclusion
본 논문의 핵심 기여는 다음과 같다:
- [[Skip-gram]] 모델에 [[Negative Sampling]]과 [[Subsampling of Frequent Words]]를 도입해 학습 속도와 벡터 품질을 동시에 개선했다.
- 단어 수준에서 구(Phrase) 수준으로 모델을 확장하여 관용적 표현의 벡터 학습을 가능하게 했다.
- 벡터의 Additive Compositonality를 발견하고 이론적으로 설명했다.