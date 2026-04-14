## 주요 정보
- 발표 연도: 2008년
- 저자: Yifan Hu 외
- tags: #collaborative-filtering, #implicit-feedback
---
# Abstract
추천 시스템의 주요 목적은 과거의 [[Implicit Feedback]]을 기반으로 개인화된 추천을 제공하는 것.
다만, 사용자의 선호에 대한 직접적인 입력, 특히 싫어하는 것에 대한 정보는 매우 부족하다.
- Positive signal은 풍부하지만, Negative signal은 매우 부족하다.
- 사실 생각해보면 당연하다. 사용자는 '이거 싫어'보다 '이거 고를게'라는 반응을 보이는 것이 대부분.
그래서 우리는 이런 제안을 해볼게: 데이터를 2가지로 나누어 해석하자.
1. Preference(선호)
2. Confidence(신뢰도)
	- 단순히 고른다/안 고른다 가 아니라, 얼마나 확신할 수 있는가로 구분하자.
	- 예를 들어, 어떤 물건을 한 번 구매한 사람과 100번 구매한 사람이 있다. 이들이 말하는 '나 이 물건 좋아해'의 신뢰도는 누가 더 높겠는가?
이 아이디어에서 이어지는 Implicit Feedback에 특화된 Factor model을 제안하며, 이에 대한 최적화 방법 또한 함께 제안한다.
- Implicit 데이터는 매우 크므로, 기존 방식대로는 계산이 불가능한 수준이다.
- 따라서, 데이터 크기에 대해 선형적으로 scale되는 최적화 방법을 제안한다.

# Introduction
추천 시스템의 본질적인 문제는 다음과 같다:
> 전자상거래 환경에서 **수많은 상품 중 사용자가 좋아하는 것**이 무엇인가?

이를 해결하는 도구가 Recommender System(추천 시스템)이다.
그리고, 이 시스템의 본질은 사용자와 아이템을 프로파일링하고 둘 사이의 관계를 찾아내는 것이다.

## 접근 방식
1. Content-based
	- 아이템/유저의 속성 기반
		- 예시: 영화 - 장르, 배우 / 유저 - 나이, 설문
	- 외부 정보를 수집해야 하며, 항상 쉽게 얻을 수 있는 것은 아니다.
2. Collaborative Filtering (CF)
	- 과거 사용자의 행동만으로 추천 시스템 작동
	- 장점: Domain에 독립적이며, content-based가 잡기 어려운 관계까지 포착 가능하다.
	- 단점: cold start 문제: 새로운 아이템이나 유저를 처리하기 어렵다.

추천 시스템의 입력 데이터는 크게 두 종류로 나뉜다.
1. Explicit Feedback: 별점, 좋아요, 싫어요 등.
	- 사용자가 직접 표현한 선호/비선호 표현.
	- 고품질 데이터
2. [[Implicit Feedback]]: 행동 기반 데이터. => 사용자의 행동을 통해 간접적으로 선호를 추론한다.

## 왜 Implicit이 중요한가?
실제 시스템에서는 Explicit Feedback이 없는 경우가 매우 많음
- 사용자가 귀찮아서 평가 안 함
- 시스템이 수집할 수 없음
따라서, 많은 추천 시스템은 [[Implicit Feedback]] 중심으로 설계되어야 한다.

# Preliminaries
주요 용어들을 다음과 같이 정의하자.
- $U$: 사용자 집합
- $I$: 상품 집합
- 각 `user-item` 쌍에 대해 $r_{ui}$
	- Explicit: 별점
	- Implicit: interaction strength
		- ex: 시청 횟수, 구매 횟수, 클릭 수
	- 숫자 자체가 '선호'를 의미하지는 않음
- $f$: Latent Factor 수

## Sparsity
대부분의 `user-item` 쌍은 관측되지 않는다. 즉, 행렬은 극도로 sparse하다.
Implicit Feedback에서는 missing data가 의미 있는 자료가 된다.

기존엔 일반적인 CF는 관측된 데이터, Explicit Feedback만 사용해 모델을 학습했으나, Implicit에서는 문제가 달라진다.
- Implicit Feedback에는 unobserved data가 압도적으로 많으며, 이를 무시할 수 없다.
- 왜? "안 본 것" 그 자체가 정보이기 때문.

## Using Full Matrix
따라서, 모든 `user-item` 쌍을 고려하기 위해 unobserved data도 학습에 활용한다.
하지만 다음의 문제가 발생한다:
- unobserved가 너무 많음
- 신뢰도도 높지 않음
따라서, 모든 데이터를 사용하되 각 데이터의 중요도를 다르게 처리해야 한다.

# Previous Work
## Neighborhood Models
가장 전통적인 CF 방식.
- 유사한 사용자 또는 상품을 기반으로 예측
- 종류
	- User-based: 비슷한 사용자 기반
	- Item-based: 비슷한 상품 기반
- 발전 과정
	- 초기 CF: 나와 취향 비슷한 사람들 기반 추천
	- 이후: 내가 좋아한 아이템과 비슷한 것 기반 추천
	- 결과: Item-based가 정확도가 더 높고 확장성도 좋음. 설명 가능성도 더 좋음.
- 상품 사이의 유사도 $s_{ij}$를 정의하자.
	$\hat{r}_{ui} = \dfrac {\sum_{j \in S_k(i;u)}s_{ij}r_{uj}} {\sum_{j \in S_k (i;u)}s_{ij}}$
	- $S_k(i;u)$: 사용자 $u$가 평가한 상품 중 $i$와 유사한 $k$개
	- 그 상품들의 rating을 가중평균해서 추출
- Explicit Feedback에서는 잘 작동한다.
	- 평균 보정(user/item bias correction)
	- rating scale이 동일함 -> 안정적!
- Implicit Feedback에서의 문제점
	1. frequency 기반 데이터 문제:
		- Implicit data는 rating이 아니라 횟수
		- 사용자마다 scale이 다르므로 비교하기 어렵다.
	2. 구조적 한계
		- preference와 confidence를 구분할 수 없다.
		- 많이 봤다 != 좋아한다
		-> 이걸 분리하지 못한다.

## Latent Factor Models
관측된 데이터를 설명하는 잠재 요인(latent features)을 학습.
- 대표 모델들
	- pLSA
	- Neural Networks
	- LDA
	- SVD 기반 모델
- SVD 기반 모델 구조
	각 사용자와 상품들을 벡터로 표현한다.
	- 사용자: $x_u \in \mathbb {R}^f$
	- 상품: $y_i \in \mathbb R^f$
	예측 점수:
		$\hat r_{ui} = x_u^T y_i$
	-> 내적 = 선호도.
- 학습 (Explicit Feedback)
	관측된 rating만 사용한다.
	$\displaystyle \min_{x_*, y_*} \sum_{r_{ui} \mathrm{\ known}} (r_{ui} - x_u^Ty_i)^2 + \lambda(||x_u||^2 + ||y_i||^2)$
	특징
	- observed data만 사용
	- missing은 무시
	- regularization으로 overfitting 방지
- 장점
	- Neighborhood보다 정확도와 확장성이 높다
	- 다른 데이터셋에서도 성능이 좋았다.
- Implicit Feedback으로 확장 시 문제
	기존 SVD는 그대로 쓰면 안 됨!
	- Implicit은 모든 $(u, i)$에 값이 존재해야 함
	- rating이 아니라 preference + confidience 구조 필요
	- 데이터가 dense해짐 (SGD같은 방법은 비효율적)

# Our Model
출발점: Implicit Feedback의 핵심 문제
- Implicit data는 preference와 confidence가 섞여 있다.
- 따라서, $r_{ui}$를 그대로 쓰지 않고 2개로 분리한다.

## Preference + Confidence
1. Preference $p_{ui}$
	$p_{ui} = \begin{cases}1 & \text{if } r_{ui} > 0 \\ 0 & \text{if } r_{ui} = 0\end{cases}$
	의미
	- 1: 이 상품을 소비함 -> 좋아할 가능성 있음
	- 0: 소비 안 함 -> 모름 (!= 싫어함)
2. Confidence $c_{ui}$
	$c_{ui} = 1 + \alpha r_{ui}$
	의미
	- 관측값이 클수록 더 신뢰할 수 있음
	- 최솟값 1: 모든 $(u, i)$에 대해 약한 신뢰는 존재함

## Latent Factor Model 적용
기본 구조
- user vector: $x_u$
- item vector: $y_i$
$\hat p _{ui} = x_u^T y_i$

## Cost Function
$\displaystyle \min_{x_*, y_*} \sum_{u, i} c_{ui}(p_{ui} - x_u^Ty_i)^2 + \lambda\left(\sum_u ||x_u||^2 + \sum_i ||y_i||^2\right)$
기존 SVD와의 차이
1. 모든 $(u, i)$ 사용 (Observed + **unobserved**)
2. confidence($c_{ui}$)로 가중치
의미
- $p_{ui}$: 목표값 (0 / 1)
- $c_{ui}$: 중요도(weight)
- $x_u^T y_i$: 예측값
-> 즉, 확신이 높은 데이터일수록 더 강하게 맞추도록 학습!

## Optimization: Alternating Least Squares(ALS)
문제 발생:
- $(u, i)$가 전부 포함됨
- 데이터가 매우 dense함 -> SGD 같은 방법 비효율.

### Alternating Least Squares
핵심 아이디어:
- 사용자 고정 -> 상품 업데이트
- 상품 고정 -> 사용자 업데이트

1. 사용자 업데이트
	$x_u = (Y^TC_uY + \lambda I)^{-1}Y^TC_uP(u)$
	- $Y$: 상품 행렬
	- $C_u$: 사용자별 confidence (diagonal matrix)
	- $p(u)$: 사용자 $u$의 preference vector
2. 상품 업데이트
	$y_i = (X^TC_iX + \lambda I)^{-1}X^TC_ip(i)$
3. 반복

### Calculation Reduction
$Y^TC_uY$ -> 이거 계산이 너무 빡셈(시간 복잡도 = $O(f^2n)$)
따라서, 아래와 같이 변형하자.
$Y^TC_uY = Y^TY +Y^T(C_u-I)Y$
- $C_u - I$는 sparse하다.
- 실제론 사용자가 실제로 본 상품의 수 $n_u$만큼만 non-zero.
따라서, 시간 복잡도가 $O(f^2n_u + f^3)$이 된다.
전체 사용자 수 $m$명에 대한 전체 시간 복잡도는 다음과 같다.
$O(f^2N + f^3m)$
- $N$: non-zero 수(=$n_u \times m$).
-> 데이터 크기에 따라 선형적으로 증가.

## 추천 생성
최종적으로,
$\hat p_{ui} = x_u^T y_i$
-> 값이 큰 $k$개의 아이템 추천.

## 모델 변형 가능성
1. 다른 confidence
	$c_{ui} = 1 + \alpha \log(1+r_{ui}/\epsilon)$
2. threshold
	$r_{ui}$가 일정 값 이상일 때만 $p_{ui}=1$

# Explaining Recommendations
Latent Factor Model의 근본적인 약점은 '왜 이 상품이 추천되었는지 설명하기 어렵다'는 것이다.
- Neighborhood 모델: 이 상품을 선호한 사람들이 이것도 좋아했다고 설명할 수 있다.
- Latent Factor Model: 벡터 내적이므로 직관적인 설명이 어렵다.
따라서, Latent Factor Model 또한 설명할 수 있는 결과가 필요하다.

## Key Idea
추천 점수 $\hat p_{ui} = x_u^T y_i$에 대하여, user vector를 다음과 같이 분해하자.
$x_u = (Y^TY + \lambda I)^{-1} \displaystyle \sum_j c_{uj}y_j$
즉, user vector는 과거의 소비한 상품들의 가중합이다.
이걸 대입하면,
$\hat p_{ui} = x_u^Ty_i = \displaystyle \sum_j \mathrm{contribution}_{y \rightarrow i}$
-> 추천 점수 = 과거의 상품들이 만든 기여도의 합

## Contribution
각 상품 $j$가 $i$에 기여하는 정도.
$\mathrm{contribution}_{y \leftarrow i} = c_{uj} \cdot y_j^TWy_i$
- $W=(Y^TY + \lambda I)^{-1}$
- $c_{uj}$: 사용자가 $j$를 얼마나 많이 소비했는지(confidence)
- $y^T_jWy_i$: 상품 $j$와 $i$의 latent similarity.

## Explanation
사용자 $i$가 소비한 상품 $j$들 중에서 contribution 값을 계산한다.
이후 상위 $k$개를 선택해 나열할 수 있다.
이 나열된 상품들이 사용자 $i$에게 추천된 상품 $p$를 고르는 데 가장 기여를 많이 한 상품들이다.

## With Neighborhood
이 방법은 implicit하게 item-item simliarity를 학습한 것이다.
즉, 명시적인 계산 없이도 latent space에서 자연스럽게 simliarity가 형성된다.

장점
1. 설명 가능성 확보: black-box 모델에서 semi-interpretable.
	- 설명이 아직 추상적이나, 그래도 "왜 이런 결과가 나왔는지"에 대한 제한적인 설명이나마 가능하다.
2. 품질 유지: recommendation 성능은 유지하면서 explanation을 제공할 수 있다.
3. Implicit 데이터에도 적용 가능