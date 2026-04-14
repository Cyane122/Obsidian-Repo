# 정의
Ba et al. (2016)이 제안한 정규화 기법. 미니배치가 아닌 단일 샘플의 feature 차원 전체에 대한 정규화를 수행한다.
$$\hat x_i = \dfrac{x_i - \mu}{\sqrt{\sigma^2 + \epsilon}}, \ \ \ \ \ \ y_i = \gamma \hat x_i + \beta$$
- $\mu$, $\sigma^2$: 해당 샘플의 모든 feature에 대한 평균과 분산
- $\gamma$, $\beta$: 학습 가능한 파라미터

# 적용
- [[Transformer]] 아키텍처의 표준 정규화 기법. 각 sub-layer(Attention, FFN) 뒤에 배치한다.
- [[LSTM]] 등 [[Recurrent Neural Networks]] 계열에도 적용할 수 있다.
- 배치 크기가 1인 상황이나 추론 시에도 동작이 안정적이다.
> [!note] Layer Norm의 안정성
> 문장마다 길이가 다르고, 배치 크기도 실험마다 달라지기 때문에, Transformer에서 배치 방향으로만 통계를 내면 불안정함. Layer Norm은 이 샘플 하나 기준으로만 정규화하므로 그런 문제가 덜하다.

# 대표 변형 / 관련 기법
- RMS Nomalization: 평균을 빼는 과정을 생략하고 RMS만으로 정규화한다. LLaMA 등에서 주로 사용된다.
- Pre-norm vs Post-norm: [[Residual Connection]]과의 결합 순서 변형. Pre-norm이 학습 안정성에 유리하다.
- [[Batch Normalization]]: 배치 방향 정규화의 선행 기법.

# 관련 개념
- [[Batch Normalization]]
- [[Transformer]]
- [[Residual Connection]]
- [[LSTM]]

#normalization #training-stabilty #transformer