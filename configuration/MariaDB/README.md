# MariaDB

MariaDB 서버 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 데이터베이스 생성, 사용자 권한, 백업/복구 절차를 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `mariadb-server`, `mariadb` |
| 주요 서비스 | `mariadb.service` |
| 주요 설정 파일 | `/etc/my.cnf`, `/etc/my.cnf.d/*.cnf` |
| 기본 보안 | `mariadb-secure-installation` |
| 방화벽 | TCP 3306 |

## 확인 명령

```bash
systemctl status mariadb
mysql -u root -p
ss -tulnp | grep 3306
mysqldump --help
```
