---
tags:
- Logseq
title: Logseq
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
## 개요


![logseq-sample.webp](/assets/logseq-sample_1697191058214_0.webp)

Logseq 은 오픈소스 PKM(Personal Knowledge Management) 시스템이다. markdown 만 지원하는 여타 PKM 과 다르게 org 로 파일을 작성할 수 있다.

오픈소스/프리 프로젝트이지만 추후 유료화할 가능성도 있는 것 같다.
* https://discuss.logseq.com/t/what-is-logseqs-business-model/389/6
* https://blog.logseq.com/logseq-raises-4-1m-to-accelerate-growth-of-the-new-world-knowledge-graph/

## 설치·실행 방법


### 설치 방법:

Arch 와 같은 롤링 릴리즈 배포판이 아니라면, [flatpak]({{< ref "/pages/flatpak" >}}) 을 이용하는 것이 가장 편하고 빠른 방법 같다.

``` bash
flatpak install com.logseq.Logseq
```

### 실행 방법:

v0.9.18 (2023년 10월) 기준, 기본적으로 wayland 환경에서도 X 서버에서 실행된다.

다음 커맨드로 wayland native 하게 실행할 수 있다.
``` bash
flatpak run com.logseq.Logseq --enable-wayland-ime --ozone-platform-hint=auto --enable-features=UseOzonePlatform,WaylandWindowDecorations
```

편하게 사용하기 위해 따로 desktop 파일을 작성해서 항상 위 커맨드로 실행할 수 있도록 하자.

[`${XDG_DATA_HOME}/application/com.logseq.Logseq.desktop`]([Desktop Entry]({{< ref "/pages/Desktop Entry" >}}))  에 다음 내용을 추가한다.

``` desktop
[Desktop Entry]
Name=Logseq Desktop
Exec=flatpak run --file-forwarding com.logseq.Logseq --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform-hint=auto --enable-wayland-ime @@u %U @@
Terminal=false
Type=Application
Icon=com.logseq.Logseq
StartupWMClass=Logseq
Comment=Run Logseq with custom flags.
MimeType=x-scheme-handler/logseq;
Categories=Utility;office;
NoDisplay=false
Actions=Wayland;
X-Flatpak=com.logseq.Logseq
```

이 옵션으로 [KDE]({{< ref "/pages/KDE" >}}) 5.27 Wayland 세션, fcitx5, [NixOS]({{< ref "/pages/NixOS" >}}) 23.05 환경에서 아무런
문제 없이 한글 입력이 됨을 확인하였다.

## 장단점


### 장점:
* 러닝 커브가 정말 낮다. 대체제인 org-roam은 emacs를 사용한다는 것 부터 난이도가 있는데, 그러한 것이 없다.
* GUI 앱이라, org-roam 보다 영상·이미지 처리 등의 유리.
* 유명한 서지 시스템인 zotero 랑 연동하는 것도 가능해 보임.
* electron 앱이지만, wayland 리눅스에서 HiDPI, 한글 입력등에서 큰 문제가 발생하지 않는다.
* VIM-Shortcut 플러그인의 IME 대응이 훌륭하다.
  * IME가 한글 입력 모드이고, VIM-Shrotcut이 Normal 모드일 때 정상적으로 작동한다. 이게 안되는 앱들이 많아 결국 VIM으로 돌아가고는 하는데, 그러한 문제가 없어서 반갑다.
  * 다만 vim 처럼 문자 단위 조작을 할 수 있지는 않다. "텍스트 블록" 단위로 조작하게 된다.

### 단점:
v0.9.18; NixOS 23.05; fcitx5; KDE 5.27 Wayland 세션 기준

* xwayland 위에서 돌렸을 때, 한글 입력 버그가 있다. 세벌식에서 여는 괄호 `(` 를 입력할 때, `[` 가 입력되는 버그가 있다. 대괄호 입력은 IME가 아니라 키 시퀀스 자체에서 읽는 건가?
* wayland native 으로 돌렸을 때, 일본어 입력이 안된다.
* org가 파일 포맷으로 지정되었음에도 각종 구문에서 markdown 포맷이랑 뒤섞이는 모습이 보인다. 예를 들어 `/code block` 을 호출 하였을 경우 org 구문인 `#+begin_src ` 이 입력되지 않는다. (v0.9.18)

## org vs markdown


Logseq 에서는 `org`, `markdown` 두가지 포맷을 지원하는데, `org` 포맷에는 여러 이슈가 있어 `markdown` 을 사용하는 것이 더 나아보인다.

2020년 10월에 Logseq 내부에서는 `org` 와 `markdown` 이 동등하게 취급된다고 하였는데, [#](https://discuss.logseq.com/t/advantages-to-using-org-vs-markdown/49/2) 현황은 그러하지 않는 것 같다.

`org` 사용시 다음의 이슈를 확인하였다.
* Export as standard Markdown 기능이 `org` 에서는 지원되지 않음 (v0.9.18)
* Syntax 준수 이슈
  * `org` 에서는 `*` 로 heading 을 지정하는데, Logseq에서는 문서 내 프로퍼티로 헤딩을 지정한다.
    * 이 프로퍼티는 Logseq  에디터에서는 보이질 않아, 헤딩을 변경하거나 삭제하기 까다롭다.
  * `org`의 `*`기능을 그냥 bullet list 처럼 사용하고 있어, `org` 로서 가치가 떨어진다.
* 몇 플러그인이 `org` 는 지원하지 않는 듯 한 모습이 보임 e.g.) <https://github.com/sawhney17/logseq-schrodinger>

## Publish


Logseq은  작성한 문서를 publish 하는 것을 공식적으로 지원한다 [#](https://github.com/logseq/publish-spa). 이걸로 배포하면 마치 Logseq 앱을 read-only 모드로 보는 것 같은 느낌이 나는데, 내가 원하는 배포 형태가 아니다.

다행히도 Logseq 문서를 Hugo로 export 를 도와주는 플러그인이 있다. [git:sawhney17/logseq-schrodinger](https://github.com/sawhney17/logseq-schrodinger) 다만 Logseq는 기본적으로 outliner 라서, Hugo로 배포시 레이아웃이 깨져 정말 읽기 힘든 문서가 된다.

예를 들어 이 문서가  
![logseq-publish-in-app.webp](/assets/logseq-publish-in-app_1697186474419_0.webp)

이렇게 보인다.
![logseq-publish-hugo.webp](/assets/logseq-publish-hugo_1697186477023_0.webp)

다음의 원칙을 지키면 그나마 읽기 편한 문서가 되는 것 같다.

* Hugo 로 배포시 인덴트 되어 보이는 모든 블록이 flat 하게 바뀜을 인지하고 문서를 작성하자.
* 플러그인 옵션 `bulletHandling` 을 `Remove All Bullets`으로 바꾸자.
* 위의 옵션을 껐으므로, Logseq의 블록을 Unordered list 라고 생각하면 안된다. Unordered list 는 `*` 로 블록 내에서 사용하자.
* 블록 구분을 위해서 heading 을 적극적으로 써야한다. (Hugo로 배포하면 Logseq에서 보는 것 처럼 블록 인덴트가 생기지 않기 때문에)

Logseq 에서 Hugo 를 고려하여 잘 작성한 문서의 예: <https://aryansawhney.com/pages/the-ultimate-guide-to-aliases-in-logseq/>

## 관련 링크
* <https://discuss.logseq.com/>
* <https://github.com/WhiskeyJack96/logseqlsp>
* <https://docs.logseq.com/#/page/advanced%20commands>
