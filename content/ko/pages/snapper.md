---
title: snapper
tags:
categories:
date: 2023-10-17
lastMod: 2023-10-17
---
[snapper](https://github.com/openSUSE/snapper)은 파일 시스템 스냅샷을 관리하는 툴이다. [Btrfs]({{< ref "/pages/Btrfs" >}})의 snapshot 기능을 활용할 수 있다.

## 복구하기

실수로 `rm -rf *` 로 모든 파일을 지워버렸다. 복구해보자.

#### 복구할 스냅샷 찾기

```shell
snapper list-configs # 필요한 config_name 찾기
snapper -c config_name list
```

다음과 같은 표가 출력될 것이다.

```text
   # | Type   | Pre # | Date                     | User | Cleanup  | Description | Userdata
-----+--------+-------+--------------------------+------+----------+-------------+---------
  0  | single |       |                          | root |          | current     |         
180  | single |       | Wed 11 Oct 2023 00:00:00 | root | timeline | timeline    |         
204  | single |       | Thu 12 Oct 2023 00:00:00 | root | timeline | timeline    |         
228  | single |       | Fri 13 Oct 2023 00:00:01 | root | timeline | timeline    |         
252  | single |       | Sat 14 Oct 2023 00:00:00 | root | timeline | timeline    |         
276  | single |       | Sun 15 Oct 2023 00:00:01 | root | timeline | timeline    |         
```

원하는 스냅샷의 숫자를 메모하자.

#### 복구하기

기본 아이디어: snapper 가 찍은 스냅샷의 스냅샷을 찍고, 이를 기존 서브볼륨 경로에 둔다.

1. 해당 서브볼륨을 사용하는 모든 프로세스를 종료한다. 만약 `/home`, `/` 와 같이 모든 프로세스를 종료 못하는 파티션이면, 시스템을 종료하고, 타 볼륨을 쓰는 OS로(e.g. Live CD 같은 것)으로 부팅할 것.

2. 해당 서브볼륨의 부모 볼륨을 안쓰는 경로에 마운트

3. [Btrfs]({{< ref "/pages/Btrfs" >}}) 의 서브볼륨은 평범한 디렉토리 처럼 취급할 수 있다. 해당 서브볼륨의 이름이 `foo` 라고 하면, 다음과 같은 절차로 복구할 수 있다.

```sh
mv foo foo2
btrfs subvol snapshot foo2/.snapshots/snapshot_number/snapshot foo
mv foo2/.snapshots foo/
```

#### 주의점

새로 서브볼륨을 만들어 재배치 했으므로, 서브볼륨의 `subvolid`가 변경되었다. 만약 `/etc/fstab`나 기타 설정에서 이를 참조하고 있다면 변경해주자.
