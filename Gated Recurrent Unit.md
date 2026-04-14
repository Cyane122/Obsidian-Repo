# 정의
Cho et al. (2014)이 제안한 [[Recurrent Neural Networks]]의 변형으로, [[LSTM]]의 gate 메커니즘을 단순화해 파라미터 수를 줄이면서도 장거리 의존성 학습 능력을 유지한다.

# 구조
GRU는 2개의 gate로 구성된다.
## Reset gate $r_t$
이전 hidden state 중 얼마나 잊을지를 결정한다.
$$r_t = \sigma(W_r x_t + U_r h_{t-1})$$

## Update gate $z_t$
이전 hidden state와 새로운 후보 state를 얼마나 혼합할지 결정한다.
$$z_t = \sigma(W_z x_t + U_z h_{t-1})$$

## 후보 hidden state
$$\tilde h_t = \tanh(W x_t + U(r_t⊙h_{t-1}))$$

## 최종 hidden state
$$h_t = (1-z_t)⊙h_{t-1} + z_t⊙\tilde h_t$$

# 대표 변형 / 관련 기법
- [[LSTM]]: 더 복잡한 gate 구조를 가진 선행 모델
- Minimal GRU: reset gate를 제거한 더 단순화된 변형
- bidirectional RNN: GRU를 양방향으로 적용한 구조

# 관련 개념
- [[LSTM]]
- [[Recurrent Neural Networks]]
- [[Vanishing Gradient]]
- [[Backpropagation]]

#RNNs #sequence-model 