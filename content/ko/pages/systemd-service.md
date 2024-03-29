---
tags:
- systemd
title: systemd-service
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
[systemd]({{< ref "/pages/systemd" >}}) 유닛의 `[Service]` 섹션에 들어갈 항목들

### `Type=simple` 과 `Type=oneshot` 의 차이

#### 결론
기본적으로 실행시간이 짧은 프로세스는 `oneshot` 으로, 아니면 `simple` 로 하는게 옳아 보임. 만약 해당 유닛의 종속된 다른 유닛을 만들 수도 있는 경우에는 관련해서 고민할 필요 있음.

#### `simple`

* 프로세스가 실행 중 일때는 active 상태, 종료 되었을 때 inactive 상태로 바뀐다.
  * 즉 종속된 서비스들은 해당 유닛 실행 후 종료를 기다리지 않고 실행된다.
* 하나의 `ExecStart` 만 가질 수 있다.

#### `oneshot`

* 프로세스가 종료되기 전까지 activating 상태 유지. 종료 되면 inactive 상태로 바뀐다. (따로 옵션이 없을 경우 절대 active 상태가 되지 않는다.)
  * 즉 종속된 서비스들은 선언한 유닛이 종료될때까지 실행되지 않는다.
* 0개 이상의 `ExecStart` 를 가질 수 있다.
* `RemainAfterExit=true`을 같이 사용하면 프로세스가 성공적으로 종료된 후에 종속 유닛이 실행.

## 같이 보기
* <https://www.freedesktop.org/software/systemd/man/systemd.service.html>
* <https://trstringer.com/simple-vs-oneshot-systemd-service/>
