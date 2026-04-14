# 정의
단어를 저차원 실수 벡터 공간에 매핑하는 기법의 총칭.
[[Distributed Representation]]을 단어에 적용한 것으로, 의미적으로 유사한 단어가 벡터 공간에서 가까운 위치에 놓이도록 학습된다.

# 핵심 특징
- 학습 기반: 대규모 텍스트 말뭉치로부터 데이터 기반으로 학습됨
- 의미 인코딩: 단어 사이의 유사도나 관계가 벡터 연산으로 표현됨
- 전이 가능성: 학습된 벡터를 다양한 downstream NLP task에 재사용 가능
- 차원: 일반적으로 저차원(50~1000)

# 대표 학습 방법
- [[Continuous Bag-of-Words]]: 주변 단어들로 중심 단어를 예측
- [[Skip-gram]]: 중심 단어로 주변 단어들을 예측

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - CBOW / Skip-gram 기반 word embedding의 효율적 학습 방법 제안

# 관련 개념
- [[Distributed Representation]]
- [[One-hot Encoding]]
- [[Continuous Bag-of-Words]]
- [[Skip-gram]]
- [[Neural Network Language Model]]

#word-embedding #representation-learning 