---
title: LVM
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
### tldr

#### LV 확장
```sh
lvextend --size +200G volume_group/logical_volume
```

이후 파일시스템도 관련 커맨드로 LV 크기에 맞춰 확장하는 것이 필요하다. 일부 파일시스템 (아마도 ext4)는 `lvextend`에 `--resizefs` 옵션을 주어서 이를 자동으로 처리할 수 있다.

[Btrfs]({{< ref "/pages/Btrfs" >}})의 경우 해당 문서 참고.
