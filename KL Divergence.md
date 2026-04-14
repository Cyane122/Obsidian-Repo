# 정의
KL Divergence(Kullback-Leibler Divergence, 쿨백-라이블러 발산)은 두 확률분포 $P$와 $Q$ 사이의 비대칭적 차이를 측정하는 정보이론적 척도이다. $P$를 기준 분포, $Q$를 근사 분포라 할 때:
$$D_{KL}(P||Q) = \displaystyle \sum_x P(x) \log \dfrac{P(x)}{Q(x)} = H(P, Q) - H(P)$$

# 특성
- $P=Q$일 때, $D_{KL}(P|| Q) = 0$. 항상 $D_{KL}(P||Q) \geq 0$. (Gibbs 부등식)
- 비대칭성: $D_{KL}(P||Q) \neq D_{KL}(Q||P)$. 따라서, 거리 척도는 아님.
- $P(x)>0$인 영역에서 $Q(x)=0$이면 발산함. 모델 분포 $Q$가 실제 분포 $P$의 지지(support)를 포함해야 한다.
- [[Cross-Entropy]]와의 관계: $P$가 고정된 경우, $H(P, Q)$를 최소화하는 것과 $D_{KL}(P||Q)를 최소화하는 것은 동치다.

# 대표 변형/관련 기법
- JS Divergence (Jensen-Shannon Divergence): KL Divergence를 대칭화한 형태. $D_{JS}(P||Q) = \dfrac{D_{KL}(P||M) + D_{KL}(Q||M)}{2}$, $M = \dfrac{P+Q}{2}$.
- Forward KL vs Reverse KL: $D_{KL}(P||Q)$를 최소화(forward)하면 $P$의 전체 지지를 커버하려 하고, $D_{KL}(Q||P)$를 최소화(reverse)하면 $P$의 최빈값(mode)에 집중하는 경향.
- Rényi Divergence: KL Divergence를 일반화한 형태.

# 관련 개념
- [[Cross-Entropy]]
- [[Softmax]]