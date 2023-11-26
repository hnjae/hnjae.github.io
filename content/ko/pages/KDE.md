---
tags:
- freedesktop
title: KDE
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
## 내가 사용하는 플러그인 리스트

### Widget

#### Active Window Control [#](https://store.kde.org/p/998910)

상단바에 현행 윈도우를 표기하는 용도

#### Simple Overview Pager [#](https://store.kde.org/p/1833220)

기존 Pager 대체. 숫자로만 표기되어 깔끔하다.

#### Latte Separator [#](https://store.kde.org/p/1295376)

구분선이 필요한 separator 가 필요할 때 사용.

### Kwin Scripts

#### Always Open on Active Screen [#](https://store.kde.org/p/1617640)

앱을 여는 모니터를 컨트롤.

#### Polonium

KDE 5.27 에 도입된 타일링 기능을 활용한 스크립트.

## 트러블슈팅

### 특정 어플리케이션 포커스 숏컷

특정 어플리케이션를 포커스하는 숏컷을 사용하고 싶다. X11 를 사용하던 시절에는 어떤 환경이든 `wmctrl` 라는 훌륭한 툴로 할 수 있었는데, wayland 에서는 더 이상 이 툴을 사용하는 것이 불가능하다. [link](https://unix.stackexchange.com/questions/656729/wmctrl-like-tool-or-alternative-for-kde-wayland) 관련 내용 참고해서 해결 할수 있다.

### Lock 스크린에서 화면 꺼짐이 안되는 문제

![screen-lock-event.webp](/assets/screen-lock-event_1699615843444_0.webp) 

KDE 5.27 기준, 따로 수동으로 lock 을 걸면 화면이 안꺼지는 문제가 있다.  설정에서 `Personalization` - `Notifications` - `Screen Saver` - `Configure Events` - `Screen locked` - `Run command` 에 관련 명령어를 추가해주자. 다음 내용의 스크립트를 사용하였다.

```sh
#!/bin/sh

sleep 2 && dbus-send --session --print-reply --dest=org.kde.kglobalaccel  /component/org_kde_powerdevil org.kde.kglobalaccel.Component.invokeShortcut string:'Turn Off Screen'
```


