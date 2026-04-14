# 정의
[[Skip-gram]] 모델의 학습 목표를 단순화한 기법. [[Noise Contrastive Estimation]]에서 파생되었으며, 정답 단어(positive sample)와 노이즈 분포에서 추출한 $k$개의 오답 단어(negative sample)를 이진분류하는 방식으로 파라미터를 학습한다.

# 목표 함수
매 학습 스텝마다 다음 목표 함수를 최대화한다:
$$\log \sigma(v^{'⊤}_{w_O}v_{w_I}) + \displaystyle \sum_{i=1}^k \mathbb{E}_{w_i ~ P_n(w)} [\log \sigma(-v^{'⊤}_{w_i}v_{w_I})]$$
- $\log \sigma(v^{'⊤}_{w_O}v_{w_I})$: 정답 단어 쌍의 점수를 높임
- $\displaystyle \sum_{i=1}^k \mathbb{E}_{w_i ~ P_n(w)} [\log \sigma(-v^{'⊤}_{w_i}v_{w_I})]$: 노이즈에서 샘플링된 $k$개 단어의 점수를 낮춤.
- Skip-gram 목표 함수의 각 $\log P(w_O | w_I)$ 항을 위 식으로 대체한다.

# 노이즈 분포
$P_n(w)$는 자유 파라미터. unigram distribution $U(w)$를 3/4제곱한 분포가 유니그램 및 균등 분포 대비 일관되게 우수한 성능을 보였다:
$$P_n(w) = \dfrac{U(w)^{3/4}}{Z}$$
자주 등장하는 단어의 샘플링 확률을 낮추고, 희귀 단어의 확률을 상대적으로 높이는 효과가 있다.

# $k$ 선택 기준
- 소규모 데이터셋: $k = 5 \sim 20$
- 대규모 데이터셋: $k = 2 \sim 5$

# NCE와의 차이
|               |        NCE         | Negative Sampling |
| :-----------: | :----------------: | :---------------: |
|    필요한 정보     | 샘플 + 노이즈 분포의 수치 확률 |        샘플만        |
| softmax 근사 보장 |         O          |         X         |
|      목적       |       언어 모델링       |   고품질 벡터 표현 학습    |
Negative Sampling은 [[Softmax]] 로그 확률의 최대화를 보장하진 않지만, 벡터 표현의 품질 유지에는 충분하다!

> [!note] Softmax를 안 쓰는 게 아니다!
> NCE에서 '수치 확률까지는 필요없고, 진짜 단어와 가짜 단어 구별만 되면 된다'는 생각으로 단순화한 것이 NEG.
> 전체 어휘 합산 대신 $k$개 비교로 대체하는 것!


# 등장 논문
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - 제안 및 실험 검증.

# 관련 개념
- [[Noise Contrastive Estimation]]
- [[Skip-gram]]
- [[Hierarchical Softmax]]
- [[Softmax]]

#training-objective #efficiency
