---
type: project-entity
title: "Finance Tracker"
aliases: [Finance_Tracker.prj.xml]
project: "[[개인 지출 기록 자동화]]"
session_refs: ["antigravity:0302344a"]
tags: []
---

# 개요

`Finance Tracker`는 Android 결제 알림을 정형화된 Gmail로 보내는 Tasker 프로젝트 이름이다. 가져오기 가능한 전체 프로젝트 파일은 `tasker/Finance_Tracker.prj.xml`이다.

# 구성

- `Finance_Notification_Capture.prf.xml`: 지정 금융 앱의 notification profile
- `Process_Finance_Notification.tsk.xml`: 앱별 parser, 정규화와 event ID 처리
- Email Dispatcher: key-value Gmail 메시지 전송

# 지원 입력

Naver Pay, Toss Pay, 카드 앱과 fallback parser를 포함한다. 결제·취소·환불·이체를 구분하고 파싱 실패 시 원문을 보존한다. 최근 20개의 결정론적 event ID로 같은 알림의 재전송을 막는다.

# 보안 경계

금융 앱 로그인이나 인증정보를 다루지 않는다. Android notification access 이후의 텍스트만 사용하며, raw notification을 감사 기록으로 Gmail에 남긴다.

# 검증

`tests/run_tests.js`의 52개 assertion이 통과했다. 실제 휴대전화로 Tasker 프로젝트를 import하고 Gmail OAuth 또는 SMTP를 설정하는 절차는 `docs/SETUP_GUIDE.md`에 정리됐다.

# 관련 문서

- [[개인 지출 기록 자동화]]
- [[Process Finance Notification]]

# 세션 근거

- `antigravity:0302344a` — Tasker project asset과 52개 테스트
