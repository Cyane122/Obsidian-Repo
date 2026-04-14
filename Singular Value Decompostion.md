# 정의
임의의 행렬 $M \in \mathbb{R}^{m\times n}$을 세 행렬의 곱 $M=UΣV^T$로 분해하는 행렬 분해 기법. $U$, $V$는 직교 행렬이며, $Σ$는 특이값을 대각 원소로 갖는 대각행렬이다.

# 구성 요소
- $U \in \mathbb{R}^{m\times n}$: 좌특이 벡터 행렬이며, 행(row)공간의 직교 기저이다.
- $Σ \in \mathbb{R}^{m\times n}$: 특이값 행렬이다. 대각 원소 $\sigma_n$에 대하여 $\sigma_1 \geq \sigma_2 \geq \cdots \geq 0$이다.
- $V \in \mathbb{R}^{m\times n}$: 우특이 벡터 행렬이며, 열(column)공간의 직교 기저이다.

# 저랭크 근사 (Truncated SVD)
상위 $k$개의 특이값만 보존하고 나머지를 $0$으로 치환하면, 원래 행렬에 대한 Frobenius Norm 기준 최적의 랭크-$k$ 근사 $M_k = U_kΣ_kV_k^T$를 얻을 수 있다. NLP에서는 이 $U_k$ 또는 $U_kΣ_k$를 단어 벡터로 사용한다.

# 한계
- 행렬의 크기가 클수록 계산 비용이 급격하게 증가한다. 어휘 크기 $|V|$의 [[Co-occurrence Matrix]]에 직접 적용하면 현실적으로 전체 SVD는 불가능해 Truncated SVD를 사용한다.
- 새로운 단어나 문서가 추가되면 전체를 재계산해야 한다.

# 대표 변형/관련 기법
- Truncated SVD
- Randomized SVD: 대규모 행렬에 대해 근사적으로 빠르게 SVD를 수행하는 방법.
- [[Principal Component Analysis]]: 공분산 행렬에 SVD를 적용한 것과 같은 방법이다.

# 관련 개념
- [[Latent Semantic Analysis]]
- [[Co-occurrence Matrix]]
- [[Word Embedding]]