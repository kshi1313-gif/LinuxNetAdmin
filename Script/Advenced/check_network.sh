#!/bin/bash

source $HOME/bin/functions.sh

# 1) ping 192.168.10.2
# 2) ping 8.8.8.8
# 3) ping www.google.com

IP1=192.168.10.2
IP2=8.8.8.8
IP3='www.google.com'

print_info "네트워크 점검 시작"
print_info "[Phase 01] ping $IP1"
ping -c 1 -W 1 $IP1 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "Local Network Connection"
else
    print_error "Local Network Connection"
    cat <<'EOF'
    (ㄱ) VMware >  Edit > Virtual Network Editor
    (ㄴ) VMware > VM > Settings > Network Adapter
    (ㄷ) # ip addr
EOF
fi
echo

print_info "[Phase 02] ping $IP2"
ping -c 1 -W1 $IP2 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "External Network Connection"
else
    print_error "External Network Connection"
    cat <<'EOF'
    (ㄱ) # ip route
EOF
fi
echo

print_info "[Phase 03] ping $IP3"
ping -c 1 -W 1 $IP3 >/dev/null 2>&1
if [ $? -eq 0 ]; then
    print_good "DNS Client Connection"
else
    print_error "DNS Client Connection"
    cat <<'EOF'
    (ㄱ) # cat /etc/resolv.conf
EOF
fi
echo
