# 정의
대규모 말뭉치의 term-document 행렬 또는 term-term 행렬에 [[Singular Value Decompostion]]을 적용하여 저차원 밀집 벡터 표현을 얻는 행렬 분해 기반 의미 분석 방법.

# 핵심 아이디어
원본 행렬은 고차원, 희소하므로 저차원 근사를 통해 노이즈를 줄이고 잠재적 의미 구조를 포착한다. 차원 축소 과정에서 유사한 문맥에서 등장하는 단어들이 벡터 공간상 가까운 위치에 놓이게 된다.

# 한계
- 단어 유추 과제에서 성능이 낮음 (벡터 공간의 선형 부분구조가 약함)
- 말뭉치 통계를 효율적으로 활용하지만, 빈도 정보를 그대로 사용할 경우, 고빈도 단어(the, and 등)가 유사도 측정을 지배하는 문제가 있음
이를 완화하기 위해 PPMI, Hellinger PCA 등의 변환 기법이 제안되었으나 근본적 한계는 유지되었다.

# 대표 변형/관련 기법
- HAL (Hyperspace Analogue to Language): term-term 행렬 사용. 고빈도 단어 문제가 두드러짐.
- COALS: 엔트로피 또는 상관관계 기반 정규화로 공동출현 행렬을 변환 후 SVD 적용.
- [[Positive Pointwise Mutual Information]]: 공동출현 행렬 변환 기법 중 가장 성능이 좋은 것으로 알려짐.
- [[Hellinger PCA]]: 제곱근 변환 형태의 PCA 적용.

> [!note] Analogy Task에서
>  LSA가 analogy task에서 약한 이유는 SVD로 얻은 벡터 공간이 선형 관계를 보존하도록 설계된 게 아니기 때문이다.
>  전체 통계를 잘 압축하는 것이 목표일 뿐, 벡터 차이가 의미를 담도록 강제하지 않았다.

# 등장 논문
- [[GloVe - Global Vectors for Word Representation]] (Pennington et al., 2014) - 전역 행렬 분해 계열의 대표 선행 방법으로 언급.

# 관련 개념
- [[Singular Value Decompostion]]
- [[Co-occurrence Matrix]]
- [[Word Embedding]]
- [[Positive Pointwise Mutual Information]]