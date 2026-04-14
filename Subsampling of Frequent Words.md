# 정의
대규모 코퍼스에서 지나치게 자주 등장하는 단어("the", "in", "a" 등)를 학습 중 확률적으로 제거하여, 빈도 불균형을 완화하고 학습 속도와 희귀 단어 표현 품질을 동시에 개선하는 기법.

# 제거 확률 공식
단어 $w_i$를 학습 데이터에서 제거할 확률:
$$P(w_i) = 1 - \sqrt{\dfrac{t}{f(w_i)}}$$
- $f(w_i)$: 단어 $w_i$의 말뭉치 내 빈도
- $t$: 임계값(threshold). 일반적으로 $10^{-5}$ 사용.

$f(w_i) > t$인 단어는 공격적으로 제거되며, 빈도 순위는 보존된다.

# 효과
- 학습 속도: 서브샘플링 적용 시 2배에서 10배 가량 속도 향상
- 희귀 단어 표현: 고빈도 단어와의 불필요한 공기(co-occurrence) 제거로 희귀 단어의 표현 품질이 유의미하게 향상
- 맥락 정보: "France-the"처럼 정보량이 낮은 공기를 줄이고, "France-Paris"처럼 의미 있는 공기에 집중

# 등장 논문
- [[Distributed Representations of Words and Phrases and their Compositionality]] (Mikolov et al., 2013) - 제안 및 실험 검증.

# 관련 개념
- [[Skip-gram]]
- [[Negative Sampling]]
- [[Word Embedding]]