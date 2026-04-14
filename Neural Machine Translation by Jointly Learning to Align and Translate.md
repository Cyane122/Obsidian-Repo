## 주요 정보
- 발표 연도: 2015년
- 저자: Dzmitry Bahdanau 외
- tags: #NLP, #attention, #neural-machine-translation, #seq2seq, #alignment, #machine-translation , #encoder-decoder
- ---
# Abstract
기존 [[Encoder-Decoder]] 계열 NMT 모델은 소스 문장 전체를 고정 길이 벡터(fixed-length vector) 하나로 압축한다. 이 병목이 특히 긴 문장에서 성능 저하를 유발한다.
따라서 이 논문에선 다음을 제안한다.
- 디코더가 각 타깃 단어를 생성할 때마다 소스 문장의 관련 위치를 자동으로 (soft-)탐색하는 메커니즘 도입
- 고정 길이 벡터 없이 소스 시퀀스 전체를 어노테이션 시퀀스로 유지하고 선택적으로 참조.
결과
- 영-프 번역에서 기존 Encoder-Decoder 대비 유의미한 성능 향상
- 당시 phrase-based 기계번역 시스템(Moses)과 필적하는 수준 달성
- Soft-alignment 시각화 결과, 언어학적으로 타당한 정렬 패턴 확인
