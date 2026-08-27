---
type: concept
title: "Monte Carlo Tree Search"
aliases:
  - "MCTS"
  - "Monte Carlo Tree Search(MCTS)"
tags:
  - domain/machine-learning
  - method/tree-search
  - method/sampling
---

# 정의

Monte Carlo Tree Search(MCTS)는 가능한 행동을 트리로 표현하고, 일부 경로를 반복 탐색·평가해 유망한 행동에 계산을 집중하는 계획 알고리즘이다.

# 작동 원리

1. Selection: 현재 통계로 유망한 자식을 따라간다.
2. Expansion: 아직 시도하지 않은 행동으로 노드를 확장한다.
3. Evaluation: rollout이나 가치 모델로 결과를 추정한다.
4. Backpropagation: 평가값을 방문 경로의 노드 통계에 반영한다.

[[Upper Confidence Bound for Trees]]는 평균 보상과 탐색 보너스를 결합해 exploration-exploitation 균형을 잡는 대표 선택 규칙이다.

# 특징과 한계

- 전체 탐색 공간을 열거하지 않고도 anytime 방식으로 해를 개선할 수 있다.
- 분기 수가 크거나 평가가 비싸면 계산량이 빠르게 증가한다.
- 언어 생성에서는 같은 의미의 후보가 매우 많아 action 설계와 reward model의 품질이 성능을 좌우한다.

# 등장/대표 논문

- [[Zero-Shot Privacy-Aware Text Rewriting via Iterative Tree Search]]

# 관련 개념

- [[Upper Confidence Bound for Trees]]
- [[Beam Search]]

# 왜 필요한가

가능한 행동열을 전부 탐색할 수 없고 어느 분기가 좋은지 사전에 확실하지 않은 문제에서, 현재까지의 평가와 새로운 탐색에 계산을 나누기 위해 사용한다.

# 수식 / 알고리즘

UCT는 보통 \(\bar X_j+c\sqrt{\ln N/n_j}\)가 큰 자식을 고른다. \(N\)은 부모 방문 수, \(n_j\)는 자식 방문 수이며 \(c\)가 탐색 강도를 조절한다.

# 대표 변형

- UCT: UCB 규칙으로 자식을 선택한다.
- PUCT: 정책 prior를 탐색 보너스에 반영한다.
