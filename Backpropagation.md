# 정의
신경망 학습에서 손실 함수(loss function)의 기울기를 출력층에서 입력층 방향으로 연쇄 법칙(chain rule)을 적용하여 역방향으로 전파하는 알고리즘.
$$\dfrac{\partial L}{\partial w} = \dfrac{\partial L}{\partial y} \cdot \dfrac{\partial y}{\partial w}$$

## 핵심 원리
- 연쇄 법칙: 합성 함수의 미분을 각 층의 편미분의 곱으로 분해한다.
- 순전파(Forward pass): 입력 → 출력 방향으로 활성화 값을 계산한다.
- 역전파(Backward pass): 출력 → 입력 방향으로 기울기를 계산한다.
- 각 파라미터 $w$에 대해 $\dfrac{\partial L}{\partial w}$를 구한 뒤 옵티마이저로 업데이트.

# 계산 복잡도
순전파와 동일한 수준의 연산량이며, 레이어 수에 선형적으로 비례한다.

# 대표적인 옵티마이저
- [[Stochastic Gradient Descent]]: 미니 배치 샘플로 기울기를 근사하여 업데이트
- [[Adam]]: 1차/2차 모멘트 추정을 결합한 적응형 학습률 옵티마이저.
- [[AdaGrad]]: 파라미터별 학습률을 누적 기울기 크기에 따라 조정
- [[RMSProp]]: Adagrad의 학습률 감소 문제를 지수 이동 평균으로 완화

# 주요 이슈
- [[Vanishing Gradient]]: 레이어가 깊어질수록 기울기가 소실되는 문제.
- [[Exploding Gradient]]: 기울기가 발산하는 문제.

