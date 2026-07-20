---
type: paper
title: "Korean named entity recognition based on language-specific features"
authors:
  - "Yige Chen"
  - "KyungTae Lim"
  - "Jungyeul Park"
year: 2024
venue: "Natural Language Engineering 30(3)"
url: "https://doi.org/10.1017/S1351324923000311"
pdf: "[[40 Sources/Papers/NLP/Korean named entity recognition based on language-specific features.pdf]]"
status: read
read_date: "2026-07-13"
tags:
  - domain/nlp
  - method/transformer
aliases:
  - "Korean Named Entity Recognition Based on Language-Specific Features"
---

# Abstract

한국어 [[Named Entity Recognition|NER]]에서 생기는 문제 중 하나는 annotation 단위다.
- 어절 단위: 조사까지 개체명에 포함되는 문제
- 음절 단위: 경계는 정확하지만 형태소와 품사 정보가 사라지는 문제

본 논문은 형태소 기반 CoNLL-U annotation scheme을 제안한다.
- 어절 경계는 보존
- 어절 내부는 형태소로 분해
- 실제 개체명에 해당하는 형태소에만 BIO tag 부여
- 기존 어절/음절 기반 corpus를 새 형식으로 바꾸는 conversion script 제공

결과
- CRF, BiLSTM-CRF, BERT 계열 모두에서 형태소 형식이 어절/음절 형식보다 높음
- UPOS feature를 추가하면 소폭 향상
- 실험 모델 중 KLUE-RoBERTa-CRF가 F1 88.84로 가장 높음

> [!note] 핵심
> 새로운 NER architecture보다 한국어를 어떤 단위로 잘라서 tag할 것인지가 중심인 논문.

# Introduction

## 한국어 NER이 어려운 이유
1. 한글은 영문처럼 대소문자로 고유명사를 구분할 수 없다.
2. 한국어는 교착어라서 명사 뒤에 조사나 어미가 바로 붙는다.
3. 하나의 개체명이 여러 어절에 걸칠 수 있고, 한 어절의 일부만 개체명일 수도 있다.

예를 들어 `태건이가`에서 실제 인명은 `태건`까지다. 마지막 `이가`는 조사/어미.
- 어절 단위로 보면 전체를 하나의 entity로 처리하게 된다.
- 형태소 단위로 보면 `이가`만 `O` tag로 분리 가능.

## 기존 annotation 단위의 한계
- 어절 기반: 자연스러운 띄어쓰기는 유지하지만 functional morpheme을 개체명에서 뺄 수 없다.
- 음절 기반: 세밀하게 tag할 수 있지만 의미 단위와 POS 정보를 잃는다.
- 기존 형태소 기반: 형태소 sequence만 남기고 원래 어절 경계를 보존하지 않는 경우가 많다.

## 제안
CoNLL-U의 multiword token 구조를 사용한다.
- 상위: 원래 어절
- 하위: 분해된 형태소 + UPOS/XPOS + NE tag

즉, 어절 정보와 형태소 정보를 둘 다 남기는 방식.

# Korean Linguistic Features

한국어는 SOV 어순을 가진 교착어다. 명사 뒤에 격조사와 보조사가 결합하기 때문에 개체명 다음에 오는 POS가 꽤 유용한 단서가 된다.
- PER/ORG: 문장 앞에서 주어나 화제로 자주 등장 -> `JKS`, `JX` 비율이 높음
- LOC: 방향이나 장소를 나타내는 `JKB`가 자주 붙음

다만 조사를 항상 개체명 밖으로 빼면 안 된다. 작품명 내부의 관형격 조사처럼 조사 자체가 이름에 포함되는 예외가 존재한다.
-> 그래서 단순 제거 규칙이 아니라 sequence labeling으로 처리한다.

# Korean NER Datasets

기존 공개 corpus는 annotation 단위가 서로 다르다.

| 말뭉치                                                       | 표기 단위 |   Train |   Dev |  Test |
| --------------------------------------------------------- | ----: | ------: | ----: | ----: |
| KIPS 2016                                                 |   형태소 |   3,660 |     - |     - |
| KIPS 2017                                                 |   형태소 |   3,555 |   501 | 2,569 |
| NAVER NER                                                 |    어절 |  90,000 |     - |     - |
| MODU 2019                                                 |    음절 | 150,082 |     - |     - |
| MODU 2021                                                 |    음절 |  68,400 | 1,085 | 8,685 |
| [[KLUE - Korean Language Understanding Evaluation\|KLUE]] |    음절 |  21,008 | 5,000 | 5,000 |

# Conversion

## eoj2morph
어절 기반 NAVER corpus를 형태소 기반 CoNLL-U로 바꾸는 script.

절차
1. NAVER의 각 어절을 CoNLL-U 형태소 sequence와 align한다.
2. 조사, 구두점, particle, determiner, verb는 기본적으로 NE tag 대상에서 제외한다.
3. 제외하고 나서 tag를 받을 형태소가 하나도 없으면 조건을 단계적으로 완화한다.
4. 같은 entity의 `B-*`와 `I-*` 사이에 있는 형태소는 `I-*`로 채운다.
5. 나머지는 `O`.

## syl2morph
KLUE, MODU처럼 음절 단위로 annotation된 corpus를 형태소 단위로 변환한다.
- 음절 annotation에서 이미 functional morpheme이 entity 밖으로 빠져 있으므로 POS 기반 제외 규칙은 사용하지 않는다.
- `morph2eoj`, `morph2syl`도 제공해서 prediction을 원래 형식으로 되돌릴 수 있다.

원래 형식으로 back-conversion한 뒤 평가하므로 token 수 차이 때문에 생기는 불공정한 비교를 줄인다.

# NER Models

표기 형식의 효과가 특정 model에만 해당하는지 보기 위해 여러 model을 비교한다.
- CRF: word, UPOS, XPOS의 unigram/bigram feature 사용
- BiLSTM-CRF: fastText embedding + 2-layer BiLSTM
- BERT: multilingual BERT, XLM-RoBERTa, KLUE-RoBERTa
- classifier: MLP / CRF 비교

BERT tokenizer가 한 형태소를 여러 subword로 나누면 첫 번째 subword representation만 사용한다. POS feature가 있으면 해당 embedding을 뒤에 concat한다.

# Experiments & Results

## 실험 설정
- Data: NAVER NER 90,000문장
- 변환: 어절 -> 형태소 기반 CoNLL-U
- Split: 80/10/10
- Baseline seed: 42
- Neural model: seed 41~45 평균 ± 표준편차
- Metric: entity-level [[F1 Score]]

공식 test set이 공개되지 않아 NAVER training set을 다시 split했다.

## Model 비교

| 모델                    |               F1 |
| --------------------- | ---------------: |
| CRF                   |            71.50 |
| BiLSTM-CRF            |     84.76 ± 0.29 |
| multilingual BERT-CRF |     87.28 ± 0.37 |
| XLM-RoBERTa-CRF       |     88.16 ± 0.33 |
| KLUE-RoBERTa-CRF      | **88.84 ± 0.43** |

결과
- contextual embedding의 효과가 큼: CRF 71.50 -> KLUE-RoBERTa-CRF 88.84
- 한국어 단일언어 model인 KLUE-RoBERTa가 multilingual BERT/XLM-RoBERTa보다 높음
- XLM-RoBERTa에서 CRF가 MLP보다 0.23 높지만 차이는 작음

## POS Feature
- WORD only: 88.16
- WORD + UPOS: 88.41
- WORD + UPOS + XPOS: 88.37

UPOS가 가장 높다. 처음에는 한국어 전용 XPOS가 더 유용할 것 같지만 결과는 반대.
- UPOS: 17 labels
- Sejong XPOS: 46 labels
-> 자동 POS tagger가 UPOS를 더 정확하게 예측하기 때문이라고 해석한다.

## Annotation Format 비교
1. 형태소 CoNLL-U vs 어절
   - CRF: 71.50 vs 49.15
   - XLM-RoBERTa-CRF: 88.16 vs 86.72
2. BIO vs BIOES
   - CRF: 71.50 vs 70.67
   - XLM-RoBERTa-CRF: 88.16 vs 85.70
   - entity type이 14개라 `E`, `S`까지 추가하면 label space가 너무 커진다 -> BIO가 더 높음
3. 형태소 vs 음절

| Dataset   | CoNLL-U | Syllable |
| --------- | ------: | -------: |
| MODU 2019 |   88.03 |    84.91 |
| MODU 2021 |   81.72 |    78.10 |
| KLUE      |   91.72 |    88.15 |
| ETRI      |   97.59 |    93.28 |

네 dataset 모두 형태소 형식이 3.12~4.31 F1 높았다.

> [!warning] 비교 시 주의
> XLM-RoBERTa는 subword tokenizer를 사용한다. 음절 전용 tokenizer가 아니므로 이 차이를 annotation 단위만의 효과라고 보기는 어렵다.

# Discussion

각 형식의 trade-off
- 어절: 자연스러운 segmentation 유지 / 조사 분리 불가능
- 음절: 정확한 boundary / 형태론 정보 손실
- 제안 형식: 어절을 위에 남기고 실제 tag는 형태소에 부여

즉, 한국어 NER에서는 model만큼 tokenization과 annotation scheme도 중요하다. 더 큰 encoder를 쓰는 것보다 entity boundary와 언어의 형태론이 맞는 단위를 쓰는 게 먼저일 수 있다.

## 한계
- NAVER 공식 test set이 없어 training data를 다시 나눴다.
- 형태소 분석과 POS prediction 오류가 NER까지 전파될 수 있다.
- 주 실험이 뉴스 corpus 중심이라 구어체나 신조어에서도 같은 효과가 나는지는 불분명하다.
- 음절 전용 tokenizer를 사용한 통제 실험이 필요하다.

# Conclusion

한국어 NER corpus를 형태소 기반 CoNLL-U로 표현하는 방법을 제안했다.
- 조사/어미를 실제 entity에서 분리
- 어절 boundary와 POS 정보는 유지
- 어절/음절 corpus와 서로 변환 가능

CRF부터 [[Transformer]] model까지 형태소 형식이 더 높은 성능을 보였다. 핵심은 한국어의 구조에 맞게 annotation 단위를 잡은 것.
