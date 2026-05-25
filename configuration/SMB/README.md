# SMB

Samba 기반 Windows/Linux 파일 공유 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 `smb.conf`, 공유 디렉토리, 사용자 매핑 예시를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `samba`, `samba-client` |
| 주요 설정 파일 | `/etc/samba/smb.conf` |
| 주요 서비스 | `smb.service`, `nmb.service` |
| 방화벽 | `samba` |
| 사용자 등록 | `smbpasswd -a <user>` |

## 확인 명령

```bash
testparm
systemctl status smb nmb
smbclient -L //<server-ip> -U <user>
```
