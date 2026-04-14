# 정의
순방향(forward)과 역방향(backward) 언어 모델을 결합하여 토큰의 양방향 문맥을 동시에 모델링하는 언어 모델. 각 토큰에 대해 왼쪽 문맥과 오른쪽 문맥 모두를 인코딩한 표현을 생성한다.

# 구조
## Forward LM
시퀀스 $(t_1, t_2, \cdots, t_N)$이 주어졌을 때, 이전 토큰들로부터 현재 토큰의 확률을 모델링한다.
$$p(t_1, t_2, \cdots, t_N) = \displaystyle \prod_{k=1}^N p(t_k | t_1, \cdots, t_{k-1})$$
각 위치 $k$에서 $L$개의 [[LSTM]] 레이어를 통과하며, 레이어 $j$의 출력을 $\overrightarrow h _{k, j}^{LM}$으로 표기한다.

## Backward LM
시퀀스를 역방향으로 처리하여 이후 토큰들로부터 현재 토큰의 확률을 모델링한다.
$$p(t_1, t_2, \cdots, t_N) = \displaystyle \prod_{k=1}^N p(t_k | t_{k+1} , \cdots, t_N)$$
레이어 $j$의 출력을 $\overleftarrow h {}_{k, j}^{LM}$으로 표기한다.

## 결합 학습
목적함수 양방향의 log likelihood를 동시에 최대화한다.
$$\displaystyle \sum_{k=1}^N \left(\log p(t_k | t_1, \cdots, t_{k-1}; \theta_x, \overrightarrow \theta_{LSTM}, \theta_s) + \log p(t_k | t_{k+1}, \cdots, t_N; \theta_x, \overleftarrow \theta {}_{LSTM}, \theta_s) \right)$$
토큰 표현: 파라미터 $\theta_x$와 [[Softmax]] 레이어 파라미터 $\theta_s$는 양방향이 공유하며, LSTM 파라미터는 방향별로 독립적으로 유지한다.

## 레이어 표현
$L$층 biLM은 각 토큰 $t_k$에 대해 $2L+1$개의 표현을 생성한다.
$$R_k = \{x_k^{LM}, \overrightarrow h _{k, j}^{LM}, \overleftarrow h {}_{k, j}^{LM} | j = 1, \cdots, L \}$$
- $x_k^{LM}$: 문맥 독립적인 토큰 임베딩 (레이어 0)
- $h_{k, j}^{LM}=[\overrightarrow h _{k, j}^{LM}; \overleftarrow h {}_{k, j}^{LM}]$: 각 biLSTM 레이어의 결합 표현

## 레이어별 인코딩 특성
deep biLM에서 레이어마다 인코딩하는 정보의 종류가 다름이 실험적으로 확인되었다.
- 하위 레이어: 구문론적 정보를 주로 인코딩
- 상위 레이어: 의미론적 정보를 주로 인코딩

# 등장 논문
- Semi-supervised Sequence Tagging with Bidirectional Language Models (Peters et al., 2017) - biLM의 최상위 레이어만을 문맥 표현으로 활용하는 방식(TagLM)을 제안.
- [[Deep Contextualized Word Representations]] (Peters et al., 2018) - biLM의 모든 레이어 표현을 task별로 가중 합산하는 ELMo를 제안.

# 관련 개념
- [[LSTM]]
- [[Language Model]]