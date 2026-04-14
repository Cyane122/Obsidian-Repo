# 정의
[[Pointwise Mutual Information]]에서 음수 값을 0으로 클리핑한 변환 기법. 공동출현이 우연보다 드문 단어 쌍의 부정적 연관성을 제거하여 실용적으로 사용 가능한 형태로 만든다.
$$\mathrm{PPMI}(i, j) = \max(\mathrm{PMI}(i, j), 0)$$

# 특성
- PMI가 가진 희귀 단어 쌍의 과대평가 문제를 일부 완화하나 근본적으로 해결하지는 못한다.
- 음수를 0으로 치환하므로 원본 [[Co-occurrence Matrix]]의 희소성을 유지한다.
- 단어 유사도 과제에서 원시 빈도 기반 방법보다 일관되게 우수한 성능을 보인다.

# 모델별 적용 방식
- [[GloVe - Global Vectors for Word Representation|GloVe]]: 공동출현 행렬 변환 기법의 선행 연구로 언급되나, 대규모 어휘에서 희소성을 파괴하는 변형들과 함께 묶여 적용이 어렵다는 한계가 지적됨.

# 관련 개념
- [[Pointwise Mutual Information]]
- [[Co-occurrence Matrix]]
- [[Latent Semantic Analysis]]
- [[Word Embedding]]
