---
type: concept
title: "Eigenvalues and Eigenvectors"
summary: "정사각행렬이 방향을 바꾸지 않고 배율만 변화시키는 벡터와 그 배율을 나타낸다."
maturity: developing
last_reviewed: ""
aliases:
  - "Eigenvalue"
  - "Eigenvector"
  - "고유값"
  - "고유벡터"
tags:
  - domain/machine-learning
  - theme/mathematical-foundations
---

# 정의

정사각행렬 $A$와 영벡터가 아닌 $v$에 대해 $Av=\lambda v$이면 $v$는 고유벡터(Eigenvector), $\lambda$는 대응하는 고유값(Eigenvalue)이다.

# 왜 필요한가

고유벡터는 선형변환이 유지하는 방향을 보여준다. 공분산 행렬의 고유벡터는 [[Principal Component Analysis]]에서 주성분 축을 구하는 데 사용된다.

# 작동 원리

고유값은 $A-\lambda I$가 가역이 아니게 만드는 값이다. 그 값을 찾은 뒤 $(A-\lambda I)v=0$의 영벡터가 아닌 해를 구한다. 실수 대칭행렬에는 정규직교 고유기저가 존재한다.

# 수식 / 알고리즘

$\det(A-\lambda I)=0$을 풀어 $\lambda$를 구하고, 각 값에 대해 $(A-\lambda I)v=0$을 푼다.

# 특징과 한계

고유벡터의 영이 아닌 스칼라배도 같은 고유값의 고유벡터다. 일반 실수행렬에는 실수 고유값이나 충분한 수의 독립 고유벡터가 없을 수 있다.

# 대표 변형

- 실수 대칭행렬은 $A=Q\Lambda Q^\top$로 직교대각화할 수 있다.

# 관련 개념

- [[Linear Transformation]]
- [[Determinant]]
- [[Principal Component Analysis]]
- [[Singular Value Decomposition]]
