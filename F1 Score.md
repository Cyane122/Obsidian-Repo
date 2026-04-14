# 정의
[[Precision]]과 [[Recall]]의 조화평균. 불균형 클래스 분류 문제에서 [[Accuracy]]를 대체하는 평가 지표.
$$\mathrm{F1} = 2 \cdot \dfrac{\mathrm{Precision} \times \mathrm{Recall}}{\mathrm{Precision} + \mathrm{Recall}}$$

# 특성
- 정밀도와 재현율 중 하나만 높고 다른 하나가 낮으면 F1이 낮게 유지되므로, 두 지표의 균형을 요구한다.
- 조화평균을 사용하므로 산술평균보다 작은 값에 더 민감하게 반응한다.
- 클래스 불균형이 심한 경우 [[Accuracy]]보다 더 신뢰성 높은 지표로 사용된다.

# 대표 변형 / 관련 기법
- $F_\beta$ Score: $F_\beta = (1 + \beta^2) \cdot \dfrac{\mathrm{Precision} \times \mathrm{Recall}}{\beta^2 \cdot \mathrm{Precision} + \mathrm{Recall}}$. $\beta > 1$이면 재현율에 더 가중치가 부여되고, $\beta<1$이면 정밀도에 더 가중치가 부여된다.
- Macro F1: 클래스별 F1을 단순 평균.
- Micro F1: 전체 TP, FP, FN을 합산 후 F1 계산. 클래스 빈도를 반영한다.
- Weighted F1: 클래스별 샘플 수로 가중평균.

# 모델별 적용 방식
- [[Named Entity Recognition]]: 개체명 경계와 범주가 모두 일치해야 TP로 인정하는 엄격한 기준을 적용한다. CoNLL-2003 벤치마크의 표준 평가 지표이다.

# 관련 개념
- [[Named Entity Recognition]]
- [[Sequence Labeling]]