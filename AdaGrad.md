# 정의
각 파라미터마다 학습률을 개별적으로 적용시키는 경사하강법 기반 옵티마이저. 자주 등장하는 feature에는 학습률을 줄이고, 희귀하게 등장하는 feature에는 학습률을 높게 유지한다.
$$\theta_{t+1, i} = \theta_{t, i} - \dfrac{\eta}{\sqrt{G_{t, ii}+\epsilon}}\cdot g_{t, i}$$
- $g_{t, i}$: $t$번째 스텝에서 파라미터 $i$의 기울기
- $G_{t, ii}$: 파라미터 $i$에 대한 기울기 제곱합의 누적값
- $\eta$: 초기 학습률
- $\epsilon$: 수치 안정성을 위한 보정치 (보통 $10^{-8}$)

# 특성
- 희소 feature가 많은 문제(NLP, 추천 시스템 등)에서 [[Stochastic Gradient Descent]] 대비 효과적이다.
- 기울기 제곱합이 단조증가하므로 학습이 진행될수록 학습률이 계속 감소한다. => 학습 후반부에 업데이트가 사실상 멈추는 문제가 있다.

# 모델별 적용 방식
- [[GloVe - Global Vectors for Word Representation|GloVe]]: [[Co-occurrence Matrix]]의 비영 원소를 확률적으로 샘플링해 학습했다.

# 대표 변형 / 관련 기법
- [[RMSProp]]: 기울기 제곱합 대신 지수 이동 평균을 사용해 학습률 소멸 문제 완화.
- [[Adam]]: RMSProp에 모멘텀을 결합한 형태. 현재 가장 많이 사용되는 옵티마이저.
- [[AdaDelta]]: 학습률을 전혀 지정하지 않는 AdaGrad 변형.

# 등장 논문
- Adaptive Subgradient Methods for Online Learning and Stochastic Optimization (Duchi et al., 2011) - 제안 논문
- [[GloVe - Global Vectors for Word Representation]] (Pennington et al., 2014) - 학습 옵티마이저로 채택.

# 관련 개념
- [[Adam]]
- [[Stochastic Gradient Descent]]

#optimizer