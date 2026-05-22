Firewall CMD

* 1.기본 영역 안 규칙 확인
 * - firewall-cmd --list-all

* 2. 지정된 서비스에 대한 포트/프로토콜 확인
 * - firewall-cmd --info-service=http

* 3. 서비스 등록 및 삭제
 * - firewall-cmd --permanent --add-service=http
 * - firewall-cmd --reload
 * - firewall-cmd --remove-service={http,https}

* 4. 포트 등록 및 삭제
 * - firewall-cmd --permanent --add-port={514/tcp,514/udp}
 * - firewall-cmd --permanent --remove-port={514/tcp.514/udp}


