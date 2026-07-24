---
type: paper
title: "IncogniText: Privacy-enhancing Conditional Text Anonymization via LLM-based Private Attribute Randomization"
authors:
  - "Ahmed Frikha"
  - "Nassim Walha"
  - "Krishna Kanth Nakka"
  - "Ricardo Mendes"
  - "Xue Jiang"
  - "Xuebing Zhou"
year: 2025
venue: "IJCNLP-AACL 2025"
url: "https://aclanthology.org/2025.ijcnlp-long.134/"
pdf: ""
status: read
read_date: "2026-07-21"
tags:
  - domain/nlp
  - task/text-rewriting
  - method/large-language-model
  - theme/privacy-preservation
aliases:
  - "IncogniText"
---

# Abstract

이 논문은 텍스트의 의미와 유용성을 유지하면서 공격자가 작성자의 사적 속성을 올바르게 추론하지 못하도록 하는 IncogniText를 제안한다. IncogniText는 속성 단서를 단순히 제거하는 대신, LLM이 선택한 다른 속성값을 암시하도록 텍스트를 반복 재작성하여 공격자의 추론을 의도적으로 빗나가게 한다.

8개 사적 속성에 대한 실험에서 원래 속성 누출을 90% 이상 줄였으며, 재작성 능력을 LoRA parameter로 증류한 on-device 모델에서도 누출을 절반 이상 줄였다.

# Introduction

익명 텍스트에는 이름·주소 같은 직접 식별자뿐 아니라 나이, 직업, 소득, 거주지 등을 추론하게 하는 간접 단서가 남는다. 이러한 quasi-identifier의 조합은 작성자 재식별 가능성을 높인다. 기존 접근은 다음 한계를 가진다.

- 단어 수준 치환은 저자 특유의 구문이나 문체 단서를 충분히 바꾸지 못한다.
- [[Differential Privacy]] 기반 재작성은 강한 보호를 얻을수록 의미와 자연스러움이 크게 손상될 수 있다.
- PII 탐지 후 치환하는 방식은 외부 지식과 문맥 추론을 통해 드러나는 간접 속성 누출에 취약하다.

논문의 목표는 원문의 의미와 용도를 가능한 한 유지하면서, 공격자가 작성자의 실제 사적 속성값을 맞히지 못하도록 텍스트를 재작성하는 것이다.

# Method

## 위협 모델

사용자가 가명으로 게시하거나 온라인 서비스에 전송한 단일 텍스트를 공격자가 볼 수 있다고 가정한다. 공격자는 텍스트로부터 성별, 나이, 위치, 국적, 직업 같은 사적 속성을 추론한다. IP 주소나 기기 fingerprint 같은 메타데이터 공격은 범위에서 제외한다.

주어진 속성 $a$에 대해 다음 기호를 사용한다.

- $x_{orig}$: 원문
- $a_{true}$: 작성자의 실제 속성값
- $a_{target}$: 공격자가 추론하도록 유도할 다른 속성값
- $x_{anon}$: 재작성된 텍스트
- $M_{adv}$: 로컬에서 공격을 모사하는 adversary model
- $M_{anon}$: 텍스트를 재작성하는 anonymization model
- $M_{attacker}$: 최종 평가에 사용하는 별도의 attacker model

핵심 목표는 $x_{orig}$를 $x_{anon}$으로 바꾸어 $M_{attacker}$가 $a_{true}$가 아니라 $a_{target}$을 예측하게 만드는 것이다. $M_{adv}$와 $M_{attacker}$를 구분하여, 방어가 평가 모델 하나에만 과적합되는 것을 줄인다.

## 두 단계 반복 재작성

1. **Adversarial inference**: $M_{adv}$가 현재 텍스트에서 속성값 $I$와 그 추론 근거 $R$을 생성한다.
2. **Target-conditioned anonymization**: $M_{anon}$이 현재 텍스트, 잘못된 목표값 $a_{target}$, 추론 결과 $I$, 근거 $R$을 받아 공격자를 속일 새로운 단서를 삽입하거나 기존 단서를 수정한다.

두 단계를 반복하되 $M_{adv}$가 더 이상 $a_{true}$를 예측하지 않으면 조기 종료한다.

$$
(I_i, R_i) = M_{adv}(x_{anon}^{i-1}, T_{adv})
$$

$$
x_{anon}^{i} = M_{anon}(x_{anon}^{i-1}, T_{anon}, a_{target}, a_{true}, I_i, R_i)
$$

이 설계는 실제 속성 단서를 모두 찾아 제거하는 대신, latent attribute space에서 추론 방향을 다른 값으로 옮긴다는 발상이다. $a_{target}$은 사용자가 정하거나 후보 집합에서 무작위로 고를 수 있다. 실제 속성값 $a_{true}$을 재작성 모델에 알려주는 것은 선택 사항이다.

> [!note] 핵심 직관
> 단서를 없애는 것은 무엇이 남았는지 계속 확인해야 하지만, 일관된 반대 단서를 넣으면 공격자의 결정 경계를 더 직접적으로 다른 속성값 쪽으로 이동시킬 수 있다.

## On-device distillation

큰 Phi-3-small이 생성한 IncogniText 재작성 쌍 664개를 이용해 Qwen2-1.5B에 LoRA instruction fine-tuning을 적용한다. 같은 소형 모델을 재작성과 adversarial inference에 함께 사용할 수 있어, 원문과 실제 속성 프로필을 기기 밖으로 보내지 않는 배치를 목표로 한다.

# Experimental Evaluation

## 데이터셋

- **Synthetic Reddit-based dataset**: 사람이 검증한 합성 대화 525개. 나이, 성별, 직업, 교육, 소득 수준, 관계 상태, 출생·현재 거주 국가와 도시 등 8개 속성을 포함한다.
- **Real self-disclosure dataset**: Reddit 게시물과 댓글에서 작성자 자신의 속성이 노출된 사례 196개. 성별, 관계 상태, 나이, 교육, 직업을 평가한다.

비교 대상은 Azure Language Service, Dou-SD, Feedback-guided Adversarial Anonymization(FgAA), local DP를 제공하는 DP-BART-PR+이다.

## 평가 지표

- **Privacy**: 별도의 LLM 공격자가 속성값을 맞힌 accuracy. 낮을수록 좋다.
- **ROUGE / BLEU**: 원문과의 표면적 내용 보존 정도.
- **LLM utility judge**: 의미 보존, 가독성, hallucination 점수의 평균.

## 주요 결과

합성 데이터셋에서 가장 좋은 IncogniText 설정인 Phi-3-small은 공격자 정확도를 원문의 71.2%에서 7.2%로 낮췄다. 이는 원래 속성 누출의 약 90% 감소에 해당하며, FgAA 재현 결과 43.2%보다도 낮다. ROUGE는 80.7%, utility judge는 92.2%였다.

| 설정 | Privacy ↓ | ROUGE | Utility |
|---|---:|---:|---:|
| Unprotected original | 71.2 | 100.0 | 100.0 |
| FgAA 재현 | 43.2 | 87.9 | 98.8 |
| IncogniText Llama-3-70B | 13.5 | 78.7 | 92.2 |
| IncogniText Phi-3-small | **7.2** | 80.7 | 92.2 |

실제 Reddit self-disclosure 데이터셋에서도 공격자 정확도를 73.0%에서 12.8%로 낮췄다. 대부분의 속성에서 원래 누출을 90% 이상 줄였으며, income level은 86% 감소했다. 샘플의 80% 이상은 한 번의 반복만으로 익명화되어 평균 반복 횟수도 FgAA의 1.9회보다 적은 1.3회였다.

## Ablation study

- 잘못된 목표 속성값 $a_{target}$으로 조건화하는 것이 프라이버시 향상의 가장 중요한 요소였다.
- adversary의 예측을 이용한 early stopping은 불필요한 재작성을 막아 privacy와 utility를 함께 개선했다.
- 재작성 모델에 $a_{true}$를 제공하는 것은 도움이 되었지만, 추론 근거 $R$과 예측 $I$를 추가로 제공하는 효과는 모델에 따라 일관되지 않았다.

On-device 실험에서 Qwen2-1.5B의 공격자 정확도는 fine-tuning 전 40.8%에서 18.1%로 감소했다. 다만 큰 Phi-3-small의 7.8%에는 미치지 못했고, ROUGE도 84.0에서 71.1로 낮아졌다.

# Conclusion

IncogniText의 차별점은 삭제·일반화만으로 실제 속성의 흔적을 줄이는 것이 아니라, 공격자가 다른 값으로 분류하도록 텍스트의 속성 신호를 적극적으로 재배치한다는 데 있다. 실험은 이 방식이 강한 경험적 보호와 비교적 높은 유용성을 함께 달성하고, 소형 on-device 모델로 일부 이전될 수 있음을 보인다.

# Limitations

- 논문의 privacy 수치는 형식적 보장이 아니라 선택한 LLM 공격자에 대한 경험적 attack accuracy다. fine-tuned attacker나 GPT-4급 평가자는 더 많은 누출을 발견할 수 있다.
- 단일 텍스트 접근을 중심으로 평가한다. 같은 사용자의 여러 텍스트에서 항상 실제 값과 다른 목표만 샘플링하면, 실제 값이 반복해서 나타나지 않는 패턴 자체가 단서가 될 수 있다.
- 목표값을 암시하도록 넣은 새 정보는 의미 보존 지표에서 hallucination으로 평가될 수 있고, 실제 사용에서는 사실성이나 downstream 의사결정을 왜곡할 수 있다.
- 자동 LLM judge 중심의 utility 평가를 실제 사용자 평가로 보완할 필요가 있다.
- [[Differential Privacy]] 보장은 제공하지 않는다. 저자들은 true value도 일정 확률로 뽑는 randomized response 확장을 후속 과제로 남긴다.
