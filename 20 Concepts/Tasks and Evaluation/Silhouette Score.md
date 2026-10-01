---
type: concept
title: "Silhouette Score"
summary: "군집 안의 응집도와 다른 군집과의 분리도를 비교하는 내부 군집 평가 지표다."
maturity: developing
last_reviewed: ""
aliases:
  - "Silhouette Coefficient"
  - "실루엣 계수"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

군집 안의 응집도와 다른 군집과의 분리도를 비교하는 내부 군집 평가 지표다.

# 왜 필요한가

참조 레이블이 없을 때 군집 배치가 거리 기준으로 얼마나 잘 구분되는지 살펴본다.

# 작동 원리

점 $i$의 같은 군집 평균 거리 $a(i)$와 다른 군집 중 가장 가까운 평균 거리 $b(i)$로 $s(i)=(b(i)-a(i))/\max(a(i),b(i))$를 구한 뒤 평균한다.

# 특징과 한계

$1$에 가까우면 분리가 뚜렷하고, $0$ 부근은 경계에 가깝다. 거리 척도와 군집 모양에 민감하며 점수가 높다고 실제 의미가 보증되지는 않는다.

# 관련 개념

- [[K-Means]]
- [[DBSCAN]]

