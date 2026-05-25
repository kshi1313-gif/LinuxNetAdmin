# NFS

NFS 파일 공유 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 `/etc/exports` 예시와 클라이언트 마운트 절차를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `nfs-utils` |
| 주요 설정 파일 | `/etc/exports` |
| 주요 서비스 | `nfs-server.service` |
| 방화벽 | `nfs`, `mountd`, `rpc-bind` |
| 클라이언트 마운트 | `mount -t nfs server:/share /mnt` |

## 확인 명령

```bash
exportfs -v
showmount -e <server-ip>
systemctl status nfs-server
mount -t nfs <server-ip>:/share /mnt
```
