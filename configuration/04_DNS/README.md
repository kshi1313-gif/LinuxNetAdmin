DNS Server Configuration
1. named.conf
 의미 : Named DNS Service 전역설정파일 
 내용 :  
 	-Ipv4, Ipv6 IP 대역 설정
	-Iclude 설정 (보조설정파일 경로 지정)

2. namad.rfc1912.zones
의미 : Named DNS Service 보조 설정파일 
	- Forwarding DNS Service 설정 진행
		-> zone 파일 권한 및 경로 지정
		-> rev 파일 권한 및 경로 지정
3. named.ca
의미 : DNS Server 확인에 필요한 힌트파일 -> 정확한 의미 확인 필요

4. example.zone
의미 : DNS Forwarding Server 구성할때 사용한 정방향 레코드 정보 파일
	- NS
	- A
	- MX
	- SOA

5. example.rev
의미 : DNS Server 동일한 구성할대 사용한 역방향 레코드 정보 파일
	- NS
	- PTR
	- SOA

정방향, 역방향 레코드 정보에 대한 내용 확인 필요 추가로 더 있는지
-------------------------------------------------------------------
