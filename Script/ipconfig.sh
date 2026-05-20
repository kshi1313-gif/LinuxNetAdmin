#!/bin/bash

print_value() {
    local value="$1"

    if [[ -z "$value" || "$value" == "--" ]]; then
        echo "-"
    else
        echo "$value"
    fi
}

convert_dhcp_method() {
    local method="$1"

    case "$method" in
        auto)
            echo "예"
            ;;
        manual)
            echo "아니요"
            ;;
        disabled)
            echo "비활성화"
            ;;
        *)
            echo "$(print_value "$method")"
            ;;
    esac
}

SERVER=$(hostname)

cat << EOF
Linux IP 구성

    호스트 이름.....................: $SERVER

EOF

nmcli -t -f DEVICE,TYPE,STATE device status | while IFS=: read -r NIC TYPE STATE
do
    # lo 제외
    [[ "$NIC" == "lo" ]] && continue

    # ethernet, wifi만 출력
    [[ "$TYPE" != "ethernet" && "$TYPE" != "wifi" ]] && continue

    CON=$(nmcli -g GENERAL.CONNECTION device show "$NIC")
    MAC=$(nmcli -g GENERAL.HWADDR device show "$NIC")
    IP=$(nmcli -g IP4.ADDRESS device show "$NIC")
    GW=$(nmcli -g IP4.GATEWAY device show "$NIC")
    DNS=$(nmcli -g IP4.DNS device show "$NIC")

    if [[ -z "$CON" || "$CON" == "--" ]]; then
        DHCP="-"
    else
        DHCP_METHOD=$(nmcli -g ipv4.method connection show "$CON" 2>/dev/null)
        DHCP=$(convert_dhcp_method "$DHCP_METHOD")
    fi

    cat << EOF
    네트워크 어댑터: $NIC

        어댑터 종류.................: $(print_value "$TYPE")
        장치 상태...................: $(print_value "$STATE")
        커넥션 이름.................: $(print_value "$CON")
        물리적 주소.................: $(print_value "$MAC")
        DHCP 사용...................: $(print_value "$DHCP")
        IPv4 주소...................: $(print_value "$IP")
        기본 게이트웨이.............: $(print_value "$GW")
        DNS 서버....................: $(print_value "$DNS")

EOF

done
