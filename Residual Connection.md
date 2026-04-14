# 정의
He et al. (2015)이 제안한 구조로, 레이어의 입력을 해당 레이어의 출력에 직접 더해주는 skip connection.
$$\mathrm{output} = F(x)+x$$
여기서 $F(x)$는 레이어가 학습하는 변환이며, 레이어는 항등함수로부터의 *잔차(residual)* 만 학습하면 된다.

# 목적 및 효과
1. Gradient 흐름 개선: $\dfrac{\partial L}{\partial x} = \dfrac{\partial L}{\partial \mathrm{output}} \cdot (F'(x)+1)$에서 $+1$항이 gradient가 레이어를 우회해 직접 흐르는 경로를 제공해 [[Vanishing Gradient]]를 완화한다.
2. 최적화 용이성: 레이어가 항등함수를 학습하는 것이 쉬워져, 깊이를 늘려도 성능이 저하되지 않는다(degradation 문제 해결).

>[!note] 고작 더하기?
>gradient 입장에서 보면, [[Backpropagation]] 때 이 $+x$ 경로가 깊은 레이어를 통과하지 않고 초기 레이어까지 직접 전달되기 때문이다. [[Transformer]]가 이 구조를 적극적으로 채택했고, 이내 NLP에서도 핵심 구조가 되었다.

# 대표 변형 / 관련 기법
- Pre-norm vs Post-norm: Residual Connection과 [[Layer Normalization]]의 적용 순서. Transformer 원 논문은 Post-norm이었으나, 이후 연구들은 Pre-norm이 학습 안정성이 더 유리함을 보였다.
- Dense Connection: 모든 이전 레이어의 출력을 연결하는 더 적극적인 변형.
- Highway Network: gate를 이용해 skip 비율을 학습하는 초기 변형.

# 관련 개념
- [[Vanishing Gradient]]
- [[Layer Normalization]]
- [[Transformer]]
- [[Batch Normalization]]

#optimization #gradient #deep-learning #architecture
