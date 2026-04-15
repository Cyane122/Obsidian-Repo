# 정의
입력 시퀀스를 하나의 벡터 표현으로 압축하는 Encoder와, 그 벡터로부터 출력 시퀀스를 생성하는 Decoder로 구성된 신경망 아키텍처.
- Encoder: 가변 길이 입력 시퀀스 -> 고정 길이 컨텍스트 벡터 $c$
- Decoder: $c$ -> 가변 길이 출력 시퀀스

# 구조
Encoder와 Decoder는 하나의 목적함수로 jointly하게 학습된다.
## Encoder
- 입력 토큰 $x = (x_1, \cdots, x_{T_x})$를 순차적으로 처리
- 최종 hidden state를 컨텍스트 벡터 $c$로 사용
- $h_t = f(x_t, h_{t-1})$
- $c = q(\{h_1, \cdots, h_{T_x}\})$

# Decoder
- $c$와 이전 생성 토큰을 조건으로 다음 토큰 예측
- $p(y) = \prod_{t=1}^{T} p(y_t | \{y_1, \cdots, y_{t-1}\}, c)$

# 한계
- 소스 문장의 모든 정보를 단일 고정 길이 벡터에 압축해야 한다.
- 문장이 길어질수록 정보 손실이 심화되어 번역 품질이 급락한다.

# 관련 개념
- [[Attention]]
- [[LSTM]]

#seq2seq #architecture #encoder-decoder 