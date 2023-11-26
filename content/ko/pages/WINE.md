---
title: WINE
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
WINE을 사용할 경우, [Bottles](https://github.com/bottlesdevs/Bottles) 를 활용하는 것이 것이 정말 편리한 방법이다. 여러 버전의 와인과 용도별 `WINEPREFIX`를 쉽게 구분하여 사용할 수 있다. 그리고 `$HOME` 에 알 수 없는 WINE 설정 파일을 남기지 않아 심적으로도 좋다.

※ 참고: Bottles의 개발자들은 [flatpak]({{< ref "/pages/flatpak" >}}) 버전으로 설치하기를 강력 권고 하고 있다. 귀찮은 트러블 슈팅을 피하려면 flatpak을 사용하는 것이 좋다.

## 한글 관련

### 한글 표기

#### 로케일 설정

`LANG=ko_KR.UTF-8` 를 적용하거나, Bottles 의 언어 설정에서 설정하면, 한글이 정상적으로 표시된다. 일부 영어 폰트를 사용하는 곳이, 한글 폰트를 사용하도록 변경되는 것으로 보인다.

그러나 내 환경에서는 위 설정을 할 경우, 불분명한 이유로 한글 입력이 되질 않는다··! (fcitx5, [KDE]({{< ref "/pages/KDE" >}}) 5.27.9).

#### 한글 폰트 설정

WINE 에서는 맑은 고딕과 굴림체가 기본적으로 제공되지 않는 것 같다. [이 링크]( https://moordev.tistory.com/336)에서 제공하는 가짜 맑은 고딕과 굴림을 설치하면 해당 글꼴의 텍스트를 볼 수 있다. `gulim.ttc` 및 `malgun.ttf` 파일을 `drive_c/windows/Fonts` 디렉토리에 넣어 설치할 수 있다.

또한, 다음 레지스트리 설정을 통해 `MS Shell Dlg`의 폰트를 다른 폰트로 지정하니, 한글이 잘 표시되었다.

```reg
[Software\Microsoft\Windows NT\CurrentVersion\FontSubstitutes]
"MS Shell Dlg"="Pretendard"
```

### 한글 입력

별도의 설정 없이 OUT OF BOX 로 한글 입력이 잘 되었다.

Notepad2 같은 프로그램으로 한글 입력을 테스트하는 것이 가장 간단하다.

한글 입력이 제대로 되지 않을 경우, 다음 레지스트리 설정을 통해 해결할 수 있다고 한다. (테스트 미실시)
* `HKEY_CURRENT_USER\Software\Wine\X11 Driver` 의 값을 `root` 로 설정
* `HKEY_CURRENT_USER\Software\Wine\UseXIM` 의 값을 `y` 로 설정

## 트러블 슈팅

### 카카오톡

Bottles 에서 설치할 경우, "빠른 실행에 바로가기 등록"을 켜야 Bottles 에서 자동으로 인식을 한다. (v51.9; 2023-11-22)

카카오톡의 경우 Virtual Desktop 옵션을 활성화해야 정상적으로 사용할 수 있었다. 카카오톡 창이 내부적으로는 3개의 창을 겹쳐 띄우는 방식인 것으로 보인다. 컨텐츠 창, 그림자를 띄우는 창, 등이 구분되어 있어 Virtual Desktop 옵션을 비활성화하면, 윈도우 매니저에 창이 3개가 등록되어 동작이 이상해진다.

![kakaotalk-20231122.webp](/assets/kakaotalk-20231122_1700636285181_0.webp)

`DXVK`, `VKD3D` 와 같은 그래픽 설정을 완료해야 카카오톡 이모지가 정상적으로 작동한다.

## 같이 보기

https://wiki.winehq.org/Useful_Registry_Keys
