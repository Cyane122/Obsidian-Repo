# 정의
[[Recurrent Neural Networks]]의 일종으로, 기울기 소실 문제를 해결하기 위해 게이트 메커니즘을 도입한 시퀀스 모델. 장기 의존성(long-range dependency)을 효과적으로 학습할 수 있다.

# 구조
각 time step $t$에서 입력 $x_t$, 이전 은닉 상태 $h_{t-1}$, 이전 셀 상태 $c_{t-1}$을 받아 다음을 계산한다.
## 게이트 연산
$$f_t = \sigma(W_f \cdot [h_{t-1}, x_t] + b_f) \ \ \ \ \\ \ \ \ \ \ \text{(forget gate)}$$
$$i_t = \sigma(W_i \cdot [h_{t-1}, x_t] + b_i) \ \ \ \ \\ \ \ \ \ \ \text{(input gate)}$$
$$o_t = \sigma(W_o \cdot [h_{t-1}, x_t] + b_o) \ \ \ \ \\ \ \ \ \ \ \text{(output gate)}$$

## 셀 상태 및 은닉 상태 갱신
$$\tilde c_t = \tanh(W_c \cdot [h_{t-1}, x_t] + b_c)$$
$$c_t = f_t ⊙ c_{t-1} + i_t ⊙ \tilde c_t$$
$$h_t = o_t ⊙ \tanh(c_t)$$
셀 상태 $c_t$가 장기 기억을 담당하며, forget gate가 과거 정보의 보존 여부를, input gate가 새 정보의 반영 여부를 조절한다.

# 주요 특성
- 장기 의존성 학습: 셀 상태를 통해 기울기가 먼 time step까지 전파될 수 있어 일반 RNN 대비 장기 의존성 포착에 유리하다.
- 게이트를 통한 선택적 정보 흐름: 각 게이트가 정보의 저장, 삭제, 출력을 독립적으로 제어한다.
- Bidirectional LSTM (biLSTM): forward LSTM과 backward LSTM을 결합하여 양방향 문맥을 동시에 인코딩한다.

> [!tip] 셀 상태 $c_t$와 은닉 상태 $h_t$
> $c_t$는 장기 기억을 위핸 내부 컨베이어 벨트 역할. $h_t$는 현재 time step의 출력이자 다음 step으로 전달되는 단기 기억.


# 대표 변형 / 관련 기법
- [[Gated Recurrent Unit]]: forget gate와 input gate를 하나의 update gate로 통합하여 파라미터를 줄인 경량화 변형.
- Peephole LSTM: 게이트 연산에 셀 상태 $c_{t-1}$를 추가로 입력한다.
- Stacked LSTM: 여러 LSTM 레이어를 쌓아 계층적 표현을 학습한다. 상위 레이어일수록 추상적인 정보를 인코딩하는 경향이 있다.
- Variational Dropout: time step마다 다른 마스크를 사용하는 일반 dropout 대신, 동일한 마스크를 시퀀스 전체에 적용하는 정규화 기법.

# 관련 개념
- [[Recurrent Neural Networks]]
- [[bidirectional Language Model]]
- [[Attention]]
- [[Gated Recurrent Unit]]

#sequence-model #RNNs