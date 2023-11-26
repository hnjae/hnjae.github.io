---
title: NixOS
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
### 각종 트러블슈팅 기록

#### [kernel module]({{< ref "/pages/kernel module" >}})

커널 모듈은 `/run/current-system/kernel-modules/lib/modules/$(uname -r)` 에 위치한다.

#### `oci-containers`

`:latest` 태그로 컨테이너를 선언하여도, `nixos-rebuild`에서 업데이트 된 이미지가 있는지 체크해주지 않는다. 직접 `podman pull` 로 새 이미지를 받아오고, 서비스를 restart 해야한다.

자동으로 `latest` 컨테이너를 업데이트하는 것이 별로 신경쓰이지 않는다면, [systemd]({{< ref "/pages/systemd" >}}) 서비스를 만들어서 등록해주자.

### Remote Builds

#### tldr
```sh
nixos-rebuild --build-host id@example.com switch --flake "path#output"
```

* `root` 가 remote 서버의 접속할 수 있어야 한다.

#### 트러블 슈팅
다음과 같은 이슈가 있을 때.
```text
sudo: a terminal is required to read the password; either use the -S option to read from standard input or configure an askpass helper
sudo: a password is required
```

remote build 에서는 `nix-store` 를 `sudo` 로 실행하는데, 이때 패스워드 입력이 안되서 생기는 문제이다. 리모트 빌드를 받는 전용 계정(`builder` 로 명명) 생성 후, `nix-store` 를 `NOPASSWD 로 실행할 수 있도록 `sudo` 설정을 해주는 것으로 해결하였다.

```nix
security.sudo.extraConfig = ''
      builder ALL=NOPASSWD: ${pkgs.nix}/bin/nix-store
'';
```

그리고 보안을 위해 `passwd -l builder` 로 `builder` 로 로그인하는 것을 제한적으로 막았다.

#### 참고자료
* <https://nixos.org/manual/nix/stable/advanced-topics/distributed-builds>
* <https://nixos.wiki/wiki/Distributed_build>
* <https://nixos.wiki/wiki/Nixos-rebuild>
