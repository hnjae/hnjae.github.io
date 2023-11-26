---
tags:
- freedesktop
title: flatpak
categories:
date: 2023-11-26
lastMod: 2023-11-26
---
### Note

[Desktop Entry]({{< ref "/pages/Desktop Entry" >}})에서 `@@` 이 뜻하는 것

`--file-forwarding` 옵션이 주어졌을 때, `@@` 으로 둘러싸인 argument 는 파일 경로로 관주 된다. `@@u` 와 `@@` 으로 둘러싸인 argument 는 uri 로 관주된다.

<https://docs.flatpak.org/en/latest/flatpak-command-reference.html#flatpak-run>

### TIP

[Btrfs]({{< ref "/pages/Btrfs" >}})를 사용하고 있어, 임시 파일 경로인 `~/.cache` 는 평소에 subvolume으로 구분하고, NOCOW attribute 를 설정하여 사용하고 있다. 이렇게 하면 [snapper]({{< ref "/pages/snapper" >}}) 에서 스냅샷을 찍을 때 해당 경로가 제외되어 스냅샷 관리에 이점이 있다.

다만 flatpak 의 경우 `~/.cache` 경로 대신에 보통 `~/.var/app/app_name/cache` 경로를 사용한다. 이로 인해 캐시 파일에 NOCOW 가 적용되지 않고,  스냅샷에 캐시가 그대로 저장되게 된다.

해당 `cache` 경로를 삭제하고, subvolume 생성하며, NOCOW 적용하는 스크립트를 작성하여 해결 하였다.

```sh
#!/bin/sh

FLATPAK_DATA_PATH="${HOME}/.var/app"
TMPFILE=$(mktemp)

if [ ! -d "${FLATPAK_DATA_PATH}" ]; then
	echo "${FLATPAK_DATA_PATH} IS NOT DIRECTORY"
        rm "$TMPFILE"
	exit 1
fi

count=0
find "$FLATPAK_DATA_PATH" -maxdepth 1 -mindepth 1 ! -name "$(printf "*\n*")" \
	>"$TMPFILE"
while IFS= read -r dir; do
	if [ -h "${dir}/cache" ]; then
		echo "INFO: ${dir}/cache IS SYMBOLIC LINK"
		continue
	fi

	if [ ! -d "${dir}/cache" ]; then
		echo "INFO: ${dir}/cache IS NOT DIRECTORY"
		continue
	fi

        # check nocow attribute
	if lsattr "$dir" 2>/dev/null |
		grep -q -- "^---------------C------ ${dir}/cache\$"; then
		continue
	fi

	count=$((count + 1))
	rm -r "${dir}/cache" &&
		btrfs subvol create "${dir}/cache" >/dev/null &&
		chattr +C -R "${dir}/cache" &&
		echo "INFO: Recreating ${dir}/cache done" ||
		echo "ERROR: Recreating ${dir}/cache had issue"
done <"$TMPFILE"
rm "$TMPFILE"
echo "$count processed"
```
