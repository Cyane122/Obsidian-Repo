# 정의
Query, Key, Value 세 행렬을 입력으로 받아, Query와 Key의 내적으로 유사도를 계산하고 차원 수로 스케일링한 뒤 [[Softmax]]로 정규화하여 Value의 가중합을 출력하는 [[Attention]] 연산.
$$\mathrm{Attention}(Q, K, V) = \mathrm{softmax}\left(\dfrac{QK^⊤}{\sqrt{d_k}} \right)V$$

# 메커니즘
## 유사도 점수 계산
$Q \in \mathbb{R}^{n \times d_k}$, $K \in \mathbb{R}^{m \times d_k}$의 내적으로 점수 행렬을 계산한다.
$$\mathrm{score} = QK^⊤ \in \mathbb{R}^{n \times m}$$
- $\mathrm{score}_{ij}$: $i$번째 Query가 $j$번째 Key와 얼마나 관련있는지

## 스케일링
점수를 $\sqrt{d_k}$로 나눈다.
- 이유: $d_k$가 커질수록 내적값의 분산이 커져 [[Softmax]]가 극단적으로 작은 gradient를 생성하는 문제를 방지한다. $d_k$가 커지면 softmax 출력이 one-hot에 가까워져 학습이 불안정해진다.

## Softmax 정규화
스케일링된 점수를 행 단위로 [[Softmax]]하여 각 Query에 대한 Attention 가중치 분포를 얻는다.
$$A = \mathrm{softmax}\left(\dfrac{QK^⊤}{\sqrt{d_k}} \right) \in \mathbb{R}^{n \times m}$$

## Value 가중합
$A$를 가중치로 $V \in \mathbb{R}^{m \times d_v}$를 합산한다.
$$\mathrm{Output} = AV \in \mathbb{R}^{n \times d_v}$$

## Masking
- Padding Mask: 패딩 토큰 위치의 점수를 $-\infty$로 설정한다 -> Softmax 후 가중치 0
- Casual Mask (Look-ahead Mask): Decoder Self-Attention에서 미래 토큰 참조 방지 - 상부삼각행렬을 $-\infty$로 마스킹

# 등장 논문
- [[Attention is All You Need]] (Vaswani et al., 2017) - 정식 도입. Transformer의 핵심 연산으로 사용.

# 관련 개념
- [[Attention]]
- [[Multi-Head Attention]]
- [[Softmax]]
- [[Transformer]]
