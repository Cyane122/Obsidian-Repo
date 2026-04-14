# 정의
신경망을 이용하여 단어 시퀀스의 확률 분포 $P(w_t | w_{t-1}, \cdots, w_{t-N+1})$를 추정하는 언어 모델의 총칭.
단어를 [[Distributed Representation]]으로 표현하며 학습하는 초기 모델군을 포함한다.

# 주요 아키텍처
## Feedforward NNLM (Bengio et al., 2003)
- 입력: 이전 $N$개 단어를 one-hot으로 인코딩
- 구조: 투영층(Projection) → 은닉층(Hidden) → 출력층(Output)
- 계산 복잡도: $Q=N \times D + N \times D \times H + H \times V$
	- 지배적 항: $H \times V$ ([[Hierarchical Softmax]]로 $H \times \log_2 (V)$로 감소 가능)

## Recurrent NNLM (RNNLM)
- [[Recurrent Neural Networks]] 기반으로 고정 길이 문맥의 제약을 극복
- 구조: 입력층 → 은닉층(재귀 연결) → 출력층 (투영층 없음)
- 계산 복잡도: $Q=H \times H + H \times V$

# 한계
- 은닉층의 비선형 연산으로 인한 높은 계산 비용
- 대규모 어휘에서 출력층 계산량이 $O(V)$에 달함
- [[Continuous Bag-of-Words]], [[Skip-gram]]은 이 은닉층을 제거하여 효율을 극적으로 향상시킴

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikilov et al., 2013) - NNLM의 계산 복잡도 분석을 출발점으로 삼아 경량 아키텍처 제안

# 관련 개념
- [[Distributed Representation]]
- [[Word Embedding]]
- [[Continuous Bag-of-Words]]
- [[Skip-gram]]
- [[Hierarchical Softmax]]
- [[Recurrent Neural Networks]]

#language-model #neural-network