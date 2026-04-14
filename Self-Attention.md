## 정의
[[Attention is All You Need]]에서 제안된 하나의 시퀀스 내부에서 각 토큰이 다른 모든 토큰을 참조하여 새로운 표현을 만드는 [[Attention]]의 일종.
- 입력: 시퀀스 $X=(x_1, \cdots, x_n)$
- 출력: 각 위치마다 context-aware representation

# 동작 구조
각 토큰은 세 가지 벡터로 분리되며, 각각은 입력 $x$에 대한 선형 변환으로 생성된다.
- Query (Q): $Q = XW_Q$ : 나는 무엇을 찾고 싶은가?
- Key (K): $K=XW_K$ : 나는 어떤 정보를 가지고 있는가?
- Value (V): $V=XW_V$ : 실제로 전달할 정보.
-> [[Scaled Dot-Product Attention]] 적용!

# 특징
1. 거리 무관성: 멀리 떨어진 토큰도 동일한 비용으로 참조 가능.
2. 병렬 처리 가능: 모든 토큰을 동시에 계산한다.
3. Global dependency modeling: 전체 시퀀스를 한 번에 고려한다.

# 적용 사례
- reading comprehension
- abstractive summarization
- textual entailment
- sentence representation learning