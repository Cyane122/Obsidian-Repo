# 정의
디코더가 출력 시퀀스의 각 토큰을 생성할 때, 입력 시퀀스 전체를 균등하게 참조하는 대신 현재 생성 단계와 관련성이 높은 위치에 선택적으로 집중하는 메커니즘.
- 입력 시퀀스를 단일 벡터로 압축하지 않고 Annotation 시퀀스 전체를 유지한다.
- 각 생성 step마다 Annotation에 대한 가중치 분포(attention distribution)를 동적으로 계산한다.
- 컨텍스트 벡터 $c_i$는 그 가중치로 Annotation을 합산한 값
$$c_i = \displaystyle \sum_{j=1}^{T_x} \alpha_{ij}h_j$$

# 메커니즘
1. 유사도 점수 계산 (Score Function)
	- 현재 디코더 상태 $s_{i-1}$과 각 소스 Annotation $h_j$ 사이의 관련성 점수 $e_{ij}$ 계산

| 방식                 | 수식                                 | 특징                                      |
| ------------------ | ---------------------------------- | --------------------------------------- |
| Additive           | $v^⊤ \tanh(Ws_{i-1}+UH_j)$         | feedforward 신경망, jointly 학습             |
| Dot-Product        | $s^⊤_{i-1}h_j$                     | 파라미터 없음. 계산 효율적                         |
| Scaled Dot-Product | $\dfrac{s_{i-1}^⊤h_j}{\sqrt{d_k}}$ | 차원 수 $d_k$로 스케일링. [[Transformer]]에서 사용. |

2. 가중치 정규화: 점수를 [[Softmax]]로 정규화. 합이 1인 확률분포 $\alpha_{ij}$를 만든다.
$$\alpha_{ij} = \dfrac{\exp(e_{ij})}{\sum_{k=1}^{T_x} \exp(e_{ik})}$$

3. 맥락 벡터 계산
	- $\alpha_{ij}$를 가중치로 Annotation $h_j$를 합산한다.
	- 결과 $c_i$는 현재 생성 step에서 소스 시퀀스의 기댓값(expected annotation).

# Soft-Attention vs. Hard-Attention
- Soft-Attention: 모든 소스 위치에 연속적인 가중치 부여 - 미분 가능하며 end-to-end 학습 가능
- Hard-Attention: 하나의 소스 위치만 이산적으로 선택 - 미분 불가능하며 강화학습이 필요하다.
- NLP에서는 사실상 Soft가 표준.

# [[Self-Attention]]
- 소스-타깃 간 Attention이 아닌 동일 시퀀스 내부의 토큰 사이의 관계 계산.
- Query, Key, Value 모두 같은 시퀀스에서 유래.
- [[Transformer]]의 핵심 구성 요소.

# 관련 개념
- [[Encoder-Decoder]]
- [[bidirectional RNN]]
- [[Transformer]]
- [[Multi-Head Attention]]
- [[Softmax]]

#attention #seq2seq #transformer #alignment 