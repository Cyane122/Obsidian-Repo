# 정의
분류 모델의 예측 결과를 실제 레이블과 대조하여 정리한 행렬. 행은 실제 클래스, 열은 예측 클래스를 나타낸다.
이진 분류 기준:

|                 | 예측 Positive         | 예측 Negative         |
| --------------- | ------------------- | ------------------- |
| **실제 Positive** | TP (True Positive)  | FN (False Negative) |
| **실제 Negative** | FP (False Positive) | TN (True Negative)  |
- TP: 실제 양성을 양성으로 올바르게 예측
- TN: 실제 음성을 음성으로 올바르게 예측
- FP: 실제 음성을 양성으로 잘못 예측 (Type I Error)
- FN: 실제 양성을 음성으로 잘못 예측 (Type II Error)

# 특성
- 단일 숫자 지표([[Accuracy]] 등)로는 드러나지 않는 오류 패턴을 시각적으로 파악할 수 있음.
- 클래스 불균형이 심한 경우, 모델이 다수 클래스만 예측해도 Accuracy가 높게 나오는 문제를 진단 가능.
- 다중 클래스 분류로 자연스럽게 확장됨. $n$개 클래스에 대해 $n \times n$ 행렬.

# 대표 변형/관련 기법
- Normalized Confusion Matrix: 각 행을 실제 클래스 샘플 수로 나누어 비율로 표현한다. 클래스 불균형 상황에서 직관적 해석에 용이하다.

# 관련 개념
- [[Accuracy]]
- [[Precision]]
- [[Recall]]
- [[F1 Score]]