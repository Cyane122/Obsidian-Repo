---
type: paper
title: "KLUE: Korean Language Understanding Evaluation"
authors:
  - "Sungjoon Park et al."
year: 2021
venue: "NeurIPS 2021 Datasets and Benchmarks Track"
url: "https://openreview.net/forum?id=q-8h8-LZiUm"
pdf: "[[40 Sources/Papers/NLP/KLUE - Korean Language Understanding Evaluation.pdf]]"
status: read
read_date: "2026-07-13"
tags:
  - domain/nlp
  - method/transformer
  - theme/evaluation
aliases:
  - "Korean Language Understanding Evaluation"
  - "KLUE"
---

# 한 줄 요약

한국어의 언어적·사회문화적 특성을 반영해 8개 NLU 과제를 처음부터 구축하고, 한국어 특화 tokenization을 적용한 KLUE-BERT와 KLUE-RoBERTa를 함께 공개한 종합 한국어 이해 benchmark이다.

# Abstract

KLUE는 Topic Classification, Semantic Textual Similarity, [[Natural Language Inference]], [[Named Entity Recognition]], Relation Extraction, Dependency Parsing, Machine Reading Comprehension, Dialogue State Tracking의 8개 과제로 구성된다. 번역된 영어 benchmark에 의존하지 않고 현대 한국어의 문어체·구어체 자료를 바탕으로 각 데이터셋을 새로 만들었다.

저자들은 저작권과 재배포 가능성을 고려해 원천 말뭉치를 선정하고, 반복적으로 annotation guideline을 개선했다. 사회적 편향, 유해 표현, PII를 제거하는 절차도 benchmark 구축에 포함했다. 함께 공개한 KLUE-BERT와 KLUE-RoBERTa는 한국어 형태론을 고려한 subword tokenization을 사용하며, 실험에서 다국어 PLM과 기존 공개 한국어 PLM에 경쟁력 있는 결과를 보였다.

# 1. Introduction

GLUE와 SuperGLUE는 영어 NLU 발전을 촉진했지만, 기존 다국어 benchmark는 영어 데이터를 번역하는 과정에서 한국어의 사회문화적 맥락과 교착어적 특성을 놓치고 translation artifact를 만들 수 있다. 당시 한국어에는 다양한 model을 동일 조건에서 비교할 통합 NLU benchmark도 부족했다.

KLUE는 원천 corpus 선정, task 정의, annotation protocol 설계, 검증을 모두 한국어 자료에서 새로 수행한다. 이를 통해 저작권 침해, annotation artifact, 사회적 편향, 개인정보 노출을 설계 단계에서 다루고자 한다.

# 2. KLUE Benchmark

## 2.1 Design Principles

KLUE는 네 가지 원칙을 따른다.

1. 다양한 task와 corpus: 뉴스, 백과사전, 사용자 review, smart-home query, task-oriented dialogue를 포함하고 문어체와 구어체를 함께 다룬다.
2. 제한 없는 접근성: 복제·재배포·변형이 가능한 자료를 사용해 공통 benchmark로서의 접근성을 확보한다.
3. 정확하고 모호하지 않은 annotation: guideline을 반복 개선하고 annotator agreement가 낮은 예시를 제거한다.
4. 윤리적 위험 완화: 사회적 편향, toxic content, PII를 자동·수동 절차로 식별해 최종 benchmark에서 제외한다.

## 2.2 Source Corpora

원천 자료는 뉴스 headline, Wikipedia, Wikinews, Wikitree, 정책 뉴스, ParaKQC smart-home utterance, Airbnb review, NAVER Sentiment Movie Corpus, Acrofan 뉴스, 한국경제신문 뉴스 등 10개 source로 구성된다. 공개 license 또는 별도 계약을 통해 파생·재배포·상업적 이용 가능성을 확보하고, source별 noise와 품질 차이를 전처리한다.

## 2.3 Considerations in Annotation

한국어 고유 특성, annotation 정확성, 윤리적 위험을 공통 기준으로 둔다. NER에서는 개체명과 조사가 한 어절 안에 결합하는 현상을 반영하고, dependency parsing에서는 한국어 POS와 dependency label 체계를 사용한다. 작업자는 유해하거나 편향된 표현과 PII를 보고하도록 안내받으며, 합의가 어려운 example은 제거하거나 전문가 검수를 거친다.

## 2.4 Tasks

| Task | 형식 | Train / Dev / Test | 주요 평가 지표 |
|---|---|---:|---|
| KLUE-TC (YNAT) | 단일 문장 7-class topic 분류 | 45k / 9k / 9k | Macro F1 |
| KLUE-STS | 문장 쌍 similarity regression·이진 분류 | 11k / 0.5k / 1k | Pearson's $r$, F1 |
| KLUE-NLI | 문장 쌍 3-class 추론 | 25k / 3k / 3k | [[Accuracy]] |
| KLUE-NER | character-level sequence tagging | 21k / 5k / 5k | Entity·character-level Macro F1 |
| KLUE-RE | entity pair의 30-class relation 분류 | 32k / 8k / 8k | Micro F1, AUPRC |
| KLUE-DP | word-level dependency parsing | 10k / 2k / 2.5k | UAS, LAS |
| KLUE-MRC | passage 기반 answer span 예측 | 12k / 8k / 9k | Exact Match, character-level ROUGE-W |
| KLUE-DST (WoS) | dialogue slot-value 예측 | 8k / 1k / 1k | Joint Goal Accuracy, slot Micro F1 |

KLUE-NER는 person, location, organization, date, time, quantity의 6개 entity type을 사용한다. 개체명과 조사가 한 어절에 결합하는 한국어 특성을 반영해 character-level BIO로 annotation하며, entity-level F1과 character-level F1을 함께 보고한다. Wikitree 뉴스와 NSMC review에서 뽑은 문장을 51명의 crowdworker가 먼저 annotation하고, 언어학자 2명과 NLP 연구자 6명이 검수·수정해 31,008문장을 구성했다.

KLUE-MRC는 단순 paraphrase question뿐 아니라 multi-sentence reasoning과 unanswerable question을 포함한다. 전체 29,313개 question은 paraphrase 12,207개, 다문장 추론 7,895개, 정답 없음 9,211개로 구성된다. 순서를 무시한 character overlap이 성능을 과대평가하지 않도록 longest common consecutive subsequence 기반 ROUGE-W를 사용한다.

WoS는 다섯 domain의 10,000개 dialogue와 146,692개 turn으로 구성된다. 한 작업자가 user와 system 역할을 모두 수행하는 self-dialog 방식으로 dialogue와 state를 함께 생성한다.

# 3. Experiments

## 3.1 Pretrained Language Models

저자들은 BERT와 RoBERTa의 학습 방식을 따라 KLUE-BERT와 KLUE-RoBERTa를 사전학습한다. 최대 sequence length는 512이고, whole word masking을 사용한다. BERT는 batch size 256, RoBERTa는 2,048이며 learning rate는 모두 $10^{-4}$이다.

가장 중요한 차이는 한국어의 교착어적 성격을 고려한 형태소 기반 subword tokenization이다. 일반 BPE와 달리 형태소 분석 결과를 subword 학습에 반영하여 한국어 어절 내부 구조를 더 잘 보존하려 한다. 비교 대상은 mBERT, XLM-R, KR-BERT, KoELECTRA이다.

## 3.2 Fine-tuning Language Models

- TC와 RE는 단일 문장 분류로 처리하며, RE는 subject와 object span에 특수 marker를 삽입한다.
- NLI와 STS는 문장 쌍 분류·회귀 구조를 사용한다.
- NER와 MRC는 각 subword representation을 label 또는 span score에 선형 변환한다.
- DP는 단어의 첫·마지막 subword를 연결해 word representation을 만들고, biaffine·bilinear attention으로 head와 arc type을 예측한다.
- DST는 TRADE의 GRU utterance encoder를 PLM으로 바꾸고, state generator와 slot gate classifier를 공동 학습한다.

## Results

한국어 단일언어 모델은 전반적으로 mBERT와 XLM-R 같은 다국어 모델보다 높았다. 특히 NER와 MRC처럼 span 경계가 중요한 task에서는 character-level 점수보다 entity-level exact score에서 tokenization 차이가 더 크게 드러났다.

BASE 크기끼리 비교하면 task별 최적 model이 달랐다. KLUE-BERT는 YNAT, KLUE-RoBERTa는 RE·DP·MRC·WoS, KoELECTRA는 STS·NLI·NER에서 가장 높았다. 크기를 키운 KLUE-RoBERTa-LARGE는 YNAT와 NER을 제외한 모든 task에서 비교 모델 중 가장 높은 결과를 냈다.

| KLUE-RoBERTa-LARGE 주요 결과 | 점수 |
|---|---:|
| KLUE-STS Pearson's $r$ | 93.35 |
| KLUE-NLI Accuracy | 89.17 |
| KLUE-NER entity / character F1 | 85.00 / 91.86 |
| KLUE-RE Micro F1 / AUPRC | 71.13 / 72.98 |
| KLUE-DP UAS / LAS | 93.48 / 88.36 |
| KLUE-MRC EM / ROUGE-W | 75.58 / 80.59 |
| WoS JGA / slot F1 | 50.22 / 92.23 |

# 4. Discussion

KLUE의 가치는 단순히 한국어 데이터를 모은 데 있지 않다. 번역 benchmark 대신 한국어 원문에서 task를 설계하고, 각 task의 언어 단위에 맞는 metric과 annotation을 선택했다. NER·MRC에는 character-level metric을, DP에는 word-level 구조 metric을, DST에는 dialogue state 전체와 개별 slot 관점의 metric을 적용한다.

저자들은 이처럼 metric의 종류와 granularity가 서로 다르기 때문에 GLUE식 단순 평균 점수를 제공하지 않는다. F1, accuracy, AUPRC, UAS/LAS, ROUGE-W, JGA, Pearson correlation을 평균하면 task마다 의도하지 않은 가중치를 주고 해석 가능성을 잃기 때문이다. 따라서 model은 8개 task별 성능으로 평가한다.

KLUE-NLI의 100개 표본을 KorNLI와 다시 annotation한 비교에서는 4명의 추가 annotator가 gold label에 전원 동의한 비율이 KLUE-NLI 71%, KorNLI 38%였다. 이는 한국어에서 직접 구축하고 반복 검증한 annotation이 번역 기반 dataset보다 모호성을 줄였다는 근거로 제시된다.

데이터는 CC BY-SA로 배포되며, benchmark와 함께 pretrained model, pretraining·fine-tuning pipeline을 공개해 재현성과 후속 개선을 지원한다.

# 5. Conclusion

KLUE는 한국어 NLU를 하나의 숫자로 단순화하기보다 서로 다른 능력을 측정하는 8개 task suite로 정의한다. 한국어 원문에서 dataset을 새로 구축하고, 언어별 annotation과 metric을 설계하며, 한국어 특화 PLM과 재현 가능한 학습 절차를 함께 제공했다. 이 benchmark는 한국어 model의 controlled comparison뿐 아니라 다국어 연구에서 한국어를 포함하는 공통 기반을 마련했다.

# 핵심 기여

1. 한국어 원문과 한국어 특성에 기반한 8개 NLU benchmark를 처음부터 구축했다.
2. 저작권, annotation quality, social bias, toxic content, PII를 dataset design의 명시적 기준으로 다뤘다.
3. 형태소 기반 subword tokenization을 적용한 KLUE-BERT와 KLUE-RoBERTa를 공개했다.
4. task별 적합한 metric과 강한 baseline을 제공하고 pretraining·fine-tuning recipe를 공개했다.

# 한계와 후속 질문

- 저자가 명시한 한계: 서로 다른 metric을 통합할 해석 가능한 overall KLUE score를 제시하지 못했다.
- 저자가 명시한 한계: 대규모 pretraining corpus에서는 PII를 가명화하지만 사회적 편향과 hate speech를 모두 자동 제거하지는 않았다. 저자들은 이를 탐지·교정 연구 가능성과 현실적 검수 한계 사이의 선택으로 설명한다.
- 해석상 제약: benchmark가 높은 품질의 정적 test set을 제공하더라도 반복적인 leaderboard 최적화로 test set에 간접 과적합될 수 있다.
- 해석상 제약: 8개 task가 한국어 이해 전체를 포괄하지는 않으며 생성, 장문 추론, 방언·세대어, multimodal 이해 등은 범위 밖이다.
- 후속 질문: task별 metric의 의미를 보존하면서 model capability를 통합 추정하는 방법은 무엇인가?
- 후속 질문: KLUE가 포착한 tokenization 이득이 더 큰 decoder-only language model에서도 같은 방식으로 나타나는가?
