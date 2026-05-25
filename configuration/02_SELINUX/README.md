# 02_SELINUX

SELinux 동작 모드를 설정하는 파일을 정리한 디렉토리입니다.

## 파일 구성

| 파일 | 설명 |
| --- | --- |
| `config` | `/etc/selinux/config` 예시입니다. 시스템 부팅 후 적용될 SELinux 모드를 지정합니다. |

## SELinux 모드

| 모드 | 설명 |
| --- | --- |
| `enforcing` | SELinux 정책을 강제로 적용합니다. 정책 위반 동작은 차단됩니다. |
| `permissive` | 정책 위반을 차단하지 않고 로그만 남깁니다. 문제 분석에 유용합니다. |
| `disabled` | SELinux를 비활성화합니다. |

## 확인 명령

```bash
getenforce
sestatus
cat /etc/selinux/config
```

`/etc/selinux/config` 변경은 재부팅 후 적용됩니다. 즉시 모드를 바꿀 때는 `setenforce 0` 또는 `setenforce 1`을 사용합니다.
