# firewall_RichRule

firewalld rich rule은 출발지, 목적지, 서비스, 포트, 로그, 허용/거부 동작을 세밀하게 지정할 때 사용합니다.

## 주요 규칙 유형

| 유형 | 설명 |
| --- | --- |
| Port Forwarding | 특정 포트로 들어온 트래픽을 다른 포트나 주소로 전달합니다. |
| Masquerade | NAT 환경에서 내부 주소를 외부 인터페이스 주소로 변환합니다. |
| Log/Audit | 특정 트래픽을 로그 또는 audit 기록으로 남깁니다. |
| Reject/Drop | 트래픽을 거부하거나 조용히 폐기합니다. |
| Accept | 조건에 맞는 트래픽을 허용합니다. |

## 예시

```bash
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.10.10/32 reject'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.10.0/24 service name=http accept'
firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.10.0/24 port port=22 protocol=tcp accept'
firewall-cmd --reload
```

## 확인 명령

```bash
firewall-cmd --list-rich-rules
firewall-cmd --list-all
```

rich rule은 조건이 구체적일수록 운영 정책을 명확하게 표현할 수 있지만, 중복 규칙이 생기면 분석이 어려워집니다. 변경 전후 규칙 목록을 기록해 두는 것이 좋습니다.
