# DHCP

DHCP 서버 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 `dhcpd.conf` 같은 설정 예시와 임대 범위 정보를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `dhcp-server` |
| 주요 설정 파일 | `/etc/dhcp/dhcpd.conf` |
| 주요 서비스 | `dhcpd.service` |
| 방화벽 | `dhcp`, UDP 67 |
| 검증 | 클라이언트 IP 임대 여부, `/var/lib/dhcpd/dhcpd.leases`, 로그 확인 |

## 예시 점검 명령

```bash
systemctl status dhcpd
firewall-cmd --list-all
journalctl -u dhcpd
```
