# 파이썬 텍스트 분석과 LLM, RAG 애플리케이션 개발

텍스트를 정제하고 수치화하는 전통적 NLP에서 시작해, 신경망·Transformer·GPT를 거쳐 RAG와 LangGraph 애플리케이션으로 확장하는 강의 지도이다.

## 전체 학습 흐름

| 단계 | 주차 | 핵심 질문 | 대표 용어 |
|---|---:|---|---|
| 텍스트 준비 | [[2주차]] | 텍스트를 어떻게 일관된 분석 단위로 만드는가? | Tokenization, Normalization, Stopword |
| 희소 표현 | [[3주차]] | 텍스트를 빈도 기반 숫자 벡터로 어떻게 바꾸는가? | BoW, TF, IDF, TF-IDF |
| 전통적 분류 | [[4주차]] | 수치화된 텍스트를 어떻게 분류하고 평가하는가? | Naive Bayes, Logistic Regression, F1 |
| 분산 표현 | [[5주차]] | 단어의 의미적 유사성을 벡터에 어떻게 담는가? | Word2Vec, Embedding, Cosine Similarity |
| 순차 모델 | [[6주차]] | 단어 순서와 장기 문맥을 어떻게 학습하는가? | RNN, LSTM, Backpropagation |
| 문맥 모델 | [[7주차]] | 모든 토큰의 관계를 병렬로 어떻게 계산하는가? | Transformer, Self-Attention, Q/K/V |
| 생성 모델 | [[8주차]] | 다음 토큰 예측으로 어떻게 텍스트를 생성하는가? | GPT, Causal Mask, Autoregressive Generation |
| LLM 앱 구성 | [[9주차]] | API 호출을 재사용 가능한 체인으로 어떻게 구성하는가? | Gemini API, LangChain, LCEL |
| 대화 상태 | [[10주차]] | 여러 턴의 대화와 사용자 세션을 어떻게 관리하는가? | Message History, Session, Summary Memory |
| 의미 검색 | [[11주차]] | 의미가 가까운 문서를 어떻게 저장하고 찾는가? | Embedding, Vector Database, Chroma |
| 기본 RAG | [[12주차]] | 검색 결과를 근거로 답변하게 하려면 무엇이 필요한가? | Chunking, Retriever, Augmentation, RAG |
| 고급 RAG | [[13주차]] | 검색 정확도·다양성·근거성을 어떻게 높이는가? | BM25, Hybrid Search, MMR, Reranking |
| 그래프 워크플로 | [[14주차]] | 분기와 반복이 있는 LLM 흐름을 어떻게 명시적으로 제어하는가? | State, Node, Edge, Reducer, LangGraph |

## 통합 정리

- [[전체 용어 정리]]: 전 주차 핵심 용어를 정의·관계·한계 중심으로 정리한 용어집
- [[NLP 표현 학습의 흐름]]: BoW에서 문맥적 표현까지의 연구 흐름
- [[Attention Is All You Need]]: Transformer의 대표 논문
- [[BERT - Pre-training of Deep Bidirectional Transformers for Language Understanding]]: Encoder 계열 사전학습의 대표 논문

## 원본 자료

- [Google Drive 강의자료 폴더](https://drive.google.com/drive/folders/10UO_uZZLDQWSVZ7r4RkJFiW76qZqiuIx)
- 범위: 2주차~14주차 강의자료
- 정리 기준일: 2026-07-28

> [!note] 자료 표기
> Drive의 11주차 폴더에 있는 노트북 내부 제목은 “12주차 실습: 임베딩 & 벡터 DB”로 표기되어 있다. 이 공간에서는 폴더 기준에 따라 11주차로 정리했다.
