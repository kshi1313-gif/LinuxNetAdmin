# firewall_basic

firewalld에서 가장 자주 사용하는 서비스/포트 등록, 삭제, 조회 명령을 정리한 메모입니다.

## 기본 확인

```bash
firewall-cmd --state
firewall-cmd --get-default-zone
firewall-cmd --list-all
```

## 서비스 정보 확인

```bash
firewall-cmd --get-services
firewall-cmd --info-service=http
```

## 서비스 등록과 삭제

```bash
firewall-cmd --permanent --add-service=http
firewall-cmd --permanent --add-service=https
firewall-cmd --reload

firewall-cmd --permanent --remove-service=http
firewall-cmd --reload
```

## 포트 등록과 삭제

```bash
firewall-cmd --permanent --add-port=514/tcp
firewall-cmd --permanent --add-port=514/udp
firewall-cmd --reload

firewall-cmd --permanent --remove-port=514/tcp
firewall-cmd --permanent --remove-port=514/udp
firewall-cmd --reload
```

## 확인 순서

1. 현재 zone과 적용 상태를 확인합니다.
2. 서비스 이름 또는 포트/프로토콜을 등록합니다.
3. `--reload` 후 `--list-all`로 결과를 검증합니다.
