# 정의
시퀀스 생성 모델에서 가장 높은 확률의 출력 시퀀스를 근사적으로 탐색하는 디코딩 알고리즘. 매 time step마다 상위 $B$개 (beam width)의 후보 시퀀스(hypothesis)만 유지하면서 탐색 공간을 제한한다.

# 동작 방식
완전 탐색(exhaustive search)은 어휘 크기 $V$, 시퀀스 길이 $T$에 대해 $V^T$개의 후보를 검토해야 하므로 현실적으로 불가능하다. Beam search는 이를 다음과 같이 근사한다.
1. 시작 토큰에서 상위 $B$개의 첫 번째 토큰을 선택해 초기 beam을 구성
2. 각 시간 단계에서 현재 beam의 각 후보에 어휘 전체를 확장 -> $B \times V$개의 후보 생성
3. 전체 누적 로그 확률 기준으로 상위 $B$개만 유지
4. `<EOS>` 토큰이 생성된 후보는 beam에서 제거하고 완성된 시퀀스로 저장
5. 모든 beam이 `<EOS>`에 도달하거나 최대 길이에 도달하면 탐색을 종료한다.
> [!note] vs Greedy Search
> $B=1$이면 그냥 Greedy Decoding. $B$가 커질수록 좋은 시퀀스를 찾을 확률은 커지지만, 계산량이 $B$배 늘어난다. Sutskever et al. (2014)에서 $B=2$여도 $B=1$ 대비 성능이 크게 오르고, $B=12$와 차이가 크지 않았다.
> 즉, 작은 beam size로도 충분하다는 뜻!

# 한계
- 길이 편향: 누적 로그 확률은 시퀀스가 길수록 작아지므로, 짧은 시퀀스가 선호되는 경향이 있음. 길이 정규화(length normalization)로 완화 가능하다.
- 다양성 부족: 상위 $B$개 후보가 서로 유사한 시퀀스일 수 있어 출력 다양성이 낮다.
- 최적해 비보장: 근사 탐색이므로 전역 최적 시퀀스를 반드시 찾는다는 보장은 없다.

# 대표 변형 / 관련 기법
- [[Greedy Decoding]]: $B=1$인 특수 케이스.
- Length Normalization: 누적 확률을 시퀀스 길이로 나눠 길이 편향을 보정한다.
- Diverse Beam Search: beam 사이의 다양성을 강제하는 변형.
- Sampling 기반 디코딩: Top-k Sampling, Nucleus Sampling 등 확률적 대안. 창의적 생성 task에서 선호된다.

# 관련 개념
- [[Greedy Decoding]]
- [[Softmax]]
- [[BLEU Score]]