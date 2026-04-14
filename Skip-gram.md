# 정의
중심 단어로부터 주변 문맥 단어들을 예측하는 방식으로 [[Word Embedding]]을 학습하는 모델 아키텍처.

# 구조
중심 단어 하나를 입력으로 받아, 최대 거리 $C$ 이내의 주변 단어들을 예측한다. 거리가 먼 단어일수록 학습 샘플에서 적게 샘플링된다.
$$Q=C \times (D + D \times \log_2(V))$$
- $C$: 최대 윈도우 크기
- $D$: 벡터 차원
- $V$: 어휘 크기

# 핵심 특징
- 하나 → 다수 예측: 중심 단어 하나로 $R \times 2$회의 분류 수행 ($R$: 무작위 샘플링된 윈도우 크기)
- 풍부한 학습 신호: 하나의 단어로 여러 예측을 수행하므로 희귀 단어에 대한 표현 학습에 유리
- 속도: CBOW보단 느림
- 성능: semantic task에서 CBOW보다 우수했으나 syntactic task에선 다소 부족

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - 제안된 아키텍처 중 하나
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - Negative Sampling과 Subsampling 기법 도입.
- [[GloVe - Global Vectors for Word Representation]] (Pennington et al., 2014) - [[Word2Vec]]과의 관계 분석 및 성능 비교 대상으로 등장.

# 관련 개념
- [[Continuous Bag-of-Words]]
- [[Word Embedding]]
- [[Distributed Representation]]
- [[Neural Network Language Model]]