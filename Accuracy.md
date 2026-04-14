# 정의
전체 예측 중 올바르게 예측한 비율.
$$\mathrm{Accuracy} = \dfrac{TP+TN}{TP+TN+FP+FN}$$

# 특성
- 직관적이고 계산이 단순하나, 클래스 불균형 상황에서 신뢰성이 낮음.
- 클래스가 균형 잡혀 있고 FP와 FN의 비용이 동일할 때 유효하다.

# 모델별 적용 방식
- [[GloVe - Global Vectors for Word Representation|GloVe]]: 단어 유추 task 평가에서 사용. 19,544개 질문에 대해 정확히 일치하는 답을 맞힌 비율로 계산.

# 대표 변형/관련 기법
- Balanced Accuracy: 클래스별 [[Recall]]의 평균. 불균형 데이터셋에서 Accuracy를 보완한다.
- Top-k Accuracy: 모델의 상위 $k$개 예측 안에 정답이 포함되면 정답으로 인정한다.

# 관련 개념
- [[Confusion Matrix]]
- [[Precision]]
- [[Recall]]