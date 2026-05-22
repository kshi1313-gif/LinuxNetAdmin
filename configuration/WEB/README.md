WEB Server 
* 1. 주 설정 파일
*  -> /etc/httpd/conf/httpd.conf
*  -> /etc/httpd/conf.d/*.conf

* 2. 보조 설정 파일
*  -> /var/www/html/*

* 3. WEB Server 로그 파일
*  -> /etc/httpd/logs

--------------------------------------------------------------------------

파일 분석
* 1. httpd.conf
*	-> Listen 80		: 웹서버 listen 포트 지정
*	-> DocumentRoot		: 웹서비스 소스 디렉토리
*	-> DirectoryIndex	: 웹 기본 파일 설정
*	-> CustomLog		: 로그 파일
*	-> ScriptAlias		: 스크립트 엘리어스 설정
*	-> IncludeOptional	: 추가적인 설정 파일 포함
