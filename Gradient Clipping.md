# 정의
학습 중 gradient의 크기가 임계값을 초과할 때 강제로 스케일을 줄여 [[Exploding Gradient]]로 인한 학습 발산을 방지하는 기법.

# 방식
## Norm Clipping
더 일반적인 방법. Gradient 벡터 전체의 $L_2$ norm을 기준으로 스케일을 조정한다.
$$g \leftarrow \dfrac{\theta}{||g||_2} \cdot g \ \ \ \ \text{if } ||g||_2 > 0$$
Gradient의 방향은 유지하고 크기만 줄인다는 점에서 Value Clipping보다 선호된다.

# Value Clipping
각 gradient 원소를 독립적으로 $[-\theta, \theta]$ 범위로 클리핑한다. 방향 정보가 왜곡될 수 있다.

# 관련 개념
- [[Exploding Gradient]]
- [[Vanishing Gradient]]
- [[Backpropagation]]
- [[LSTM]]
- [[Recurrent Neural Networks]]

#optimization #gradient #training 