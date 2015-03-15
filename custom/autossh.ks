cat > /etc/systemd/system/autossh.service << FOE
[Unit]
Description=AutoSSH service for a reverse tunnel
After=network.target

[Service]
ExecStart=/usr/bin/autossh -M 0 -q -N -o "StrictHostKeyChecking no" -o "ServerAliveInterval 60" -o "ServerAliveCountMax 3" user@example.com -R 127.3.0.1:8080:localhost:22 -i /home/kiosk/.ssh_key


[Install]
WantedBy=multi-user.target
FOE

cat > /home/kiosk/.ssh_key << FOE
-----BEGIN RSA PRIVATE KEY-----
XXX: to be replaced
-----END RSA PRIVATE KEY-----
FOE
chmod 600 /home/kiosk/.ssh_key

systemctl daemon-reload
systemctl enable getty@tty1.service
systemctl enable autossh.service
systemctl restart getty@tty1.service
systemctl start autossh.service
EOF

