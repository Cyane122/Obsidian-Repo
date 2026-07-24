---
type: concept
title: "Prompt Engineering"
aliases:
  - "프롬프트 엔지니어링"
tags:
  - domain/nlp
  - method/large-language-model
  - theme/alignment
---

# 정의

Prompt Engineering은 [[Large Language Model]]이나 비전-언어 모델이 원하는 과제와 출력 제약을 이해하도록 지시, 문맥, 예시, 출력 형식을 설계하는 작업이다.

# 작동 원리

명확한 목표와 입력 경계를 제시하고, 필요한 경우 few-shot 예시와 구조화된 출력 형식을 더한다. 복잡한 과제는 하위 단계로 분해하고 외부 자료가 있다면 근거의 범위를 명시한다.

# 특징과 한계

- 파라미터 업데이트 없이 모델 행동을 빠르게 바꿀 수 있다.
- 표현의 작은 변화, 예시 순서, 모델 버전에 민감해 재현성이 낮을 수 있다.
- prompt만으로 지식의 부재, 권한, 도구 오류, 환각을 해결할 수 없으므로 검증 절차가 필요하다.

# 등장/대표 논문

- [[Learning Transferable Visual Models From Natural Language Supervision]]

# 관련 개념

- [[Zero-Shot Transfer]]
- [[Few-Shot Learning]]
- [[GPT]]

# 왜 필요한가

같은 모델도 과제 설명과 예시, 출력 제약에 따라 성능이 크게 달라지므로 의도를 재현 가능한 입력 계약으로 바꾸기 위해 필요하다.

# 수식 / 알고리즘

정해진 수식보다 반복 평가 절차가 중요하다. task suite와 성공 기준을 먼저 고정하고 prompt 후보를 비교하며, 개발 예시와 최종 평가 예시를 분리한다.

# 대표 변형

- Zero-shot instruction: 지시만 제공한다.
- Few-shot prompting: [[Few-Shot Learning|소수 예시]]를 함께 제공한다.
- Structured prompting: JSON schema나 구분자로 입력과 출력을 제한한다.
