#!/bin/bash

if [ -z "$1" ]; then
	filepath=./firmware.bin
else
	filepath=$1
fi

if [ ! -f "$filepath" ]; then
	echo "Firmware file $filepath not found"
else
	echo "...Detecting LPC device"
	
	lpcpath=`df -P | grep "CRP DISABLD" | tr -s ' ' | cut -d ' ' -f 1`
	
	if [ "${#lpcpath}" == 0 ]; then
		echo "LPC device not detected"
	else
		echo "Device found at $lpcpath"
		echo "...Unmounting $lpcpath"
		
		if [ `uname` == 'Darwin' ]; then
			diskutil umount $lpcpath
			echo "...Wiritng $filepath"
			dd if=$filepath of=$lpcpath seek=4
		else
			umount ${lpcpath}
			echo "...Wiritng $filepath"
			sudo dd if=$filepath of=$lpcpath seek=4
		fi

		echo "...Finished"
	fi
fi

exit

