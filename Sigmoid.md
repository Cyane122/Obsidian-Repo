# 정의
임의의 실수 입력을 (0, 1) 범위의 값으로 압축하는 활성화 함수.
$$\sigma(x) = \dfrac{1}{1+e^{-x}}$$
출력이 확률로 해석 가능하다는 특성 때문에 이진 분류의 출력층과 [[LSTM]]의 gate 함수로 널리 사용된다.

# 특성
- 출력 범위: (0, 1)
- 미분: $\sigma'(x) = \sigma(x)(1-\sigma(x))$. 최댓값은 $x=0$일 때 0.25.
- 입력의 절댓값이 커질수록 기울기가 0에 수렴하는 포화 구간(saturation)이 존재함

> [!warning] 주의할 것
> 포화 구간에서 미분값이 거의 0이 되기 때문에 [[Vanishing Gradient]] 문제의 주요 원인 중 하나다. 깊은 네트워크의 은닉층에 sigmoid를 반복 사용하면 gradient가 소실되기 쉬워, 현재는 은닉층 활성화 함수로 [[ReLU]] 계열이 선호된다.


# 대표 변형 / 관련 기법
- [[Tanh]]: 출력 범위를 (-1, 1)로 확장한 변형. 원점대칭 특성으로 인해 은닉층에서 Sigmoid보다 선호됨.
- [[ReLU]]: 포화 문제를 해결한 대표적 대안. $\max(0, x)$.
- [[Softmax]]: Sigmoid를 다중 클래스로 일반화한 함수. 출력의 합이 1이 된다.
- [[Hard Sigmoid]]: 연산 효율을 위한 선형 근사 버전.

#activation-function #probability #classification