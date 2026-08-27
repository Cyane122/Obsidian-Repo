---
type: comparison
title: "암시적 피드백 추천 - WR-MF와 BPR 비교"
subjects:
  - "[[Collaborative Filtering for Implicit Feedback Datasets]]"
  - "[[BPR - Bayesian Personalized Ranking from Implicit Feedback]]"
sources:
  - "[[Collaborative Filtering for Implicit Feedback Datasets]]"
  - "[[BPR - Bayesian Personalized Ranking from Implicit Feedback]]"
tags:
  - domain/recommender-systems
  - task/recommendation
  - theme/evaluation
aliases: []
---

# 비교 목적

관측만 있고 명시적 음성이 없는 [[Implicit Feedback]]에서, confidence-weighted pointwise 학습과 pairwise ranking 학습이 미관측 항목을 어떻게 다루는지 비교한다.

# 비교 축

| 축 | WR-MF | BPR |
|---|---|---|
| 문제 정의 | 모든 사용자-항목 쌍의 preference를 confidence로 가중해 예측 | 관측 항목이 미관측 항목보다 위에 오도록 순위 학습 |
| 학습 단위 | 사용자-항목 쌍 | 사용자-positive-negative 삼중항 |
| 목적함수 | weighted squared error | pairwise logistic posterior |
| 최적화 | Alternating Least Squares | bootstrap sampling + [[Stochastic Gradient Descent]] |
| 장점 | 전체 행렬과 관측 강도를 사용하며 ALS 병렬화가 쉬움 | 추천 평가 목표와 가까운 상대 순위를 직접 최적화 |
| 주요 한계 | ranking metric과 목적함수가 다름 | 음성 샘플링과 노출 편향에 민감 |

# 핵심 차이

WR-MF는 “얼마나 선호하는가”라는 점수를 confidence와 함께 근사하고, BPR은 “어느 항목을 더 위에 둘 것인가”라는 순서 관계를 학습한다. 따라서 반복 횟수처럼 관측 강도가 의미 있는 서비스에는 WR-MF가 자연스럽고, top-N 개인화 순위가 직접 목표라면 BPR의 목적이 더 가깝다.

# 비교 가능성의 한계

두 논문의 데이터 분할, negative 처리, metric과 구현이 같지 않으므로 논문 수치의 직접 비교는 부적절하다. 실제 선택에서는 top-k metric, 노출 로그의 존재, 학습·서빙 비용을 같은 실험 조건에서 평가해야 한다.

# 관련 문서

- [[암시적 피드백 추천]]
- [[Matrix Factorization]]
