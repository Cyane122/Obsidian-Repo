## 주요 정보
- 발표 연도: 2015년
- 저자: Dzmitry Bahdanau 외
- tags: #NLP, #attention, #neural-machine-translation, #seq2seq, #alignment, #machine-translation , #encoder-decoder
- ---
# Abstract
기존 [[Encoder-Decoder]] 계열 NMT 모델은 소스 문장 전체를 고정 길이 벡터(fixed-length vector) 하나로 압축한다. 이 병목이 특히 긴 문장에서 성능 저하를 유발한다.
따라서 이 논문에선 다음을 제안한다.
- 디코더가 각 타깃 단어를 생성할 때마다 소스 문장의 관련 위치를 자동으로 (soft-)탐색하는 메커니즘 도입
- 고정 길이 벡터 없이 소스 시퀀스 전체를 어노테이션 시퀀스로 유지하고 선택적으로 참조.
결과
- 영-프 번역에서 기존 Encoder-Decoder 대비 유의미한 성능 향상
- 당시 phrase-based 기계번역 시스템(Moses)과 필적하는 수준 달성
- Soft-alignment 시각화 결과, 언어학적으로 타당한 정렬 패턴 확인

# Introduction
## 기존 접근의 문제
- NMT 모델의 대부분이 [[Encoder-Decoder]] 계열.
- 소스 문장이 길수록 하나의 벡터에 정보를 욱여넣기 어려워진다.

## 제안 아키텍처
- 타깃 단어 $y_i$ 생성 시, 소스 시퀀스 전체를 고정 벡터로 압축하지 않고 어노테이션 시퀀스 $(h_1, \cdots, h_{T_x})$로 유지한다.
- Decoder가 매 step마다 어느 소스 위치에 집중할지 동적으로 결정한다.
- 이 탐색 과정은 hard segment가 아니라 (soft-) search. 미분 가능하므로 end-to-end 학습이 가능하다.

# Method
## 전체 구조 개요
- Encoder: [[bidirectional RNN]]. 각 소스 단어를 앞뒤 문맥을 모두 담은 Annotation 벡터로 변환한다.
- Decoder: 매 스텝마다 Annotation 시퀀스 전체를 참조해 문맥 벡터를 동적으로 계산한다.

## Decoder
조건부확률 재정의
- 기존 Encoder-Decoder: 모든 타깃 단어가 동일한 $c$에 의존한다.
- 제안 모델: 타깃 단어 $y_i$마다 별도의 맥락 벡터 $c_i$를 사용한다.
$$p(y_i | y_1, \cdots, y_{i-1}, {\bf x}) = g(y_{i-1}, s_i, c_i)$$
맥락 벡터 $c_i$ 계산
- Annotation 시퀀스의 가중합
	$$c_i = \displaystyle \sum_{j=1}^{T_x}\alpha_{ij}h_j$$
Alignment 모델 $a$
- $\alpha_{ij}$는 아래 에너지 점수 $e_{ij}$를 [[Softmax]]로 정규화해 얻는다.
$$\alpha_{ij} = \dfrac{\exp(e_{ij})}{\sum_{k=1}^{T_x}\exp(e_{ik})}, \ \ \ \ \ e_{ij} = a(s_{i-1}, h_j)$$
- $a$: 디코더 이전 hidden state $s_{i-1}$과 소스 Annotation $h_j$를 입력받는 feedforward 신경망
- 별도로 설계된 규칙이 아니며, 전체 모델과 jointly하게 학습된다.

## Encoder - bidirectional RNN
## 왜 bidirectional?
- 단방향 RNN은 $h_j$ 생성 시 $x_j$ 이전 문맥만 반영한다.
- Annotation이 앞뒤 문맥을 모두 담으려면 양방향 처리가 필요하다.

## 구조
- Forward RNN $\overrightarrow f: x_1 \rightarrow x_{T_x}$ 순서로 처리. $(\overrightarrow h_1, \cdots, \overrightarrow h_{T_x})$
- Backward RNN $\overleftarrow f: x_{T_x} \rightarrow x_1$ 순서로 처리. $(\overleftarrow h_1, \cdots, \overleftarrow h_{T_x})$
- 두 방향 hidden state를 concat하여 최종 Annotation 생성.
$$h_j = \begin {bmatrix} \overrightarrow h_j \\ \overleftarrow h_j \end{bmatrix}$$

# Experiments & Results
## 실험 설정
- Task: 영어 -> 프랑스어 번역 (ACL WMT'14 데이터셋)
- 학습 데이터: 348M 단어 (850M에서 데이터 선별)
- 어휘 크기: 각 언어 상위 30,000단어 - 미등록 단어는 `[UNK]` 처리.
- 평가 지표: [[BLEU Score]]

## 비교 모델

| 모델              | 설명                                     |
| --------------- | -------------------------------------- |
| RNNencdec-30/50 | 기존 RNN Encoder-Decoder. 최대 문장 길이 30/50 |
| RNNsearch-30/50 | 제안하는 모델. 최대 문장 길이 30/50                |
| RNNsearch-50*   | 개발셋 수렴까지 더 오래 학습한 버전                   |
| Moses           | 당시 SOTA였던 phrase-based SMT.            |

## 결과

| 모델            | All   | No UNK |
| ------------- | ----- | ------ |
| RNNencdec-30  | 13.93 | 24.19  |
| RNNsearch-30  | 21.50 | 31.44  |
| RNNencdec-50  | 17.82 | 26.71  |
| RNNsearch-50  | 26.75 | 34.16  |
| RNNsearch-50' | 28.45 | 36.15  |
| Moses         | 33.30 | 35.63  |
- RNNsearch가 모든 조건에서 RNNencdec를 압도했다.
- UNK 없는 문장만 평가하면 RNNsearch-50'이 Moses를 소폭 상회했다.
- RNNsearch-30이 RNNencdec-50보다 높음 - 모델 크기보다 구조가 중요함을 시사한다.

## 문장 길이별 성능
- RNNencdec: 문장이 길어질수록 BLEU 급락
- RNNsearch-50: 길이 50 이상에서도 성능 저하 없음
- 고정 길이 벡터 병목 가설을 실험적으로 검증

## 정성분석: Soft-Alignment
주요 관찰
- 영어-프랑스어 간 정렬이 대체로 단조적(monotonic): 대각선 패턴
- 형용사-명사 어순 차이 같은 비단조적 정렬도 올바르게 학습했다.
e.g. European Economic Area → zone économique européenne: 단어 순서 역전을 자연스럽게 처리
Soft-alignment의 강점
- the man → l' homme: "the"를 번역할 때 뒤따르는 "man"까지 함께 참조한다(관사 형태 결정).

# Conclusion
기존 방식의 한계 재확인: Encoder-Decoder의 고정 길이 벡터 압축 방식이 긴 문장에서 구조적 한계.
제안 모델 요약
- Decoder가 타깃 단어 생성마다 소스 Annotation 시퀀스를 동적으로 참조한다.
- Alignment 메커니즘을 별도 설계하지 않고 번역 목적함수로 jointly 학습
- 긴 문장에서도 성능 저하 없이 안정적인 번역 품질 유지
의의
- 단일 NMT 모델로 당시 SOTA에 필적하는 성능 달성
- NMT 연구가 제안된 지 얼마 되지 않은 시점에서 거둔 성과임을 강조
- Alignment가 번역 시스템의 부산물이 아닌 학습 가능한 구성 요소임을 입증