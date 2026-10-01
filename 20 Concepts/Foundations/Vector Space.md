---
type: concept
title: "Vector Space"
summary: "벡터의 덧셈과 스칼라배가 정의된 공간으로, 선형결합과 선형변환을 다루는 기본 틀이다."
maturity: developing
last_reviewed: ""
aliases:
  - "벡터공간"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

벡터공간(Vector Space)은 벡터의 덧셈과 스칼라배에 대해 닫혀 있고, 영벡터·덧셈의 역원·분배법칙 등 벡터공간 공리를 만족하는 집합이다. 기계학습에서는 주로 실수체 위의 벡터공간을 다룬다.

# 왜 필요한가

데이터를 좌표로 나타내고, 특성 간의 선형 관계나 차원 축소를 논의하려면 먼저 벡터가 속한 공간을 정해야 한다.

# 작동 원리

벡터 $v_1,\ldots,v_k$의 선형결합은 $\sum_i c_i v_i$이다. 가능한 모든 선형결합의 집합을 생성공간(span)이라 한다. 벡터공간의 부분집합이 덧셈과 스칼라배에 대해 닫혀 있으면 부분공간이다.

# 수식 / 알고리즘

$u,v\in V$와 스칼라 $a,b$에 대해 $au+bv\in V$이다.

# 특징과 한계

벡터공간이라는 조건만으로는 길이나 각도를 정의할 수 없다. 이를 위해서는 노름이나 내적 같은 구조가 추가로 필요하다.

# 대표 변형

- $\mathbb{R}^n$은 대표적인 유한차원 벡터공간이다. 행렬이나 함수의 집합도 적절한 연산 아래 벡터공간이 될 수 있다.

# 관련 개념

- [[Linear Independence and Basis]]
- [[Linear Transformation]]
- [[Orthogonal Projection]]
