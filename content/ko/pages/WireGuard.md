---
title: WireGuard
tags:
categories:
date: 2023-10-25
lastMod: 2023-10-25
---
## tldr

### `wg-quick` 으로 설정하기
와이어가드 컨피그 파일이 있으면, `ip`, `wg` 와 커맨드를 사용할 필요 없이, `wg-quick` 으로 쉽게 설정이 가능하다.
`ip`와 `wg` 커맨드로 제대로 설정되었는지 확인할 수 있다.

다음 커맨드로 설정한 인터페이스들을 제거할 수 있다.
```sh
wg-quick delete youre_wireguard_conf.conf
```
