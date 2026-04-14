## 주요 정보
- 발표 연도: 2014년
- 저자: Ilya Sutskever 외
- tags: #seq2seq, #LSTM, #machine-translation , #encoder-decoder, #RNNs
---
# Abstract
[[Deep Neural Networks]]은 고정 차원의 입력과 출력을 전제로 하기 때문에 가변 길이 시퀀스 간 매핑 문제에 직접 적용할 수 없다.
이 논문은 그 한계를 극복하기 위해 두 개의 [[LSTM]]을 사용하는 end-to-end 시퀀스 학습 방법을 제안한다.
구조는 다음과 같다.
1. 입력 시퀀스를 하나의 LSTM으로 읽어 고정 차원 벡터로 압축 (encoder)
2. 해당 벡터를 초기 상태ㅗㄹ 삼아 다른 LSTM으로 출력 시퀀스를 생성 (decoder)
WMT-14 영어-프랑스어 번역 task에서 주요 결과는 다음과 같다.
- LSTM 자동 번역: [[BLEU Score]] 34.8 (구문 기반 SMT baseline의 33.3 초과)
- SMT 시스템의 1000-best 리스트를 LSTM으로 재순위화(rescoring): BLEU 36.5
주요 기술적 기여로, 소스 문장의 단어 순서를 역전시켜 입력하는 것이 성능을 크게 향상시켰다.
이는 소스와 타겟 시퀀스 사이의 단기 의존성(short-term dependency)을 늘려 [[Backpropagation]]이 더 쉽게 연결 관계를 학습하도록 만들기 때문이다.

# Introduction
## 기존 DNN의 한계
DNN은 음성 인식, 객체 인식 등에서 뛰어난 성능을 보이지만, 한 가지 전제가 있다: 입출력이 고정 차원 벡터로 표현 가능해야 한다.
따라서, 기계번역, 질의응답처럼 길이가 가변적인 시퀀스 문제에는 직접 적용할 수 없다.

## 왜 기본 RNN으로는 부족할까?
[[Recurrent Neural Networks]]은 시퀀스를 처리할 수 있지만, 입출력 길이가 다르고 관계가 비단조적(non-monotonic)인 경우는 적용하기 어렵다. 하나의 RNN으로 입력을 압축하고 다른 RNN으로 출력을 생성하는 구조를 생각해볼 수 있겠으나, 일반 RNN은 [[Vanishing Gradient]] 문제로 장거리 의존성 학습이 사실상 불가능하다.

## 제안하는 구조
[[LSTM]]은 장거리 의존성에 강해 이 문제를 해결할 수 있다. 본 논문의 구조는 두 가지다.
1. Encoder LSTM: 입력 시퀀스를 읽어 고정 차원 벡터 $v$를 생성
2. Decoder LSTM: $v$를 초기 hidden state로 삼아 출력 시퀀스 생성

## 핵심 기술적 발견: Reverse trick
소스 문장의 단어 순서를 역전시키면 성능이 크게 향상된다.
- 역전 전: 소스 앞부분 단어 - 타겟 앞부분 단어 사이의 시간 거리가 멀다.
- 역전 후: 두 시퀀스의 앞부분이 시간적으로 가까워져 최소 시간 지연(minimal time lag) 감소
결과적으로 [[Backpropagation]]이 소스-타겟 간 연결 관계를 훨씬 쉽게 학습한다.

# Related Work
- Kalchbrenner & Blunsom (2013): CNN으로 입력 문장 -> 벡터 형태로 최초로 압축. CNN 특성상 단어 순서 정보가 손실된다.
- Cho et al. (2014): LSTM과 유사한 구조로 문장을 벡터로, 벡터를 다시 문장으로 변환. SMT 보조 용도에 집중했음
- Banhdanau et al. (2014): Attention 매커니즙 도입으로 긴 문장 문제 대응
- Pouget-Abadie et al. (2014): 소스 문장을 구간 분할해 번역.

## 본 논문의 위치
위 연구들과 달리 순수 신경망으로 SMT baseline을 직접 초과한 첫 번째 사례. SMT 보조 도구가 아닌 독립적인 번역 시스템으로서의 가능성을 처음 입증했다는 점이 핵심.

# Method
## 기본 RNN의 한계
표준 [[Recurrent Neural Networks]]은 입출력 정렬이 알려진 경우에만 시퀀스를 처리할 수 있다. 입출력 길이가 다르고 관계가 복잡한 경우, 하나의 RNN으로 입력을 압축하고 다른 RNN으로 출력을 생성하는 구조를 생각해볼 수 있겠으나 [[Vanishing Gradient]] 문제로 학습이 어렵다.

## LSTM 기반 Seq2Seq 구조
본 논문의 목표는 조건부확률 $p=(y_1, \cdots, y_{T'} | x_1, \cdots, x_T)$를 추정하는 것이다. 입력과 출력의 길이 $T$와 $T'$는 서로 다를 수 있다.
$$p(y_1, \cdots, y_{T'} | x_1, \cdots, x_T) = \displaystyle \prod_{t=1}^{T'}p(y_t | v, y_1, \cdots, y_{t-1})$$
- $v$: Encoder LSTM의 마지막 hidden state. 입력 시퀀스 전체를 압축한 고정 차원 벡터
- 각 $p(y_t | v, y_1, \cdots, y_{t-1})$: 어휘 전체에 대한 [[Softmax]]로 표현
- 모든 문장은 특수 토큰 `<EOS>`로 끝나며, 이로 인해 가변 길이 출력이 가능하다.

## 실제 구현의 세 가지 선택
이론적 구조에서 실제 모델로 가면서 세 가지 중요한 결정이 있었다.
1. Encoder와 Decoder를 별도 LSTM으로 분리: 파라미터를 늘리는 효과가 있으며, 여러 언어 쌍을 동시에 학습하는 데 자연스럽게 확장 가능
2. 깊은 LSTM 사용 (4 layers): 깊은 LSTM이 얕은 LSTM을 크게 능가함을 확인했다. 레이어 추가마다 perplexity가 약 10% 감소했다.
3. 소스 문장 단어 순서 역전
	- $a, b, c \rightarrow \alpha, \beta, \gamma$ 대신 $c, b, a \rightarrow \alpha, \beta, \gamma$ 로 학습
	- $a$와 $\alpha$, $b$와 $\beta$가 시간적으로 가까워져 [[Backpropagation]]이 소스-타겟 연결 관계를 더 쉽게 학습한다.
	- text perplexity: 5.8 -> 4.7, BLEU: 25.9 -> 30.6

# Experiments
## 데이터셋
- WMT'14 영어-프랑스어 번역 task
- 학습 데이터: 1200만 문장 (영어 3억 400만 단어, 프랑스어 3억 4800만 단어)
- 어휘 크기: 소스(영어) 160,000 / 타겟(프랑스어) 80,000
- 어휘 외 단어는 모두 `UNK` 토큰으로 대체

## 학습 설정
- 4 Layer LSTM, 각 레이어 1000 cells, 1000차원 word embedding
- 파라미터 총 3억 8000만개 (recurrent conneciton 6400만개)
- batch size 128, learning rate 0.7 고정 -> 5 epoch 이후 매 0.5 epoch마다 절반으로 감소.
- [[Gradient Clipping]]: $||g||_2 > 5$이면 $g \leftarrow \dfrac{5}{||g||_2}g$
- 8-GPU 병렬화: 레이어 4개를 GPU 4개에 분산, 나머지 4개로 Softmax 병렬화 -> 초당 6300단어

## 디코딩 방식
번역 생성 시 [[Beam Search]]를 사용한다.
$$\hat T = \arg \max_T p(T|S)$$
- 매 time step마다 beam 내 각 후보를 어휘 전체로 확장 후 상위 $B$개만 유지
- `<EOS>` 생성 시 해당 후보를 완성된 번역으로 확정
- Beam size 1 (Greedy)도 준수한 성능이었고, beam size=2에서 이미 대부분의 이득을 확보했다.

## 실험 결과
직접 번역:

| 모델                                 | BLEU  |
| ---------------------------------- | ----- |
| SMT baseline                       | 33.30 |
| Single forward LSTM, beam 12       | 26.17 |
| Single reversed LSTM, beam 12      | 30.59 |
| Ensemble 5 reversed LSTMs, beam 1  | 33.00 |
| Ensemble 5 reversed LSTMs, beam 2  | 34.50 |
| Ensemble 5 reversed LSTMs, beam 12 | 34.81 |

SMT 1000-best 재순위화 (rescoring)

| 모델                                  | BLEU  |
| ----------------------------------- | ----- |
| SMT baseline                        | 33.30 |
| Single forward LSTM rescoring       | 35.61 |
| Single reversed LSTM rescoring      | 35.85 |
| Ensemble 5 reversed LSTMs rescoring | 36.5  |
| SOTA                                | 37.0  |

## 긴 문장에서의 성능
일반적으로 RNN 계열 모델은 긴 문장에서 성능이 급격하게 저하된다고 알려져 있었다. 그러나 reverse trick을 적용한 LSTM은 35단어 이하 문장에서 성능 저하가 없었으며 그 이상의 긴 문장에서도 경미한 수준이었다. 이는 소스 역전으로 인한 메모리 활용 개선의 결과로 해석할 수 있다.

## 문장 표현 분석
학습된 LSTM의 hidden state를 [[Principal Component Analysis]]로 2차원 투영하면, 의미가 유사한 문장들이 가깝게 클러스터링된다.
- 단어 순서에 민감: "John respects Mary"와 "Mary respects John"이 다른 위치에 표현된다.
- 능/수동 변환에 둔감: "I gave her a card"와 "She was given a card by me"가 유사한 위치에 표현된다.

# Conclusion
## 순수 신경망으로 SMT를 능가할 수 있다
제한된 어휘를 가진 LSTM이 무제한 어휘의 구문 기반 SMT 시스템을 직접 번역에서 처음으로 초과했다. 상대적으로 최적화되지 않은 구조임에도 이 결과가 나왔다는 점에서 추가 개선의 여지도 크다.

## Reverse Trick의 효과
단어 순서 전환이라는 단순한 전처리 트릭이 성능에 결정적인 영향을 미쳤다. **Short-term dependency**를 최대화하는 인코딩을 찾는 것이 매우 중요하다.

## 긴 문장 처리 능력
LSTM이 긴 문장을 처리하지 못할 것이라는 초기 예상과 달리, Reverse trick으로 학습 시 긴 문장에서도 성능 저하가 적었다.