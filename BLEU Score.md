# 정의
Papineni et al. (2002)이 제안한 기계번역 자동 평가 지표. 모델이 생성한 번역문(hypothesis)과 사람이 작성한 참조 번역문(reference) 사이의 n-gram 중첩 정도를 측정해 번역 품질을 수치화한다.

# 계산 방식
$$\mathrm{BLEU} = \mathrm{BP} \cdot \exp \left(\displaystyle \sum_{n=1}^N w_n\log p_n \right)$$
- $p_n$: n-gram 정밀도. hypothesis의 n-gram이 reference에 등장하는 비율. 동일 n-gram의 중복 계산은 reference에서의 최대 등장 횟수로 클리핑해 방지.
- $\mathrm{BP}$: 짧은 번역에 대한 패널티.
	$$\mathrm{BP} = \begin{cases} 1 & \text{if } c > r \\ e^{1-r/c} & \text{if } c \leq r\end{cases}$$
	- $c$: hypothesis 길이
	- $r$: reference 길이
	- 일반적인 설정: $N=5$, 각 $w_n=0.25$
> [!tip] BLEU의 특징
> BLEU는 [[Precision]] 기반 지표라 재현율(Recall)을 직접 측정하지 않는다. 즉, 짧지만 정확한 번역은 BP 패널티만 감수하면 높은 점수를 받을 수 있다. 또한 n-gram 단위 매칭이라 의미가 같더라도 다른 단어를 쓰면 점수가 낮게 나오는 한계가 있다.

# 해석
- 0~100 사이의 값을 가지며, 0~1로 압축하기도 한다.
- 기계번역 기준 대략적인 해석은 다음과 같다.

| BLEU    | 품질 수준     |
| ------- | --------- |
| < 10    | 거의 무의미    |
| 10 ~ 19 | 이해 가능한 수준 |
| 20 ~ 29 | 어느 정도 유창함 |
| 30 ~ 40 | 좋은 번역     |
| > 40    | 전문가 수준    |
- task, 언어 쌍, 평가 방식에 따라 절댓값의 의미가 달라지므로 동일 조건 내 비교가 원칙이다.

# 대표 변형 / 관련 기법
- SacreBLEU: 토크나이징 방식을 표준화해 재현성을 높인 구현체. 현재 표준으로 쓰인다.
- ROUGE: 재현율 기반 지표. 주로 요약(summarization) 평가에 사용된다.
- METEOR: 동의어/어간 일치를 고려한 개선 지표.
- BERTSCore: 임베딩 유사도 기반 지표. 의미적 동치를 더 잘 포착한다.

# 관련 개념
- [[Beam Search]]

#evaluation #machine-translation #ROUGE