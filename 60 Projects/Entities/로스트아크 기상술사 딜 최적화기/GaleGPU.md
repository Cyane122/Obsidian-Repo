---
type: project-entity
title: "GaleGPU"
aliases: [Gale GPU optimizer]
project: "[[로스트아크 기상술사 딜 최적화기]]"
session_refs: ["claude:03928006", "claude:cbdd680f"]
tags: []
---

# 개요

`GaleGPU`는 [[로스트아크 기상술사 딜 최적화기]]의 WebGPU 탐색 경로다. 약 88만 개 후보 조합의 점수를 WGSL 커널에서 병렬 계산하고, 상위 결과를 JavaScript 엔진으로 다시 평가한다.

# 처리 방식

후보 조합을 정수 인덱스로 펼쳐 GPU 버퍼에 넣고, 셰이더가 조합별 상대 딜을 계산한다. 측정 세션에서는 GPU 커널 자체가 약 76ms, 결과 정리까지 포함한 전체 처리가 약 944ms였다. CPU 경로와 의미가 갈라지는 것을 막기 위해 상위 후보의 점수를 기존 엔진으로 재계산하고 허용 오차를 검사했다.

# 발견된 결함

초기 서버의 정적 파일 목록에 `kernel.js`와 `gpu-optimizer.js`가 없어, 브라우저에서 `GaleGPU`가 정의되지 않고 CPU worker로만 내려가는 문제가 있었다. 입력이 바뀐 뒤 이전 GPU 작업이 끝나 낡은 결과를 그리는 비동기 경합도 발견돼 실행 세대 번호로 결과를 폐기하도록 수정했다.

# 관련 문서

- [[evaluateSetting]]
- [[음속 돌파]]

# 세션 근거

- `claude:03928006` — WebGPU 구현과 76ms/944ms 측정
- `claude:cbdd680f` — 실제 서버에서 GPU 경로가 막힌 문제와 취소 토큰 보강

