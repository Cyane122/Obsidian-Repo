## 주요 정보
- 발표 연도: 2014년
- 저자: Jeffrey Pennington 외
- tags: #GloVe, #word-embedding , #co-occurrence, #matrix_factorization, #representation-learning, #NLP
---
# Abstract
## 문제 제기
기존 단어 벡터 학습 방법들은 벡터 산술 연산으로 의미적, 문법적 규칙성을 포착하는 데 어느 정도 성공했지만, 그 규칙성이 _왜_ 발생하는지는 불분명한 상태였다.
## 두 계열의 한계
기존 모델은 크게 2개로 나뉜다.
1. 전역 행렬 분해 계열 ([[Latent Semantic Analysis]] 등): 말뭉치 전체의 통계 정보를 효율적으로 활용하지만, 단어 유추(word analogy) 과제에서 성능이 낮음 - 벡터 공간의 구조가 최적이 아님!
2. 지역 문맥 창 계열 ([[Skip-gram]], [[Continuous Bag-of-Words]]) 등: 유추 과제 성능은 더 낮지만, 말뭉치 전체의 공동출현 통계를 직접 활용하지 않고 개별 문맥 창을 순회하는 방식이라 통계 활용이 비효율적!

## 제안
전역 단어-단어 [[Co-occurrence Matrix]]의 비영(non-zero) 원소에 대해서만 학습하는 가중최소제곱회귀(weighted least squares regression) 모델 GloVe를 제안한다. 두 계열의 장점을 결합하여 의미 있는 선형 부분구조를 가진 벡터 공간을 생성한다.

## 주요 결과
- 단어 유추 과제: 75% 정확도 (당시 SOTA)
- 단어 유사도 및 [[Named Entity Recognition]] 과제에서도 기본 모델 대비 우수한 성능

> [!note] 한 마디로 정리하면
> LSA는 전체 통계를 보지만 구조가 나쁘다. Word2Vec은 구조는 좋은데 전체를 보지 못한다. GloVe는 둘 다 잡았다.

# Introduction
## 배경
단어 벡터 학습 방법들은 벡터 산술 연산으로 의미적, 문법적 규칙성을 포착하는 데 성공했다. 특히 [[Distributed Representations of Words and Phrases and their Compositionality|Mikolov et al. (2013)]]이 제안한 단어 유추 평가 방식은 벡터 간 스칼라 거리가 아닌 차이의 방향을 검사한다.

## 두 계열의 문제
기존 모델은 두 계열로 나뉘며, 각각 고유한 한계점을 가진다.
1. 전역 행렬 분해 계열 ([[Latent Semantic Analysis]] 등): 말뭉치 전체의 통계를 효율적으로 활용하지만, 단어 유추 과제에서 성능이 낮음. 벡터 공간의 선형 부분구조가 약하기 때문.
2. 지역 문맥 창 계열 ([[Skip-gram]] 등): 유추 과제 성능은 더 낫지만, 전체 말뭉치의 공동출현 통계를 직접 활용하지 않고 개별 문맥 창을 순회하므로 데이터의 반복성을 낭비함.

## 핵심 주장
의미의 선형 방향성이 나타나려면 **전역 log-bilinear** 회귀 모델이 적합하다. 전역 [[Co-occurrence Matrix]]의 통계를 직접 학습에 활용하는 가중 최소제곱 모델 GloVe를 제안한다.

# The GloVe Model
## 출발점: 공동출현 확률의 비율
모든 비지도 단어 표현 학습 방법의 핵심 정보원은 말뭉치의 단어 출현 통계다. GloVe는 이 통계에서 의미가 어떻게 생성되는지 분석하는 것에서 출발한다.
표기 정의:
- $X_{ij}$: 단어 $j$가 단어 $i$의 문맥에 등장한 횟수
- $X_i = \sum_k X_{ik}$: 단어 $i$ 주변에 등장한 전체 단어 수
- $P_{ij} = P(j | i) = X_{ij}/X_i$: 단어 $i$의 문맥에서 단어 $j$가 등장할 확률
핵심 관찰: 원시 확률보다 확률의 비율이 의미 관계를 더 잘 포착한다.

|                        | $k=\text{solid}$     | $k = \text{gas}$     | $k = \text{water}$   | $k = \text{fashion}$ |
| ---------------------- | -------------------- | -------------------- | -------------------- | -------------------- |
| $P(k \| \mathrm{ice})$ | $1.9 \times 10^{-4}$ | $6.6 \times 10^{-5}$ | $3.0 \times 10^{-3}$ | $1.7 \times 10^{-5}$ |
| $P(k \| \text{steam})$ | $2.2 \times 10^{-5}$ | $7.8 \times 10^{-4}$ | $2.2 \times 10^{-3}$ | $1.8 \times 10^{-5}$ |
| 비율                     | $8.9$                | $8.5 \times 10^{-2}$ | $1.36$               | $0.96$               |
- 비율 > 1: ice에만 관련된 단어 (solid)
- 비율 < 1: steam에만 관련된 단어 (gas)
- 비율 ≈ 1: 둘 다 관련되거나, 무관한 단어 (water, fashion)
즉, 비율을 사용하면 무관한 단어들의 노이즈가 상쇄되어 변별력이 높아진다.

## 수식 유도
확률의 비율은 세 단어 $i, j, k$에 의존하므로, 가장 일반적인 형태의 모델은 다음과 같다.
$$F(w_i, w_j, \tilde w_k) = \dfrac{P_{ik}}{P_{jk}}$$
여기서 $w$는 target word vector, $\tilde w$는 context word vector. 우변은 말뭉치에서 직접 추출된다.

단계 1. 벡터 공간은 선형 구조이므로, 두 target word의 차이로 제한한다.
$$F(w_i - w_j, \tilde w_k) = \dfrac{P_{ik}}{P_{jk}}$$

단계 2. 좌변은 벡터, 우변은 스칼라이므로 내적을 취해 차원 혼합을 방지한다.
$$F((w_i - w_j)^T\tilde w_k) = \dfrac{P_{ik}}{P_{jk}}$$

단계 3. [[Co-occurrence Matrix]]에서 단어와 문맥 단어의 역할은 임의적이므로, $w \leftrightarrow \tilde w$, $X \leftrightarrow X^T$ 교환에 대해 대칭이어야 한다. 이를 위해, $F$가 $(R, +)$에서 $R_{>0}, \times)$로의 준동형(homomorphism)이어야 한다.
$$F(w_i^T \tilde w_k) = P_{ik} = \dfrac{X_{ik}}{X_i}$$
$F=\exp$이 해가 되어:
$$w^T_i \tilde w_k = \log P_{ik} = \log X_{ik} - \log X_i$$

단계 4. $\log X_i$는 $k$에 독립이므로 $w_i$의 bias $b_i$로 흡수한다. $\tilde w_k$의 bias $\tilde b_k$를 추가하여 대칭성을 복원한다.
$$w_i^T \tilde w_k + b_i + \tilde b_k = \log X_{ik}$$

> [!tip] 로그의 발산 문제
> $X_{ik} = 0$이면 $\log 0$이 발산하는 문제가 있다. 논문에서는 $\log X_{ik} \rightarrow \log (1 + X_{ik})$로 처리해서 희소성을 유지하면서 발산을 막는다.

## 목적함수
단계 4의 식을 최소제곱 문제로 변환하고, 공동출현 빈도에 따른 가중치 함수 $f(X_{ij})$를 도입하자.
$$J = \displaystyle \sum_{i, j = 1} ^V f(X_{ij}) \left(w_i^T\tilde w_k + b_i + \tilde b_i - \log X_{ij} \right)^2$$
가중치 함수 $f$의 조건:
1. $f(0) = 0$: 공동출현이 없는 쌍은 학습에 기여하지 않는다.
2. $f(x)$는 단조증가: 희귀한 공동출현 쌍이 과대평가되지 않는다.
3. $f(x)$는 큰 $x$에서 상대적으로 작음: 고빈도 공동출현 쌍이 과대평가되지 않는다.

논문에서는 다음의 형태를 채택했다:
$$f(x) = \begin{cases} (x/x_{\text{max}})^\alpha & \text{if } x < x_{\text{max}} \\ 1 &  \text{otherwise} \end{cases}$$
실험 결과, $x_{\text{max}} = 100$, $\alpha = 3/4$로 고정.

## 계산 복잡도
모델의 복잡도는 [[Co-occurrence Matrix]] $X$의 비영 원소 수에 의존한다. 단어 공동출현이 멱함수(power-law) 분포를 따른다고 가정하면,
$$|X| = O(|C|^{0.8})$$
즉, 실제 복잡도는 최악의 경우인 $O(|V|^2)$보다 훨씬 낮고, 온라인 문맥 창 방식은 $O(|C|)$보다도 낮다.

## Relationship to Other Models
### Skip-gram과의 연결
모든 비지도 단어 학습 방법은 결국 말뭉치의 공동출현 통계에 기반하므로, 모델 사이엔 공통점이 존재해야 한다. 따라서, [[Skip-gram]]의 목적함수가 GloVe와 동일한 목적함수로 수렴함을 보이자.

Skip-gram 계열 모델의 출발점은 단어 $j$가 단어 $i$의 문맥에 등장할 확률 모델 $Q_{ij}$다. [[Softmax]] 형태로 정의하면:
$$Q_{ij} = \dfrac{\exp(w_i^T\tilde w_j)}{\sum_{k=1}^V \exp (w_i^T \tilde w_k)}$$

말뭉치 전체를 순회하는 문맥 창 학습의 전역 목적함수는:
$$J=-\displaystyle \sum_{i \in \text{corpus, } j \in \text{context}(i)} \log Q_{ij}$$

같은 $(i, j)$쌍을 묶으면 공동출현 행렬 $X$로 표현이 가능하다:
$$J = - \displaystyle \sum_{i=1}^V \sum_{j=1}^V X_{ij} \log Q_{ij}$$

이를 [[Cross-Entropy]] 형태로 재작성하자:
$$J = \sum_{i=1}^V X_i H(P_i, Q_i)$$
이따, $H(P_i, Q_i)$는 실제 분포 $P_i$와 모델 분포 $Q_i$ 사이의 Cross-Entropy.

### 목적함수의 한계와 GloVe 목적함수로의 수렴
위의 목적함수 $J$는 다음 두 가지 문제점을 가진다.
1. Cross-Entropy의 문제: 확률 분포의 꼬리(tail)가 긴 경우 희귀 사건에 과도한 가중치를 부여한다.
2. 정규화 비용: $Q_{ij}$의 정규화 상수 계산이 어휘 전체에 대한 합산을 요구하여 계산 비용이 크다.

Cross-Entropy 대신 최소제곱 목적함수를 채택하고, 정규화되지 않은 분포 $\hat P_{ij} = X_{ij}, \hat Q_{ij} = \exp(w_i^T \tilde w_j)$를 사용하면:
$$\hat J = \displaystyle \sum_{i, j} X_{ij} \left(\log \hat P_{ij} - \log \hat Q_{ij} \right)^2 = \sum_{i, j} X_i\left(w_i^T\tilde w_j - \log X_{ij} \right)^2$$
이때 고정된 가중치 $X_i$ 대신 $f(X_{ij})$를 도입하면 GloVe와 동일한 목적함수를 갖는다.

> [!note] Skip-gram과의 공통점과 차이점
> 이 유도의 핵심 메시지는 "skip-gram도 전역 목적함수로 쓰면 GloVe와 같은 형태가 된다"는 것. 차이는 가중치 함수다. skip-gram은 $X_i$가 가중치로 고정되지만, GloVe는 $f(X_{ij})$를 자유롭게 설계할 수 있다!

# Experiments
## 평가 방법
세 가지 task로 평가한다.
1. 단어 유추 (Word Analogy): "A is to B as C to ?" 형태의 질문 19,544개로 구성한다. 의미적(semantic) 하위셋과 문법적(syntactic) 하위셋으로 분리.
	- 의미적: 인명, 지명 기반 유추. "Athens is to Greece as Berlin is to ?"
	- 문법적: 시제, 형용사 기반 변형 유추. "dance is to dancing as fly is to ?"
	- 정답은 $w_d$가 $w_b - w_a + w_c$에 코사인 유사도 기반으로 가장 가까운 단어. 완전 일치만 정답으로 인정한다.
2. 단어 유사도 (Word Simliarity): WordSim-353, MC, RG, SCWS, RW 다섯 데이터셋에서 Spearman 순위 상관계수로 평가.
3. [[Named Entity Recognition]]: CoNLL-2003 영어 벤치마크. [[Conditional Random Field]] 모델에 50차원 단어 벡터를 연속 feature로 추가했으며, [[F1 Score]]로 평가함.

## 학습 데이터 및 설정
다섯 개 말뭉치에서 학습:
- Wikipedia 2010: 1B tokens
- Wikipedia 2014: 1.6B tokens
- Gigaword 5: 4.3B tokens
- Gigaword 5 + Wikipedia 2014: 6B tokens
- Common Crawl: 42B tokens

공통 설정:
- 어휘: 상위 400,000단어
- 토크나이저: Stanford Tokenizer, 소문자 처리
- 거리 가중치: 거리 $d$만큼 떨어진 단어 쌍의 기여를 $1/d$로 감소
- $x_{\text{max}}=100$, $\alpha=3/4$
- 옵티마이저: [[AdaGrad]], 초기 학습률 0.05
- 반복 횟수: 300차원 미만 50회, 300차원 이상 100회
- 문맥 창: 좌우 각 10단어 (symmetric)
- 최종 벡터: $W + \tilde W$
>[!note] 왜 $\tilde W$?
> $X$가 대칭일 때 W와 \tilde W는 이론적으로 동치인데, 랜덤 초기화 때문에 살짝 다르게 수렴한다. 이 둘을 평균내면 노이즈가 줄고 성능이 조금 오른다. (앙상블과 같은 원리)


## 결과
1. 단어 유추
	GloVe 300차원, 6B token 기준으로 전체 정확도 71.7%. 42B token에서는 75.0%로 당시 SOTA를 달성했다.
	동일 말뭉치, 동일 학습 시간 기준으로 [[Skip-gram]], [[Continuous Bag-of-Words]] 대비 일관되게 우수한 성능을 보였다.
	주요 관찰:
	- 말뭉치 크기가 증가하면 syntactic 성능은 단조증가했으나 semantic 성능은 반드시 그렇진 않았다.
	- Wikipedia가 Gigaword보다 작지만 지명, 인명 유추에서 더 우수했다. 이는 Wikipedia의 내용 특성 때문.
	- SVD 계열은 대규모 말뭉치에서 성능이 저하됐다. 이는 가중치 없이 원시 빈도를 그대로 사용하기 때문.
2. 단어 유사도
	각 feature를 어휘 전체 기준으로 정규화한 후, 코사인 유사도와 Spearman 순위 상관계수로 평가했다. GloVe 42B가 100B token으로 학습된 [[Continuous Bag-of-Words]]보다 우수했다.
3. NER
	CoNLL test 기준 F1 88.3으로 HPCA(88.7)을 제외한 모든 모델 대비 우수했다. ACE, MUC7에서는 전체 1위.

## 모델 분석
벡터 차원 및 문맥 창 크기
- 벡터 차원: 200차원 이상부터 수확체감. 300차원이 실용적.
- 문맥 창 크기
	- syntactic: 작고 비대칭인 창에서 유리하다. 문법 정보는 인접 단어에 집중되기 때문이다.
	- semantic: 크고 대칭인 창에서 유리하다. 의미 정보는 비지역적이기 때문이다.

학습 시간: 동일 말뭉치, 어휘, 문맥 창 기준, GloVe가 word2vec 대비 더 빠르게 수렴하고 최종 성능도 높다. [[word2vec]]은 negative sample 수가 10개를 넘으면 오히려 성능이 하락했다([[Negative Sampling]]이 목표 분포를 잘 근사하지 못하기 때문)

# Conclusion
count 기반 방법과 prediction 기반 방법, 두 계열은 근본적으로 다르지 않다. 둘 모두 결국 말뭉치의 공동출현 통계를 탐색하며, 둘의 차이는 그 통계를 얼마나 효율적으로 활용하느냐에 있다.

## GloVe의 위치
전역 공동출현 통계를 직접 활용하는 count 기반 방법의 장점과, log-bilinear prediction 기반 방법([[Word2Vec]] 등)에서 나타나는 선형 부분구조를 동시에 포착한다. 그 결과물인 GloVe는 단어 유추, 단어 유사도, [[Named Entity Recognition]] task 전반에서 기존 모델 대비 우수한 성능을 달성했다.