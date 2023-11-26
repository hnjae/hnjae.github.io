---
title: Btrfs
tags:
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
### tldr

#### 파일시스템 확장

[LVM]({{< ref "/pages/LVM" >}}) 아니면 GPT 단에서 파티션을 확장하여, 이에 맞춰 Btrfs를 확장할 필요가 있을 수 있다. 다음 커맨드를 이용하자.
```sh
btrfs filesystem resize max /path/to/mountpoint
```

`btrfs fs show /path/to/mountpoint` 로 크기가 변경되었음을 확인할 수 있다.

### `ENOSPC` 문제

`df` 와 같은 툴로 여유 공간을 확인 했음에도, `ENOSPC` 오류가 발생하여 작업을 못하는 경우가 있다. 개인적인 경험으로 이 문제는 주로 balance 문제이며, `btrfs balance` 를 실행하면 해결되었다.

Btrfs 는 데이터, 메타데이터, 시스템 3가지 종류의 블록으로 나눠 파일을 저장하는데, 이 문제는 주로 새 블록을 생성할 공간이 부족해서 생기는 문제이다. `btrfs balance` 는 아직 자료가 차지 않은 블록들을 합치는 역할을 수행한다. 이로서 새 블록을 만들 여유 공간을 확보할 수 있다. [참고 자료](https://unix.stackexchange.com/questions/377908/enospc-why-is-btrfs-balance-required-what-does-it-do)

다음 커맨드를 사용하자.

```sh
btrfs balance start -dusage=<percent> /path/to/mountpoints
```

* `-dusage=<percent>` 는 데이터 블록 중 `<percent>` 이하 만큼 찬 블록만 balance 를 하겠다는 의미이다. 높은 숫자를 잡을 경우 수행시간이 길어지니 작은 숫자로 먼저 시도해 보자.
* `-m` 옵션으로 메타데이터 블록도 balance 할 수 있지만 권장되지 않는다. balance는 안쓰는 공간을 다시 돌려주는 동작인데, 이걸 수행하면 메타데이터 공간이 부족해질 수 있다. 메타데이터 공간의 추후 확보가 불가능하면 Btrfs 는 read-only 모드로 돌아가고 이후 복구하기 매우 까다로워진다. [참고 링크](https://www.spinics.net/lists/linux-btrfs/msg90536.html)

처음 부터 `<percent>` 에 큰 숫자를 주면 `ENOSPC` 오류가 발생할 가능성이 높다. 개인적으로 `5` 부터 차근차근 올려가면서 시도하는 것을 권한다. 만일 `-dusage=1` 로 돌렸는데도 여유 공간이 없다며 동작을 안한다면, 파일을 삭제하여 조금이라도 여유 공간을 확보해야 한다.

※ `btrfs-balance` 는 `RAID` 시스템에서 각 블록디바이스간 데이터 쏠림을 조정하는 것이 주된 목적인 커맨드이다. 하지만 single-drive 에서도 이러한 이슈가 발생하니 주기적으로 `balance` 를 돌려주는 것이 좋았다.

### 같이보기
* https://github.com/kdave/btrfsmaintenance
