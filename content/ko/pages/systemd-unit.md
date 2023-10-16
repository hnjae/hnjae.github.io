---
tags:
- systemd
title: systemd-unit
categories:
date: 2023-10-16
lastMod: 2023-10-16
---
## `[UNIT]` 섹션 옵션

### `Wants` vs `Requires`

#### 결론
`Wants`를 `Requires` 대신 사용하는 것이 더 나은 선택인 경우가 많다고 한다. 꼭 필요한 경우가 아니면 `Wants`를 쓰자.

#### `Wants`

* 선언한 유닛이 활성화되면, `Wants` 의 유닛들도 활성화 됨.
* `Wants` 의 유닛들이 실패하거나 존재하지 않아도, 선언한 유닛은 시작됨.
* `Wants` 는 서비스가 시작·중지되는 순서에 영향을 미치지 않음.
* `After`나 `Before` 로 순서를 구성할 것.

#### `Requires`

* 선언한 유닛이 활성화되면, `Requires` 의 유닛들도 활성화 됨.
* `Requires` 의 유닛 중 하나를 정지·재시작 하면 선언한 유닛도 정지함.
* `Requires` 의 유닛들이 항상 active 상태이여야함을 의미하지는 않음.
* 다른 유닛의 active 상태에 종속시키고 싶으면 `BindsTo` 나 `After` 를
사용할 것.

## 같이 보기 
* <https://www.freedesktop.org/software/systemd/man/systemd.unit.html>
