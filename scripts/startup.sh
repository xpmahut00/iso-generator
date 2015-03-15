#!/bin/bash -x
echo `date` >> /var/log/htmtrade.log
exec 1>> /var/log/htmtrade.log 2>&1

# load our configuration
touch .config

# we connect to the wireless first
timeout 120s nmcli dev wifi connect $WFNAME password $WFPASSWD

# update the application
cd /home/kiosk/app
time rsync -r -t /home/kiosk/app /dev/shm
cd /dev/shm/app
time git pull

# make sure rackup web server is dead and start it again
pkill -f rackup
cd /dev/shm/app && time rackup -D

# configure the graphic interface for our TV
xrandr --output  DP2 --mode 1920x1080 --pos 0x0 --rotate left
export TOUCH_DEV=`xinput --list|grep "Elo TouchSystems"|grep pointer|awk -F 'id=' '{print $2}'|cut -f1|head -2|tail -1`
xinput --map-to-output $TOUCH_DEV DP2
xset s off
xset -dpms
xset s noblank

# custom stuff for our X windows
/usr/bin/matchbox-window-manager &
unclutter -idle 0 &

# shutdown the box at 4pm
shutdown -h 16:00

# start chrome browser in kiosk mode
rm -fr /home/kiosk/.config/chromium/
/usr/bin/chromium-browser --no-first-run --touch-events=enabled --touch-devices=$TOUCH_DEV --kiosk http://localhost:9292/
