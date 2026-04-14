# 정의
실제 양성 샘플 중 양성으로 올바르게 예측한 비율. 모델이 실제 양성을 얼마나 놓치지 않고 잡아내는지를 측정한다.
$$\mathrm{Recall} = \dfrac{TP}{TP+FN}$$

# 특성
- FN을 줄이는 것이 중요한 상황에서 핵심 지표.
- Recall만 높이려 하면 모델이 모든 샘플을 양성으로 예측하게 되어 FP가 증가하고 [[Precision]]이 낮아지는 Trade-off 발생.
- Sensitivity 또는 True Positive Rate(TPR)과 동의어.

# 대표 변형 / 관련 기법
- Macro Recall: 클래스별 Recall의 단순 평균.
- Weighted Recall: 클래스별 샘플 수로 가중평균.
- Specificity (True Negative Rate): $\dfrac{TN}{TN+FP}$. Recall의 음성 클래스 버전.

# 관련 개념
- [[Confusion Matrix]]
- [[Precision]]
- [[F1 Score]]