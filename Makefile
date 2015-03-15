NAME=myiso

compile: 
	livecd-creator -v --product=$(NAME) -c ./upstream.ks

load:
	livecd-iso-to-disk --reset-mbr --overlay-size-mb 666 ./$(NAME).iso /dev/sdb1

clean:
	rm -fr *.iso
