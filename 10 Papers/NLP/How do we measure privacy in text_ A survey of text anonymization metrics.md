---
type: paper
title: "How do we measure privacy in text? A survey of text anonymization metrics"
authors:
  - "Yaxuan Ren"
  - "Krithika Ramesh"
  - "Yaxing Yao"
  - "Anjalie Field"
year: 2025
venue: "Findings of IJCNLP-AACL 2025"
url: "https://aclanthology.org/2025.findings-ijcnlp.94/"
pdf: "[[40 Sources/Papers/NLP/How do we measure privacy in text_ A survey of text anonymization metrics.pdf]]"
status: read
read_date: "2026-08-22"
tags:
  - domain/nlp
  - task/text-rewriting
  - theme/privacy-preservation
  - theme/evaluation
aliases: []
---

# Abstract

이 논문은 텍스트 익명화 기법의 성능보다, **익명화된 텍스트의 프라이버시를 어떻게 평가해야 하는지**를 다룬 체계적 문헌 검토다. 저자들은 2019년 이후 영어 텍스트를 대상으로 한 47편을 검토하여, 기존 지표가 사실상 여섯 가지 서로 다른 프라이버시 목표를 측정한다는 점을 보인다. 그 목표는 식별자 제거 효과, 데이터셋 membership, 속성 추론 위험, 원문 복원 공격, 의미 추론 위험, 이론적 프라이버시 상한이다.

핵심 결론은 단일 점수만으로 프라이버시를 판단할 수 없다는 것이다. 이름과 주소를 잘 가렸다는 span-level F1은 간접 단서에 따른 재식별, 속성 추론, 원문 복원, 학습 데이터 membership 누출까지 막았다는 뜻이 아니다. 저자들은 각 지표의 측정 범위와 한계, [[Differential Privacy]]의 형식적 보장이 실증 공격 평가를 대신할 수 없는 이유, HIPAA·GDPR 및 사용자 기대와의 간극을 함께 분석한다.

# 1 Introduction

텍스트 익명화는 redaction(식별자 가림), rewriting(재작성), 합성 텍스트 생성으로 임상 기록·법률 문서·소셜 미디어처럼 민감한 자료를 연구와 모델 개발에 활용할 수 있게 하는 기반 기술이다. 그러나 차원이 높은 데이터는 여러 단서만 결합해도 재식별될 수 있고, 형식적 보장을 갖춘 기법도 실제 익명 해제 공격에 취약할 수 있다. LLM의 학습 데이터 암기와 민감 속성 추론 능력은 이 문제를 더 크게 만든다.

저자들이 문제로 삼는 것은 평가 방식의 불일치다. 직접 식별자를 가리는 연구와 합성 텍스트를 만드는 연구는 서로 다른 프라이버시 개념을 전제하며, 같은 목표를 다루는 연구끼리도 지표가 다르다. 그 지표들이 실제 법의 익명화 기준이나 사람이 기대하는 프라이버시와 어떻게 연결되는지도 대체로 불분명하다.

이 논문은 다음 작업을 수행한다.

1. 익명화된 텍스트 출력에 남은 민감 정보의 노출을 측정한 47편을 수집하고, 정량 지표를 여섯 가지 프라이버시 목표로 분류한다.
2. 각 목표에 쓰인 지표군, 적용 방식, 공격자 가정, 장단점을 비교한다.
3. 이 분류를 HIPAA, GDPR, 사람 중심 프라이버시와 Contextual Integrity, 모델 프라이버시 연구에 연결하여 현재 평가의 공백을 짚고, 지표 선택과 표준화를 위한 권고를 제시한다.

# 2 Existing privacy metrics in NLP

## 2.1 Scope and Methodology

이 조사의 대상은 **익명화 뒤의 텍스트 출력물**에 민감 정보가 얼마나 남는지를 직접 평가하는 지표다. 따라서 원문과 익명화본이 함께 있는 redaction·rewriting·합성 텍스트 생성 설정이 중심이다. 내부 embedding만 보호하고 텍스트 출력을 평가하지 않는 연구는 직접 대상이 아니지만, 그 결과는 모델 프라이버시 논의와 맞닿아 있다.

포함 기준은 모두 충족해야 했다.

- 자연어 텍스트를 다룰 것. 이미지·표 형태 데이터·음성은 제외했다.
- 익명화하거나 보호한 텍스트 출력이 있을 것. 내부 표현만 다룬 경우는 제외했다.
- 유용성, 유창성, 가독성을 넘어 적어도 하나의 정량 프라이버시 지표를 보고할 것.
- 주로 영어 데이터를 사용할 것. 저자들은 비영어 전용 데이터는 주석 체계와 접근성이 다르므로 제외했다.
- 2019년 1월 이후에 나온 동료 심사 논문 또는 공개 preprint일 것.

ACL Anthology와 Google Scholar에서 `text anonymization`, `text sanitization`, `synthetic text generation` 조합을 검색하고, 인용문헌을 거슬러 올라가며 추가 자료를 찾았다. 예를 들어 `text anonymization` 검색은 ACL Anthology에서 1,500편 이상, Google Scholar에서 16,000편 이상을 반환했지만, 대부분은 프라이버시 평가와 직접 관련이 없었다. 저자들은 이를 수동으로 선별해 최종 47편을 남겼다. 논문별 프라이버시 목표와 지표의 대응표는 별도 GitHub spreadsheet로 제공한다.

## 2.2 Survey of Evaluation Metrics

Figure 1은 여섯 가지 프라이버시 목표를 다음 질문으로 대비한다.

| 프라이버시 목표 | 핵심 질문 | 그림의 예시 |
|---|---|---|
| Identifier removal effectiveness | 이름·주소 등 식별자를 제대로 가렸는가 | `John Smith`, `123 Main St.`를 `[NAME]`, `[ADDRESS]`로 치환 |
| Dataset membership | 특정 record가 학습 집합에 있었음을 공격자가 알 수 있는가 | 주입한 canary `Xjqwz Qubit`을 모델이 다시 생성 |
| Attribute inference risk | 성별 같은 민감 속성을 여전히 맞힐 수 있는가 | 익명화된 review로 분류기가 여성이라고 예측 |
| Reconstruction attacks | 익명화본에서 원문을 다시 복원할 수 있는가 | 가려진 ER 방문문에서 원래 이름을 맞힘 |
| Semantic inference risk | 명시적 식별자 없이도 민감한 사건·의미가 전달되는가 | Stage IV lung cancer를 가린 뒤 aggressive chemotherapy가 남음 |
| Theoretical privacy bounds | 형식적 보장 아래에서 최악의 누출 상한은 무엇인가 | 프라이버시 예산 $\epsilon = 2.0$, $\delta = 10^{-5}$ |

Table 1에서 집계한 각 목표의 보고 논문 수는 식별자 제거 18편, 데이터셋 membership 8편, 속성 추론 9편, 원문 복원 16편, 의미 추론 8편, 이론적 상한 16편이다. 한 논문이 여러 목표의 지표를 함께 보고할 수 있으므로 합계는 47보다 크다. 다만 §3.1에서는 식별자 제거 지표가 15편에 쓰였다고도 적혀 있다. 본문과 표의 집계 차이에 관해 저자들은 별도 설명을 하지 않는다.

### 2.2.1 Identifier Removal Effectiveness

이 목표는 이름, 주소, 연락처처럼 개인을 직접 가리키는 식별자가 익명화본에 남았는지를 묻는다. 가장 흔한 평가는 gold annotation과 탐지·가림 결과를 비교하는 token-level 또는 span-level precision, recall, F1이다.

$$
F_1 = \frac{2PR}{P+R}
$$


- false negative는 가려야 할 식별자를 남긴 경우이고, false positive는 비민감 정보를 지나치게 가린 경우다. F1은 이 두 오류를 함께 반영한다.
- entity-level recall은 하나의 식별자가 문서나 말뭉치 전체에 걸쳐 등장할 때, 모든 mention을 가려야 성공으로 본다. 개별 span의 부분 성공보다 일관된 보호에 더 엄격하다.
- 일부 지표는 이름처럼 단독으로 개인을 특정하는 식별자와, 나이·ZIP code처럼 다른 정보와 결합될 때 특정성이 생기는 quasi-identifier를 구분한다.
- IOB-Exact와 IOB-Partial 같은 tagging scheme은 예측 span의 경계가 gold span과 정확히 맞지 않는 부분 가림과 경계 불일치를 평가한다.
- 문자열이 달라도 충분히 보호될 수 있으므로 approximate match도 쓴다. 예를 들어 `John Smith`를 `Jonathan`으로 바꾸거나 paraphrase한 경우를 edit distance 기반 Levenshtein Recall, token-level lexical divergence로 점수화한다.
- 더 높은 의미 수준에서는 PRIVACY_NLI가 textual entailment 모델로 익명화 문장이 원래의 개인 정보를 여전히 함의하는지 검사하고, SPRIVACY는 사람이 개인 정보가 남았다고 판단하는지를 묻는다.

span F1은 여전히 표준 지표이지만, 재작성처럼 표면을 바꾸는 방법에서는 semantic 또는 corpus-level 지표가 남은 위험을 더 잘 포착할 수 있다. 이름을 빠짐없이 가렸다고 해서 다른 문맥 단서로 개인을 추론할 수 없다는 보장은 없다.

### 2.2.2 Dataset Membership

Dataset membership은 특정 record가 익명화 출력을 만들거나 모델을 학습한 데이터에 포함됐는지를 공격자가 알아낼 수 있는지를 평가한다. 전체 환자 기록처럼 record의 단위가 명확하다면 membership을 숨기는 것만으로도 폭넓은 보호를 줄 수 있다. 이 목표는 모델 프라이버시와 특히 가깝고, 입력 record를 그대로 쓰는 redaction 방식은 대개 이 검사를 통과하기 어렵다. 그래서 합성 텍스트 생성 평가에서 가장 흔하다.


- shadow model 또는 reference model을 활용한 membership inference attack(MIA)의 accuracy, F1, AUC가 표준 지표다. AUC는 member와 non-member를 구별하는 ROC 면적이다.
- 보호한 embedding에 confidence threshold 또는 entropy threshold 공격을 적용하고, 성공률을 누출 지표로 보기도 한다.
- MIA 결과는 공격 설계, 데이터셋 구성, reference data의 성격에 크게 좌우된다. 따라서 한 공격의 낮은 성공률만으로 일반적인 membership 안전성을 주장해서는 안 된다.
- 합성 텍스트 생성에는 canary injection experiment도 쓰인다. 학습 데이터에 고유한 문구를 넣은 뒤 누출률과 canary의 perplexity 순위를 본다. perplexity가 낮으면 그 문구가 학습 데이터에 포함됐을 가능성을 시사한다.
- DP 보장을 주장하는 생성 연구는 보통 $(\epsilon,\delta)$ 예산과 MIA·canary 같은 실증 누출 결과를 함께 제시해, 이론적 보호가 실제 견고성으로 이어지는지를 점검한다.

Table 1의 대표 사례는 Arnold et al. (2023)의 합성 텍스트 생성 연구로, IMDb에서 MIA AUC를 보고한다. 이 목표를 보고한 조사 대상 논문은 8편이다.

### 2.2.3 Attribute Inference Risk

Attribute inference는 정제한 텍스트만 보고 성별, 나이, 진단 등 민감 속성을 우연보다 잘 맞힐 수 있는지를 본다. 식별자를 제거한 뒤에도 문체, 주제, 관계, 행동 묘사가 속성 신호로 남는 문제를 겨냥한다.


- 재작성 기반 연구와 합성 텍스트 생성 연구에서 자주 쓴다.
- 많은 공격은 텍스트 작성자의 속성을 노린다. 예로 Trustpilot review의 성별·나이, tweet의 정치 성향, blog post의 문체 단서가 있다.
- 텍스트에 언급된 사람의 속성을 겨냥하는 연구도 있다. DP-RVAE나 PromptEHR가 만든 synthetic EHR에서 환자의 성별·동반 질환을 추론하는 경우가 이에 해당한다.
- 흔한 protocol은 원문과 익명화본에서 분류기를 학습·평가하고, 보호할 속성의 accuracy 또는 F1 변화를 비교하는 것이다. 점수 하락을 프라이버시 향상으로 해석한다.
- DP-MLM 재작성은 고정된 공격자와 익명화 출력에 맞춰 재학습한 adaptive attacker 각각에 대해 PrivacyF1을 보고한다. 여러 속성을 다룰 때는 keyword-inference accuracy, Gender-F1, Age-F1 등을 함께 쓴다.
- 더 강한 sequential attack은 synthetic clinical trial record를 실제 환자에게 먼저 연결한 뒤 tumor grade 같은 민감 속성을 예측한다. 이는 단순 분류보다 복합적인 누출을 모사한다.

속성 분류 정확도 하락은 식별자 가림만으로는 보이지 않는 잔여 누출을 드러내는 유용한 신호다. 다만 몇 가지 속성에서 공격이 실패했다고 해서 원문 복원이나 membership disclosure까지 막았다는 뜻은 아니다. Table 1의 대표 사례는 Wang and Sun (2022)의 PromptEHR/MIMIC-III이며, 성공률은 익명화한 sample에서 민감 속성을 올바르게 예측한 비율이다. 이 목표를 보고한 논문은 9편이다.

### 2.2.4 Reconstruction Attacks

Reconstruction attack은 익명화 뒤에도 원문 문서의 verbatim 또는 near-verbatim 부분을 되살릴 수 있는지를 묻는다. 이름이 없더라도 희귀한 문구, 주제의 조합, 일관된 문체가 원문·저자·문서 속 인물로 이어지는 단서가 될 수 있다.


- document-level retrieval은 BM25, Jaccard, ensemble linking으로 익명화본의 원문을 candidate pool에서 찾아오는 비율을 센다. 이는 문구와 주제에 남은 고유성을 드러낸다.
- 임상 분야에서는 사람이 재작성한 note를 실제 환자에게 다시 연결할 수 있는지를 수동으로 조사하기도 한다.
- 더 자동화된 방식으로는 token별 최악의 누출률에 상한을 두거나, BERT 같은 모델이 가려진 token을 맞히는 난도를 재는 방법이 있다.
- span surprisal, plausible-deniability set size, ROUGE overlap, rare-token count도 고유하거나 암기된 내용이 남았는지를 보여 주는 신호다.

이 목표에서는 먼저 무엇을 보호하는지를 정해야 한다. 문서 전체를 찾아내는 일이 위험한지, 민감한 일부 문구를 복원하는 일이 위험한지, 텍스트 작성자를 보호하는지 또는 문서에 등장하는 사람을 보호하는지에 따라 적절한 공격과 지표가 달라진다. Table 1의 대표 지표는 Pilán et al. (2024)의 Text Re-Identification Risk(TRIR)로, 원문을 올바르게 찾아낸 익명화본의 비율을 센다. INTact method와 Text Anonymization Benchmark(TAB)를 예로 들며, 이 목표를 보고한 논문은 16편이다.

### 2.2.5 Semantic Inference Risk

Reconstruction이 원문의 표면과 문구 복원에 초점을 둔다면, semantic inference risk는 익명화본이 원래의 민감한 의미를 계속 전달하는지를 묻는다. 특정 속성의 정답을 맞히게 하는 attribute inference와 달리, 주제·관계·서사 구조를 포함한 원문과 익명화본의 유사성 자체를 주로 평가한다. 즉 공격자가 어떤 개인 속성을 예측하도록 미리 정하지 않아도, 텍스트가 민감한 사건을 알아낼 만큼의 의미를 남기면 위험 신호로 본다.


- SBERT cosine similarity는 원문과 익명화본의 semantic alignment를 재는 대표적인 embedding-based 지표다.
- Xin et al. (2025)은 superficial rewording을 걸러내는 lexical divergence score와, language model prompt로 factual consistency를 심사하는 semantic alignment score를 제안했다. 특히 임상 텍스트에서 표면을 바꾼 뒤에도 깊은 의미가 남는 경우를 겨냥한다.
- dense encoder를 쓸 수 없으면 corpus-level BLEU를 프라이버시 지표로 재해석할 수 있다. $n$-gram overlap이 클수록 원문의 표현과 잠재적 누출이 많이 남았다는 뜻이다.
- Perturbation Percentage(PP)는 익명화 과정에서 바뀐 token의 비율이다. 저자들이 인용한 연구에서는 낮은 PP가 작성자 속성 추론의 성공과 자주 함께 나타났다.

이 목표는 유용성 보존과 프라이버시가 충돌한다는 사실을 선명하게 보여 준다. downstream utility가 중요하면 비교적 높은 유사성을 허용할 수 있지만, 임상 기록처럼 민감도가 높은 분야에서는 사소한 의미 유사성도 큰 위험일 수 있다. Table 1은 Igamberdiev and Habernal (2023)의 ADePT/ATIS에서 BLEU를 대표 지표로 든다. 이 목표를 보고한 논문은 8편이다.

### 2.2.6 Theoretical Privacy Bounds

앞의 다섯 범주는 실증 측정인 반면, differential privacy 기반 기법은 허용되는 최악의 프라이버시 누출에 수학적 상한을 둔다. 보통 $(\epsilon,\delta)$-DP 예산을 보고하며, $\epsilon$이 작을수록 더 강한 보호를 뜻한다. Table 1의 단순화된 표기는 다음과 같다.

$$
\Pr[M(D)] \leq e^{\epsilon}\Pr[M(D')]
$$

여기서 $D$와 $D'$는 record 하나만 다른 인접 데이터셋이고, $M$은 무작위 mechanism이다. 엄밀한 $(\epsilon,\delta)$ 정의에서는 우변에 $\delta$ 항이 추가된다. 이 논문은 representation 또는 gradient에 calibrated noise를 넣어 membership inference risk를 낮추는 방법을 설명하며, 합성 텍스트 생성과 재작성에서 SANTEXT, DP-BART, DP-MLM, DP-RVAE 등이 여러 $\epsilon$ 값에서 결과를 보고한다고 정리한다.

전체 예산 외에 token-level 동작을 보는 지표도 있다.

- self-substitution rate $N_w$: token $w$가 mechanism을 거친 뒤에도 그대로 남을 확률.
- support size $S_w$: token $w$에 대해 mechanism이 낼 수 있는 서로 다른 output의 수.

token이 덜 원형으로 남고($N_w$가 낮고), 가능한 치환 후보가 많을수록($S_w$가 크고) 치환 결과의 entropy가 커져 공격자의 원문 추론 불확실성도 커진다.

다만 형식적 상한이 실증 검사를 대신할 수는 없다. 보장은 구현이 정확하고 필요한 데이터 가정이 충족될 때만 성립한다. $\epsilon=4$가 $\epsilon=8$보다 강한 보호라는 순서는 알 수 있어도, 이 수치가 실제 누출이나 사람에게 미치는 피해를 무엇을 뜻하는지는 직관적이지 않다. 그래서 저자들은 원문 복원 또는 membership 공격 결과를 DP 파라미터와 함께 보고하는 관행을 중요하게 본다. Table 1의 대표 사례는 Chen et al. (2023)의 CusText/SST-2이며, 이 목표를 보고한 논문은 16편이다.

# 3 Are current metrics sufficient to meet legal standards?

저자들은 기술 지표가 익명화의 법적 정의를 자동으로 충족하지는 않는다고 본다. 여기의 HIPAA·GDPR 논의는 법률 자문이 아니라, 현재 지표가 법이 요구하는 식별 가능성과 위험의 개념에 어느 정도 대응하는지를 살피는 해석적 비교다.

## 3.1 HIPAA: Emphasis on Identifier Removal and Expert Judgment

HIPAA Privacy Rule에는 두 가지 de-identification path가 있다.

1. **Safe Harbor**: 열거된 18개 식별자를 제거한다.
2. **Expert Determination**: 예상되는 사용 맥락을 고려할 때 재식별 위험이 매우 작다는 사실을 통계 expert가 판단·증명한다.

식별자 제거 지표는 Safe Harbor와 가장 직접적으로 맞닿아 있다. 이름·연락처를 찾아 가리는 precision·recall은 이 요건을 바로 점검할 수 있기 때문이다. 그러나 저자들은 현재 평가 데이터셋이 HIPAA 기준으로 annotation된 경우는 드물다고 지적한다. 일반적인 named entity type annotation은 HIPAA의 geographic information, date 같은 domain-specific 식별자와 quasi-identifier를 놓치기 쉽다. 문서 전체에서 모든 mention을 가려야 하는 entity-level recall은 span-level 지표보다 HIPAA compliance에 더 가깝지만, 이를 쓰는 평가는 많지 않다.

Expert Determination은 훨씬 폭넓은 잔여 위험 분석을 요구한다. attribute inference, reconstruction, semantic inference는 적대적 재식별을 모사할 수 있지만, 실제로 이런 분석을 하는 연구는 적고 공격 모델이 실제 expert와 얼마나 비슷한지도 거의 검증되지 않는다. 예외로 TILD framework의 motivated intruder test는 background knowledge를 가진 사람이 entity를 재식별할 수 있는지 본다. 결론적으로 현재 지표는 Safe Harbor의 일부를 잘 다루지만, 포괄적이고 공격자 관점을 반영한 Expert Determination에는 부족하다.

## 3.2 GDPR: Contextual Risk and Semantic Inference

GDPR의 기준은 공격자가 합리적으로 사용할 법한 수단으로 개인을 식별할 수 없게 만드는 것이다. 따라서 직접 식별자의 제거뿐 아니라 의미 단서, 보조 데이터, 과업별 추론까지 포함한 맥락적 식별 가능성이 핵심이 된다.


- reconstruction metric은 공격자의 행동을 직접 모사하므로 GDPR과 가장 가깝다. 하지만 대다수 연구는 고정된 한 공격자만 쓰고, 공격자의 지식 기반과 배경 가정을 바꾸지 않아 법적 근거로는 견고하지 않다.
- attribute inference metric도 민감 속성의 복원 가능성을 보므로 직접 관련된다. 그러나 여러 속성을 폭넓게 시험하는 평가는 드물다.
- semantic inference risk의 높은 유사성은 민감한 사건이나 속성이 남았음을 시사하지만, 실제 공격자가 개인정보를 추론할 수 있는지를 직접 재지는 않는다.

따라서 식별자 F1만으로 quasi-identifier와 재식별 위험을 포착할 수 없고, 원문 복원 공격 하나로 실제 위협을 대표할 수도 없으며, 의미 유사도 역시 법적 기준과 일대일로 대응하지 않는다. 저자들은 human-intruder study, 다양한 원문 복원 공격, 여러 속성 추론 probe를 폭넓게 도입해야 한다고 결론짓는다.

# 4 User-Centered Privacy and Contextual Integrity

기술 지표는 대개 식별자가 남았는지, 공격이 성공했는지에 집중한다. 그러나 사용자가 프라이버시를 받아들이는 방식은 그보다 넓다. HCI와 social computing 연구에 따르면 사용자의 기대는 정보의 맥락, 자신의 통제권, 익명화한 텍스트가 자연스럽고 납득되는지에 따라 달라진다.

Contextual Integrity 이론은 프라이버시를 추상적인 secrecy나 통제 자체가 아니라 **적절한 정보 흐름**의 문제로 본다. 누가 어떤 정보를 누구에게, 어떤 조건과 목적으로 전달하는지가 그 맥락의 규범에 맞는지가 중요하다. 저자들은 COVID-19 contact-tracing app과 vaccination certificate의 수용성이 recipient, use purpose, retention time에 대한 기대에 달려 있음을 예로 든다. 이는 이름을 지우거나 재식별 위험을 낮추는 일만으로는 포착되지 않는다.

인용한 721명 대상 사용자 연구는 differential privacy를 적용한 텍스트에서 사용자가 데이터의 민감도, 사용한 기법, 데이터 수집 이유를 모두 중요하게 본다고 보고했다. NLP 익명화 지표는 이런 관점을 아직 거의 반영하지 못했다. 반면 Rescriber는 사용자가 LLM에 보내는 메시지에서 그 순간 자신에게 적절하다고 느끼는 민감 부분을 직접 재작성하거나 숨기게 한다. CLEAR와 Contextual Privacy Policies 같은 도구는 위치, 앱의 동작, 수신자에 따라 데이터 처리를 조정한다.

현재 평가가 놓치는 질문은 다음과 같다.

- 이 결과 텍스트가 해당 데이터 공유 상황에서 적절한 정보 흐름을 유지하는가?
- 사용자가 정보 공개를 통제한다고 느끼는가?
- 지표가 사용자의 프라이버시 기대와 맞는가?

저자들은 지표마다 적절한 적용 맥락을 명시하고, 맥락 또는 사용자 선호를 평가의 입력 변수로 쓰는 맥락 민감형 평가를 연구 과제로 제시한다. 표준 benchmark에서 높은 점수를 얻어도 실제 신뢰나 프라이버시 수용성을 보장하지 않는다는 경고다.

# 5 Discussion

이 조사는 텍스트 자체의 익명화 평가를 주 대상으로 하지만, 텍스트로 학습된 모델의 프라이버시와 겹치는 부분이 많다. 모델 프라이버시는 학습된 모델이 민감한 학습 데이터를 암기·노출하거나, 그 데이터에 관한 추론을 허용하는지를 본다. 평가 대상은 다르지만 membership inference와 reconstruction attack은 두 연구 흐름에 공통된다.


- 합성 텍스트 프라이버시에서는 canary attack과 MIA success rate가 모델 프라이버시의 지표와 겹친다. 생성한 합성 텍스트의 누출을 평가할 때도 이런 공격을 사용한다.
- 모델 프라이버시 문헌의 black-box·white-box MIA는 few-shot과 in-context learning setting까지 확장되고 있다.
- LLM은 민감 속성을 추론하는 강력한 익명 해제 도구가 될 수 있다. 이는 위험인 동시에 reconstruction, attribute inference, semantic inference 평가에서 더 강한 실증 공격자로 활용할 기회이기도 하다.
- 모델 프라이버시에는 Contextual Integrity 관점의 평가, PII exposure·attribute inference를 표준 과업으로 묶은 PrivLM-Bench, 내부 access 없이 누출을 probe하는 ProPILE과 targeted black-box attack 같은 benchmark·도구가 있다.

저자들은 텍스트 익명화와 모델 프라이버시를 분리된 분야로 두지 말고, 공격자 simulation, 맥락 분석, 실제 프라이버시 우려에 근거한 평가 틀을 함께 발전시켜야 한다고 제안한다. paraphrase와 semantic proxy를 통한 정보 누출은 두 분야 모두의 핵심 난점이다.

# 6 Recommendations and Open Challenges

저자들은 조사 결과를 다음 다섯 가지 실행 권고로 정리한다.

1. **방법이 내세우는 프라이버시 목표에 지표를 맞출 것.** 재식별 위험을 줄이는 기법을 식별자 제거 F1만으로 평가해서는 안 된다. 의미 추론을 줄인다고 주장한다면 표면 유사도뿐 아니라 과업별 probe 또는 분류기 기반 평가가 필요하다. 의도한 사용 사례와 지표의 대응을 분명히 밝혀야 한다.
2. **비교 가능하고 사용 맥락에 근거한 평가를 설계할 것.** redaction은 식별자 제거, 합성 생성은 MIA로만 평가하는 현재 관행으로는 방법의 실용성을 비교하기 어렵다. 제안 기법에 유리한 test가 아니라 현실적인 상황과 예상 사용 사례에서 공통된 평가 절차를 적용해야 한다.
3. **사람 중심·맥락 인식 평가를 포함할 것.** web search나 domain knowledge를 쓰는 motivated intruder test, 맥락적 수용성 판단, scenario-based probing은 토큰 누출 점수가 놓치는 위험을 잡을 수 있다. 비용은 크지만 실제 프라이버시 우려에 더 충실한 신호다.
4. **기술 지표를 법적 기준과 연결할 것.** 토큰 수준의 성능이 privacy law나 사용자 기대의 충족을 뜻하지 않는다는 점을 전제로, 공격자 simulation, auxiliary-knowledge test, plausibility-based linkage metric을 포함해야 한다. 반대로 emerging threat에 뒤처진 policy를 개선하는 데 투명한 실증 지표가 근거가 될 수 있다.
5. **사람이 참여한 평가를 확장하고 구조화할 것.** manual re-identification·attribute inference study는 비용과 재현성 문제가 있으므로 annotation protocol, intruder-test guideline, automated heuristic과 targeted human review를 결합한 방식을 발전시키고, 보고 방식의 norm을 세워야 한다.

# 7 Conclusion

텍스트 익명화는 프라이버시 보존 NLP에 필수적이지만, 구현과 평가가 모두 어렵다. 이 조사는 현재 지표가 식별자 제거, membership, 속성 추론, 원문 복원, 의미 추론, 형식적 상한이라는 서로 다른 여섯 목표를 뒤섞어 쓰고 있음을 보인다. 따라서 어떤 방법을 무엇으로 측정했는지 밝히지 않으면 법적·사회적·실무적 프라이버시 보호를 주장하기 어렵다.

저자들은 프라이버시 목표와 지표를 명시적으로 맞추고, 적대적·맥락적 위험을 더 엄격하게 평가하며, 사람 중심 관점을 통합해야 한다고 주장한다. 더 강력한 생성 모델이 확산될수록 구조와 맥락을 함께 살피는 평가가 책임 있는 데이터 공유와 모델 배포의 전제가 된다는 것이다.

# Limitations

- 이 논문은 익명화 기법의 효과 자체가 아니라 **사후 프라이버시 평가 지표**만 조사한다.
- 모델 프라이버시는 조사와 연결되는 범위에서만 다루며, federated learning 등 다른 프라이버시 paradigm을 포괄적으로 검토하지 않는다.
- 적어도 하나의 정량 프라이버시 지표를 명시적으로 보고한 논문만 포함했으므로, 정량 평가를 채택한 연구 쪽으로 표본이 치우쳤을 수 있다.
- HIPAA·GDPR와 사회적 프라이버시 개념의 연결은 해석적 분석이며, 법률 자문이 아니다.

# 관련 문서

- [[프라이버시 보존 텍스트 재작성]]: 이 논문의 여섯 프라이버시 목표는 해당 연구 흐름의 기법을 비교할 때 사용할 평가 축이다.
- [[Differential Privacy]]: 이론적 프라이버시 상한의 정의와 텍스트 보호에서의 상충 관계를 보완한다.
- [[Perplexity]]: membership canary와 의미 누출 평가에서 쓰이는 보조 신호다.
- [[Large Language Model]]: 프라이버시 공격의 대상이면서 실증적 익명 해제 도구로도 쓰이는 모델 계열이다.
