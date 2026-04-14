# 정의
비정규화 확률 모델(unnormalized statistical model)을 학습하기 위한 추정 기법. 정답 데이터와 인위적으로 생성한 노이즈 데이터를 이진 분류하는 문제로 변환하여, 분모(정규화 상수) 계산 없이 모델 파라미터를 추정한다.

# 핵심 아이디어
좋은 모델은 실제 데이터와 노이즈를 구별할 수 있어야 한다는 전제에서 출발한다. 노이즈 분포 $P_n(w)$에서 샘플을 추출하고, 모델이 해당 샘플이 실제 데이터인지 노이즈인지를 로지스틱 회귀로 판별하도록 학습한다.

# [[Softmax]]와의 관계
표준 Softmax는 출력 확률 계산 시 전체 어휘 $|V|$에 대한 합산이 필요하다. NCE는 이 정규화 합산을 노이즈 대비 분류 문제로 우회하여 $O(|V|)$ 비용을 $O(k)$로 줄인다.

# 등장 논문
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - Negative Sampling의 출발점으로 언급.

# 관련 개념
- [[Negative Sampling]]
- [[Softmax]]
- [[Skip-gram]]