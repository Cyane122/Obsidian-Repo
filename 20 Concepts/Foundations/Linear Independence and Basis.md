---
type: concept
title: "Linear Independence and Basis"
summary: "선형독립은 중복 없는 벡터 집합을 뜻하고, 기저는 공간 전체를 생성하는 선형독립 집합이다."
maturity: developing
last_reviewed: ""
aliases:
  - "Linear Independence"
  - "Basis"
  - "일차독립"
  - "기저"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

벡터 $v_1,\ldots,v_k$에 대해 $\sum_i c_i v_i=0$을 만족하는 계수가 모두 $0$뿐이면 선형독립(Linear Independence)이다. 공간 전체를 생성하는 선형독립 집합을 기저(Basis)라 한다.

# 왜 필요한가

기저를 정하면 공간의 모든 벡터를 유일한 좌표로 표현할 수 있다. 선형독립성은 특성이나 행렬의 열 사이에 불필요한 중복이 있는지 판단하는 데에도 쓰인다.

# 작동 원리

어떤 벡터가 나머지 벡터들의 선형결합으로 표현되면 그 집합은 선형종속이다. 유한차원 공간의 기저는 여러 개일 수 있지만, 각 기저의 벡터 수는 같고 이를 차원이라 한다.

# 수식 / 알고리즘

$A=[v_1\ \cdots\ v_k]$의 열이 선형독립일 필요충분조건은 $\ker(A)=\{0\}$이다.

# 특징과 한계

벡터 집합이 공간을 생성한다는 사실만으로 기저가 되지는 않는다. 선형독립 조건도 함께 필요하다.

# 대표 변형

- 정규직교기저(Orthonormal Basis)는 기저 벡터들이 서로 직교하고 길이가 1인 경우다.

# 관련 개념

- [[Vector Space]]
- [[Matrix Rank]]
- [[Eigenvalues and Eigenvectors]]
