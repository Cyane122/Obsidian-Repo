---
type: paper
title: "Robust Utility-Preserving Text Anonymization Based on Large Language Models"
authors:
  - "Tianyu Yang"
  - "Xiaodan Zhu"
  - "Iryna Gurevych"
year: 2025
venue: "ACL 2025"
url: "https://aclanthology.org/2025.acl-long.1404/"
pdf: ""
status: read
read_date: "2026-08-01"
tags:
  - domain/nlp
  - task/text-rewriting
  - method/large-language-model
  - theme/privacy-preservation
aliases:
  - "RUPTA"
---

# 한 줄 요약

RUPTA는 LLM 재식별 위험을 먼저 낮추고 실제 downstream task 성능을 그다음 보존하도록 privacy evaluator, utility evaluator, LLM optimizer를 결합한 반복적 텍스트 익명화 프레임워크다.

# Abstract

기존 텍스트 익명화는 이름 같은 명시적 식별자를 가려도 [[Large Language Model|LLM]]이 여러 문맥 단서를 결합해 개인을 다시 식별할 수 있고, 방어를 강화하면 분석에 필요한 정보까지 손실될 수 있다. 이 논문은 privacy와 utility를 익명화 이후에 따로 측정하지 않고 생성 과정의 두 목적함수로 직접 사용한다.

RUPTA는 privacy evaluator(P-Evaluator), utility evaluator(U-Evaluator), lexicographic optimizer(L-Optimizer)로 구성된다. 반복적 LLM 추론 비용을 줄이기 위해 최종 출력과 중간 출력의 선호 관계를 Direct Preference Optimization(DPO)에 사용하여 익명화 능력을 소형 모델로 증류한다.

# Introduction

NER 기반 masking이나 일반화는 미리 정의한 entity에는 대응하지만, 직업·가족관계·활동 이력처럼 여러 간접 단서가 함께 만드는 재식별 위험을 놓칠 수 있다. 기존 LLM 기반 반복 재작성도 공격자 피드백으로 privacy를 개선하지만, 대개 downstream utility는 익명화가 끝난 뒤 평가하므로 수정 과정에서 필요한 정보를 능동적으로 보존하지 못한다.

논문은 다음 질문을 다룬다.

- LLM 공격자가 이용하는 명시적·암묵적 단서를 함께 줄일 수 있는가?
- privacy를 우선하면서 특정 downstream task에 필요한 정보는 얼마나 유지할 수 있는가?
- 고비용 반복 최적화의 동작을 소형 모델 한 번의 생성으로 이전할 수 있는가?

# RUPTA

## 문제 공식화

원문 $x_0$의 가능한 편집 집합을 $X_0$, privacy와 utility 목적함수를 각각 $f_p$와 $f_u$라 두고 다음 lexicographic optimization을 푼다.

$$
\operatorname{lex\ max}_{x \in X_0} F(x) = [f_p(x), f_u(x)]
$$

$x_a$는 privacy 점수가 더 높거나, privacy가 같을 때 utility가 더 높으면 $x_b$보다 선호된다. 즉 두 목적을 단순 가중합하지 않고 privacy를 우선 만족시킨 뒤 utility를 높인다.

## Privacy Evaluator

P-Evaluator는 현재 텍스트 $x_t$에서 정답 개인 정보 $y$를 top-$K$ 후보로 재식별한다. $y$가 후보에 있으면 그 순위를 privacy score $p_t$로 사용하고, 어떤 단서로 맞혔는지 자연어 피드백 $f_t$를 생성한다. 후보에 없으면 최대값 $K+1$을 준다.

$$
(y'_1, \ldots, y'_K) \sim \mathrm{LLM}(I_p \Vert x_t)
$$

$$
p_t =
\begin{cases}
\operatorname{rank}(y), & y \in \{y'_1, \ldots, y'_K\} \\
K+1, & \text{otherwise}
\end{cases}
$$

$K$가 클수록 더 넓은 후보 집합에서 누출을 검사하므로 요구하는 보호 수준을 조절할 수 있다. 다만 이 점수는 선택한 공격 모델에 대한 경험적 측정이지 형식적 privacy guarantee는 아니다.

## Utility Evaluator

U-Evaluator는 현재 텍스트 $x_t$와 downstream task의 정답 label $c$를 받아, 텍스트가 $c$를 지지하는 정도를 confidence score $u_t$로 평가한다.

$$
u_t = f_u(x_t, c)
$$

실험에서는 LLM evaluator를 사용하지만, 실제 배치에서는 sentiment classifier 같은 해당 task 모델의 ground-truth logit으로 대체할 수 있다. 이 설계가 일반적인 semantic similarity와 달리 업무에 필요한 정보 보존을 직접 최적화한다.

## Lexicographic Optimizer

L-Optimizer는 이전 편집과 두 evaluator의 점수·피드백을 memory로 받아 텍스트를 반복 수정한다.

1. privacy가 목표치에 못 미치면 재식별 단서를 generalize하거나 제거한다.
2. privacy 목표를 만족하면 privacy를 낮추지 않는 범위에서 원문에 있던 task-relevant 정보를 더 구체적으로 복원한다.
3. 두 단계가 수렴하거나 최대 반복 횟수 $T$에 도달하면 종료한다.

따라서 $K$와 $T$가 privacy–utility trade-off의 조절점이다. 단순 반복 익명화가 계속 정보를 지우는 것과 달리, RUPTA는 utility 회복 단계를 명시적으로 포함한다.

## 익명화 능력 증류

GPT-4 기반 반복 최적화의 최종 출력을 supervised fine-tuning label로 사용한다. 이어서 같은 편집 이력의 최종 출력을 preferred response, 중간 출력을 rejected response로 간주해 DPO를 적용한다. 소형 모델은 여러 evaluator 호출 없이 최종 형태에 가까운 익명문을 한 번에 생성하도록 학습된다.

# Experimental Set-up

## 데이터셋과 task

- **DB-bio**: DBpedia celebrity biography에서 새로 구성한 데이터셋. 개인 identity를 숨기면서 occupation classification label을 유지해야 한다.
- **PersonalReddit**: Reddit 글에서 gender와 location 같은 개인 속성을 숨기면서 occupation classification 성능을 보존한다. 명시적 entity보다 암묵적 단서가 많다.

비교 대상은 Azure anonymizer, DEID-GPT, SD, Adversarial Feedback(AF), [[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization|IncogniText]]다.

## 평가 지표

- **Disclosure risk**: 별도 LLM이 정답 개인 정보를 맞힌 success rate(SR)와 confidence score(CS). 낮을수록 좋다.
- **Utility preservation**: 원문 train split으로 fine-tuning한 BERT classifier를 익명화된 test split에 적용한 precision, recall, F1, accuracy, loss.
- **Human evaluation**: 의미 보존과 fluency를 1–5 Likert scale로 평가한다.

# Experimental Results

## DB-bio

RUPTA(GPT-4)는 AF와 거의 같은 disclosure success rate를 보이면서 분류 성능을 크게 보존했다.

| 방법            |      SR ↓ |      F1 ↑ | Accuracy ↑ |
| ------------- | --------: | --------: | ---------: |
| Original      |    100.00 |     99.61 |      99.58 |
| IncogniText   |     58.06 |     87.32 |      88.28 |
| AF            |     52.91 |     91.75 |      92.02 |
| RUPTA (GPT-4) | **52.67** | **95.91** |  **96.02** |

RUPTA(GPT-4)의 utility 결과는 AF보다 one-tailed paired t-test에서 유의하게 높았다($p<0.05$). 반복 횟수가 늘면 일반적인 adversarial feedback 방식은 disclosure risk와 accuracy가 함께 낮아졌지만, RUPTA에는 privacy를 확보한 뒤 accuracy가 회복되는 구간이 나타났다.

## PersonalReddit

암묵적 개인정보가 많은 PersonalReddit에서 entity 기반 방법은 원문과 비슷한 utility를 남겼지만 privacy 개선도 작았다. RUPTA(GPT-4)는 AF와 유사한 SR(35.75 대 35.40)을 유지하면서 accuracy를 21.26에서 35.75로 높였다. 원문의 accuracy 58.45에는 여전히 큰 차이가 있어, 강한 privacy 아래 utility 손실이 사라진 것은 아니다.

## 증류와 사람 평가

Llama-3-8B와 Phi-3 Mini student는 supervised fine-tuning만으로 teacher에 가까운 privacy 성능을 얻었고, DPO가 그 격차를 더 줄였다. 그러나 DPO는 privacy를 더 우선하도록 학습해 downstream task 성능을 낮출 수 있었다.

DB-bio 100개 표본을 평가자 3명이 채점한 결과, RUPTA의 semantic preservation은 3.96으로 Azure(3.23), SD(3.64), AF(3.78)보다 높았다. Fluency는 3.68로 AF의 3.71과 비슷했지만 최고값은 아니었다.

# 핵심 기여

1. privacy를 우선하고 downstream utility를 그다음 최적화하는 LLM 기반 lexicographic anonymization을 제안했다.
2. 재식별 결과뿐 아니라 공격 단서와 task confidence를 반복 편집의 피드백으로 사용했다.
3. occupation label이 포함된 DB-bio 데이터셋을 구축해 익명화 후 실제 task utility를 평가했다.
4. 편집 이력을 DPO preference pair로 재사용하여 고비용 반복 익명화를 소형 모델에 증류했다.

# Limitations

- 실험은 celebrity biography와 Reddit, occupation classification에 집중되어 다른 도메인·task로 일반화되는지 충분히 검증하지 않았다.
- P-Evaluator와 최종 평가는 정적인 LLM 공격자를 가정한다. 더 강하거나 적응적인 공격자는 남은 단서를 새롭게 이용할 수 있다.
- privacy score는 [[Differential Privacy]] 같은 형식적 보장이 아니라 특정 LLM의 top-$K$ 재식별 실패에 근거한 경험적 보장이다.
- 반복적 LLM 호출은 계산 비용이 크고, 증류 모델도 데이터 품질과 teacher의 편향에 의존한다.
- framework가 utility label과 ground-truth personal information을 입력으로 요구하므로, label이 없거나 개인정보 정답을 안전하게 취급하기 어려운 실제 환경에서는 적용 비용이 커진다.

# Related Documents

- [[프라이버시 보존 텍스트 재작성]]
- [[IncogniText - Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization]]
- [[Zero-Shot Privacy-Aware Text Rewriting via Iterative Tree Search]]

