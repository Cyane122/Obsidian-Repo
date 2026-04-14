# 정의
단어(또는 다른 언어 단위)를 고정된 크기의 실수 벡터로 표현하는 방식. 하나의 개념이 벡터의 여러 차원에 분산되어 인코딩된다.
[[One-hot Encoding]]과 대비되는 개념으로, one-hot vector는 어휘 크기만큼의 고차원 공간에서 단 하나의 차원만 활성화되는 반면, distributed representation은 저차원의 밀집 벡터(dense vector)로 의미를 표현한다.

# 핵심 특징
- 밀집성(Dense): 벡터의 대부분의 차원이 0이 아닌 실수값을 가짐.
- 저차원성: 어휘 크기에 비해 훨씬 작은 차원(보통 50~1000)으로 표현 가능.
- 유사도 인코딩: 의미적으로 유사한 단어는 벡터 공간에서 가까운 위치에 놓임
- 선형 구조: 벡터 사이의 산술 연산으로 의미 관계를 표현할 수 있음.
	e.g. `King - Man + Woman ≈ Queen`

# 등장 논문
[[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013): CBOW / Skip-gram으로 대규모 데이터에서 효율적으로 학습하는 방법 제안.

# 관련 개념
- [[One-hot Encoding]]
- [[Word Embedding]]
- [[Continuous Bag-of-Words]]
- [[Skip-gram]]

> [!tip] distributed
> 하나의 의미가 벡터 전체에 _분산되어_ 담긴다는 뜻.
> one-hot은 의미가 한 점에 몰려 있고, distributed는 여러 차원에 퍼져 있는 것.


#representation-learning #distributional-semantics