# 정의
말뭉치에서 단어 $i$의 문맥 창(context window) 내에 단어 $j$가 등장한 횟수를 원소 $X_{ij}$로 갇는 $|V|\times|V|$ 크기의 행렬. ($|V|$는 어휘 크기)

# 구성 방식
- 문맥 창 크기: 중심 단어 기준으로 좌우 $d$개 단어를 문맥으로 정의한다. 창이 클수록 의미적(semantic) 정보가 풍부해지고, 작을수록 문법적(syntactic) 정보에 집중됨.
- 대칭성: 문맥 창을 좌우 동일하게 설정하면 $X_{ij} = X_{ji}$가 성립해 행렬이 대칭이 된다.

# 주요 특성
- 어휘 크기 $|V|$의 제곱에 비례하는 크기를 가지므로, 대규모 말뭉치에서는 매우 희소(sparse)함. 0 원소가 전체의 75~95%를 차지하는 경우가 일반적.
- 원소값의 범위가 수십억 토큰 말뭉치에서 8~9자리에 걸쳐 분포하므로, 직접 사용하기 전에 로그 변환이나 [[Positive Pointwise Mutual Information]] 등의 정규화가 필요한 경우가 많음.

# 모델별 적용 방식
- [[Latent Semantic Analysis]]: term-document 행렬 또는 term-term 행렬에 [[Singular Value Decompostion]]를 적용하여 저차원 벡터를 얻음. 원시 빈도를 그대로 사용할 경우 고빈도 단어가 유사도를 지배하는 문제가 있음.
- HAL: term-term 행렬을 사용하되 별도의 정규화 없이 원시 빈도를 유지. 고빈도 단어 문제가 두드러짐.
- [[GloVe - Global Vectors for Word Representation|GloVe]]: 비영(non-zero) 원소에 대해서만 가중최소제곱회귀를 수행. 거리 $d$만큼 떨어진 단어 쌍의 기여를 $1/d$로 감소시켜 반영.

# 관련 개념
- [[Latent Semantic Analysis]]
- [[Positive Pointwise Mutual Information]]
- [[Word Embedding]]

#count-based-model #pretraining