#!/bin/bash

# ==========================================================
# webserver.sh
# Apache(httpd)와 Nginx 중 하나만 선택해서 실행하는 스크립트
#
# 사용법:
#   sudo ./webserver.sh httpd
#   sudo ./webserver.sh nginx
#   sudo ./webserver.sh status
#
# 동작 방식:
#   ./webserver.sh httpd  -> nginx 중지, httpd 설치/기동
#   ./webserver.sh nginx  -> httpd 중지, nginx 설치/기동
# ==========================================================

set -e

HTTPD_INDEX="/var/www/html/index.html"
NGINX_INDEX="/usr/share/nginx/html/index.html"

# ----------------------------------------------------------
# root 권한 확인
# ----------------------------------------------------------
check_root() {
    if [ "$EUID" -ne 0 ]; then
        echo "[ERROR] root 권한으로 실행해야 합니다."
        echo "예시: sudo ./webserver.sh httpd"
        exit 1
    fi
}

# ----------------------------------------------------------
# 패키지 설치 확인 및 설치
# ----------------------------------------------------------
install_package() {
    local pkg="$1"

    if rpm -q "$pkg" &>/dev/null; then
        echo "[OK] $pkg 패키지가 이미 설치되어 있습니다."
    else
        echo "[INFO] $pkg 패키지를 설치합니다."

        if command -v dnf &>/dev/null; then
            dnf install -y "$pkg"
        elif command -v yum &>/dev/null; then
            yum install -y "$pkg"
        else
            echo "[ERROR] dnf 또는 yum 명령어를 찾을 수 없습니다."
            exit 1
        fi

        echo "[OK] $pkg 설치 완료"
    fi
}

# ----------------------------------------------------------
# Apache index.html 생성
# ----------------------------------------------------------
create_httpd_index() {
    mkdir -p /var/www/html

    cat > "$HTTPD_INDEX" <<'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Apache HTTPD Test Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            text-align: center;
            padding-top: 80px;
        }
        .box {
            display: inline-block;
            background-color: white;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
        }
        h1 {
            color: #d35400;
        }
        p {
            font-size: 18px;
        }
        .service {
            font-weight: bold;
            color: #c0392b;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>Apache HTTPD Web Service</h1>
        <p>현재 실행 중인 웹 서비스는 <span class="service">Apache HTTPD</span> 입니다.</p>
        <p>DocumentRoot: /var/www/html</p>
        <p>Test File: /var/www/html/index.html</p>
    </div>
</body>
</html>
EOF

    echo "[OK] Apache index.html 생성 완료: $HTTPD_INDEX"
}

# ----------------------------------------------------------
# Nginx index.html 생성
# ----------------------------------------------------------
create_nginx_index() {
    mkdir -p /usr/share/nginx/html

    cat > "$NGINX_INDEX" <<'EOF'
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>Nginx Test Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #eef7ff;
            text-align: center;
            padding-top: 80px;
        }
        .box {
            display: inline-block;
            background-color: white;
            padding: 40px 60px;
            border-radius: 15px;
            box-shadow: 0 0 15px rgba(0,0,0,0.15);
        }
        h1 {
            color: #2980b9;
        }
        p {
            font-size: 18px;
        }
        .service {
            font-weight: bold;
            color: #2471a3;
        }
    </style>
</head>
<body>
    <div class="box">
        <h1>Nginx Web Service</h1>
        <p>현재 실행 중인 웹 서비스는 <span class="service">Nginx</span> 입니다.</p>
        <p>DocumentRoot: /usr/share/nginx/html</p>
        <p>Test File: /usr/share/nginx/html/index.html</p>
    </div>
</body>
</html>
EOF

    echo "[OK] Nginx index.html 생성 완료: $NGINX_INDEX"
}

# ----------------------------------------------------------
# Apache 실행 함수
# ----------------------------------------------------------
start_httpd() {
    echo "========================================"
    echo "[MODE] Apache HTTPD 실행 모드"
    echo "========================================"

    install_package "httpd"

    echo "[INFO] Nginx 서비스를 중지합니다."
    systemctl stop nginx 2>/dev/null || true
    systemctl disable nginx 2>/dev/null || true

    create_httpd_index

    echo "[INFO] Apache HTTPD 서비스를 실행합니다."
    systemctl enable --now httpd

    echo
    echo "[RESULT] Apache HTTPD 실행 완료"
    echo

    systemctl is-active --quiet httpd \
        && echo "[OK] httpd 서비스가 정상 실행 중입니다." \
        || echo "[FAIL] httpd 서비스 실행 상태를 확인해야 합니다."

    echo
    echo "[CHECK] 접속 테스트 명령어:"
    echo "curl http://localhost"
}

# ----------------------------------------------------------
# Nginx 실행 함수
# ----------------------------------------------------------
start_nginx() {
    echo "========================================"
    echo "[MODE] Nginx 실행 모드"
    echo "========================================"

    install_package "nginx"

    echo "[INFO] Apache HTTPD 서비스를 중지합니다."
    systemctl stop httpd 2>/dev/null || true
    systemctl disable httpd 2>/dev/null || true

    create_nginx_index

    echo "[INFO] Nginx 서비스를 실행합니다."
    systemctl enable --now nginx

    echo
    echo "[RESULT] Nginx 실행 완료"
    echo

    systemctl is-active --quiet nginx \
        && echo "[OK] nginx 서비스가 정상 실행 중입니다." \
        || echo "[FAIL] nginx 서비스 실행 상태를 확인해야 합니다."

    echo
    echo "[CHECK] 접속 테스트 명령어:"
    echo "curl http://localhost"
}

# ----------------------------------------------------------
# 서비스 상태 확인
# ----------------------------------------------------------
show_status() {
    echo "========================================"
    echo "[STATUS] Web Service 상태 확인"
    echo "========================================"

    echo
    echo "[Apache HTTPD]"
    if systemctl is-active --quiet httpd; then
        echo "active"
    else
        echo "inactive"
    fi

    echo
    echo "[Nginx]"
    if systemctl is-active --quiet nginx; then
        echo "active"
    else
        echo "inactive"
    fi

    echo
    echo "[Port 80 사용 상태]"
    ss -tulnp | grep ':80' || echo "80번 포트를 사용하는 서비스가 없습니다."
}

# ----------------------------------------------------------
# 사용법 출력
# ----------------------------------------------------------
usage() {
    echo "사용법:"
    echo "  sudo ./webserver.sh httpd     # Apache 실행, Nginx 중지"
    echo "  sudo ./webserver.sh nginx     # Nginx 실행, Apache 중지"
    echo "  sudo ./webserver.sh status    # 현재 상태 확인"
    echo
    echo "예시:"
    echo "  sudo ./webserver.sh httpd"
    echo "  sudo ./webserver.sh nginx"
}

# ----------------------------------------------------------
# Main
# ----------------------------------------------------------
check_root

case "$1" in
    httpd|apache)
        start_httpd
        ;;
    nginx)
        start_nginx
        ;;
    status)
        show_status
        ;;
    *)
        usage
        exit 1
        ;;
esac