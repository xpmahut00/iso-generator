wget http://example.com/splash.png -O /boot/grub2/themes/system/background.png
echo "GRUB_BACKGROUND=/usr/share/images/splash.png" >> /etc/default/grub 
echo "GRUB_TIMEOUT=2" >> /etc/default/grub 
/usr/sbin/grub2-mkconfig -o /boot/grub2/grub.cfg
/usr/sbin/plymouth-set-default-theme spinfinity
/usr/bin/dracut --force
