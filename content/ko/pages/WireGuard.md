---
title: WireGuard
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
## tldr

### `wg-quick` 으로 설정하기
만약 와이어가드 컨피그 파일이 있다면, `ip`, `wg` 와 같은 명령어를 사용하지 않고도 간편하게 설정할 수 있다.
`ip`와 `wg` 커맨드로 설정이 제대로 되었는지 확인할 수 있다.

다음 커맨드로 설정한 인터페이스들을 제거할 수 있다.
```sh
wg-quick delete youre_wireguard_conf.conf
```
