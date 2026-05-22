#!/bin/bash
# $HOME/.bashrc
# * alias LS='ls --color=auto -h'
# * alias grep='grep --color=auto -i'
# * export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\$ \[\e[m\]'
# $HOME/.vimrc
# * syntax on
# * set ai nu sw=4 ts=4

set -e

echo "[ INFO ] ENV2.sh"
echo '[Phase 01]: $HOME/.bashrc'
grep -q PS1 $HOME/.bashrc \
    || cat <<'EOF'>> $HOME/.bashrc

#
# Specific configuration
#
alias LS='ls --color=auto -h'
alias grep='grep --color=auto -i'
export PS1='\[\e[31;1m\][\u@\h\[\e[33;1m\] \w]\$ \[\e[m\]'

EOF

echo '[Phase 02]: $HOME/.vimrc'
if [ -f $HOME/.vimrc ]; then
    grep -q syntax $HOME/.vimrc \
        || cat <<'EOF' > $HOME/.vimrc
syntax on
set ai nu sw=4 ts=4
EOF
else
    cat <<'EOF' > $HOME/.vimrc
syntax on
set ai nu sw=4 ts=4
EOF
fi