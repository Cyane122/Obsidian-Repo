# 정의
[[Attention]]의 구체적인 구현 방식 중 하나. 다음의 공식을 따른다.
	$\mathrm{Attention}(Q, K, V) = \mathrm{softmax}\left(\dfrac{QK^T}{\sqrt{d_k}}\right)V$

# 구성 요소
1. Dot-Product:
	$QK^T$: Query - Key 유사도
2. Scaling:
	$\dfrac{1}{\sqrt{d_k}}$
	- 값이 커지는 것 방지
	- softmax saturation 방지
3. [[Softmax]]: attention weight 생성
4. Weighted sum: Value 결합

# 특징
- 계산 효율적 (행렬 연산)
- GPU 병렬화에 적합