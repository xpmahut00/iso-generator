echo "exec startx /home/kiosk/startup.sh" >> /home/kiosk/.bash_profile
echo "nameserver 8.8.8.8" >> /etc/resolv.conf
wget http://example.com/startup.sh -O /home/kiosk/startup.sh && chmod +x /home/kiosk/startup.sh
echo "https://api:key@api.mailgun.net/v2/example.com/messages" > /etc/mailgun_passwd
echo "0 16 * * mon,tue,wed,thu,fri root /sbin/shutdown -h now" >> /etc/crontab
echo "10 7 * * sun,sat root /sbin/shutdown -h now" >> /etc/crontab
