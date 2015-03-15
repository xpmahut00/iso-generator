# make sure to set the right permissions and selinux contexts
chown -R liveuser:liveuser /home/liveuser/
restorecon -R /home/liveuser/

mkdir /etc/systemd/system/getty@tty1.service.d
cat > /etc/systemd/system/getty@tty1.service.d/autologin.conf << FOE
[Service]
ExecStart=
ExecStart=-/usr/sbin/agetty --autologin kiosk --noclear %I 38400 linux
Type=simple
Restart=always
Alias=getty.target.wants/getty@tty1.service
FOE
