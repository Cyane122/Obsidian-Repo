---
type: concept
title: "F1 Score"
summary: "양성 클래스를 기준으로 정밀도와 재현율의 조화평균을 구한 지표다."
maturity: "developing"
last_reviewed: ""
aliases: []
tags:
  - domain/machine-learning
  - theme/evaluation
---
# 정의

F1 점수는 지정한 양성 클래스에 대한 [[Precision|정밀도]]와 [[Recall|재현율]]의 조화평균이다. 참음성(TN)은 계산에 들어가지 않으므로 오류 비용에 맞춰 지표를 선택해야 한다.

[[Precision]]과 [[Recall]]의 조화평균. 불균형 클래스 분류 문제에서 [[Accuracy]]를 대체하는 평가 지표.
$$\mathrm{F1} = 2 \cdot \dfrac{\mathrm{Precision} \times \mathrm{Recall}}{\mathrm{Precision} + \mathrm{Recall}}$$

# 왜 필요한가

# 작동 원리

## 모델별 적용 방식

- [[Named Entity Recognition]]: 개체명 경계와 범주가 모두 일치해야 TP로 인정하는 엄격한 기준을 적용한다. CoNLL-2003 벤치마크의 표준 평가 지표이다.

# 수식 / 알고리즘

# 특징과 한계

## 특성

- 정밀도와 재현율 중 하나만 높고 다른 하나가 낮으면 F1이 낮게 유지되므로, 두 지표의 균형을 요구한다.
- 조화평균을 사용하므로 산술평균보다 작은 값에 더 민감하게 반응한다.
- 클래스 불균형 때문에 정확도가 오해를 부를 때 정밀도와 재현율을 함께 볼 수 있다. 다만 F1이 모든 과제에서 다른 지표보다 적합한 것은 아니다.

# 대표 변형

## 대표 변형 / 관련 기법

- $F_\beta$ Score: $F_\beta = (1 + \beta^2) \cdot \dfrac{\mathrm{Precision} \times \mathrm{Recall}}{\beta^2 \cdot \mathrm{Precision} + \mathrm{Recall}}$. $\beta > 1$이면 재현율에 더 가중치가 부여되고, $\beta<1$이면 정밀도에 더 가중치가 부여된다.
- Macro F1: 클래스별 F1을 단순 평균.
- Micro F1: 전체 TP, FP, FN을 합산 후 F1 계산. 클래스 빈도를 반영한다.
- Weighted F1: 클래스별 샘플 수로 가중평균.

# 관련 개념

- [[Named Entity Recognition]]
- [[Sequence Labeling]]
