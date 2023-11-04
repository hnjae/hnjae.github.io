---
tags:
- freedesktop
title: Desktop Entry
categories:
date: 2023-10-18
lastMod: 2023-10-18
---
### 옵션

#### `Exec` 옵션

<https://specifications.freedesktop.org/desktop-entry-spec/latest/ar01s07.html>
* `%u`: A single URL
* `%U`: A list of URLs

### Misc

#### 메뉴에서 숨기기

`$XDG_DATA_HOME/applications/app-name.desktop` 에 다음 내용을 기재하면 보이지 않는다.
```desktop
[Desktop Entry]
NoDisplay=true
Exec=:
```

※ Desktop Entry Spec에 `Hidden` 이라는 키가 있어 헷갈리기 쉽다. `Hidden=true` 로 하면 해당 desktop 파일은 무시되는 걸로 보인다. 그래서 `Hidden`은 별도로 기재하지 않거나, `Hidden=false` 로 작성해야한다.

※ Spec에 `Exec` 키는 분명히 `REQUIRED` 가 `NO`로 되어 있지만, `Exec` 값이 없으면 해당 desktop 파일은 무시되므로 기재해야한다.

### 관련 문서
* https://specifications.freedesktop.org/desktop-entry-spec/desktop-entry-spec-latest.html
* https://wiki.archlinux.org/title/desktop_entries
* https://develop.kde.org/docs/features/desktop-file/
