# 정의
입력 시퀀스를 정방향과 역방향으로 동시에 처리하여, 각 위치의 hidden state가 앞뒤 문맥을 모두 반영하도록 설계된 RNN의 변형.
- 단방향 RNN: $h_j$ 생성 시 $x_1, \cdots, x_j$만 참조.
- bidirectional RNN: $h_j$ 생성 시 $x_1, \cdots, x_{T_x}$ 전체 참조 가능.

# 구조
## Forward RNN $\overrightarrow f$
입력을 $x_1 \rightarrow x_{T_x}$ 순서로 처리.
각 위치에서 forward hidden state $\overrightarrow h_j$ 생성.
$$\overrightarrow h_j = f(x_j, \overrightarrow h_{j-1})$$

## Backward RNN $\overleftarrow h_j$
입력을 $x_{T_x} \rightarrow x_1$ 순서로 처리.
각 위치에서 backward hidden state $\overleftarrow h_j$ 생성
$$\overleftarrow h_j = f(x_j, \overleftarrow h_{j-1})$$

## Annotation Concat
두 방향의 hidden state를 concatenate하여 최종 Annotation을 생성한다.
$$h_j = \begin {bmatrix} \overrightarrow h_j \\ \overleftarrow h_j \end{bmatrix}$$
- $h_j$: $x_j$를 중심으로 앞뒤 문맥을 모두 담은 표현
- RNN의 특성상 최근 입력을 더 강하게 반영한다. 즉, $h_j$는 $x_j$ 주변 문맥에 집중한다.

# 적용 사례
- [[Neural Machine Translation by Jointly Learning to Align and Translate]] (Bahdanau et al., 2015)
- [[Deep Contextualized Word Representations]] (Peters et al., 2018)

# 대표 변형 / 관련 기법
- biLSTM: LSTM 셀 기반 bidirectional RNN.
- biGRU: GRU 셀 기반 bidirectional RNN. 경량화된 대안
- Multi-layer biRNN: 여러 층으로 쌓아 고수준 표현 학습
- Transformer Encoder: Self-Attention을 통해 RNN 없이 양방향 문맥을 처리한다.

# 관련 개념
- [[Recurrent Neural Networks]]
- [[LSTM]]
- [[Attention]]
- [[Transformer]]

#RNNs #Encoder #sequence-model