#!/bin/bash
# gnome-tweaks
# epel-release
# boxes, cowsay

set -e

source $HOME/bin/function.sh

echo "[ INFO ] 선수 패키지 설치"
echo "[Phase 01]: $pkg_esential"
yum install -q -y $pkg_esential>/dev/null 2>&1

echo "[Phase 02]: $pkg_additional"
yum install -q -y $pkg_additional >/dev/null 2>&1

