# 정의
$K$개의 클래스에 대한 logit vector ${\bf z}=[z_1, z_2, \cdots, z_K]$를 확률 분포로 변환하는 함수.
$$\mathrm{Softmax}(z_i) = \dfrac{e^{z_i}}{\sum_{j=1}^K e^{z_j}}$$
출력값은 (0, 1) 범위이며 모든 클래스에 대한 출력의 합은 1이 된다.

# 핵심 특징
- 정규화: 출력이 확률 분포를 이루도록 보장
- 미분 가능: [[Backpropagation]]을 통한 학습 가능
- 계산 비용: 분모 계산에 전체 클래스 $K$에 대한 합산이 필요 → $O(K)$
	- 언어 모델에서 $K=|V|$이므로, 어휘가 클수록 계산 비용이 급증.

# 한계 및 대안 기법
어휘 크기 $|V|$가 수만~수십만에 달하는 언어 모델에서 매 학습 스텝마다 $O(|V|)$ 연산이 필요하므로 병목 발생.
이를 해결하기 위해 여러 기법들이 제안되었다.
- [[Hierarchical Softmax]]: 어휘를 이진 트리로 구조화하여 $O(\log_2 |V|)$로 감소시킨다.
- [[Negative Sampling]]: 전체 어휘 대신 소수의 negative sample만 사용하여 근사한다.
- [[Noise Contrastive Estimation]]: 실제 데이터와 노이즈 데이터를 이진 분류하는 방식으로 정규화 합산을 우회한다.
- Sampled Softmax: 학습 시 일부 클래스만 샘플링하여 분모를 근사한다.

# 관련 개념
- [[Hierarchical Softmax]]
- [[Neural Network Language Model]]
- [[Backpropagation]]
- [[Negative Sampling]]

#activation-function #efficiency