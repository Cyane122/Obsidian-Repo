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
2. [[Monte Carlo Tree Search(MCTS)]]