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

# Abstract

KLUE(Korean Language Understanding Evaluation)는 한국어 NLU benchmark다.

8개 task로 구성된다.
1. Topic Classification
2. Semantic Textual Similarity
3. [[Natural Language Inference]]
4. [[Named Entity Recognition]]
5. Relation Extraction
6. Dependency Parsing
7. Machine Reading Comprehension
8. Dialogue State Tracking

기존 영어 benchmark를 번역하지 않고 한국어 corpus에서 전부 새로 구축했다.
- 한국어의 언어적 특성 반영
- 문어체 + 구어체 포함
- 저작권과 재배포 가능성 확인
- social bias, toxic content, PII 제거

KLUE-BERT와 KLUE-RoBERTa도 함께 공개한다. 한국어 형태론을 고려한 tokenization을 사용하며, 전반적으로 multilingual PLM보다 높은 성능을 보였다.

# Introduction

GLUE/SuperGLUE는 영어 model을 비교할 공통 기준을 만들었다. 한국어에는 이런 통합 benchmark가 부족했다.

기존 multilingual benchmark의 방식
- 영어 dataset을 machine/human translation
- 빠르게 확장할 수 있다는 장점
- 하지만 한국어의 사회문화적 맥락과 교착어적 특징을 놓칠 수 있음
- translation artifact도 발생

따라서 KLUE는 번역 대신 처음부터 새로 만든다.
1. source corpus 선정
2. task 정의
3. annotation guideline 설계
4. annotation 검증

이 과정에서 copyright, annotation artifact, bias, privacy 문제까지 같이 다룬다.

# KLUE Benchmark

## Design Principles
1. **다양한 task/corpus**
   - 뉴스, Wikipedia, review, smart-home query, task-oriented dialogue
   - formal + colloquial Korean
2. **접근성**
   - 복제, 재배포, 변형이 가능한 자료만 사용
3. **정확한 annotation**
   - guideline을 반복해서 수정
   - annotator agreement가 낮은 example은 제거
4. **윤리 문제 완화**
   - bias, toxic content, PII를 자동/수동으로 검사

## Source Corpora
총 10개 source를 사용한다.
- 뉴스 headline
- Wikipedia / Wikinews / Wikitree / 정책 뉴스
- ParaKQC smart-home utterance
- Airbnb review
- NAVER Sentiment Movie Corpus
- Acrofan / 한국경제신문 뉴스

공개 license 또는 별도 계약으로 derivative work, redistribution, commercial use가 가능한 자료를 확보했다. Source마다 품질 차이가 있으므로 noise와 유해 표현을 전처리한다.

## Annotation
공통 기준
- 한국어 특성을 반영할 것
- 모호한 annotation을 줄일 것
- bias, hate speech, PII를 제외할 것

예시
- NER: 개체명 뒤에 조사가 붙는 한국어 특성 고려
- Dependency Parsing: 한국어 POS/dependency label 사용
- agreement가 낮은 sample: 제거 또는 전문가 재검수

## Tasks

| Task           | 형식                                | Train / Dev / Test | 주요 평가 지표                             |
| -------------- | --------------------------------- | -----------------: | ------------------------------------ |
| KLUE-TC (YNAT) | 단일 문장 7-class topic 분류            |      45k / 9k / 9k | Macro F1                             |
| KLUE-STS       | 문장 쌍 similarity regression·이진 분류  |    11k / 0.5k / 1k | Pearson's $r$, F1                    |
| KLUE-NLI       | 문장 쌍 3-class 추론                   |      25k / 3k / 3k | [[Accuracy]]                         |
| KLUE-NER       | character-level sequence tagging  |      21k / 5k / 5k | Entity·character-level Macro F1      |
| KLUE-RE        | entity pair의 30-class relation 분류 |      32k / 8k / 8k | Micro F1, AUPRC                      |
| KLUE-DP        | word-level dependency parsing     |    10k / 2k / 2.5k | UAS, LAS                             |
| KLUE-MRC       | passage 기반 answer span 예측         |      12k / 8k / 9k | Exact Match, character-level ROUGE-W |
| KLUE-DST (WoS) | dialogue slot-value 예측            |       8k / 1k / 1k | Joint Goal Accuracy, slot Micro F1   |

### KLUE-NER
- Entity type: person, location, organization, date, time, quantity
- 한국어 단어는 entity + particle 형태가 많음
-> character-level BIO annotation 사용
- 평가: entity-level F1 + character-level F1
- Wikitree 뉴스 + NSMC review
- 51명 crowdworker annotation -> 언어학자 2명 검수 -> NLP 연구자 6명 수정
- 최종 31,008문장

### KLUE-MRC
세 종류의 question을 포함한다.
- paraphrase: 12,207
- multi-sentence reasoning: 7,895
- unanswerable: 9,211
- 전체: 29,313

평가 지표
- Exact Match
- character-level ROUGE-W

일반 character F1은 글자 순서와 무관하게 overlap만 있으면 점수를 준다 -> 성능을 과대평가할 수 있음. 따라서 longest common consecutive subsequence 기반 ROUGE-W를 사용한다.

### KLUE-DST (Wizard of Seoul)
- 5 domains
- 10,000 dialogues
- 146,692 turns
- 한 작업자가 user/system 역할을 모두 수행하는 self-dialog 방식

# Pretrained Language Models

KLUE-BERT, KLUE-RoBERTa를 함께 학습하고 공개한다.

학습 설정
- Maximum sequence length: 512
- Whole Word Masking
- BERT batch size: 256
- RoBERTa batch size: 2,048
- Learning rate: $10^{-4}$

핵심 차이: 형태소 기반 subword tokenization.
일반 BPE만 사용하는 대신 형태소 분석 결과를 subword 학습에 반영한다. 한국어는 한 어절에 여러 형태소가 붙기 때문에 이 방식이 더 적합하다고 본다.

비교 model
- mBERT
- XLM-R
- KR-BERT
- KoELECTRA

# Fine-tuning
- TC / RE: single sentence classification
  - RE는 subject/object span에 special marker 추가
- NLI / STS: sentence pair classification/regression
- NER / MRC: subword-level tagging / span prediction
- DP: 첫/마지막 subword representation을 concat하고 biaffine/bilinear attention 사용
- DST: TRADE의 GRU encoder를 PLM으로 교체

# Experiments & Results

주요 관찰
1. Korean monolingual model이 multilingual model보다 전반적으로 높다.
2. NER/MRC처럼 boundary가 중요한 task에서 tokenization의 영향이 크다.
3. BASE model끼리 보면 task마다 잘하는 model이 다르다.
   - KLUE-BERT: YNAT
   - KLUE-RoBERTa: RE, DP, MRC, WoS
   - KoELECTRA: STS, NLI, NER
4. KLUE-RoBERTa-LARGE는 YNAT와 NER을 제외한 모든 task에서 가장 높다.

| KLUE-RoBERTa-LARGE 주요 결과       |            점수 |
| ------------------------------ | ------------: |
| KLUE-STS Pearson's $r$         |         93.35 |
| KLUE-NLI Accuracy              |         89.17 |
| KLUE-NER entity / character F1 | 85.00 / 91.86 |
| KLUE-RE Micro F1 / AUPRC       | 71.13 / 72.98 |
| KLUE-DP UAS / LAS              | 93.48 / 88.36 |
| KLUE-MRC EM / ROUGE-W          | 75.58 / 80.59 |
| WoS JGA / slot F1              | 50.22 / 92.23 |

# Discussion

## From Scratch vs Translation
KLUE-NLI와 번역 기반 KorNLI를 비교한다. 각 dataset에서 100문장을 다시 annotation했다.
- 4명 전원 gold label 동의
  - KorNLI: 38%
  - KLUE-NLI: 71%

한국어에서 직접 만들고 검수한 dataset이 번역 dataset보다 label ambiguity가 낮다는 근거.

## Overall Score를 만들지 않은 이유
KLUE는 task별 점수를 단순 평균하지 않는다.
- F1
- Accuracy
- AUPRC
- UAS/LAS
- ROUGE-W
- JGA
- Pearson correlation

Metric의 단위와 의미가 모두 다르다. 평균을 내면 특정 task에 의도하지 않은 weight를 주게 되고 점수 해석도 어려워진다.
-> 8개 task를 각각 평가.

## Ethics & License
- Dataset: CC BY-SA
- bias/toxic content: classifier + annotator report + manual review
- PII: manual inspection 후 제거
- pretrained model과 pretraining/fine-tuning pipeline도 공개

다만 pretraining corpus는 규모가 커서 PII만 pseudonymize하고 bias/hate speech를 전부 제거하지는 않았다. 저자들은 해당 내용을 탐지/교정하는 연구 가능성도 남겨야 한다고 설명한다.

## 한계
- 하나의 overall KLUE score가 없다.
- 8개 task가 한국어 이해 전체를 대표하지는 않는다. 생성, 장문 추론, 방언 등은 없음.
- leaderboard를 반복해서 사용하면 test set에 간접적으로 overfitting될 수 있다.
- 정적 benchmark이므로 model 성능이 포화되면 더 어려운 dataset이 필요하다.

# Conclusion

한국어를 위한 통합 NLU benchmark KLUE를 제안한다.
- 8개 task를 한국어 원문에서 직접 구축
- 한국어 특성에 맞는 annotation/metric 설계
- copyright, bias, privacy를 구축 단계에서 고려
- KLUE-BERT, KLUE-RoBERTa와 학습 code 공개

핵심은 영어 benchmark의 번역판이 아니라 한국어를 기준으로 처음부터 만들었다는 점.
