# 00_files

시스템 공통 설정 파일 예시를 보관하는 디렉토리입니다.

## 파일 구성

| 파일 | 설명 |
| --- | --- |
| `fstab` | 부팅 시 자동 마운트할 파일 시스템 정보를 정리하는 `/etc/fstab` 예시입니다. LVM, RAID, SWAP, SMB, NFS 마운트 예시가 주석으로 포함되어 있습니다. |

## fstab 작성 메모

- 실제 장치명은 환경마다 달라질 수 있으므로 가능하면 `blkid`로 확인한 UUID를 사용하는 것이 안전합니다.
- 편집 후에는 재부팅 전에 `mount -a`로 문법과 마운트 가능 여부를 확인하세요.
- 잘못된 `/etc/fstab` 설정은 부팅 문제를 만들 수 있으므로 원본을 먼저 백업하세요.

## 확인 명령

```bash
blkid
findmnt
mount -a
systemctl daemon-reload
```
