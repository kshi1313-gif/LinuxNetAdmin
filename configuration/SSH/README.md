# SSH

SSH 서버와 클라이언트 설정을 정리하기 위한 디렉토리입니다. 현재는 README만 있으며, 이후 `sshd_config`, 키 기반 인증, 보안 옵션을 추가할 수 있습니다.

## 정리하면 좋은 항목

| 항목 | 내용 |
| --- | --- |
| 패키지 | `openssh-server`, `openssh-clients` |
| 서버 설정 | `/etc/ssh/sshd_config` |
| 클라이언트 설정 | `~/.ssh/config` |
| 주요 서비스 | `sshd.service` |
| 방화벽 | `ssh`, TCP 22 |

## 확인 명령

```bash
systemctl status sshd
sshd -t
ssh <user>@<server-ip>
ssh-keygen
ssh-copy-id <user>@<server-ip>
```

운영 환경에서는 root 직접 로그인, 비밀번호 인증, 포트 변경, 접근 허용 대역을 별도로 점검하는 것이 좋습니다.
