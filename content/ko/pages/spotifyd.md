---
title: spotifyd
tags:
categories:
date: 2023-10-16
lastMod: 2023-10-16
---
https://github.com/Spotifyd/spotifyd

## keyring 사용법

[공식 문서](https://docs.spotifyd.rs/config/File.html)

spotifyd는 시스템 keyring 서비스에서 패스워드를 읽어 사용할 수 있다. `spotify.conf`에서 `use_keyring = true` 옵션을 주어야 한다.

### Linux
준비물: libsecret 패키지와, [Freedesktop Secret Service Interface](https://specifications.freedesktop.org/secret-service/latest/re01.html) 를 지원하는 keyring 시스템. Gnome Keyring 이나 KDE Wallet (KDE 5.27+) 이 제대로 설정되어야 한다.
```sh
secret-tool store --label='name you choose' application rust-keyring service spotifyd username <your-username>
```

다음 커맨드로 등록된 값을 확인할 수 있다.
```sh
secret-tool lookup application rust-keyring service spotifyd username <your-username>
```

`spotifyd --no-daemon` 으로 실행해 동작을 테스트 해보자.

####  작동하지 않을 때
* `no usable credentials found, enabling discovery` 가 `spotifyd --no-daemon` 에서 출력될 때.
  * 패키지 빌드 옵션에 keyring 이 들어가지 않았거나, 시스템 keyring 서비스가 제대로 설정되어 있지 않은 문제.
  * 2023-10-16 기준 NixOS Unstable 에서는 `withKeyring ? False` 로 되어있어, 따로 플래그 설정을 해줘야 한다.

### MacOS
```sh
security add-generic-password -s spotifyd -D rust-keyring -a <your username> -w
```
