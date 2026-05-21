# for host in main server1 server2
do
	cat <<'EOF' | ssh -T $host bash
	date
	hostname
	cal
	date
EOF
done
