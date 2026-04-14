# 정의
Query와 Key의 유사도로 Value를 가중합하는 연산.

# 기본 구조
입력: Query (Q), Key (K), Value (V)
출력: Query마다, Value들의 가중합

# 일반적인 형태
$\mathrm{Attention}(Q, K, V) = f(Q, K)V$
- $f(Q, K)$: 유사도 계산 & 정규화 ([[Softmax]])