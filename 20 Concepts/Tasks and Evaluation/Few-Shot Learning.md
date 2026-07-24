---
type: concept
title: "Few-Shot Learning"
aliases:
  - "Few-Shot Prompting"
tags:
  - domain/machine-learning
  - task/zero-shot-transfer
  - theme/generalization
---

# 정의

Few-Shot Learning은 새로운 과제를 소수의 예시만으로 학습하거나 수행하는 설정이다. [[Large Language Model]] 문맥에서는 파라미터를 바꾸지 않고 프롬프트에 몇 개의 입력-출력 예시를 넣는 in-context few-shot을 흔히 뜻한다.

# 왜 필요한가

레이블을 대량 수집하기 어려운 과제에서 데이터 비용을 줄이고, 모델이 새로운 지시와 출력 형식을 빠르게 파악하도록 한다.

# 특징과 한계

- 예시 선택, 순서, 형식에 매우 민감하며 예시가 대표적이지 않으면 zero-shot보다 나쁠 수 있다.
- 모델이 문맥에서 실제로 학습하는지, 표면 패턴을 모방하는지는 과제에 따라 다르다.
- 같은 클래스 수와 샘플 수라도 사전학습 데이터 중복 여부에 따라 난도가 달라진다.

# 관련 개념

- [[Zero-Shot Transfer]]
- [[Prompt Engineering]]
- [[GPT]]

# 작동 원리

meta-learning은 여러 과제에서 빠른 적응 규칙을 학습하고, in-context learning은 프롬프트의 예시를 문맥으로 읽어 출력 규칙을 유추한다.

# 수식 / 알고리즘

일반적으로 클래스당 \(K\)개 표본인 \(N\)-way \(K\)-shot 설정으로 기술한다. 평가에서는 예시 선택과 random seed를 고정하거나 여러 episode의 평균과 분산을 보고해야 한다.

# 대표 변형

- Prototype-based few-shot: 클래스 prototype과 거리로 분류한다.
- In-context few-shot: 파라미터 갱신 없이 예시를 prompt에 넣는다.

# 등장/대표 논문

- 대규모 [[GPT]] 계열에서 in-context few-shot 수행이 널리 연구되었다.
