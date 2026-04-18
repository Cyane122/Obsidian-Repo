# 정의
모델이 학습 시 한 번도 본 적 없는 task 또는 카테고리에 대해, 추가적인 fine-tuning이나 labeled 예시 없이 직접 예측을 수행하는 능력. 사전학습 과정에서 획득한 일반적 표현을 새로운 downstream task에 그대로 적용한다.

# 기존 컴퓨터 비전에서의 정의
전통적으로 학습 시 보지 못한 객체 카테고리를 인식하는 문제로 정의되었다. 클래스 간 속성 전이나 의미론적 임베딩을 활용하는 방식이 주였다.

# NLP에서의 발전
[[GPT]] 계열 언어 모델에서 두드러지게 나타났다. 대규모 웹 텍스트로 사전학습된 모델이 별도 학습 없이 번역, 요약, 분류 등 다양한 task를 수행할 수 있음이 확인되면서 zero-shot capability가 주요 연구 주제로 부상했다.

# 대표 변형 / 관련 기법
- [[Prompt Engineering]]
- [[Few-Shot Learning]]
- [[GPT]]-3

#zero-shot #transfer-learning #generalization #prompt