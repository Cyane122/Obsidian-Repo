# 정의
두 확률 분포 $P$와 $Q$ 사이의 차이를 측정하는 정보이론적 척도. $P$를 실제 분포, $Q$를 모델이 예측한 분포라 할 때,
$$H(P, Q) = \displaystyle -\sum_x P(x)\log Q(x)$$

# 특성
- $P=Q$일 때, $H(P, Q) = H(P)$ (엔트로피)로 최소화된다.
- $P \neq Q$일 때, 항상 $H(P, Q) \geq H(P)$.
- 머신러닝에서 모델 분포 $Q$를 실제 분포 $P$에 가깝게 만드는 손실함수로 널리 사용된다.
- 꼬리가 긴 분포(long-tail distribution)에서 희귀 사건에 과도한 가중치를 부여하는 경향이 있다.
- 모델 분포 $Q$가 정규화되어 있어야 유한한 값을 가진다. 정규화 상수 계산이 병목이 되는 경우가 있다.

# 모델별 적용 방식
- [[Skip-gram]]: 말뭉치 전체 목적함수를 $\sum_i X_iH(P_i, Q_i)$ 형태의 가중 교차 엔트로피로 표현 가능하다. 단, $Q_{ij}$의 정규화 상수 계산 비용 때문에 [[Negative Sampling]] 등의 근사를 사용한다.
- [[GloVe - Global Vectors for Word Representation|GloVe]]: 교차 엔트로피의 정규화 요구와 꼬리 분포 문제를 피하기 위해 최소제곱(least squares) 목적함수로 대체한다.

# 대표 변형/관련 기법
- [[KL Divergence]]: $D_{KL}(P||Q) = H(P, Q) - H(P)$. 교차 엔트로피에서 $P$의 엔트로피를 뺀 값.
- Binary Cross-Entropy: 이진 분류에서 사용되는 특수 형태. $-[y\log \hat y + (1-y)\log(1-\hat y)]$.
- Log-loss: 이진 분류에서의 Binary Cross-Entropy와 동의어로 사용되는 경우가 많다.

# 관련 개념
- [[KL Divergence]]
- [[Softmax]]
- [[Negative Sampling]]