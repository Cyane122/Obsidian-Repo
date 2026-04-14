## 주요 정보
- 발표 연도: 2017년
- 저자: Ashish Vaswani 외
- tags: #NLP, #attention 
---
# Abstract
기존 sequence transduction 모델은 RNN 또는 CNN 기반 encoder-decoder 구조에 의존했다.
성능이 좋은 모델들은 [[Attention]]을 추가로 결합한다. 다만, 아직 보조적 역할에 그친다.
저자들은 [[Transformer]]라는 새로운 아키텍쳐를 제안한다.
- 오직 Attention Mechanism만 사용
- Recurrence(RNN) 제거
- Convolution 제거
즉, Sequence modeling을 할 때 기존의 시/공간적 구조를 완전히 버리고 [[Attention]] 하나로 전부 해결하는 구조.

# Introduction
## 기존 모델들의 접근
RNN 계열, 특히 LSTM, GRU는 sequence modeling 및 transduction 문제에서 사실상 표준으로 자리잡은 상황.
즉, 이후의 연구들은 이 구조를 기반으로 한 성능 향상에 중점을 둬왔다.

## Sequentiality
RNN의 핵심 구조는 각 시점 $t$에서의 hidden state다.
즉, 이전 상태인 $h_{t-1}$ + 현재 입력에 의존하는데, 이는 다음의 문제점을 불러온다.
1. 병렬화 불가능
	- 계산이 시간 순서에 종속된다.
	- 즉, $t$의 hidden state를 계산하려면 $t-1$의 hidden state가 필요하다.
	-> 훈련 병렬화 불가능, 시퀀스가 길어질수록 심해지는 병목
2. 배치 처리 제한
	- 메모리의 제약이 있어, 시퀀스가 길수록 batch size가 줄어든다.
	-> 전체 학습 효율이 저하된다.
3. 기존 개선 시도들의 한계
	- factorization tricks, conditional computation 등 일부 개선은 있었음
	- 하지만, 순차 계산이라는 그 구조 자체는 그대로 유지되었다.

## Attention
Attention은 이미 다양한 모델에서 핵심 요소로 사용되었다.
장점
- 거리와 무관하게 dependency modeling가능
- long-range dependency 해결
하지만, 대부분의 경우 attention은 RNN 위에 얹힌 보조 구조.

## Key Idea
Attention이 그렇게 좋으면, 그거만 써보면 어떨까?

## Transformer
- Recurrence 제거
- Convolution 제거
- Attention만으로 전체 구조 구성

### 장점
1. 병렬화가 가능하다.
	: 순차 의존성이 사라져, 모든 위치를 동시에 계산할 수 있다.
2. Global dependency를 직접 처리한다. => Attention이 모든 위치를 직접 연결한다.

# Background
## 연구 흐름
RNN의 순차성 병목 문제를 해결하기 위해, 다음과 같은 모델들이 제안되었다.
1. Extended Neural GPU
2. ByteNet
3. ConvS2S
공통점:
- RNN 대신 CNN 사용
- 모든 위치를 병렬적으로 처리 가능

## CNN 기반 접근의 한계
병렬화에는 성공했지만, 다음의 한계점은 명확했다.
1. 거리 기반 연산 비용 증가
	두 위치 사이의 정보를 연결하려면,
	- ConvS2S: 선형 증가 ($O(n)$)
	- ByteNet: 로그 증가($O(\log n)$)
	→ 즉, 멀리 떨어진 토큰 사이의 관계를 학습하기 위해선 더 많은 연산 단계가 필요하다.
2. 장거리 의존성 학습 어려움
	정보가 여러 레이어를 거쳐 전달되며, 경로(path length)가 길어진다.
	→ long-range dependency 학습이 어렵다.

## Transformer
핵심 아이디어: 모든 위치를 직접 연결하는 [[Self-Attention]] 사용
→ 결과:
- 두 위치 간 관계 계산: 항상 O(1) 단계
- 즉, 거리와 무관하게 바로 연결된다.

Trade-off:
- Attention은 여러 위치를 가중평균으로 결합 → effective resolution이 감소할 가능성이 있다.
- 해결 방법: [[Multi-Head Attention]]
	- 여러 representation subspace에서 동시에 attention 수행
	- 정보 손실 완화