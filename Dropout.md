# 정의
Srivastava et al. (2014)이 제안한 정규화 기법. 학습 중 매 forward pass마다 각 뉴런을 확률 $p$로 무작위 비활성화해 과적합을 방지한다.
$$\tilde h_i = \begin {cases} 0 & \text{with probability } p \\ \dfrac{h_i}{1-p} & \text{with probability } 1-p \end{cases}$$
비활성화되지 않은 뉴런의 출력은 $\dfrac{1}{1-p}$로 스케일업해 기댓값을 유지한다.

# 동장 원리
- 학습 시: 매 step마다 다른 뉴런 부분집합만 활성화해 특정 뉴런 조합에 과도하게 의존하는 co-adaptation을 방지한다.
- 추론 시: 모든 뉴런을 활성화해 스케일 조정 없이 그대로 사용한다.
> [!note] 직관적으로 보면
> 매번 다른 서브네트워크를 학습시키는 것과 같다. 추론 시엔 수많은 서브네트워크들의 앙상블 효과가 나오는 것이다.

# 적용 위치와 $p$ 설정
- 일반적으로 fully connected layer 사이에 적용하며, $p=0.5$가 기본값.
- [[Transformer]]에서는 [[Attention]] 출력, FFN 출력 Embedding에 적용하며 $p=0.1$이 일반적.
- [[LSTM]] 등 RNN에서는 recurrent connection에 직접 적용하면 학습이 불안정해지므로 입출력 방향에만 적용하거나 Variational Dropout을 적용한다.

# 대표 변형 / 관련 기법
- DropConnect: 뉴런이 아닌 가중치 연결을 무작위로 제거한다.
- Variational Dropout: RNN에서 동일한 dropout mask를 time step 전체에 공유한다.
- DropPath / Stochastic Depth: Transformer / ResNet에서 레이어 단위로 dropout
- [[Batch Normalization]]: 정규화 효과가 겹쳐 함께 사용 시, 상호작용에 주의가 필요하다.

# 관련 개념
- [[Batch Normalization]]
- [[Layer Normalization]]
- [[Overfitting]]
- [[LSTM]]
- [[Transformer]]

#regularization #training #overfitting