# 정의
[[Transformer]] 계열 모델에서 RNN과 달리 순서 정보가 구조에 내재되어 있지 않으므로, 각 토큰의 시퀀스 내 위치 정보를 명시적으로 주입하는 매커니즘.
- 입력 임베딩 $x_i$에 위치 정보 벡터 $PE_i$를 더해 모델에 전달한다.
- 위치 정보 없이는 Transformer가 토큰 순서를 구별하지 못한다 (순열 불변의 문제)

# 방식별 분류
1. Sinusoidal Postional Encoding
	- [[Attention is All You Need]]에서 제안된 방법.
	- 학습 파라미터 없이 사인/코사인 함수로 위치 벡터를 결정론적으로 생성한다.
	$$PE_{(pos, 2i)} = \sin \left(\dfrac{pos}{10000^{2i/d_{\mathrm{model}}}} \right), \ \ \ \ \ PE_{(pos, 2i)} = \cos \left(\dfrac{pos}{10000^{2i/d_{\mathrm{model}}}} \right)$$
	- 각 차원마다 다른 주기의 파동을 가지므로, 위치마다 고유한 벡터를 얻는다.
	- 학습 데이터에 없는 긴 시퀀스에도 사용 가능하다.
	- 상대 위치 관계가 내적으로 표현 가능하다는 이론적 근거가 존재한다.
2. Learned Positional Embedding
	- 위치 벡터를 학습 가능한 파라미터로 처리한다.
	- 각 위치 $pos$에 해당하는 임베딩 벡터를 데이터에서 직접 학습한다.
	- [[BERT]], [[GPT]]-1/2에서 채택했다.
	- 학습 시 기존 최대 길이를 초과하는 시퀀스에 사용 불가능하다는 한계가 있다.
3. Relative Positional Encoding
	- 절대 위치 대신 토큰 사이의 상대 거리를 인코딩한다.
	- Attention 점수 계산 시 절대 위치가 아닌 두 토큰의 거리 $i-j$를 반영한다.
	- 대표 구현:
		- Transformer-XL (Dai et al., 2019): 세그먼트 경계를 넘는 장거리 의존성을 처리한다.
		- T5 (Reffel et al., 2020): Attention logit에 학습된 상대 위치 bias를 더하는 단순화된 형태.
4. Rotary Position Embedding (RoPE)
	- Query와 Key 벡터를 회전 행렬(rotation matrix)로 변환해 위치 정보를 내적에 자연스럽게 반영한다.
	- 절대 위치를 더하는 대신 상대 위치가 내적값에 직접 반영되는 구조.
	$$\mathrm{Re}(q_m^⊤k_n) = \mathrm{Re}(qe^{im\theta} \cdot ke^{in\theta}) = \mathrm{Re}(qke^{i(m-n)\theta})$$
	- 타 시퀀스 사용 성능이 우수하고 길이 일반화에 강하다.
	- LLaMA, PaLM, GPT-NeoX 등 최근 대형 언어 모델에서 광범위하게 채택되었다.
5. Attention with Linear Biases (ALiBi)
	- Press et al. (2022)에서 제안되었다.
	- Positonal Encoding 벡터를 입력에 더하는 대신, Attention 점수 행렬에 위치 기반 음수 bias를 직접 가산한다.
	$$\mathrm{score}_{ij} = \dfrac{q_i^⊤k_j}{\sqrt{d_k}} - m \cdot |i-j|$$
	- $m$: head마다 다르게 설정된 고정 기울기 파라미터
	- 학습 길이를 훨씬 초과하는 시퀀스에도 사용 성능이 우수하다.
	- 구현이 단순하고 추가 파라미터도 없다.

# 관련 개념
- [[Transformer]]
- [[Multi-Head Attention]]
- [[Scaled Dot-Product Attention]]

#positional-encoding #transformer #sequence-model #architecture 