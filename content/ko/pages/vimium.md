---
title: vimium
tags:
categories:
date: 2023-10-18
lastMod: 2023-10-19
---
vimium은 브라우저에 vim 바인딩을 지원하는 플러그인이다. 비슷한류의 다른 플러그인들(e.g. [tridactyl](https://github.com/tridactyl/tridactyl))와 달리 딥하지 않아, 가볍게 사용하기 좋다. 원본은 다크모드를 지원하지 않아서 변종인 [vimium-c](https://github.com/gdh1995/vimium-c)를 사용한다.

#### 설정

1. 기본 스크롤 스텝이 `100px` 인데, 답답해서 `120px`를 사용한다.

2. Characters used for link hints 를 누르기 편한키로 한정한다. 각 키별 누르는 effort는 [링크](https://colemakmods.github.io/mod-dh/model.html) 참조해서 적용.

3. [Firefox]({{< ref "/pages/Firefox" >}})의 새탭에서는 vimium이 작동하지 않아 답답하다. [NewTab Adapter](https://addons.mozilla.org/en-US/firefox/addon/newtab-adapter/?src=external-vc-readme) 플러그인을 설치하면, 새 탭에서도 vimium을 사용할 수 있다.

#### 단축키 관련

기본값으로 `C-d`, `C-u` 대신 `d`, `u`를 사용하는데, vim과 달라 어색하다.
 ```text
map <c-d> scrollPageDown
map <c-u> scrollPageUp
```

#### 한계

탭이 로딩 중일 때는 작동하지 않는다. 예전 세션을 복구하거나, 실수로 무거운 페이지를 열었을 경우 정말 답답하다.
