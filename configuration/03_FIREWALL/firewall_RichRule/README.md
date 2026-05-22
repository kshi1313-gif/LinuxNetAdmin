firewall 고급규칙
* 1. PortForwarding 규칙
* 2. Masquerade 규칙
* 3. Log, Audit 규칙 -> 로깅 규칙
* 4. Reject/Drop 규칙 -> 거부 규칙
* 5. Accept 규칙
----------------------------------------------------------
규칙 사용 예시

* firewall-cmd --permanent --add-rich-rule='rule family=ipv4 source address=192.168.10.10/32 reject'
* firewall-cmd --permanent --add-rich-rule='rule family'
