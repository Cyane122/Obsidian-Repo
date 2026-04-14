# 정의
양성으로 예측한 샘플 중 실제 양성인 비율. 모델이 양성이라고 주장할 때, 얼마나 믿을 수 있는지를 측정한다.
$$\mathrm{Precision} = \dfrac{TP}{TP+FP}$$

# 특성
- FP를 줄이는 게 중요한 상황에서 핵심 지표.
- Precision만 높이려 하면 모델이 확실한 경우에만 양성 예측을 하게 되어 FN이 증가하고 [[Recall]]이 낮아지는 Trade-off 발생.

# 대표 변형/관련 기법
- Macro Precision: 클래스별 Precision의 단순 평균.
- Weighted Precision: 클래스별 샘플 수로 가중평균.

# 관련 개념
- [[Confusion Matrix]]
- [[Recall]]
- [[F1 Score]]