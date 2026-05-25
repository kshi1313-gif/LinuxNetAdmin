# 03_FIREWALL

firewalld 기본 사용법과 rich rule 예시를 정리한 디렉토리입니다.

## 구성

| 경로 | 설명 |
| --- | --- |
| `firewall_basic/` | 서비스와 포트 등록, 삭제, 조회 같은 기본 `firewall-cmd` 사용법입니다. |
| `firewall_RichRule/` | 출발지 IP, 포트 포워딩, masquerade, log, reject/drop, accept 등 rich rule 예시입니다. |

## 관련 도구

```bash
firewall-cmd --state
firewall-cmd --list-all
firewall-config &
```

설정 변경 시 영구 적용 옵션인 `--permanent`를 사용했다면 `firewall-cmd --reload`로 다시 불러와야 합니다.
