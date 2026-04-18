# 정의
[[Attention]] 메커니즘만으로 시퀀스를 처리하는 신경망 아키텍처. RNN이나 CNN 없이 [[Self-Attention]]과 Feed-Forward Network의 반복 적층으로 Encoder와 Decoder를 구성한다.
- [[Attention is All You Need]]에서 제안됨
- 시퀀스 내 모든 토큰 쌍의 관계를 단일 연산으로 병렬 처리할 수 있다.
- 이후 NLP 전반의 사실상 표준 아키텍처로 자리잡음.

# 구조
## Encoder
각 Encoder 레이어는 두 개의 서브레이어로 구성된다.
1. Multi-Head Self-Attention: 소스 시퀀스 내 토큰 사이의 관계를 모델링한다.
2. Position-wise Feed-Forward Network: 각 토큰 위치에 독립적으로 적용되는 2층 MLP
- 각 서브레이어에 [[Residual Connection]], [[Layer Normalization]]을 적용한다.
- 기본 구성: 6개 레이어 층

## Decoder
각 Decoder 레이어는 세 개의 서브레이어로 구성된다.
1. Masked Multi-Head Self-Attention: 타깃 시퀀스 내 관계 모델링. 미래 토큰 참조를 방지한다.
2. Cross-Attention: Decoder 상태와 Encoder 출력 사이의 Attention. ([[Encoder-Decoder]] Attention)
3. Position-wise Feed-Forward Network.
- 동일하게 Residual Connection, Layer Normalization을 적용한다.

## Positional Encoding
RNN과 달리 순서 정보가 구조에 내재되어 있지 않기 때문에 [[Positonal Encoding]]을 입력 임베딩에 더해 위치 정보를 주입한다.
$$PE_{(pos, 2i)} = \sin \left(\dfrac{pos}{10000^{2i/d_{\mathrm{model}}}} \right), \ \ \ \ \ PE_{(pos, 2i)} = \cos \left(\dfrac{pos}{10000^{2i/d_{\mathrm{model}}}} \right)$$

# 이후 발전
- Encoder-only: [[BERT]] - Masked Language Modeling으로 사전 학습되었다. 분류/NER 등에 적용된다.
- Decoder-only: [[GPT]] 계열 - 언어 모델링으로 사전 학습되었다. 텍스트 생성에 특화되어 있다.
- Encoder-Decoder: T1, BART - 원래 구조를 유지하며, 번역/요약 등 seq2seq task에 사용된다.

# 관련 개념
- [[Multi-Head Attention]]
- [[Scaled Dot-Product Attention]]
- [[Positonal Encoding]]
- [[Layer Normalization]]
- [[Encoder-Decoder]]
- [[Attention]]

# 대표 변형 / 관련 기법
- [[BERT: Pre-training of Deep Bidirectional Transformers for Language Understanding]] (2018)
- GPT (2018~)
- T5 (2019)
- Vision Transformer (ViT): 이미지 패치를 토큰으로 취급해 Transformer 적용
- Sparse Transformer: $O(n^2)$ Attention 복잡도를 줄이기 위한 변형
- Flash Attention: IO-aware 구현으로 Attention 연산 속도 및 메모리 효율 개선