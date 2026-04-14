# 정의
주변 문맥 단어들로부터 중심 단어를 예측하는 방식으로 [[Word Embedding]]을 학습하는 모델 아키텍처.

# 구조
입력으로 중심 단어 앞뒤 각각 $N$개씩 총 $2N$개의 단어를 받아, 이들의 벡터를 평균한 뒤 중심 단어를 예측한다.
$$Q = N \times D + D \times \log_2(V)$$
- $N$: 윈도우 크기 (앞뒤 각 단어 수)
- $D$: 벡터 차원
- $V$: 어휘 크기

# 핵심 특징
- 순서 무시: 문맥 단어들의 순서를 고려하지 않음 (bag-of-words의 특징)
- 투영층 공유: 모든 단어 위치에 동일한 투영 행렬 사용
- 은닉층 없음: [[Neural Network Language Model]]의 비선형 은닉층을 제거하여 계산
- 속도: Skip-gram보다 학습이 빠름
- 성능: syntactic task에서 skip-gram보다 우수했으나 semantic task에서는 다소 부족.

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - 제안된 아키텍처 중 하나.
- [[GloVe - Global Vectors for Word Representation]] (Pennington et al., 2014) - 성능 비교 대상으로 등장.

# 관련 개념
- [[Skip-gram]]
- [[Word Embedding]]
- [[Distributed Representation]]
- [[Neural Network Language Model]]