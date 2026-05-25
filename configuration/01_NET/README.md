# 01_NET

Linux 네트워크 기본 설정 파일을 정리한 디렉토리입니다.

## 파일 구성

| 파일 | 설명 |
| --- | --- |
| `hosts` | 로컬 이름 해석을 위한 `/etc/hosts` 예시입니다. `main`, `server1`, `server2` 호스트 매핑이 포함되어 있습니다. |
| `resolv.conf` | DNS 검색 도메인과 네임서버를 지정하는 `/etc/resolv.conf` 예시입니다. |

## 관련 도구

- `nmcli`: NetworkManager CLI
- `nmtui`: 텍스트 기반 네트워크 설정 UI
- `nm-connection-editor`: GUI 기반 네트워크 설정 도구
- `ip addr`, `ip route`: IP와 라우팅 확인

## 확인 명령

```bash
cat /etc/hosts
cat /etc/resolv.conf
nmcli dev status
ip addr
ip route
```
