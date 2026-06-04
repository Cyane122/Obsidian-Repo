## 주요 정보
- 발표 연도: 2025년
- 저자: Shuo Huang et al.
- tags: #NLP, #privacy-reserving, #text-rewriting, #benchmark, #differential-privacy, #data-utility
---
# Abstract
클라우드 기반 [[Large Language Model|LLM]]의 확산으로 사용자가 서비스에 민감한 정보를 입력하는 과정에서 발생하는 프라이버시 침해 우려가 증가하고 있다. 본 논문은 민감한 텍스트를 LLM에 전송하기 전에 sanitize하는 두 가지 전략을 제안한다.
- Deleting: 민감한 표현을 문장에서 완전히 제거
- Obscuring: 민감한 세부 정보를 더 추상적인 표현으로 대체
이를 연구하기 위해 크라우드소싱과 LLM을 결합해 최초의 말뭉치 NAP²를 구축하였다. 기존 익명화 연구 대비 더 자연스러운 재작성 결과와 프라이버시 보호-데이터 유용성 간의 균형이 개선되었음을 실험으로 입증한다.

# Introduction
## 기존 익명화 방식의 한계
LLM과의 상호작용 과정에서 사용자의 민감 정보(PII 등)가 신뢰할 수 없는 서버에 노출될 위험이 있다. 기존 redaction/anomyzation 기법은 세 가지 구조적 한계를 가진다.
1. 비자연성: PII를 마스킹하거나 entity type으로 대체하면 문법적 흐름과 의미적 일관성이 깨진다. 따라서 downstream 모델이 이 비자연스러운 텍스트에 맞게 별도로 fine-tuning되어야 한다.
2. 추론 취약성: PII가 제거된 텍스트에서도 추론을 통해 개인 속성을 복원하는 것이 가능하다.
3. 역효과: 마스킹된 부분의 존재 자체가 공격자에게 해당 문서의 민감성을 알려주는 신호가 된다.

## 기존 접근들과 그 한계
**Self-disclosure abstraction** (Dou et al., 2024): 민감한 정보를 덜 구체적인 표현으로 paraphrase했다. 다만 PII span 탐지에만 집중하며, human-authored reference rewrite가 없어 reference-based 평가가 불가능하다.
**Differential Privacy** 기반: 이론적 프라이버시 보장을 제공하지만, 높은 수준의 보장을 위해 과도한 노이즈를 주입해 정보 유용성이 크게 손상된다.

## 본 논문의 접근
인간이 실제로 민감한 정보를 숨길 때 쓰는 두 전략에서 착안했다.
- Deleting: 민감한 표현을 문장에서 완전히 제거 -> k-anonymity의 suppression 원칙에 대응한다.
- Obscuring: 민감한 표현을 더 일반적이거나 추상적인 표현으로 치환 -> k-anonymity의 generalization 원칙에 대응한다.
재작성된 텍스트가 sanitize되었다는 사실을 드러내지 않아 공격자의 경계심을 유발하지 않는다.
Downstream 모델의 별도 fine-tuning 없이도 바로 처리 가능하다.

## 주요 기여
1. NAP² 코퍼스 구축: PERSONA-CHAT 기반. 크라우드소싱(895쌍 human rewrite) + GPT-4 합성 데이터(3900쌍)로 구성된 최초의 naturalness & privacy-reserving rewriting 말뭉치.
2. PRIVACY_CLI 메트릭 제안: [[Natural Language Inference]] 모델을 활용해 재작성 결과의 프라이버시 보존 수준을 자동 평가하는 새로운 지표.
3. 실험 검증: NAP²로 fine-tuning한 T5-BASE가 zero-shot LLM 및 [[Differential Privacy]] 기반 SOTA를 큰 차이로 능가함을 입증.

> [!note]  접근 방식
> 구조화된 데이터에 사용하던 기법을 그대로 자연어에 도입해보자는 아이디어. 쿼리를 서버에 보내기 전 전처리 단계로 이 모델을 사용할 수 있다.

# Naturalness and Privacy-Preserving Rewriting
## Task 정의
입력: 발화 $x$ + 해당 발화가 노출하는 개인정보를 서술한 문장 $p$ (persona)
출력: $p$에 명시된 개인정보를 드러내지 않으면서, $x$의 비민감 내용을 최대한 보존한 자연스러운 문장 $y$.
자연스러운 문장의 조건: 문법적으로 올바르면서, 마스킹 기호나 entity type 같은 인공적 흔적이 없을 것.
적용 시점: 모델 학습 시가 아니라, 추론 시(Inference time) 프라이버시 보호에 초점

## 두 가지 재작성 전략
- Deleting: $x$에서 $p$에 명시된 개인정보와 관련된 단어와 구를 완전히 제거.
- Obscuring: 민감한 단어와 구를 더 일반적이고 추상적인 표현으로 대체(e.g. 두 명의 10대 아들 -> 아이들)

## Manually Curated Corpus
베이스 데이터: PERSONA-CHAT
- 각 대화에 두 화자의 persona가 4~5개 문장으로 부여됨.
- Persona 문장 = 사용자별 프라이버시 프로파일로 활용.
- 어떤 발화가 어떤 persona 문장의 정보를 노출하는지 alignment 필요.

Utterance-Persona Alignment
- 방법: ROBERTA MNLI 모델로 $p(y=\text{entail}|x_i, p_i)$를 alignment score $s_{ij}$로 사용
- 임계값: 0.3 이상인 쌍만 후보로 선정 후 수동 검토
- 비교: Sparse-MAX, Sharp-MAX 대비 sentence-level alignment에서 일관되게 우수

Annotations
- 플랫폼: Amazon Mechanical Turk
- 단위: 15쌍을 1개 batch로 묶어 Deleting / Obscuring 각각 재작성 요청
- 품질 관리: 배치 단위 수동 검토 -> 수락률 47.97%
- 최종 수집: 895쌍 (전략당 1개 rewrite)
- 분할: CV set 655 / Valication 140 / Test 10

데이터 통계

|           | 평균 길이 | Distinct unigram 비율 |
| --------- | ----- | ------------------- |
| ORI (원문)  | ~13.6 | ~0.25               |
| DEL (삭제)  | ~8.4  | ~0.29               |
| OBS (모호화) | ~14.1 | ~0.26               |
-> Deleting은 문장을 짧게 만들고, Obscuring은 원문보다 약간 길어지며 어휘 다양성도 소폭 증가한다.

## Synthetic Data Augmentation
