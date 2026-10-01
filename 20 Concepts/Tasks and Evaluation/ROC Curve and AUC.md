---
type: concept
title: "ROC Curve and AUC"
summary: "분류 임계값에 따른 참양성률과 거짓양성률의 관계를 나타내는 곡선과 그 아래 면적이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Receiver Operating Characteristic"
  - "ROC AUC"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

분류 임계값에 따른 참양성률과 거짓양성률의 관계를 나타내는 곡선과 그 아래 면적이다.

# 왜 필요한가

하나의 임계값에 고정되지 않고 분류 점수의 순위 구분 능력을 살펴본다.

# 작동 원리

ROC 곡선은 가로축에 $FPR=FP/(FP+TN)$, 세로축에 $TPR=TP/(TP+FN)$을 그린다. AUC는 곡선 아래 면적이다.

# 특징과 한계

AUC는 실제 운영 임계값의 비용이나 확률 보정을 알려주지 않는다. 양성 사례가 매우 드물면 정밀도-재현율 곡선도 함께 보는 편이 유용하다.

# 관련 개념

- [[Recall]]
- [[Precision]]
- [[Confusion Matrix]]
