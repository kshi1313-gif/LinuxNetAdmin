# MAIL

메일 서버 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 Postfix, Dovecot, mailx 테스트 절차를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| MTA | `postfix` |
| 수신 서버 | `dovecot` |
| 클라이언트 테스트 | `mailx` |
| 주요 설정 파일 | `/etc/postfix/main.cf`, `/etc/dovecot/dovecot.conf` |
| 주요 로그 | `/var/log/maillog` |
| 방화벽 | SMTP 25, POP3 110, IMAP 143, 필요 시 SMTPS/IMAPS |

## 확인 명령

```bash
systemctl status postfix
systemctl status dovecot
tail -f /var/log/maillog
mailx user@example.com
```
