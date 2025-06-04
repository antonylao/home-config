#/bin/sh

mixer vol.mute | grep off; [ $? -eq 0 ] && mixer vol.mute=on || mixer vol.mute=off

