---
type: concept
title: "Differential Privacy"
aliases: []
tags:
  - domain/privacy-and-safety
  - method/differential-privacy
  - theme/privacy-preservation
---
# 정의

데이터셋에서 개별 레코드 하나를 추가하거나 제거해도 분석 결과(쿼리 출력의 확률 분포)가 거의 변하지 않도록 보장하는 수학적 프라이버시 정의. 임의의 알고리즘 $M$이 다음을 만족하면 $\epsilon$-differential privacy를 만족한다고 정의한다.
$$P(M(D) \in S) \leq e^\epsilon \cdot P(M(D') \in S)$$
- $D$, $D'$: 레코드 하나만 다른 인접 데이터셋 (neighboring datasets)
- $\epsilon$: privacy budget. 작을수록 강한 프라이버시를 보장한다.
- 핵심 아이디어: 결과만 보고 특정 개인의 데이터가 포함되었는지 추정할 수 없게 만드는 것.

# 왜 필요한가

# 작동 원리

## 메커니즘

- 노이즈 주입: 쿼리 결과나 중간 표현(임베딩, 그래디언트 등)에 확률적 노이즈를 추가해 개별 레코드의 영향을 흐린다.
	- Laplace mechanism: 라플라스 분포에서 추출한 노이즈 추가
	- Gaussian mechanism: 정규분포 기반 노이즈. $(\epsilon, \delta)$-DP로 확장될 때 주로 사용된다.
- Sensitivity: 레코드 하나의 변화가 쿼리 결과에 미칠 수 있는 최대 변화량. 노이즈의 크기를 결정하는 기준이 된다.
- Composition: 동일 데이터에 여러 차례 DP 메커니즘을 적용하면 privacy budget이 누적되어 보장이 약해진다.

# 수식 / 알고리즘

# 특징과 한계

## Local DP vs. Central DP

- Central DP: 신뢰할 수 있는 중앙 서버가 전체 데이터셋에 접근해 한 번에 노이즈를 추가
- Local DP(LDP): 각 사용자가 자신의 데이터를 서버에 보내기 전에 개별적으로 노이즈를 추가. 서버를 신뢰하지 않는 상황에 적합하며, 동일 수준의 보장을 위해 더 많은 노이즈가 필요함

## 텍스트 도메인에서

텍스트는 구조화 데이터보다 sensitivity 정의가 까다롭다 (문장 하나를 바꾸는 것의 거리를 어떻게 재야 할까?)
- 단어 임베딩 공간에 노이즈를 추가한 뒤 가장 가까운 데이터로 치환하는 방식, 또는 모델 forward pass 중 임베딩이나 attention 표현에 노이즈를 주입하는 방식 등이 시도되었다.
- 높은 수준의 프라이버시 보장(낮은 $\epsilon$)을 달성하려면 노이즈가 커져야 하지만, 이 경우 텍스트의 의미가 크게 훼손된다.

# 대표 변형

## 대표 변형 / 관련 기법

- DP-SGD: 학습 시점에 그래디언트에 노이즈를 추가해 모델이 개별 학습 샘플을 기억하지 못하도록 하는 기법
- k-anonymity: 그룹 단위로 식별 불가능성을 보장하는 또 다른 프라이버시 모델. DP보다 약한 형태의 보장이며 구조화된 데이터에서 주로 사용

# 등장/대표 논문

# 관련 개념
