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

# 한 줄 요약

한국어의 교착어적 특성 때문에 어절 또는 음절 단위 표기에서 생기는 개체명 경계 문제를 형태소 단위 CoNLL-U 표기와 변환 알고리즘으로 해결하고, 형태소·품사 정보를 보존한 표현이 여러 한국어 [[Named Entity Recognition|NER]] 데이터셋에서 더 높은 F1을 보임을 검증한다.

# Abstract

한국어 어절은 내용 형태소에 조사와 어미 같은 기능 형태소가 결합되어 있으므로 어절 전체에 개체명 태그를 붙이면 실제 개체명보다 경계가 넓어진다. 반대로 음절 단위 표기는 정확한 경계를 표현할 수 있지만 형태소와 품사 정보를 잃는다. 이 논문은 어절의 자연스러운 경계를 보존하면서 내부를 형태소로 분해하는 CoNLL-U 형식을 한국어 NER에 적용하고, 기존 어절·음절 단위 말뭉치를 이 형식으로 변환하는 알고리즘을 제안한다.

CRF, BiLSTM-CRF, multilingual BERT, XLM-RoBERTa, KLUE-RoBERTa를 비교한 결과 형태소 단위 형식이 어절·음절 단위 형식보다 일관되게 높은 성능을 보였다. 형태소별 UPOS 정보도 추가 이득을 제공했으며, 실험한 모델 중에는 한국어 단일언어 모델인 KLUE-RoBERTa가 가장 높은 F1을 기록했다.

# 1. Introduction

한국어 NER의 핵심 문제는 모델 구조만이 아니라 입력과 정답을 어떤 단위로 표현할지에 있다.

- 한글에는 영문의 대소문자처럼 개체명을 표면적으로 구별하는 장치가 없다.
- 한국어는 교착어이므로 하나의 어절에 명사와 조사·어미가 함께 결합한다.
- 개체명 하나가 여러 어절에 걸칠 수 있고, 반대로 한 어절의 일부만 개체명일 수 있다.
- 기존 어절 단위 말뭉치는 기능 형태소까지 개체명에 포함하며, 음절 단위 말뭉치는 형태론적 정보를 충분히 활용하기 어렵다.

논문은 이를 데이터 표현의 문제로 보고, 형태소·어절 경계와 품사 정보를 함께 보존하는 CoNLL-U 기반 표기 체계를 제안한다. 또한 어절 기반 NAVER 데이터와 음절 기반 KLUE·MODU·ETRI 데이터를 형태소 기반 형식으로 바꾸고 원래 형식으로 되돌릴 수 있는 변환 절차를 구현한다.

# 2. Linguistic description of NEs in Korean

한국어는 SOV 어순을 갖는 교착어이며, 명사 뒤에 격조사와 보조사가 결합한다. 인명·기관명은 문장 앞에서 주어나 화제로 등장하는 비율이 높아 `JKS`·`JX`가 자주 뒤따르고, 지명은 방향·장소를 표시하는 `JKB`와 자주 결합한다. 따라서 개체명 뒤에 붙는 품사 정보는 경계와 유형을 예측하는 유용한 단서가 된다.

예를 들어 `에마뉘엘 웅가로가`에서 인명은 `에마뉘엘 웅가로`이고 주격 조사 `가`는 개체명에 속하지 않는다. 어절 단위 표기에서는 이를 분리할 수 없지만 형태소 단위 표기는 인명 형태소에만 태그를 부여할 수 있다. 다만 작품명 내부의 관형격 조사처럼 기능 형태소가 실제 개체명 일부인 예외도 있으므로, 모든 조사를 기계적으로 제거해서는 안 된다.

# 3. Previous approaches to Korean NER

기존 공개 한국어 NER 말뭉치는 서로 다른 단위를 사용한다.

| 말뭉치 | 표기 단위 | Train | Dev | Test |
|---|---:|---:|---:|---:|
| KIPS 2016 | 형태소 | 3,660 | - | - |
| KIPS 2017 | 형태소 | 3,555 | 501 | 2,569 |
| NAVER NER | 어절 | 90,000 | - | - |
| MODU 2019 | 음절 | 150,082 | - | - |
| MODU 2021 | 음절 | 68,400 | 1,085 | 8,685 |
| [[KLUE - Korean Language Understanding Evaluation|KLUE]] | 음절 | 21,008 | 5,000 | 5,000 |

기존 형태소 단위 접근도 형태소 열만 제공하고 원래 어절 경계를 보존하지 않는 경우가 많았다. 제안 형식은 CoNLL-U의 multiword token 구조를 이용해 상위에는 어절을, 하위에는 분해된 형태소와 UPOS·XPOS를 함께 둔다는 점이 다르다.

# 4. Representation of NEs for the Korean language

제안 표기의 목표는 다음 두 정보를 동시에 보존하는 것이다.

1. 문장의 자연스러운 띄어쓰기 단위인 어절 경계
2. 실제 개체명 경계에 맞춘 형태소 단위 BIO 태그와 품사 정보

어절 기반 데이터를 바꾸는 `eoj2morph`는 각 어절을 대응하는 CoNLL-U 형태소 열에 정렬한다. 기본적으로 조사·구두점·한정사·동사 같은 형태소를 개체명 후보에서 제외하되, 제외 후 태그를 받을 형태소가 없으면 제외 조건을 단계적으로 완화한다. 같은 개체명의 시작과 끝 사이에 놓인 형태소는 `I-*`로 채우고 나머지는 `O`로 둔다.

음절 기반 데이터를 바꾸는 `syl2morph`는 음절 수준에서 이미 기능 형태소가 개체명 경계 밖으로 분리되어 있다는 점을 이용한다. 변환된 출력은 `morph2eoj`와 `morph2syl`로 원래 평가 형식에 되돌릴 수 있어, 서로 다른 token granularity에서도 동일한 원본 단위로 공정하게 평가할 수 있다.

# 5. NER learning models

논문은 표기 형식의 효과가 특정 모델에만 의존하지 않는지 확인하기 위해 여러 계열을 비교한다.

- CRF: 단어와 UPOS·XPOS의 unigram/bigram feature를 사용하는 전통적 sequence labeling 기준선이다.
- BiLSTM-CRF: fastText 형태소 표현에 선택적으로 UPOS·XPOS embedding을 연결하고, 2층 양방향 LSTM으로 문맥화한다.
- BERT 계열: multilingual BERT, XLM-RoBERTa, KLUE-RoBERTa를 사용한다. 형태소가 여러 subword로 분해되면 첫 subword 표현을 해당 형태소 표현으로 사용하고, 필요한 경우 POS embedding을 연결한다.
- 분류층: MLP와 CRF를 비교한다. CRF는 인접 태그 사이의 전이 제약을 직접 모델링한다.

# 6. Experiments

주 실험은 NAVER NER의 90,000문장을 형태소 기반 CoNLL-U로 변환해 사용한다. 공개된 공식 test set이 없으므로 변환한 학습 데이터를 80%/10%/10%로 나누며, 기준 분할 seed는 42이다. 신경망 결과는 seed 41~45의 평균과 표준편차로 보고한다.

평가는 개체명 단위 precision과 recall의 조화평균인 [[F1 Score]]를 사용한다.

$$
F_1 = 2\frac{PR}{P+R}
$$

비교 질문은 세 가지다.

1. 형태소 기반 CoNLL-U가 어절·음절 기반 표기보다 유리한가?
2. contextualized [[Transformer]] 표현이 CRF와 BiLSTM 기준선보다 유리한가?
3. UPOS와 XPOS 같은 언어학적 feature가 추가 이득을 제공하는가?

# 7. Results

## 모델과 feature 비교

NAVER 데이터를 제안 형식으로 변환한 뒤 비교한 결과는 다음과 같다.

| 모델 | F1 |
|---|---:|
| CRF | 71.50 |
| BiLSTM-CRF | 84.76 ± 0.29 |
| multilingual BERT-CRF | 87.28 ± 0.37 |
| XLM-RoBERTa-CRF | 88.16 ± 0.33 |
| KLUE-RoBERTa-CRF | **88.84 ± 0.43** |

단일언어 KLUE-RoBERTa가 multilingual BERT와 XLM-RoBERTa보다 높았다. 저자들은 한국어 전용 사전학습과 한국어에 더 적합한 tokenizer를 주된 이유로 해석한다. XLM-RoBERTa에서는 CRF 분류층이 MLP보다 0.23점 높았지만 차이는 크지 않았다.

XLM-RoBERTa-CRF에 POS feature를 더하면 단어만 사용한 88.16에서 `WORD + UPOS` 88.41로 상승했다. XPOS까지 더한 88.37은 소폭 낮았다. 저자들은 17개 범주의 UPOS가 46개 범주의 Sejong XPOS보다 자동 예측이 쉬워, 더 신뢰할 수 있는 feature가 되었기 때문이라고 본다.

## 표기 형식 비교

- 형태소 CoNLL-U 대 어절: CRF는 71.50 대 49.15, XLM-RoBERTa-CRF는 88.16 대 86.72였다.
- BIO 대 BIOES: CRF는 71.50 대 70.67, XLM-RoBERTa-CRF는 88.16 대 85.70으로 BIO가 더 높았다. 14개 개체 유형에 `E`와 `S`가 추가되면서 예측해야 할 레이블 수가 늘어난 것이 불리하게 작용했다.
- 형태소 CoNLL-U 대 음절: XLM-RoBERTa-CRF에서 MODU 2019는 88.03 대 84.91, MODU 2021은 81.72 대 78.10, KLUE는 91.72 대 88.15, ETRI는 97.59 대 93.28이었다.

모든 음절 기반 데이터셋에서 형태소 형식이 3.12~4.31 F1 높았다. 다만 사용한 XLM-RoBERTa tokenizer가 음절 전용이 아니라 subword 기반이므로, 이 차이를 순수하게 표기 단위만의 효과로 해석해서는 안 된다.

# 8. Discussion

어절 형식은 자연스러운 띄어쓰기를 보존하지만 개체명에 속하지 않는 조사까지 같은 token에 묶는다. 음절 형식은 세밀한 경계를 표현하지만 의미를 갖는 최소 단위인 형태소보다 더 작게 분해되어 품사 같은 언어학적 feature를 붙이기 어렵다. 제안 형식은 어절을 multiword token으로 남겨 자연 경계를 보존하고, 실제 학습과 태깅은 형태소 단위에서 수행함으로써 두 방식의 장점을 결합한다.

이 결과는 한국어처럼 형태론적으로 풍부한 언어에서 tokenization과 annotation scheme 자체가 모델 성능의 일부임을 보여준다. 더 큰 encoder를 선택하는 것뿐 아니라, downstream task의 정답 경계와 언어의 형태론이 맞물리도록 입력 단위를 설계해야 한다.

# 9. Conclusion

형태소 기반 CoNLL-U 표기는 개체명과 조사·어미의 경계를 명시적으로 분리하면서 어절 정보와 POS feature를 보존한다. 전통적 CRF부터 사전학습 Transformer까지 다양한 모델에서 어절·음절 기반 형식보다 높은 결과를 보였으며, 자동 예측 UPOS도 소폭의 추가 이득을 제공했다. 논문의 핵심 기여는 새 NER architecture보다 한국어의 언어적 구조에 맞는 데이터 표현과 양방향 변환 절차를 제시한 데 있다.

# 핵심 기여

1. 한국어 NER을 위한 형태소 기반 CoNLL-U annotation scheme을 구체화했다.
2. 어절·음절 기반 기존 말뭉치를 형태소 형식으로 변환하고 원래 평가 단위로 복원하는 알고리즘을 제공했다.
3. UPOS·XPOS feature와 다양한 model family를 비교해 표기 형식의 효과가 특정 architecture에 한정되지 않음을 보였다.
4. NAVER, MODU, KLUE, ETRI에서 형태소 형식의 성능 향상을 정량적으로 확인했다.

# 한계와 후속 질문

- 저자가 명시한 제약: 음절 형식과의 비교는 음절 전용 tokenizer를 사용하지 않았으므로 표기 단위만의 공정한 비교라고 단정하기 어렵다.
- 저자가 명시한 제약: NAVER 공식 test set이 공개되지 않아 원래 학습 데이터를 다시 분할했다.
- 해석상 제약: 자동 형태소 분석과 POS 예측 오류가 변환 및 NER 오류로 전파될 수 있다.
- 해석상 제약: 주 실험이 뉴스 중심 말뭉치에 치우쳐 있어 구어체, 신조어, 도메인 특화 문서로의 일반화는 별도 검증이 필요하다.
- 후속 질문: 형태소 분석기와 NER을 joint model로 학습하면 pipeline error를 줄일 수 있는가?
- 후속 질문: character-aware 또는 syllable-aware tokenizer를 통제한 상태에서도 형태소 표기의 이득이 유지되는가?

