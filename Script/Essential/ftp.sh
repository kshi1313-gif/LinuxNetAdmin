#!/bin/bash
HELP() {
    cat <<'EOF'
Commands may be abbreviated.  Commands are:

!		debug		mdir		sendport	site
$		dir		mget		put		size
account		disconnect	mkdir		pwd		status
append		exit		mls		quit		struct
ascii		form		mode		quote		system
EOF
}

LS() {
    echo "[ OK ] $CMD: complete"
}

while true
do
    echo -n "ftp> "
    read CMD
    # echo $CMD
    case $CMD in
        'help') HELP ;;
        'ls'  ) LS ;;
        'quit') break ;;
        ''    ) : ;;
        *     ) echo "?Invalid command" ;;
    esac
done


