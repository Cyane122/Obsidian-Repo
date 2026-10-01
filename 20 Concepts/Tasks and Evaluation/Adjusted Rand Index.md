---
type: concept
title: "Adjusted Rand Index"
summary: "우연한 일치 가능성을 보정해 두 군집 분할의 일치도를 비교하는 지표다."
maturity: developing
last_reviewed: ""
aliases:
  - "ARI"
  - "Adjusted Rand Score"
tags:
  - domain/machine-learning
  - theme/evaluation
---

# 정의

우연한 일치 가능성을 보정해 두 군집 분할의 일치도를 비교하는 지표다.

# 왜 필요한가

참조 레이블이 있을 때 군집화 결과가 그것과 얼마나 비슷한지 평가한다.

# 작동 원리

자료의 모든 쌍에 대해 두 분할이 같은 군집 또는 다른 군집으로 배치했는지를 비교하고, 우연히 기대되는 일치도를 보정한다.

# 특징과 한계

$1$은 완전 일치, $0$ 부근은 보정 기준의 우연 수준, 음수는 그보다 낮은 일치를 뜻한다. 믿을 만한 참조 분할이 없으면 외부 정답 지표로 쓸 수 없다.

# 관련 개념

- [[K-Means]]
- [[Silhouette Score]]

