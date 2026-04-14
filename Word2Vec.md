# 정의
[[Efficient Estimation of Word Representations in Vector Space|Mikolov et al. (2013)]]이 제안한 단어 임베딩 학습 프레임워크. [[Skip-gram]]과 [[Continuous Bag-of-Words]] 두 아키텍처를 포함하며, 대규모 말뭉치에서 효율적으로 고품질 단어 벡터를 학습한다.

# 구성
- [[Skip-gram]]: 중심 단어로부터 문맥 단어를 예측. 희귀 단어 표현에 유리하다.
- [[Continuous Bag-of-Words]]: 문맥 단어들로부터 중심 단어를 예측. 학습 속도가 빠르다.

# 핵심 기법
- [[Negative Sampling]]: [[Softmax]] 정규화 비용을 피하기 위해 소수의 무작위 음성 샘플만 사용하여 목적함수를 근사.
- [[Subsampling of Frequent Words]]: 고빈도 단어(the, a 등)를 확률적으로 학습에서 제외하여 학습 속도와 희귀 안어 표현 품질을 향상.
- [[Hierarchical Softmax]]: Negative Sampling의 대안. 어휘를 이진 트리로 구성하여 $O(\log V)$로 정규화 계산.

# 한계
- 개별 문맥 창을 순회하는 온라인 학습 방식이므로 말뭉치 전체의 전역 공동출현 통계를 직접 활용하지 않음.
- 단일 에폭으로 설계되어 있어 반복 학습이 비자명함.
- Negative Sampling의 경우 음성 샘플 수가 일정 수준을 초과하면 오히려 성능이 저하됨.

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - Skip-gram, CBOW 아키텍쳐 제안.
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - Negative Sampling, Subsampling, Phrase 벡터 확장.
- [[GloVe - Global Vectors for Word Representation]] (Pennington et al., 2014) - 동일 말뭉치, 동일 학습 시간 기준 비교 대상. GloVe가 일관되게 우수함을 보임.

# 관련 개념
- [[Skip-gram]]
- [[Continuous Bag-of-Words]]
- [[Negative Sampling]]
- [[Word Embedding]]
- [[Co-occurrence Matrix]]