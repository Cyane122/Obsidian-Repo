# 정의
[[Backpropagation]] 과정에서 gradient가 이전 time step 또는 이전 레이어로 전파될수록 지수적으로 작아져 사실상 0에 수렴하는 현상. 이로 인해 네트워크의 초기 레이어 또는 먼 time step의 파라미터가 거의 업데이트되지 않아 장거리 의존성 학습이 불가능해진다.

# 발생 원인
[[Backpropagation]]에서 gradient는 시간 단계를 거슬러 올라갈 때 반복적인 행렬 곱셈을 통해 전파된다.
$$\dfrac{\partial L} {\partial h_t} = \dfrac{\partial L} {\partial h_T} \displaystyle \prod_{k=t}^{T-1} \dfrac{\partial h_{k+1}}{\partial h_k}$$
각 time step에서의 Jacobian $\dfrac{\partial h_{k+1}}{\partial h_k}$의 최대 고윳값이 1보다 작을 경우, 이 곱은 시간 거리에 따라 지수적으로 감소한다. [[Sigmoid]]나 [[Tanh]] 같은 포화 활성화 함수는 입력이 커지면 미분값이 0에 가까워지기 때문에 이 문제를 심화시킨다.

# 결과 및 영향
- RNN은 이론적으로 임의의 길이 시퀀스를 처리할 수 있지만, 이로 인해 실제로는 수십 step 이상의 장거리 의존성을 학습하기 어렵다.
- 네트워크가 깊어질수록(레이어가 많아질수록) 동일한 문제가 레이어 방향으로도 발생한다.

# 대표 변형 / 관련 기법
- [[LSTM]]: gate 구조(input/output/forget gate)를 도입해 gradient가 흐르는 경로를 보호함으로써 이 문제를 구조적으로 완화
- [[Gated Recurrent Unit]]: LSTM을 단순화한 구조로, 유사한 방식으로 Vanishing Gradient에 대응
- [[Residual Connection]]: 깊은 Feedforward 네트워크에서 gradient 흐름을 보조하는 skip connection
- [[Batch Normalization]] / [[Layer Normalization]]: 레이어 간 activation 분포를 안정화해 gradient 전파를 개선

# 관련 개념
- [[Backpropagation]]
- [[LSTM]]
- [[Exploding Gradient]]
- [[Recurrent Neural Networks]]

#optimization #gradient #training #RNNs 