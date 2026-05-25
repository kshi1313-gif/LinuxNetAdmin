# WEB

Apache HTTPD 기반 웹 서버 설정을 정리하기 위한 디렉토리입니다.

## 주요 경로

| 경로 | 설명 |
| --- | --- |
| `/etc/httpd/conf/httpd.conf` | Apache 메인 설정 파일입니다. |
| `/etc/httpd/conf.d/*.conf` | 가상 호스트, SSL 등 추가 설정 파일을 배치하는 경로입니다. |
| `/var/www/html/` | 기본 DocumentRoot입니다. 웹 콘텐츠를 배치합니다. |
| `/etc/httpd/logs/` | 접근 로그와 오류 로그 위치입니다. 배포판에 따라 `/var/log/httpd/`로 연결될 수 있습니다. |

## httpd.conf 주요 항목

| 항목 | 설명 |
| --- | --- |
| `Listen` | 웹 서버가 대기할 포트입니다. 기본값은 80입니다. |
| `DocumentRoot` | 웹 콘텐츠의 기본 디렉토리입니다. |
| `DirectoryIndex` | 디렉토리 접근 시 기본으로 보여 줄 파일입니다. 보통 `index.html`입니다. |
| `CustomLog` | 접근 로그 파일과 로그 형식을 지정합니다. |
| `ErrorLog` | 오류 로그 파일을 지정합니다. |
| `ScriptAlias` | CGI 스크립트 경로를 매핑합니다. |
| `IncludeOptional` | 추가 설정 파일을 포함합니다. |

## 확인 명령

```bash
httpd -t
systemctl restart httpd
systemctl status httpd
firewall-cmd --add-service=http --permanent
firewall-cmd --reload
curl http://localhost
```
