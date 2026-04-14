# 정의
토큰 시퀀스에 확률 분포를 부여하는 모델. 주어진 문맥으로부터 다음 토큰을 예측하는 방식으로 학습되며, 레이블 없는 대규모 텍스트 데이터만으로 학습할 수 있다.

# 구조
길이 $N$의 시퀀스 $(t_1, t_2, \cdots, t_N)$에 대해 결합 확률을 조건부 확률의 곱으로 분해한다.
$$p(t_1, t_2, \cdots, t_N) = \displaystyle \prod_{k=1}^N p(t_k | t_1, \cdots, t_{k-1})$$
신경망 기반 언어 모델은 이 조건부 확률을 [[LSTM]], [[Transformer]] 등의 신경망으로 근사한다.

# 평가 지표
**Perplexity (PPL)**: 언어 모델의 성능을 측정하는 표준 지표. 모델이 테스트 시퀀스를 얼마나 잘 예측하는지를 나타내며, 낮을수록 좋다.
$$\mathrm{PPL} = \exp\left(-\dfrac{1}{N} \displaystyle \sum_{k=1}^N \log p(t_k | t_1, \cdots, t_{k-1})\right)$$

# 주요 유형
- Undirectional LM: 왼쪽 문맥만을 보고 다음 토큰을 예측한다. 가장 기본적인 형태.
- [[bidirectional Language Model]]: forward LM과 backward LM을 결합하여 양방향 문맥을 모델링한다.
- Masked Language Model (MLM): 입력의 일부 토큰을 마스킹하고 복원하는 방식으로 학습한다. [[BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding|BERT]]가 대표적이다.
- Casual Language Model: 단방향 언어 모델과 동일한 개념. autoregressive 생성 모델인 [[GPT]] 계열에서 주로 사용하는 명칭.

# 대표 변형 / 관련 기법
- N-gram LM: 고정 길이의 앞선 토큰들만 문맥으로 사용하는 통계적 언어 모델. 신경망 기반 모델의 전신이다.
- Neural LM: 신경망으로 조건부 확률을 모델링한다. N-gram의 데이터 희소성 문제를 완화했다.

# 관련 개념
- [[bidirectional Language Model]]
- [[Transformer]]
- [[BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding|BERT]]
- [[GPT]]

#language-model #generative-model