---
type: project-entity
title: "Process Finance Notification"
aliases: [Process_Finance_Notification.tsk.xml]
project: "[[개인 지출 기록 자동화]]"
session_refs: ["antigravity:0302344a"]
tags: []
---

# 개요

`Process Finance Notification`은 [[Finance Tracker]] 안에서 원본 Android 알림을 표준 거래 schema로 바꾸는 Tasker task다.

# 출력 필드

`event_id`, `event_time`, `amount`, `currency`, `merchant`, `source_app`, `event_type`, `raw_notification`을 만든다. 시간은 KST ISO-8601, 금액은 comma와 원 표시를 제거한 정수로 정규화한다.

# 실패 처리

알 수 없는 문구에서도 email을 보내며, 확정할 수 없는 field는 `UNKNOWN`으로 남긴다. 원문을 지우거나 가맹점·금액을 추측하지 않는다.

# 중복 처리

동일 event ID의 짧은 재알림만 rolling buffer로 억제한다. 서로 다른 앱이 보낸 비슷한 거래는 후속 장부 단계에서 검토할 수 있도록 둘 다 남긴다.

# 관련 문서

- [[Finance Tracker]]
- [[개인 지출 기록 자동화]]

# 세션 근거

- `antigravity:0302344a` — task XML과 parser·fallback·dedupe 구현
