---
title: Btrfs
tags:
categories:
date: 2023-10-17
lastMod: 2023-10-18
---
### tldr

#### 파일시스템 확장

[LVM]({{< ref "/pages/LVM" >}}) 아니면 GPT 단에서 파티션을 확장하여, 이에 맞춰 Btrfs를 확장할 필요가 있을 수 있다. 다음 커맨드를 이용하자.
```sh
btrfs filesystem resize max /path/to/mountpoint
```

`btrfs fs show /path/to/mountpoint` 로 크기가 변경되었음을 확인할 수 있다.
