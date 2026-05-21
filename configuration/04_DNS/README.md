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
