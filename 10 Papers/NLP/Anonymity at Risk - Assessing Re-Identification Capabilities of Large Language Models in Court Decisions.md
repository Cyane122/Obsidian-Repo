---
type: paper
title: "Anonymity at Risk? Assessing Re-Identification Capabilities of Large Language Models in Court Decisions"
authors:
  - "Alex Nyffenegger"
  - "Matthias Stürmer"
  - "Joel Niklaus"
year: 2024
venue: "Findings of NAACL 2024"
url: "https://aclanthology.org/2024.findings-naacl.157/"
pdf: ""
status: read
read_date: "2026-07-21"
tags:
  - domain/nlp
  - method/large-language-model
  - theme/privacy-preservation
  - theme/evaluation
aliases:
  - "Anonymity at Risk"
---

# Abstract

이 논문은 LLM이 익명화된 스위스 법원 판결문에서 사람을 재식별할 수 있는지 평가한다. 실제 판결문, 수작업으로 뉴스와 연결한 판결문, 이름을 가린 Wikipedia 인물 문서로 실험하고 텍스트 재식별용 지표를 제안한다.

범용 LLM만으로 법원 판결문을 대규모 재식별하기는 어려웠지만 Wikipedia에서는 높은 재식별률을 보였다. 모델 크기, 입력 길이, instruction tuning이 주요 영향 요인이며, 관련 뉴스를 retrieval로 제공하면 일부 판결문의 재식별이 가능했다.

# Introduction

법원 판결문은 공공성과 투명성을 위해 공개할 가치가 있지만, 당사자 재식별은 보험 차별, 협박, 명예 훼손 같은 피해로 이어질 수 있다. 이름을 가리는 전통적 익명화만으로도 공개 뉴스, 사건의 세부 사실, 모델이 학습한 지식을 결합하면 신원이 드러날 수 있다는 우려가 있다.

논문은 재식별 공격을 보안 분야의 penetration testing에 대응시킨다. 즉 LLM이 가려진 사람의 이름을 맞힐 수 있는지 공격 관점에서 시험하여, 판결문 익명화 절차의 실제 취약성을 점검한다.

연구 질문은 세 가지다.

1. LLM은 Wikipedia 인물 문서와 스위스 법원 판결문에서 가려진 사람을 얼마나 잘 재식별하는가?
2. 모델 크기, 입력 길이, instruction tuning 등 어떤 요인이 재식별 성능을 좌우하는가?
3. 모델과 도구의 발전은 법원 판결문의 프라이버시에 어떤 의미를 갖는가?

# Datasets

## Court Decisions

2019년 스위스 연방대법원 판결문 약 8천 건을 사용한다. 실제 당사자 정답은 법원만 알고 있으므로 현실성은 높지만, 연구자가 대규모 ground truth 평가를 직접 수행하기 어렵다. 최종 실험에서는 입력 조건을 만족하는 7,673건이 사용되었다.

## Legal-News Linkage

법원 판결문과 관련 뉴스 기사를 수작업으로 연결하여 재식별 가능하다고 확인한 7개 사건을 구성한다. 사건번호, 형량 등의 단서를 시작으로 사건당 관련 기사 약 100개를 모았고, 1,000개의 무관한 기사도 섞었다. 전체는 판결문 7건과 기사 약 2,000개다.

한 기사만으로는 부족하고 여러 기사에 흩어진 사실을 결합해야 이름을 알아낼 수 있어, multi-hop retrieval을 포함한 현실적 공격을 시험한다. 프라이버시와 기사 저작권 문제로 데이터셋은 공개하지 않는다.

## Wikipedia Persons Masked

현실성은 낮지만 대규모 ground truth를 확보하기 위한 통제된 benchmark다. 4천 자가 넘는 인물 페이지 약 6.9만 건 중 1만 건을 무작위로 선택하고, 인물 이름을 mask token으로 대체한다. 원문과 paraphrase를 함께 두어 모델이 정확한 표면 형식을 암기했는지도 비교한다.

> [!note] 세 데이터셋의 역할
> Court Decisions는 현실성, Legal-News Linkage는 확인된 재식별 가능성, Wikipedia는 규모와 정답이라는 서로 다른 장점을 담당한다. 한 데이터셋의 결과만으로 실제 위험을 단정하지 않기 위한 삼각 측정 구조다.

# Metrics

텍스트 재식별에는 표준 지표가 없다는 문제에서 출발해 네 지표를 제안한다.

- **Partial Name Match Score (PNMS)**: 예측한 이름 중 하나라도 정답 이름의 일부와 일치하면 성공으로 본다.
- **Normalized Levenshtein Distance (NLD)**: 예측과 정답의 문자열 거리를 정답 이름 길이로 정규화한다. 낮을수록 정확하다.
- **Last Name Match Score (LNMS)**: 성(last name)의 부분 일치만 평가한다.
- **Weighted Partial Name Match Score (W-PNMS)**: 성을 더 중요하게 반영한다.

$$
\mathrm{W\text{-}PNMS}=\alpha\,\mathrm{PNMS}+(1-\alpha)\,\mathrm{LNMS}, \qquad \alpha=0.35
$$

부분 이름만 알아도 수작업 조사로 신원을 좁힐 수 있다는 현실을 반영하지만, 흔한 이름은 높은 점수만으로 특정 개인을 확정할 수 없으므로 수동 검증이 필요하다.

# Experimental Setup

Wikipedia 입력은 주로 첫 1,000자, 판결문은 최대 10,000자를 사용하고 모델별 상위 5개 예측을 평가한다. 법률·뉴스에 특화된 소형 모델부터 mT0, GPT-3.5, GPT-4 등 다양한 크기와 학습 방식을 비교한다.

RAG 공격은 다음 절차를 따른다.

1. 뉴스 기사 약 1,700개를 1,000자 단위로 나누고 text-embedding-ada-002로 embedding하여 Chroma에 저장한다.
2. GPT-3.5-turbo-16k가 판결문을 뉴스 검색에 유리한 사실 중심 요약으로 바꾼다.
3. 요약과 가까운 기사 chunk 상위 5개를 검색한다.
4. GPT-4가 판결문 요약과 검색된 기사를 함께 읽고 mask된 사람의 이름을 추론한다.

# Results

## Court Decisions

7,673건의 판결문에서 일반 모델은 사실상 재식별에 실패했다. legal_xlm_roberta와 legal_swiss_roberta가 각각 단 한 명만 맞혔고, GPT-4와 mT0도 신뢰할 만한 이름을 내놓지 못했다. GPT-4가 추측을 거부한 것은 privacy alignment의 영향일 수 있다는 것이 저자의 해석이지만, 이를 모델의 지식 부재와 분리해 입증하지는 않는다.

재식별 가능성이 확인된 Legal-News Linkage 7건에서도 모델 가중치에 저장된 지식만으로는 정답을 찾지 못했다. 그러나 관련 뉴스를 검색해 context로 제공한 RAG 공격에서는 GPT-3.5-turbo-16k가 4/7건, GPT-4가 5/7건을 재식별했다. 두 모델 모두 한 사건에서 full name까지 맞혔다.

이 결과는 현재의 vanilla LLM이 곧바로 판결문을 대규모 재식별한다는 뜻은 아니지만, 관련 외부 자료를 선별할 수 있으면 위험이 크게 달라진다는 점을 보여준다.

## Wikipedia benchmark

Wikipedia에서는 상위 모델의 재식별 성능이 훨씬 높았다.

| 모델 | PNMS ↑ | NLD ↓ | W-PNMS ↑ |
|---|---:|---:|---:|
| GPT-4 | 0.71 | 0.17 | **0.65** |
| GPT-3.5 | 0.52 | 0.23 | 0.46 |
| mT0 13B | 0.37 | 0.42 | 0.31 |
| Flan-T5 11B | 0.37 | 0.45 | 0.30 |

원문을 paraphrase하면 평균 성능이 소폭 하락했다. 이는 일부 정보가 줄었거나, 학습 때 본 표현과 달라져 지식 검색이 어려워진 효과가 섞인 것으로 해석된다.

## 영향 요인

- **Model size**: 대체로 크기가 커질수록 성능이 상승하지만 계열별 차이가 크고 일정 크기 이후 증가 폭이 둔화한다.
- **Input length**: 대부분의 모델은 약 2,000자까지 성능이 크게 좋아진 뒤 완만해졌다. 더 많은 식별 단서를 함께 제공할수록 유리하다.
- **Instruction tuning**: 같은 pre-training 지식을 가진 base model보다 instruction-tuned model이 과제를 이해하고 이름을 출력하는 능력이 훨씬 높았다.
- **Decoding**: greedy decoding은 top-1만 고려해 불리했고, 전반적으로 beam search가 더 정확한 이름을 찾았다. 다만 decoding 차이는 앞선 세 요인보다 작았다.
- **Attack interface**: text generation model이 fill-mask와 QA model보다 대체로 우수했다.

# Conclusion

저자들은 현재 시점에서 충분한 자원과 전문성 없이 LLM만으로 스위스 판결문을 대규모 재식별할 위험은 제한적이라고 결론짓는다. 그러나 Wikipedia 실험과 RAG 결과는 관련 정보가 모델의 pre-training이나 retrieval context에 충분히 들어오고 모델이 과제를 따를 수 있으면 재식별이 가능함을 보인다.

따라서 “지금 재식별률이 낮다”는 결과를 익명화의 영구적 안전 보장으로 해석해서는 안 된다. 법원은 모델 크기, context window, 검색·도구 사용 능력이 바뀔 때마다 공개 전 stress test를 반복해야 한다.

# Limitations

- 스위스의 2019년 연방대법원 판결에 집중하므로 다른 국가, 법원 단계, 언어, 시기의 위험으로 바로 일반화하기 어렵다.
- Court Decisions는 대규모 정답을 연구자가 보유하지 않고, Legal-News Linkage는 재식별 가능하다고 선별한 7건뿐이다. RAG의 5/7 결과는 중요한 가능성 증명이지만 일반 재식별률은 아니다.
- 부분 이름 지표는 흔한 성·이름을 실제 개인의 식별 성공으로 과대평가할 수 있다. 반대로 철자 변형과 다국어 이름 표기는 놓칠 수 있다.
- GPT-4의 추측 거부는 safety policy에 따른 행동일 수 있어, 잠재 지식 보유량과 실제 공격 능력을 분리하기 어렵다.
- 향후 더 긴 context, 법률·뉴스 특화 pre-training, chain-of-thought, 구조화 데이터베이스와 knowledge graph가 결합되면 위험이 달라질 수 있다.
- 재식별 도구는 익명화 검증에 유용하지만 동일한 기술이 공격에도 쓰일 수 있는 dual-use 문제를 가진다.
