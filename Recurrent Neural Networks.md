# 정의
시퀀스 데이터를 처리하기 위해 이전 시점의 은닉 상태를 현재 시점의 입력으로 재귀적으로 활용하는 신경망 구조.
$${\bf h}_t = f({\bf W}_h {\bf h}_{t-1} + {\bf W}_x {\bf x}_t + {\bf b})$$
- ${\bf h}_t$: 시점 $t$의 은닉 상태
- ${\bf x}_t$: 시점 $t$의 입력
- ${\bf W}_h$: 재귀 가중치 행렬 (hidden-to-hidden)

# 핵심 특징
- 가변 길이 입력 처리: 고정 크기 문맥 윈도우가 필요한 Feedforward [[Neural Network Language Model|NNLM]]과 달리, 임의 길이의 시퀀스를 처리 가능
- 단기 기억: 은닉 상태가 과거 정보를 암묵적으로 보존
- 투영층 없음: [[Neural Network Language Model|NNLM]]과 달리, 별도의 투영층 없이 입력층 → 은닉층 → 출력층 구조.
- 계산 복잡도: $Q = H\times H + H \times V$
	- 지배항: $H \times H$ (재귀 행렬 연산)

# 한계
- 장기 의존성 문제: 시퀀스가 길어질수록 초기 정보가 소실됨 (vanishing gradient)
- 이를 극복하기 위해 [[LSTM]], [[GRU]] 등이 제안됨.

# 언어 모델에서의 역할
RNN 기반 언어 모델(RNNLM)은 syntactic similarity task에서는 강점을 보이나, semantic task에서는 [[Continuous Bag-of-Words]], [[Skip-gram]]에 비해 부족하다.

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - 비교 대상 모델로 등장
