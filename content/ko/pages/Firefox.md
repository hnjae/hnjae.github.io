---
title: Firefox
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
## 초기 설정 메모

추후 초기 설정을 위해 Firefox Sync에서 동기화 해주지 않는 설정을 기술한다.

### `about:config`

#### UI 관련
* `browser.compactmode.show`: `true`
  * Customize Toolbar 에서 Density 를 Compact 로 바꾸는 옵션 토글.

#### DNS 관련
* `network.trr.mode`: `3`
  * DNS 쿼리에 TRR 만 사용하고 네이티브 설정을 사용 금지. [#](https://support.mozilla.org/si/questions/1273281)

#### 캐시
* [RubenKelevra 님의 설정](https://gist.github.com/RubenKelevra/fd66c2f856d703260ecdf0379c4f59db) 중 캐시 관련 설정 참고

### `about:preferences`

#### 보안 설정
* DoH 프로바이더 설정.
* Enhanced Tracking Protection 에서 DoH에서 막는 것 들은 풀기.

#### `about:preferences#search`
* 검색엔진 삭제.

### `about:addons`

1password의 Open the extension 기본 단축키가 Firefox Multi-Account Containers 랑 충돌하므로 변경. `C-,` 를 사용한다.

### Customize Toolbar

`Menu - More Tools - Customize Toolbar ..` 경로로 접근하는 메뉴
* Density를 Compact 로
* Titlebar On (CSD 끄기)
* 주소창 옆의 Flexible Space 제거

### 플러그인 개별 설정

#### 수동 조작이 필요한 플러그인

다음 플러그인들은 브라우저에서 자동 동기화를 지원해주지 않아 별도로 설정해야 한다.
* Firefox Multi-Account Containers: 수동으로 로그인 필요
* Ublock: 수동으로 클라우드에서 백업·업로드 필요. 
* enhanced-h264ify
* Enhancer for Youtube: adblock 기능을 끄자.
* StayFree
* uBlacklist
* Tab Session Manager

#### 자동으로 복원해주는 플러그인

다음 플러그인들은 설정을 자동으로 동기화 해주어 따로 신경 쓸 필요가 없다.
* Dark Reader
* [vimium-c]([vimium]({{< ref "/pages/vimium" >}}))

## [flatpak]({{< ref "/pages/flatpak" >}}) vs native

[link1](https://www.youtube.com/watch?v=OftD86RgAcc), [link2](https://www.reddit.com/r/linux/comments/uj9k93/performance_comparison_between_different/) 등에서 flatpak의 파이어폭스가 우분투·페도라의 제공 패키지 보다 빠르다는 주장이 있다. 내 환경에서는 어떤지 직접 테스트 해보았다.

테스트 환경: NixOS 23.05, KDE 5.27 Wayland 세션, Wayland 네이티브, 새 브라우저 프로파일에서 테스트
| | Flatpak | NixOS 23.05 |
|---|---|---|
|version | 118.02 | 118.01 |
| Motionmark 1.2 | 1247.8 ± 4.35% | 1259.07 ± 1.76% |
| Speedometer 2.0 | 273 ± 4.8 | 231 ± 5.2 |
| Jetstream 2 | 176.441 | 167.285 |

다른 사람들의 결과와 달리 그렇게 드라마틱한 차이가 있지는 않았다.

### [flatpak]({{< ref "/pages/flatpak" >}}) 버전 파이어폭스에서의 Native message
2023-10-16 기준 불가능하다. 그래서 시스템 1password와 연동 같은 것도 사용할 수 없다. 다음 PR이 머지되면 기대해볼 수 있을 것 같다. <https://github.com/flatpak/xdg-desktop-portal/pull/705>
