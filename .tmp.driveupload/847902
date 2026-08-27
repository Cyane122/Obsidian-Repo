---
type: paper
title: "Learning Transferable Visual Models From Natural Language Supervision"
authors:
  - "Alec Radford"
  - "Jong Wook Kim"
  - "Chris Hallacy"
  - "Aditya Ramesh"
  - "Gabriel Goh"
  - "Sandhini Agarwal"
  - "Girish Sastry"
  - "Amanda Askell"
  - "Pamela Mishkin"
  - "Jack Clark"
  - "Gretchen Krueger"
  - "Ilya Sutskever"
year: 2021
venue: "ICML 2021"
url: "https://proceedings.mlr.press/v139/radford21a.html"
pdf: ""
status: reading
read_date: ""
aliases:
  - "CLIP"
tags:
  - domain/multimodal
  - task/zero-shot-transfer
  - method/contrastive-learning
  - theme/generalization
---
# 한 줄 요약

CLIP은 4억 개 이미지-텍스트 쌍에 대한 대조 학습으로 시각 개념과 자연어를 같은 표현 공간에 정렬하고, 자연어 프롬프트만으로 새로운 분류 과제에 전이하는 방법을 보였다.

# Abstract
## 핵심 문제 의식
기존 컴퓨터 비전 모델은 사전에 정의된 고정된 카테고리 집합을 예측하도록 학습된다. 이 방식은 새로운 시각적 개념을 다루기 위해선 추가적인 labeled data가 필요하다는 근본적인 한계를 지닌다.

## 제안 방법
이미지와 텍스트 쌍에서 "어떤 캡션이 어떤 이미지와 짝인가"를 예측하는 [[Contrastive Learning]] 기반 사전학습을 수행한다. 인터넷에서 수집한 4억 개의 (image, text) 쌍을 학습 데이터로 사용한다.

## 핵심 결과
- 사전학습 후, 자연어를 통해 학습된 시각적 개념을 참조하거나 새로운 개념을 기술함으로써 [[Zero-Shot Transfer]]를 수행한다.
- 30개 이상의 기존 컴퓨터 비전 데이터셋에서 벤치마킹한 결과, 별도의 dataset-specific 학습 없이 다수의 task에서 경쟁력 있는 성능을 보인다.
- ImageNet에서 ResNet-50의 정확도에 준하는 zero-shot 성능을 달성하며, 이때 ImageNet의 128만 개 학습 예시는 단 하나도 사용하지 않는다.

# Method

## 이중 인코더

이미지 인코더와 텍스트 인코더가 각각 이미지와 캡션을 벡터로 변환한다. 같은 미니배치 안에서 실제 이미지-캡션 쌍의 유사도는 높이고 잘못 짝지은 쌍의 유사도는 낮추는 대칭적 [[InfoNCE Loss]]를 사용한다. 이 구조는 모든 이미지와 모든 라벨 텍스트의 임베딩을 미리 계산할 수 있어 생성형 방식보다 검색과 분류에 효율적이다.

## Zero-shot classifier

각 클래스 이름을 `a photo of a {class}` 같은 텍스트 프롬프트에 넣고 텍스트 임베딩을 만든다. 입력 이미지 임베딩과 각 클래스 임베딩의 [[Cosine Similarity]]를 비교해 가장 가까운 클래스를 예측한다. 여러 문구를 조합하는 prompt ensembling은 클래스 이름의 문맥 부족과 표현 민감도를 줄인다.

# 핵심 기여

1. 웹 규모의 자연어 감독만으로 범용 시각 표현을 학습할 수 있음을 30개가 넘는 데이터셋에서 확인했다.
2. 이미지 분류를 고정된 출력층이 아니라 자연어로 정의함으로써 [[Zero-Shot Transfer]]의 범위를 크게 넓혔다.
3. 동일한 표현 공간을 사용하는 검색·분류 인터페이스를 제시해 이후 비전-언어 사전학습의 기준점이 되었다.

# 한계와 후속 질문

- zero-shot 성능은 프롬프트 표현과 사전학습 데이터의 분포에 민감하다.
- 웹 데이터의 사회적 편향과 부적절한 연관을 그대로 학습할 수 있으며, 저자들도 실제 배포 전 과제별 검증이 필요하다고 지적한다.
- 세밀한 객체 구분이나 숫자 세기처럼 표준 지도학습 모델과 격차가 큰 과제가 남는다.

# 위키 연결

- 선행 기반: [[Contrastive Learning]], [[InfoNCE Loss]], [[Zero-Shot Transfer]]
- 후속 흐름: [[BLIP-2 - Bootstrapping Language-Image Pre-training with Frozen Image Encoders and Large Language Models]]
- 비교 문서: [[CLIP과 BLIP-2 비교]]
