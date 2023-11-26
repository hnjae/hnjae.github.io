---
title: NetworkManager
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
### 특정 Wifi 에 연결하기

여러개의 AP의 SSID가 동일한 와이파이 서비스 지역에서는, 2.4GHZ에 연결되거나, 먼 거리의 AP에 연결되어 답답한 경험을 할 수 있다. 이런 경우 원하는 AP를 직접 지정해서 연결하면 이 문제를 해결할 수 있다.

먼저, 다음 커맨드로 연결할 수 있는 AP 목록을 출력하자.
```sh
nmcli -f in-use,ssid,bssid,freq,chan,rate,signal,bars,security dev wifi
```
BSSID를 메모하고 NetworkManager에서 지정해주면 된다. GUI 프론트엔드에 BSSID를 적는 항목이 있을 것이다. 만약 찾을 수 없다면 `nmtui`를 활용할 수 있다.

#### 5GHz 만을 사용하고 싶을 때

※ 주의: 테스트되지 않음.

특정 AP를 지정하고 싶지는 않고, 단지 2.4GHz만 사용하지 않도록 하고 싶을 수도 있다. `/etc/NetworkManager/system-connections` 에 있는 `.nmconnection` 항목을 수정한다.

`[Wifi]` 항목에 `band=a` 를 추가해주자. [출처](https://developer-old.gnome.org/NetworkManager/stable/settings-802-11-wireless.html#id-1.3.3.47.2.2.1)

### strongSwan

#### [systemd]({{< ref "/pages/systemd" >}}) 로그에 다음과 같은 오류가 뜨면서 작동하지 않을 경우

```log
charon-nm[xxxxx]: Failed to initialize a plugin instance: Connection ":x.xxx" is not allowed to own the service "org.freedesktop.NetworkManager.strongswan" due to security policies in the configuration file
```

<https://wiki.strongswan.org/issues/3339> 참고.

[NixOS]({{< ref "/pages/NixOS" >}}) 의 경우 ([#](https://github.com/NixOS/nixpkgs/issues/29873#issuecomment-338908292) 참고)

다음 설정을 추가한다. 
```nix
  services.dbus.packages = [ pkgs.strongswanNM ];
  networking.networkmanager.plugins = with pkgs; [
    networkmanager_strongswan
  ];
```

### [WireGuard]({{< ref "/pages/WireGuard" >}})

※ 내 환경(NixOS 23.05)에서는 불분명한 이유로 NetworkManager 로 WireGuard 를 사용할 수 없다. 이럴 경우 ### `wg-quick` 으로 설정하기
 참조

[WireGuard]({{< ref "/pages/WireGuard" >}})설정 파일이 있다면, 다음 커맨드로 import 할 수 있다.
```sh
nmcli connection import type wireguard file your_wireguard_conf.conf
```
