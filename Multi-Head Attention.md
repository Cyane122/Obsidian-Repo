# 정의
[[Attention]] 연산을 단일 representation space에서 한 번 수행하는 대신, 서로 다른 subspace에서 병렬로 여러 번 수행하고 결과를 결합하는 매커니즘.
- 단일 Attention head: 하나의 관점에서 시퀀스 내 관계를 포착
- Multi-Head Attention: $h$개의 head가 각자 다른 관점에서 독립적으로 Attention 수행 -> 다양한 의존 관계를 동시에 모델링한다

# 메커니즘
## 입력 선형 투영
입력 Query $Q$, Key $K$, Value $V$를 head마다 별도의 학습된 가중치 행렬로 투영
$$Q_i = QW_i^Q, \ \ \ \ K_i = KW_i^K, \ \ \ \ V_i = VW_i^V$$
- $W_i^Q \in \mathbb R^{d_{\mathrm{model}} \times d_k}$, $W_i^K \in \mathbb R^{d_{\mathrm{model}} \times d_k}$, $W_i^V \in \mathbb R^{d_{\mathrm{model}} \times d_v}$

## 각 Head에서 [[Scaled Dot-Product Attention]] 수행
$$\mathrm{head}_i = \mathrm{Attention}(Q_i, K_i, V_i) = \mathrm{softmax}\left(\dfrac{Q_iK_i^⊤}{\sqrt{d_k}}\right)V_i$$

## 결과 Concatenate 후 선형 투영
$$\mathrm{MultiHead}(Q, K, V) = \mathrm{Concat}(\mathrm{head}_1, \cdots, \mathrm{head}_h)W^O$$
- $W^O \in \mathbb{R}^{hd_v \times d_{\mathrm{model}}}$: 출력 투영 행렬

# 설계 의도
- head 수 $h$로 나누므로 각 head의 차원은 $d_k = d_v = d_{\mathrm{model}}/h$
- 전체 계산량은 단일 full-dimenstion Attention과 유사하게 유지하면서 표현력 향상
- 각 head가 다른 종류의 의존 관계를 특화해서 학습하는 경향이 실험적으로 관찰됨
	(e.g. 한 head는 syntactic 관계, 다른 head는 장거리 의미 관계에 집중)

# 관련 개념
- [[Attention]]
- [[Scaled Dot-Product Attention]]
- [[Transformer]]
- [[Softmax]]

#attention #transformer #multi-head #representation