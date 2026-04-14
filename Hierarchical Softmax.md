# 정의
일반 [[Softmax]]의 $O(|V|)$ 계산 비용을 줄이기 위해, 어휘를 이진 트리 구조로 표현하고 루트에서 리프까지의 경로를 따라 확률을 계산하는 방식.

# 구조
- 어휘의 각 단어를 이진 트리의 리프 노드로 배치한다.
- 단어 $w$의 확률은 루트에서 해당 리프까지의 경로 상 각 내부 노드에서의 이진 분류 확률의 곱으로 계산된다.
$$P(w) = \displaystyle \prod _{j=1} ^{L(w)-1} \sigma \left(1[n(w, j+1) = \text{left child}]\cdot v_{n(w,j)}^⊤h\right)$$
- $L(w)$: 루트에서 $w$까지의 경로 길이
- $n(w, j)$: 경로 상 $j$번째 노드.

## Huffman Tree
[[Efficient Estimation of Word Representations in Vector Space]]에서는 단어 빈도 기반 Huffman tree를 사용.
- 빈출 단어에 짧은 코드(경로) 부여 → 평균 경로 길이 최소화
- 시간 복잡도:
	- 균형 이진 트리: $O(\log_2 |V|)$
	- Huffman 트리: $O(\log_2 \text{UnigramPerplexity}(V)$) - 실제로는 균형 트리보다 빠름
- 어휘 크기 100만 기준 속도 2배가량 향상

# 핵심 특징
- 전체 어휘에 대한 합산 없이 경로 길이만큼의 연산으로 확률 계산이 가능하다.
- 학습 시 평가해야 할 출력 노드 수: $O(|V|) → O(\log_2|V|)$

# 등장 논문
- [[Efficient Estimation of Word Representations in Vector Space]] (Mikolov et al., 2013) - CBOW / Skip-gram의 출력층에 적용하여 계산 효율 확보
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - Negative Sampling과 비교 평가됨.

# 관련 개념
- [[Softmax]]
- [[Neural Network Language Model]]
- [[Continuous Bag-of-Words]]
- [[Skip-gram]]

#training-objective #efficiency