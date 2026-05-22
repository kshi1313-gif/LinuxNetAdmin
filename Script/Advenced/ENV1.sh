#!/bin/bash

# WEB Service
# * 패키지 설치 : httpd, mod_ssl
# * 서비스 설정 : 
#       - /etc/httpd/conf/httpd.conf, 
#       - /etc/httpd/conf.d/*.conf
#       - /var/www/html*
# * 서비스 기동 : httpd.service
# * 방화벽 등록 : http(80/tcp), https(443/tcp)
#
# 프로그램이 실행되다가 실패하면 거기서 종료됨 더이상 진행되지 않음
source $HOME/bin/function.sh

set -e

echo "[ INFO ]: ENV1.sh"
echo "[Phase 01]: 패키지 설치 - httpd, mod_ssl"
yum install -q -y $pkg_web >/dev/null 2>&1

echo "[Phase 02]: 서비스 설정 - /var/www/html/index.html"
echo WEB > $indexfile

echo "[Phase 03]: 서비스 기동 - httpd.service"
systemctl enable --now $svc_web >/dev/null 2>&1
