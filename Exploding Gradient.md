# 정의
[[Backpropagation]] 과정에서 gradient가 이전 time step 또는 이전 레이어로 전파될수록 지수적으로 커지는 현상. gradient가 매우 커지면 파라미터 업데이트 폭이 과도해져 학습이 발산한다.

# 발생 원인
[[Backpropagation]]에서 gradient는 시간 단계를 거슬러 올라갈 때 반복적인 행렬 곱셈을 통해 전파된다.
$$\dfrac{\partial L} {\partial h_t} = \dfrac{\partial L} {\partial h_T} \displaystyle \prod_{k=t}^{T-1} \dfrac{\partial h_{k+1}}{\partial h_k}$$
각 time step에서의 Jacobian $\dfrac{\partial h_{k+1}}{\partial h_k}$의 최대 고윳값이 1보다 클 경우, 이 곱은 시간 거리에 따라 지수적으로 증가한다.

# 결과 및 영향
- 파라미터가 한 번의 업데이트로 매우 큰 폭으로 변해 손실함수가 발산한다.
- `NaN` 또는 `Inf` 값이 발생하며 학습이 중단됨
- [[Vanishing Gradient]]보다 감지가 쉬운 편이나, 발생 시 즉각적인 학습 불안정을 초래함

# 대표 변형 / 관련 기법
- [[Gradient Clipping]]: 가장 직접적인 해결책. gradient의 $L_2$ norm이 임계값 $\theta$를 초과하면 $g \leftarrow \dfrac{\theta}{||g||}g$로 스케일을 조정
- [[LSTM]]: gate가 gradient 흐름을 조절해 Exploding Gradient 완화에도 기여
- Weight Initlalization: 초기 가중치를 적절히 설정해 발생 가능성을 줄임
- Batch Normalization: activation 분포를 정규화해 gradient 크기를 간접적으로 안정화

#optimization #gradient #training #RNNs 