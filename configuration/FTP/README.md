# FTP

FTP 서버 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 `vsftpd.conf`, 사용자 제한 파일, 업로드 테스트 절차를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `vsftpd`, `ftp` |
| 주요 설정 파일 | `/etc/vsftpd/vsftpd.conf` |
| 사용자 제한 파일 | `/etc/vsftpd/ftpusers`, `/etc/vsftpd/user_list` |
| 주요 서비스 | `vsftpd.service` |
| 방화벽 | `ftp`, TCP 21 |

## 확인 명령

```bash
systemctl status vsftpd
firewall-cmd --add-service=ftp --permanent
firewall-cmd --reload
ftp localhost
```

익명 접속, 로컬 사용자 접속, chroot 설정은 보안 영향이 있으므로 실습 목적과 운영 목적을 구분해서 기록하세요.
