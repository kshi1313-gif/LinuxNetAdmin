# 04_DNS

BIND 기반 DNS 서버 설정 파일 예시를 정리한 디렉토리입니다. `example.com`과 `192.168.10.0/24` 대역을 기준으로 정방향, 역방향 zone 예시가 포함되어 있습니다.

## 파일 구성

| 파일 | 설명 |
| --- | --- |
| `named.conf` | BIND 메인 설정 파일입니다. listen 주소, 질의 허용 범위, forwarder, logging, include, rndc control 예시가 포함되어 있습니다. |
| `named.rfc1912.zones` | zone 정의 파일입니다. localhost 기본 zone과 `example.com`, `test.com`, `10.168.192.in-addr.arpa` zone 예시가 포함되어 있습니다. |
| `named.ca` | root hint 또는 실습용 hint 파일 위치를 설명하기 위한 예시 파일입니다. |
| `example.zone` | `example.com` 정방향 zone 파일입니다. SOA, NS, A, MX 레코드 예시가 포함되어 있습니다. |
| `example.rev` | `192.168.10.0/24` 대역의 역방향 zone 파일입니다. PTR 레코드 예시가 포함되어 있습니다. |

## 주요 레코드

| 레코드 | 용도 |
| --- | --- |
| `SOA` | zone의 권한 시작 정보와 serial, refresh, retry 값을 정의합니다. |
| `NS` | zone을 담당하는 네임서버를 지정합니다. |
| `A` | 호스트 이름을 IPv4 주소로 매핑합니다. |
| `MX` | 메일 서버 우선순위와 호스트를 지정합니다. |
| `PTR` | IP 주소를 호스트 이름으로 역방향 매핑합니다. |

## 검증 명령

```bash
named-checkconf /etc/named.conf
named-checkzone example.com /var/named/example.zone
named-checkzone 10.168.192.in-addr.arpa /var/named/example.rev
systemctl restart named
dig @localhost example.com
dig @localhost -x 192.168.10.10
```

운영 환경에 적용할 때는 `named.conf`의 rndc key, allow-query, controls, IP, 도메인 값을 반드시 환경에 맞게 변경하세요.
