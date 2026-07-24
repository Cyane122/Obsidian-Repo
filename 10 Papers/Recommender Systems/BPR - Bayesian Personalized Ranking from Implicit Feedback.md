---

# 한 줄 요약

BPR은 암시적 피드백에서 관측 항목이 미관측 항목보다 위에 오도록 사용자별 항목 쌍을 직접 최적화해, 점수 예측과 추천 순위 학습의 목적 불일치를 줄였다.

# 문제 설정

구매·클릭·조회 같은 [[Implicit Feedback]]은 선호의 양성 신호만 보여 준다. 미관측 항목은 싫어한 항목과 아직 노출되지 않은 항목이 섞여 있으므로 단순한 0 라벨로 취급하기 어렵다. 논문은 사용자 (u)가 관측한 항목 (i\)를 미관측 항목 (j\)보다 선호한다는 삼중항 ((u,i,j)\)를 학습 단위로 삼는다.

# BPR-Opt

모델 점수 차이를 \(\hat{x}_{uij}=\hat{x}_{ui}-\hat{x}_{uj}\)로 두면 목적함수는 다음의 정규화된 로그 사후확률이다.

$$
\operatorname{BPR\text{-}Opt}=\sum_{(u,i,j)}\ln \sigma(\hat{x}_{uij})-\lambda\lVert\Theta\rVert^2
$$

여기서 sigmoid는 관측 항목이 미관측 항목보다 높은 순위를 가질 확률을 나타낸다. 목적함수는 사용자별 AUC와 연결되며, 항목의 절대 점수보다 상대적 순서에 집중한다.

# LearnBPR

모든 삼중항을 열거하면 매우 크기 때문에 bootstrap sampling으로 ((u,i,j)\)를 뽑고 [[Stochastic Gradient Descent]]로 갱신한다. 논문은 같은 기준을 행렬분해와 적응형 kNN에 적용해 BPR-MF와 BPR-kNN을 구성한다.

# 핵심 결과

- 개인화 순위 평가에서 행렬분해와 kNN의 기존 학습 방식보다 일관되게 나은 결과를 보였다.
- 모델 구조보다 평가 목표에 맞는 학습 기준이 중요하다는 점을 실증했다.
- 점수 예측 중심의 [[Collaborative Filtering for Implicit Feedback Datasets|WR-MF]]와 달리 pairwise ranking을 직접 학습한다.

# 한계와 후속 질문

- 미관측 항목을 음성 후보로 샘플링하므로 노출 편향과 인기도 편향을 분리하지 못한다.
- 균등 샘플링은 정보량이 낮은 쉬운 쌍을 자주 뽑을 수 있다.
- AUC 중심 목적은 top-k 품질이나 순위 위치별 효용을 직접 최적화하지 않는다.

# 위키 연결

- 핵심 개념: [[Implicit Feedback]], [[Stochastic Gradient Descent]], [[Matrix Factorization]]
- 비교 문서: [[암시적 피드백 추천 - WR-MF와 BPR 비교]]
type: paper
title: "BPR: Bayesian Personalized Ranking from Implicit Feedback"
authors:
  - "Steffen Rendle"
  - "Christoph Freudenthaler"
  - "Zeno Gantner"
  - "Lars Schmidt-Thieme"
year: 2009
venue: "UAI 2009"
url: "https://www.auai.org/uai2009/papers/UAI2009_0139_48141db02b9f0b02bc7158819ebfa2c7.pdf"
pdf: ""
status: to-read
read_date: ""
aliases:
  - "BPR - Bayesian Personalized Ranking"
tags:
  - domain/recommender-systems
  - task/recommendation
  - method/pairwise-ranking
---
