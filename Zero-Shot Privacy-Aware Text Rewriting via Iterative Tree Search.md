## 주요 정보
- 발표 연도: 2025년
- 저자: Shuo Huang et al.
- tags: #NLP, #privacy-reserving , #text-rewriting, #zero-shot, #tree-search, #MCTS, #LLM
---
## Abstracts
클라우드 기반 [[Large Language Model|LLM]] 서비스가 확산되면서 사용자 입력이 의도치 않게 민감 정보를 노출하는 프라이버시 문제가 대두되었다. rule-based redaction이나 scrubbing 같은 기존 익명화 기법은 프라이버시 보호와 텍스트 자연스러움-유용성 사이의 균형을 맞추기 어렵다.
본 논문은 NaPaRe를 제안한다.
- Zero-shot, tree-search 기반의 반복적(iterative) 문장 재작성 알고리즘
- 민감 정보를 체계적으로 obfuscate하거나 삭제하되, 일관성(coherence), 관련성(relevance), 자연스러움(naturalness)을 보존한다.
- reward model의 안내를 받아 재작성 공간을 동적으로 탐색하며, privacy-sensitive segment를 점진적으로 재작성한다.
실험 결과, 기존 baseline 대비 프라이버시 보호와 유용성 보존 사이에서 우월한 균형을 달성하였다.

> [!note] 새로운 전략
> [[NAP² - A Benchmark for Naturalness and Privacy-Preserving Text Rewriting by Learning from Human|NAP²]]의 전략과는 달리, 학습을 시키지 않는 대신 추론할 때 tree search로 좋은 재작성을 찾아내는 방식이다.


## Introduction
### 기존 익명화 기법의 한계
기존 LLM 기반 anonymization은 생성 능력을 활용해 프라이버시, 유용성, 자연스러움 균형을 개선했으나 세 가지 제약이 남았다.
1. 고정된 PII 범주 의존: 사전 정의된 PII 카테고리나 정적으로 탐지된 span에 의존한다 -> 사용자별 동적 프라이버시 프로파일(e.g. 전문 서사 속 금융 정보, 공적 담론 속 이념적 뉘앙스)에 대한 적응력이 떨어진다.
2. fine-tuning 필요성: open-source LLM으로 견고한 결과를 얻으려면 특화 데이터셋에 대한 fine-tuning이 필요한데, 이런 데이터는 과소대표(under-represented) 도메인에서 구하기 어렵거나 비용이 크다.
3. 획일적 전략: 모든 민감 요소에 동일한 강도로 처리 -> 정보 민감도 차이(취미 언급 vs 보호 대상 의료 정보)를 무시한다. 결과적으로 과도한 수정(유용성 훼손) 또는 불충분한 보호(inference attack 허용)로 이어진다.

### 본 논문의 접근 - NaPaRe
- zero-shot, iterative tree-search 알고리즘으로, 중간 규모의 로컬 LLM에 배포 가능하며 완전 오프라인으로 동작한다.
- 입력 정의: privacy specification $p$ (PII 리스트, 텍스트 지시문, 사용자 프로파일 포함) + 입력 발화 $u$
- 출력 $y$의 조건:
	- $p$에 대한 언급을 제거하거나 은폐한다.
	- 클라우드 작업 수행에 필요한 비민감 내용은 유지한다.
	- 최소한의 의미 변경으로 자연어를 모방한다.

### 파이프라인 2단계
1. Privacy Segment Alignment: $u$를 분해해 민감 부분을 짚어낸다. 각 segment $t_j$에 대해 $\mathrm{Align}_{t_j}=\mathrm{Pri}(p, t_j)$ 점수를 embedding 유사도/cosine으로 계산해 집중 개입할 타깃 시퀀스 $t_p^{(1)}, \cdots, t_p^{(m)}$를 분리한다.
2. [[Monte Carlo Tree Search(MCTS)]]-Inspired 재작성: 재작성을 decision tree로 모델링한다.
	- root node = $u$의 부분 상태
	- branch = action (고민감도 span에 대한 deletion / generalization을 통한 obscuration)
	- node 선택은 [[Upper Confidence Bound for Trees|UCT]]로 유망한 경로에 가중
	- 프라이버시 전략으로 프롬프트된 one-step LLM rewriter가 후보 집합 $Y_{cand}$ 생성 후 utility 함수 $L_S(y, p_{seg}) \leq \gamma$로 게이팅한다.
	- reward model $R(y, p)$가 [[Natural Language Inference|NLI]] 기반 privacy entailment 점수와 도메인별 utility 측정치를 종합해 backpropagation으로 탐색을 반복 정제한다.

### 주요 기여
1. NaPaRe: sampling, UCT selection, composite reward를 융합한 tree-based iterative rewriter. deletion, obscuration 전략을 탐색하며 zero-shot 환경에서 다양한 $p$에 적응한다.
2. 종합 평가: NAP² corpus와 ECHR 법률 판결문 대상으로 프라이버시(PRIVACY_NLI, PII F1), 유용성([[ROUGE]]-1, judgement accuracy), 자연스러움([[Perplexity]], human 평가) 측정. baseline 대비 상대적 프라이버시 22.3% 향상. 유용성 손실은 미미, 원문 대비 perplexity 1.5점 이내 유지.
3. 광범위한 실험: privacy leakage, utility, naturalness 세 차원에서 검증. redaction 도구 및 경쟁 LLM 재작성 기법을 모두 능가.

## Privacy-Aware Text Rewriting
### Task 정의
- 입력: 사용자가 제공한 privacy 정보 $p$ + 입력 발화 $u$
- 목표: 로컬 배포 LLM의 생성 능력을 활용해, $p$에 명시된 민감 정보를 $u$에서 제거하거나 은폐하도록 재작성.
- $p$의 성격: 일반화된 privacy specification. 다음 중 무엇이든 가능하다.
	- 제거할 PII 집합
	- 텍스트 형식의 프라이버시 요구 사항
	- 사용자 프로파일(persona)

### 생성 문장 $y$의 요구조건
1. $p$에서 식별된 어떤 민감 정보도 드러내지 않는다.
2. $u$의 비민감 내용은 보존하여, 재작성된 문장이 클라우드에서 적절한 작업을 수행할 수 있게 한다.
3. 텍스트가 이미 재작성되었다는 사실을 untrusted party에게 경고하지 않는다(자연스러움 보존).

### 가정
- 민감 정보를 클라우드에 업로드하지 않기 위해, 재작성 모델은 로컬 배포되고 추론은 완전히 오프라인이다.
- 단일 사용자 기준으로, 로컬 디바이스 위의 애플리케이션 형태로 동작한다고 가정한다.
- privacy 정보 $p$는 두 형태가 가능하다.
	- 사전 정의된 속성 집합
	- 사용자가 자기 디바이스에서 입력한 임의의 정보
> [!note] 경고가 없다는 것
보통 익명화는 `[MASK]`나 `<PERSON>` 같은 흔적을 남기는데, 이 흔적 자체만으로도 민감 정보의 존재 유무를 알려주는 신호가 됨. NaPaRe의 목적은 이 신호마저도 없애서 재작성되었다는 사실조차 숨기는 것.

## One Step LLM Text Rewrite
### Rewrite
- 프라이버시 보존 재작성을 생성하는 controllable rewriting 메커니즘.
- 입력: 입력 문장 $x$ + 단일 privacy segment $p_{seg}$
- 절차
	1. stochastic language model $G_{LLM}$에 privacy-aware prompting 전략 $a \in \{\text{obscuring, deleting}\}$을 적용해 $N$개의 후보 재작성 $Y_{cand}$를 생성한다.
	2. 각 후보 $y \in Y_{cand}$를 utility 함수 $L_S(y, p_{seg}) \in [0, 1]$로 점수화한다.
		- 이 점수는 잔존하는 private attribute의 정도 또는 monitor 함수에 따른 생성 품질을 정량화한다.
	3. monotonic threshold $\gamma$를 설정한다. $\gamma$가 높아질수록 수용 기준이 더 엄격해진다.

### 후보 선택 규칙
- $L_S(y, p_{seg}) \leq \gamma$를 만족하는 후보들을 acceptable set $Y_{acc}(x)$로 유지한다.
- 이 accepted set에서 하나의 예시를 무작위로 선택한다.
- 만약 기준을 만족하는 후보가 없으면, $y_{cand}$ 중 utility 점수가 가장 높은 문장을 반환한다.
- tree 생성 도중에도 one-step rewrite에서 언급된 $\gamma$와 동일한 threshold 값을 적용한다.

## Tree Search Iterative Refinement Privacy Rewrite
### 동기
- 텍스트 내 개인정보 보호는 일반적인 obfuscation이 아니라, 정밀하고 맥락 인식적인(context-aware) 재작성을 요구한다.
- 기존 접근의 한계:
	- named entity masking: 과도한 내용 제거로 이어질 수 있다.
	- sentence-level paraphrasing: 민감한 세부 정보를 충분히 은폐하지 못할 수 있다.
- 제안: zero-shot 방식으로 발화 내 privacy segment를 명시적으로 재작성하도록 모델에 지시하는 tree-search 기반 프레임워크.

## 2단계 파이프라인
1. Privacy Segment Alignment
	- 직접 프롬프팅으로 LLM에 개인정보 제거를 지시하는 것은 신뢰도가 낮다. 모델이 암묵적(implicit)인 노출을 식별하고 수정하는 데 약하기 때문이며, 특히 한 문장에 여러 민감 정보가 있을 때 더욱 그렇다.
	- 대신, privacy specification을 기준으로 입력 문장을 분해해 segment 단위로 재작성하는 alignment 전략을 채택한다.
	- 매핑 함수: 입력 발화 $u$에서 persona $p$의 정보와 정렬되는 privacy segment를 선택한다. $p$의 의미로부터, $u$ 내에서 가장 alignment 점수가 높은 segment $t_s$를 식별한다.
	- alignment 점수는 [[Cosine Simliarity]] 같은 유사도 지표나 fine-tuned 언어 모델로 측정 가능하다.
	- 각 segment $t_j \in u$에 대하여
	$$\mathrm{Align}_{t_i} = \mathrm{Pri}(p, t_j)$$
		- $\mathrm{Pri}(p, t_j)$: 토큰 $t_j$와 persona $p$ 사이의 private alignment 점수
	- 이 매핑으로 aligned token 집합 $(t_1, t_2, \cdots, t_m)$이 생성되며, $u$에서 개인정보를 드러낼 가능성이 높은 토큰들을 식별한다.
2. Tree-Search Privacy Rewriting
	- 각 privacy segment를 서로 다른 전략으로 반복 재작성하기 위해, 재작성 과정을 tree-search 문제로 모델링한다.
		- 각 node = 문장의 수정된 버전
		- 각 branch = 단일 privacy segment에 적용된 재작성 action
	- Action Space: 각 node(중간 재작성 상태)에서 단일 privacy segment에 대해 두 전략을 고려한다.
		- deleting: privacy segment를 문장에서 제거한다.
		- obscuring: privacy segment를 덜 구체적이거나 더 일반적인 표현으로 대체한다.
	- [[Upper Confidence Bound for Trees|UCT]]
		- candidate 재작성 탐색을 안내하기 위해 Upper Confidence Bound for Trees (UCT)를 채택한다.
		- 고-reward 후보의 exploitation과 덜 방문된 옵션의 exploration 사이 균형을 맞춘다.
		- 다음 목적함수를 최대화하는 action을 선택한다.
			$$\mathrm{UCT}(i) = \bar X_i + C \cdot \sqrt {\dfrac{\ln N}{n_i}}$$
			- $\bar X_i$: 노드 $i$의 평균 reward (exploitation 항)
			- $n_i$: 노드 $i$가 방문된 횟수
			- $N$: 부모 노드의 총 방문 횟수
			- $C$: 조정 가능한 exploration 상수
		- 해석: 좌항은 지금까지 잘 나온 경로를 밀어주고, 우항은 적게 가본 경로에 보너스를 줘 다양성을 확보한다.
		- 본 논문 설정: validation 성능 기준으로 $C=6.36$으로 설정.
	- Algorithm 1: Tree-Structured Iterative Privacy Refinement
		입력: 입력 문장 $x$, reward model $\mathrm{Reward}$, 재작성 전략 집합 $A=\{\mathrm{deleting}, \mathrm{obscuring}\}$, one-step rewrite 알고리즘 $\mathrm{Rewrite}$, tree 생성 예산 $B$, 샘플링 예산 $C$
		출력: privatized 문장
		1. $p$에 따라 $x$에서 privacy segment $T_p = \{t_p^{(1)}, \cdots, t_p^{(m)}\}$를 추출한다.
		2. root 상태 $s_0 \leftarrow x$로 초기화한다.
		3. 각 privacy segment $t_p^{(i)}$에 대해 다음을 반복한다.
			1. root node $s_0$, $t_p^{(i)}$로 새로운 search tree를 초기화한다.
			2. $k=1$부터 $B$까지 반복한다.
				1. Selection: root에서 tree를 순회하며, UCT 확률에 따라 action $a \in A$를 가진 leaf node를 선택한다.
				2. Evaluation: 새로 생성된 자식 node마다 부모 node의 생성 문장을 사용해 갱신된 문장을 만든다.
					$y' = \mathrm{Rewrite}(x, a, C)$
				3. reward 계산: node의 문장을 reward 함수 $R$에 통과시킨다.
					$r \leftarrow R(y', t_p^{(i)})$
				4. Backpropagation: reward $r$을 tree 위로 전파하며, 각 조상 node의 $Q(\cdot)$와 방문 횟수 $N(\cdot)$를 갱신한다.
				5. 만약 $r' \geq \gamma$ 이면 break.
			3. best leaf node $\mathrm{leaf}_{best}$까지 순회하고 $y_{t_p^{(i)}} \leftarrow \mathrm{Rewrite}(\mathrm{leaf}_{best}, \epsilon)$으로 확정한다.
			4. $s_p \leftarrow y_{t_p^{(i)}}$를 다음 private token의 입력 문장으로 설정한다.
		4. 생성이 끝나면 마지막 생성 예시를 최종 출력으로 설정한다.
			$y_{final} \leftarrow y_{t_p^{(i)}}$
		5. $y_{final}$을 반환한다.
### 알고리즘 동작 요약
- root node = 원본 문장 $x$로 초기화.
- 첫 단계에서 단일 privacy segment를 선택하고, 두 전략 중 하나를 균등 샘플링한다.
- 한 번의 생성 후 discriminator가 reward $r$을 평가한다. 이후:
	1. Update Node Reward and re-weight: $r \leq \gamma$이면 생성을 계속하고 점수를 tree 위로 전파한다. root나 상위 branch로 돌아가, 관측된 reward에 기반해 각 전략 선택 확률을 재가중한다. 새 node 확장 시, 갱신된 확률로 root에서 새 leaf까지 샘플링한다.
	2. Termination Check: 어떤 leaf node가 reward threshold $\gamma$를 초과하면 현재 segment의 생성을 종료한다. 예산이 소진되도록 적절한 재작성을 못 찾으면, leaf node를 순회해 지금까지 최선의 생성을 취한다.
- 첫 segment의 최선 재작성이 확정되면 그 변환을 고정하고 부분 재작성된 문장을 새 root로 삼아 다음 segment로 진행한다. $x$의 모든 privacy segment가 처리될 때까지 반복한다.