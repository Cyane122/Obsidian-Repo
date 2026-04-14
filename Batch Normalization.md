# 정의
Ioffe & Szegedy (2015)가 제안한 기법으로, 미니배치 단위로 각 레이어의 입력 분포를 정규화해 학습을 안정화한다.
$$\hat x_i = \dfrac{x_i - \mu_B}{\sqrt{\sigma^2_B + \epsilon}}, \ \ \ y_i = \gamma \hat x_i + \beta$$
- $\mu_B$, $\sigma_B^2$: 미니배치의 평균과 분산.
- $\gamma$, $\beta$: 학습 가능한 스케일/이동 파라미터.

# 목적 및 효과
학습 과정에서 각 레이어의 입력 분포가 지속적으로 변화하는 현상을 Internal Covariate Shift라 하는데, Batch Normalization은 이를 억제해 다음 효과를 얻는다.
- 더 높은 학습률 사용 가능 -> 학습 속도 향상
- 가중치 초기화에 덜 민감함
- [[Dropout]]과 유사한 정규화 효과 -> 과적합 억제

# 한계
- 배치 크기 의존성: 배치 크기가 작으면 $\mu_B$, $\sigma_B^2$ 추정이 불안정해짐
- 시퀀스 모델 부적합: RNN / Transformer처럼 시퀀스 길이가 가변적이면 배치 간 통계가 불안정해 적용이 어려움. [[Layer Normalization]]이 대안으로 사용됨.
- 추론 시: 배치 통계 대신 학습 중 누적된 이동 평균(running mean/varience)을 사용

>[!warning] 주의
>NLP/Transformer 계열에서는 Batch Normalization보다 [[Layer Normalization]]이 표준. 배치 크기나 시퀀스 길이 변동에 영향을 받지 않기 때문.

# 대표 변형 / 관련 기법
- [[Layer Normalization]]: 배치가 아닌 feature 차원 방향으로 정규화. Transformer의 표준.
- Instance Normalization: 각 샘플 개별로 정규화. 이미지 스타일 변환에 사용.
- Group Normalization: 채널을 그룹으로 묶어 정규화. 배치 크기가 작은 경우 대안.

# 관련 개념
- [[Transformer]]
- [[Vanishing Gradient]]
- [[Dropout]]

#normalization #training-stabilty #deep-learning 