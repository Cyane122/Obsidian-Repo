---
type: concept
title: "Recall"
summary: "실제 양성 가운데 올바르게 양성으로 예측한 비율로, 민감도 또는 참양성률이라고도 한다."
maturity: "developing"
last_reviewed: ""
aliases: []
tags:
  - domain/machine-learning
  - theme/evaluation
---
# 정의

재현율(Recall)은 민감도(Sensitivity), 참양성률(TPR)과 같은 지표이며 $TP/(TP+FN)$으로 계산한다. 특이도(Specificity)는 참음성률로 $TN/(TN+FP)$이다.

실제 양성 샘플 중 양성으로 올바르게 예측한 비율. 모델이 실제 양성을 얼마나 놓치지 않고 잡아내는지를 측정한다.
$$\mathrm{Recall} = \dfrac{TP}{TP+FN}$$

# 왜 필요한가

# 작동 원리

# 수식 / 알고리즘

# 특징과 한계

## 특성

- FN을 줄이는 것이 중요한 상황에서 핵심 지표.
- Recall만 높이려 하면 모델이 모든 샘플을 양성으로 예측하게 되어 FP가 증가하고 [[Precision]]이 낮아지는 Trade-off 발생.
- Sensitivity 또는 True Positive Rate(TPR)과 동의어.

# 대표 변형

## 대표 변형 / 관련 기법

- Macro Recall: 클래스별 Recall의 단순 평균.
- Weighted Recall: 클래스별 샘플 수로 가중평균.
- Specificity (True Negative Rate): $\dfrac{TN}{TN+FP}$. Recall의 음성 클래스 버전.

# 관련 개념

- [[Confusion Matrix]]
- [[Precision]]
- [[F1 Score]]
