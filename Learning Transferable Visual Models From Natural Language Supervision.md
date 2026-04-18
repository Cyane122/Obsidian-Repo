# 주요 정보
- 발표 연도: 2021년
- 저자: Alec Radford 외
- tags: #multimodal, #contrastive-learning, #zero-shot-transfer, #vision-language, #CLIP
---
# Abstract
## 핵심 문제 의식
기존 컴퓨터 비전 모델은 사전에 정의된 고정된 카테고리 집합을 예측하도록 학습된다. 이 방식은 새로운 시각적 개념을 다루기 위해선 추가적인 labeled data가 필요하다는 근본적인 한계를 지닌다.

## 제안 방법
이미지와 텍스트 쌍에서 "어떤 캡션이 어떤 이미지와 짝인가"를 예측하는 [[Contrastive Learning]] 기반 사전학습을 수행한다. 인터넷에서 수집한 4억 개의 (image, text) 쌍을 학습 데이터로 사용한다.

## 핵심 결과
- 사전학습 후, 자연어를 통해 학습된 시각적 개념을 참조하거나 새로운 개념을 기술함으로써 [[Zero-Shot Transfer]]를 수행한다.
- 30개 이상의 기존 컴퓨터 비전 데이터셋에서 벤치마킹한 결과, 별도의 dataset-specific 학습 없이 다수의 task에서 경쟁력 있는 성능을 보인다.
- ImageNet에서 ResNet-50의 정확도에 준하는 zero-shot 성능을 달성하며, 이때 ImageNet의 128만 개 학습 예시는 단 하나도 사용하지 않는다.