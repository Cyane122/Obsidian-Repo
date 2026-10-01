---
type: concept
title: "Sample Space and Events"
summary: "표본공간은 가능한 결과의 집합이고, 사건은 그 결과 가운데 확률을 부여할 수 있는 부분집합이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Sample Space"
  - "Event"
  - "표본공간"
  - "사건"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

표본공간(Sample Space) $\Omega$는 확률실험에서 가능한 결과 전체의 집합이다. 사건(Event)은 결과들로 이루어진 부분집합으로, 확률을 부여할 수 있는 대상이다.

# 왜 필요한가

확률모형에서 무엇이 일어날 수 있는지 먼저 정해야 사건의 확률, 조건부확률, 통계적 추론을 정의할 수 있다.

# 작동 원리

$A\cup B$는 둘 중 하나 이상이 일어나는 사건, $A\cap B$는 둘 다 일어나는 사건, $A^c$는 $A$가 일어나지 않는 사건이다. $A\cap B=\varnothing$이면 두 사건은 배반이다.

# 수식 / 알고리즘

$P(\Omega)=1$. 일반적으로 $P(A\cup B)=P(A)+P(B)-P(A\cap B)$이고, 배반사건이면 마지막 항이 $0$이다.

# 특징과 한계

무한하거나 연속적인 표본공간에서는 모든 부분집합에 확률이 정의되는 것은 아니다. 확률은 지정된 가측사건들의 모임 위에서 정의된다.

# 대표 변형

- 유한 표본공간은 결과를 하나씩 열거할 수 있고, 연속 표본공간은 셀 수 없이 많은 결과를 포함할 수 있다.

# 관련 개념

- [[KL Divergence]]는 확률분포 사이의 차이를 측정한다.
