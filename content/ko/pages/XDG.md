---
tags:
- freedesktop
title: XDG
categories:
date: 2023-10-21
lastMod: 2023-10-21
---
XDG는 Cross-Desktop Group의 acronym 이다. [#](https://www.freedesktop.org/wiki/)

### 트러블슈팅

#### 기본 브라우저 설정
현재 기본 브라우저가 뭔지 알아보자.
```sh
xdg-settings get default-web-browser
```

`org.mozilla.firefox.desktop`을 기본 브라우저로 설정해보자.
```sh
xdg-settings set default-web-browser org.mozilla.firefox.desktop
```

이는 다음 3개의 MIME의 기본값을 변경하는 행위와 같다.
```text
text/html=org.mozilla.firefox.desktop
x-scheme-handler/http=org.mozilla.firefox.desktop
x-scheme-handler/https=org.mozilla.firefox.desktop
```

`${XDG_CONFIG_HOME}/.mimeapps.list` 에서 확인할 수 있다.
