# NTP

시간 동기화 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 Chrony 서버/클라이언트 설정 예시를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `chrony` |
| 주요 설정 파일 | `/etc/chrony.conf` |
| 주요 서비스 | `chronyd.service` |
| 방화벽 | NTP, UDP 123 |
| 확인 | `chronyc sources`, `timedatectl` |

## 확인 명령

```bash
systemctl status chronyd
chronyc sources -v
chronyc tracking
timedatectl
```
