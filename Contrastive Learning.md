# 정의
유사한 샘플 쌍(positive pair)은 임베딩 공간에서 가깝게, 비유사한 샘플 쌍은(negative pair)은 멀어지도록 표현을 학습하는 자기지도학습(self-supervised learning) 패러다임. 정답 레이블 없이 데이터 간의 상대적 유사도를 학습 신호로 활용한다.

# 메커니즘
- Positive pair: 동일한 데이터에서 파생된 두 뷰(view). e.g. 같은 이미지의 두 가지 augmentation, 또는 이미지와 그에 대응하는 캡션
- Negative pair: 서로 다른 데이터에서 온 샘플 쌍
- 학습 목표: positive pair의 임베딩 유사도는 최대로, negative pair의 임베딩 유사도는 최소로.

# 대표 손실함수
- [[InfoNCE Loss]]: batch 내 $N$개 샘플 중 올바른 positive를 식별하는 분류 문제로 전환한다.
$$\mathcal L = - \log \dfrac{\exp(\mathrm{sim}(z_i, z_j^+)/\tau)}{\sum_{k=1}^N \exp (\mathrm{sim} (z_i, z_k)/\tau)}$$

# 대표 변형 / 관련 기법
- SimCLR: 이미지 augmentation 기반 self-supervised contrastive learning
- MoCo: momentum encoder를 활용한 large negative queue 유지
- CLIP: 이미지-텍스트 cross-modal contrastive learning

#contrastive-learning #self-supervised #representation-learning #metric-learning