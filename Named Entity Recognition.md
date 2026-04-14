# 정의
텍스트에서 인명, 지명, 기관명, 기타 고유 개체를 식별하고 사전에 정의된 범주로 분류하는 Sequence Labelling Task.

# 주요 특성
- 출력 형식: 각 토큰에 `BIO2` 등의 태깅 체계로 레이블을 부여. `B`(Begin), `I`(Inside), `O`(Outside)로 개체의 시작, 내부, 외부를 구분한다.
- 평가 지표: [[F1 Score]]
- 특징: 단어 표현의 품질에 민감하게 반응하여, 임베딩 성능을 검증하는 downstream task로 자주 활용됨.

# 모델별 적용 방식
- [[GloVe - Global Vectors for Word Representation|GloVe]]: CoNLL-2003 벤치마크에서 Stanford NER의 이산 Feature에 50차원 GloVe 벡터를 연속 Feature로 추가하여 [[Conditional Random Field]] 학습.

# 대표 변형/관련 기법
- CoNLL-2003: NER 연구에서 표준 벤치마크로 사용되는 Reuters 뉴스 기사 기반 데이터셋. 인명, 지명, 기관명, 기타 4개 범주로 분류됨.
- BIO2 태깅: 개체의 경계를 `B`/`I`/`O` 태그로 표현하는 표준 체계.

# 관련 개념
- [[Sequence Labeling]]
- [[Conditional Random Field]]
- [[Word Embedding]]
