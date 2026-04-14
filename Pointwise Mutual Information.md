# 정의
두 단어 $i$, $j$의 공동출현이 각 단어가 독립적으로 등장하는 경우에 비해 얼마나 더 자주 일어나는지를 측정하는 연관성 척도.
$$\mathrm{PMI}(i, j) = \log \dfrac{P(i, j)}{P(i)P(j)} = \log \dfrac {X_{ij} \cdot |C|}{X_i \cdot X_j}$$
- $X_{ij}$: 단어 $i$ 문맥에 단어 $j$가 등장한 횟수
- $X_i$: 단어 $i$ 주변에 등장한 전체 단어 개수
- $|C|$: 말뭉치 전체 토큰 수

# 특성
- 값이 0보다 크면 두 단어가 우연보다 더 자주 공동출현함을 의미한다. 0이면 독립이며, 음수이면 우연보다 드물게 공동출현한다.
- 희귀 단어 쌍에서 값이 과도하게 커지는 경향이 있다. 한 번이라도 공동출현하면 $P(i, j)$가 매우 작아 분자가 커지기 때문이다.
- [[Co-occurrence Matrix]]의 원소가 0인 경우 $\log 0$이 발생하여 정의되지 않는다.

# 대표 변형/관련 기법
- [[Positive Pointwise Mutual Information]]: 음수 값을 0으로 클리핑한다. 실용적으로 가장 널리 쓰이는 변형이다.
- SPPMI (Shifted PPMI): $\max(\mathrm{PMI}(i, j) - \log k , 0)$ 형태. [[Negative Sampling]]의 목적함수와 수학적으로 동치임이 알려져 있다(Levy & Goldberg, 2014).
- PMI$^2$: $\log \dfrac{P(i, j)^2}{P(i)P(j)}$ 형태로 희귀 단어 편향을 일부 완화했다. 

# 관련 개념
- [[Co-occurrence Matrix]]
- [[Word Embedding]]